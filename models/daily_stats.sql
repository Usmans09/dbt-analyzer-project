SELECT
    country_region,
    last_update::date AS report_date,
    SUM(confirmed) AS total_confirmed,
    SUM(deaths) AS total_deaths
FROM covid_data
GROUP BY country_region, last_update::date
