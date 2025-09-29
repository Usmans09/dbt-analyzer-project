SELECT
    country_region,
    report_date,
    total_deaths - LAG(total_deaths) OVER (
        PARTITION BY country_region
        ORDER BY report_date
    ) AS new_deaths
FROM {{ ref('daily_stats') }}
ORDER BY country_region, report_date