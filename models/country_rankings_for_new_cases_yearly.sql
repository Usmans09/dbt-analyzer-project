WITH daily_cases AS (
    SELECT
        country_region,
        report_date,
        total_confirmed - LAG(total_confirmed) OVER (
            PARTITION BY country_region
            ORDER BY report_date
        ) AS daily_new_cases
    FROM {{ ref('daily_stats') }}
)
SELECT
    country_region,
    EXTRACT(YEAR FROM report_date)::int AS year,
    SUM(daily_new_cases) AS yearly_cases,
    RANK() OVER (ORDER BY SUM(daily_new_cases) DESC) AS rank
FROM daily_cases
WHERE EXTRACT(YEAR FROM report_date) = 2022
GROUP BY country_region, EXTRACT(YEAR FROM report_date)
ORDER BY rank
