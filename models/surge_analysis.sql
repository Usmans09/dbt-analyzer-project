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
        , weekly_avg AS (
            SELECT
                country_region,
                DATE_TRUNC('week', report_date)::date AS week_start,
                ROUND(AVG(daily_new_cases), 2)::numeric AS current_weekly_avg
            FROM daily_cases
            GROUP BY country_region, DATE_TRUNC('week', report_date)
        )
        SELECT
            country_region,
            week_start,
            current_weekly_avg,
            LAG(current_weekly_avg) OVER (
                PARTITION BY country_region
                ORDER BY week_start
            ) AS previous_weekly_avg,
            ROUND(
                current_weekly_avg
                / NULLIF(
                    LAG(current_weekly_avg) OVER (
                        PARTITION BY country_region
                        ORDER BY week_start
                    ), 0
                ), 2
            ) AS surge_ratio
        FROM weekly_avg
        ORDER BY country_region, week_start