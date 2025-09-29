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
    report_date,
    daily_new_cases,
    RANK() OVER (ORDER BY daily_new_cases DESC) AS rank
FROM daily_cases
WHERE report_date = '2022-03-09'
ORDER BY rank