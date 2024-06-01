
### scripts/data_preparation.sql
```sql
/*
    Data Preparation: Converting Date Columns to DATETIME
*/

-- Convert date column in CovidDeaths table
ALTER TABLE Covid.CovidDeaths
ADD COLUMN `date_temp` DATETIME;

SET SQL_SAFE_UPDATES = 0;
UPDATE Covid.CovidDeaths
SET `date_temp` = STR_TO_DATE(`date`, '%m/%d/%Y');
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE Covid.CovidDeaths
DROP COLUMN `date`;

ALTER TABLE Covid.CovidDeaths
CHANGE COLUMN `date_temp` `date` DATETIME;

-- Convert date column in CovidVaccinations table
ALTER TABLE Covid.CovidVaccinations
ADD COLUMN `date_temp` DATETIME;

SET SQL_SAFE_UPDATES = 0;
UPDATE Covid.CovidVaccinations
SET `date_temp` = STR_TO_DATE(`date`, '%m/%d/%Y');
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE Covid.CovidVaccinations
DROP COLUMN `date`;

ALTER TABLE Covid.CovidVaccinations
CHANGE COLUMN `date_temp` `date` DATETIME;
