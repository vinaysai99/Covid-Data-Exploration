-- I verified all values with WHO and almost all vlaues are accurate.
-- Total Covid cases and Total deaths in every country till June 2024 orderedby descending order

Select Location, max(population) as population,Max(total_cases) as total_case,Max(total_deaths) as total_death
From Covid.CovidDeaths
Where continent is not null 
Group by Location
order by 3 DESC, 4 DESC;

-- Total covid cases in world till date(JUNE 2024)

Select sum(population) as world_population,sum(total_case) as total_cases_in_world,sum(total_death) as total_deaths_in_world, (sum(total_case)/sum(population)*100) as infection_rate,(sum(total_death)/sum(total_case)*100) as death_rate
from (
Select Location, Max(population) as population ,Max(total_cases) as total_case,Max(total_deaths) as total_death
From Covid.CovidDeaths
Where continent is not null 
Group by Location
order by 2 DESC)
as total_world_cases;

-- Countries deaths and covid contact percentages

Select Location, max(population),Max(total_cases) as total_case,Max(total_deaths) as total_death,(Max(total_cases)/max(population)*100) as infection_rate,(Max(total_deaths)/max(population)*100) as death_rate
From Covid.CovidDeaths
Where continent is not null 
Group by Location
order by 5 DESC, 6 DESC;

-- Which day has maximum cases and deaths

WITH total_cases_by_date AS (
    SELECT date_covid, SUM(new_cases) AS total_case
    FROM Covid.CovidDeaths
    WHERE continent IS NOT NULL
    GROUP BY date_covid
)
SELECT date_covid, total_case AS total_cases
FROM total_cases_by_date
WHERE total_case = (SELECT MAX(total_case) FROM total_cases_by_date);

WITH total_deaths_by_date AS (
    SELECT date_covid, SUM(new_deaths) AS total_death
    FROM Covid.CovidDeaths
    WHERE continent IS NOT NULL
    GROUP BY date_covid
)
SELECT date_covid, total_death AS total_deaths
FROM total_deaths_by_date
WHERE total_death = (SELECT MAX(total_death) FROM total_deaths_by_date);

-- Which month has maximum cases and deaths

SELECT DATE_FORMAT(date_covid, '%Y-%m') AS month, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_death
FROM Covid.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY DATE_FORMAT(date_covid, '%Y-%m');

SELECT DATE_FORMAT(date_covid, '%Y-%m') AS month, SUM(new_tests) AS total_test,SUM(new_vaccinations) AS total_vaccinations
FROM Covid.covidvaccinations
WHERE continent IS NOT NULL
GROUP BY DATE_FORMAT(date_covid, '%Y-%m');

-- Total Covid cases and Total deaths in every continent till June 2024 orderedby descending order

Select Location, max(population) as population,Max(total_cases) as total_case,Max(total_deaths) as total_death,(Max(total_cases)/max(population)*100) as infection_rate,(Max(total_deaths)/max(population)*100) as death_rate
From Covid.CovidDeaths
Where continent is null and location not like "%income%"
Group by Location
order by 3 DESC, 4 DESC;

-- Vaccinations analysis
-- Countries analysis on total tests taken, total vaccinations done and percentage of population vaccinated

Select Location, max(population) as population,Max(total_tests) as total_test,Max(total_vaccinations) as total_vaccination,(Max(people_fully_vaccinated)/max(population)*100) as vaccinated_percentage
From Covid.covidvaccinations
Where continent is not null 
Group by Location
order by 3 DESC, 4 DESC;





