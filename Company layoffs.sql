-- Master raw data

Select *
From CompanyLayoffs..layoffs$


-- To check for null values

Select  COUNT(*) - COUNT(company) as CompanyNulls,
		COUNT(*) - COUNT(location) as LocationNulls,
		COUNT(*) - COUNT(industry) as IndustryNulls,
		COUNT(*) - COUNT(total_laid_off) as TotalLadiOffNulls,
		COUNT(*) - COUNT(percentage_laid_off) as PercentageLaidOffNulls,
		COUNT(*) - COUNT(date) as DateNulls,
		COUNT(*) - COUNT(stage) as StageNulls,
		COUNT(*) - COUNT(funds_raised) as FundRaisedNulls
From CompanyLayoffs..layoffs$

-- Which company hast the highest total laid off

Select TOP (10) company, SUM(total_laid_off) as CompanyTotalLaidOff
From CompanyLayoffs..layoffs$
Where total_laid_off is not null
Group by company
Order by CompanyTotalLaidOff desc

-- To plot location laid off

Select country, SUM(total_laid_off) as LocationTotalLaidOff
From CompanyLayoffs..layoffs$
Where total_laid_off is not null
Group by country

-- Top industry affected by this layoff

Select TOP (10) industry, COUNT(industry) as TotalCompanyinthesameindustry
From CompanyLayoffs..layoffs$
Where industry is not null
Group by industry
Order by TotalCompanyinthesameindustry desc

Select TOP (10) industry, SUM(total_laid_off) as TotalIndustryLaidOff
From CompanyLayoffs..layoffs$
Where industry is not null
Group by industry
Order by TotalIndustryLaidOff desc

-- To find out which year has the highest laid off

With CTE
as
(
Select YEAR(date) as Year, MONTH(date) as Month, total_laid_off
From CompanyLayoffs..layoffs$
)
Select Year,  SUM(total_laid_off) as YearlyTotalLaidOff
From CTE
Group by Year
Order by Year desc

-- To plot the graph for 2022 laid off monthly

With CTE
as
(
Select YEAR(date) as Year, MONTH(date) as Month, total_laid_off
From CompanyLayoffs..layoffs$
)
Select Month,  SUM(total_laid_off) as MonthlyTotalLaidOff
From CTE
Where Year = 2022
Group by Month
Order by Month asc