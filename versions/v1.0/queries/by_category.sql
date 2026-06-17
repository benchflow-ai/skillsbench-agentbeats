SELECT
  id,
  category AS "Category",
  ROUND(
    100.0 * SUM(CASE WHEN COALESCE(score_eligible, false) AND COALESCE(passed, false) THEN 1 ELSE 0 END)
      / NULLIF(SUM(CASE WHEN COALESCE(score_eligible, false) THEN 1 ELSE 0 END), 0),
    1
  ) AS "Pass Rate",
  ROUND(AVG(CASE WHEN COALESCE(score_eligible, false) THEN reward ELSE NULL END), 3) AS "Mean Reward",
  ROUND(SUM(CASE WHEN COALESCE(score_eligible, false) THEN COALESCE(time_used, 0) ELSE 0 END), 1) AS "Time",
  SUM(CASE WHEN COALESCE(score_eligible, false) THEN 1 ELSE 0 END) AS "# Tasks",
  SUM(CASE WHEN NOT COALESCE(score_eligible, false) OR infra_failure_type IS NOT NULL THEN 1 ELSE 0 END) AS "Infra Failed"
FROM (
  SELECT
    CAST(results.participants.agent AS VARCHAR) AS id,
    row.category,
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

  UNION ALL

  SELECT
    CAST(results.participants.agent AS VARCHAR) AS id,
    outer_row.category,
    outer_row.score_eligible,
    outer_row.passed,
    outer_row.reward,
    outer_row.time_used,
    CAST(outer_row.infra_failure_type AS VARCHAR) AS infra_failure_type
  FROM results
  CROSS JOIN UNNEST(results.results) AS outer_rows(outer_row)
  WHERE results.status = 'completed'
    AND results.participants.agent IS NOT NULL
    AND outer_row.task_id IS NOT NULL
) AS rows
WHERE category IS NOT NULL
GROUP BY id, category
ORDER BY "Category" ASC, "Pass Rate" DESC NULLS LAST, "Time" ASC, id ASC
