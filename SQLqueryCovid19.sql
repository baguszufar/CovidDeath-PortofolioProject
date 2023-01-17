select *
from PortofolioProject..coviddeath
order by 3,4

-- Select data that we are going to be using

select location,date, total_cases, new_cases, total_deaths, population_density
from PortofolioProject..coviddeath
order by 1,2


-- View total cases vs total deaths
--shows the probability of death if you catch covid in your country
select location,date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from PortofolioProject..coviddeath
where location like 'Indonesia'
order by 1,2

-- Looking at total cases vs population
-- Shows what percentage of the population is affected by covid

select location,date, total_cases, population_density, (total_cases/population_density)*100 as PopulationInfected
where location like 'Indonesia'
order by 1,2 

-- Looking at countries with highest infection rate compared to populaton

select location, population_density, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population_density))*100 as PercentagePopulationInfected
from PortofolioProject..coviddeath
group by location, population_density
order by PercentagePopulationInfected desc

-- showing the country with the highest number of deaths per population

select location, MAX(cast(total_deaths as int)) as TotalDeathCount
from PortofolioProject..coviddeath
group by location
order by TotalDeathCount desc

-- Let's break down the data by continent


select continent, SUM(cast(new_deaths as int)) as TotalDeathCount
from PortofolioProject..coviddeath
where continent is not null
group by continent
order by TotalDeathCount desc

--showing continents with the highest death count per population

select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
from PortofolioProject..coviddeath
group by continent
order by TotalDeathCount desc

--World numbers

select date, MAX(total_cases) as total_cases, MAX(cast(total_deaths as int)) as total_deaths, MAX(cast(total_deaths as int))/MAX(total_cases)*100 AS DeathPercentage
from PortofolioProject..coviddeath
where continent is not null
group by date
order by 1,2

-- Total numbers
select MAX(total_cases) as total_cases, MAX(cast(total_deaths as int)) as total_deaths, MAX(cast(total_deaths as int))/MAX(total_cases)*100 AS DeathPercentage
from PortofolioProject..coviddeath
order by 1,2


--Showing total population vs vaccinations

select die.continent, die.location, die.date, die.population_density, vak.new_vaccinations
, SUM(cast(vak.new_vaccinations as )) OVER (Partition by die.location)
from PortofolioProject..coviddeath die
join PortofolioProject..covidvaksin vak
	on die.location = vak.location
	and die.date = vak.date
	where die.continent is not null
order by 2,3
