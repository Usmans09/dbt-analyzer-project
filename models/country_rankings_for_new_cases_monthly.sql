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
    TO_CHAR(report_date, 'YYYY-MM') AS monthly,
    SUM(daily_new_cases) AS monthly_cases,
    RANK() OVER (ORDER BY SUM(daily_new_cases) DESC) AS rank
FROM daily_cases
WHERE TO_CHAR(report_date, 'YYYY-MM') = '2022-03'
GROUP BY country_region, TO_CHAR(report_date, 'YYYY-MM')
ORDER BY rank
