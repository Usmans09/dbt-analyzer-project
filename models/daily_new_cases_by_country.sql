SELECT
    country_region,
    report_date,
    total_confirmed - LAG(total_confirmed) OVER (
        PARTITION BY country_region
        ORDER BY report_date
    ) AS new_cases
FROM {{ ref('daily_stats') }}
ORDER BY country_region, report_date