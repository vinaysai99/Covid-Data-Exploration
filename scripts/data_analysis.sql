/*
    Data Analysis: COVID-19 Data Exploration
*/

-- Select initial data to explore
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM Covid.CovidDeaths
WHERE continent IS NOT NULL
ORDER BY location, date;

-- Total Cases vs Total Deaths
SELECT location, date, total_cases, total_deaths, 
       (total_deaths / total_cases) * 100 AS DeathPercentage
FROM Covid.CovidDeaths
WHERE location LIKE '%states%'
  AND continent IS NOT NULL
ORDER BY location, date;

-- Total Cases vs Population
SELECT location, date, population, total_cases, 
       (total_cases / population) * 100 AS PercentPopulationInfected
FROM Covid.CovidDeaths
ORDER BY location, date;

-- Countries with Highest Infection Rate Compared to Population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, 
       MAX((total_cases / population) * 100) AS PercentPopulationInfected
FROM Covid.CovidDeaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

-- Countries with Highest Death Count per Population
SELECT location, MAX(total_deaths) AS TotalDeathCount
FROM Covid.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- Breaking Things Down by Continent
-- Continents with Highest Death Count per Population
SELECT continent, MAX(total_deaths) AS TotalDeathCount
FROM Covid.CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- Global Numbers
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, 
       SUM(new_deaths) / SUM(new_cases) * 100 AS DeathPercentage
FROM Covid.CovidDeaths
WHERE continent IS NOT NULL
ORDER BY total_cases, total_deaths;
