WITH daily_cases AS (
            SELECT
                country_region,
                report_date,
                total_confirmed
                    - LAG(total_confirmed) OVER (
                        PARTITION BY country_region
                        ORDER BY report_date
                    ) AS daily_new_cases
            FROM {{ ref('daily_stats') }}
        )
        SELECT
            country_region,
            DATE_TRUNC('week', report_date)::date AS week_start,
            ROUND(AVG(daily_new_cases), 2) AS avg_weekly_cases,
            SUM(daily_new_cases) AS total_weekly_cases
        FROM daily_cases
        GROUP BY country_region, DATE_TRUNC('week', report_date)
        ORDER BY country_region, week_start