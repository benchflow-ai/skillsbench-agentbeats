SELECT
  id,
  CONCAT(
    CAST(COUNT(DISTINCT CASE WHEN COALESCE(score_eligible, false) AND COALESCE(passed, false) THEN task_id END) AS VARCHAR),
    '/',
    CAST(COUNT(DISTINCT CASE WHEN COALESCE(score_eligible, false) THEN task_id END) AS VARCHAR)
  ) AS "Tasks passed",
  ROUND(
    100.0 * COUNT(DISTINCT CASE WHEN COALESCE(score_eligible, false) AND COALESCE(passed, false) THEN task_id END)
      / NULLIF(COUNT(DISTINCT CASE WHEN COALESCE(score_eligible, false) THEN task_id END), 0),
    1
  ) AS "Pass Rate",
  ROUND(AVG(CASE WHEN COALESCE(score_eligible, false) THEN reward ELSE NULL END), 3) AS "Mean Reward",
  ROUND(SUM(CASE WHEN COALESCE(score_eligible, false) THEN COALESCE(time_used, 0) ELSE 0 END), 1) AS "Time",
  COUNT(DISTINCT CASE WHEN COALESCE(score_eligible, false) THEN task_id END) AS "# Tasks",
  SUM(CASE WHEN NOT COALESCE(score_eligible, false) OR infra_failure_type IS NOT NULL THEN 1 ELSE 0 END) AS "Infra Failed"
FROM (
  SELECT
    CAST(results.participants.agent AS VARCHAR) AS id,
    row.task_id,
    row.score_eligible,
    row.passed,
    row.reward,
    row.time_used,
    row.infra_failure_type
  FROM results
  CROSS JOIN UNNEST(results.results) AS outer_rows(outer_row)
  CROSS JOIN UNNEST(outer_row.results) AS nested_rows(row)
  WHERE results.status = 'completed'
    AND results.participants.agent IS NOT NULL
    AND CAST(results.participants.agent AS VARCHAR) <> ''
    AND row.task_id IS NOT NULL
) AS rows
GROUP BY id
HAVING COUNT(DISTINCT CASE WHEN COALESCE(score_eligible, false) THEN task_id END) > 0
ORDER BY "Pass Rate" DESC NULLS LAST, "Time" ASC, id ASC
