SELECT
    country_region,
    MIN(last_update::date) AS first_1000_cases_date,
    SUM(confirmed) AS cases_reported_that_day
FROM covid_data
GROUP BY country_region, last_update::date
HAVING SUM(confirmed) >= 1000
ORDER BY first_1000_cases_date