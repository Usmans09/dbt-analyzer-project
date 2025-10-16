COVID Data Transformation using dbt (DATA BUILD TOOL)
Overview:

This project is a COVID-19 Data Transformation and Analysis Pipeline built using dbt (Data Build Tool).
It transforms raw COVID datasets into clean, analytics-ready tables and provides insights through curated SQL models.
The project includes multiple transformations for daily, yearly, and country-level COVID trends, allowing data teams to monitor case surges, global rankings, and overall pandemic patterns efficiently.

Example Models and Their Purpose:

Model File	Description:

daily_new_cases_by_country.sql |	Calculates new daily COVID-19 cases per country.
daily_new_deaths_by_country.sql |	Tracks daily new deaths reported by each country.
daily_stats.sql |	Combines key daily statistics (cases, deaths, recoveries).
seven_day_average_of_new_cases.sql |	Computes the 7-day rolling average of new cases.
country_rankings_for_new_cases_one_day.sql |	Ranks countries based on new cases for a single day.
country_rankings_for_new_cases_monthly.sql |	Ranks countries based on total new cases per month.
country_rankings_for_new_cases_yearly.sql |	Ranks countries based on yearly new case totals.
surge_analysis.sql |	Identifies and analyzes sudden surges in case numbers.
threshold_dates.sql	 |    Detects key threshold dates where case counts exceed defined limits.

What’s Inside:
Models: SQL transformations organized by purpose.

Macros: Reusable SQL snippets for consistent logic.

Tests: Data quality and schema validation checks.

Docs: Auto-generated interactive documentation via dbt docs.
