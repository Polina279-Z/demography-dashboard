--регионы, где смертность выше
WITH stat1 AS(
SELECT object_name AS Регион,
MAX(CASE WHEN indicator_name = 'Общие коэффициенты рождаемости' THEN indicator_value END) AS Рождаемость,
MAX(CASE WHEN indicator_name = 'Общие коэффициенты смертности' THEN indicator_value END) AS Смертность,
FROM regions
WHERE year = 2023
AND indicator_name IN ('Общие коэффициенты рождаемости', 'Общие коэффициенты смертности')
GROUP BY object_name)
SELECT
	Регион,
	Рождаемость,
	Смертность,
	(Рождаемость - Смертность) AS Убыль
FROM stat1
WHERE Рождаемость < Смертность
ORDER BY Убыль ASC


--регионы, где рождаемость выше
WITH RegionStats AS (
    SELECT 
        object_name AS region,
        MAX(CASE WHEN indicator_name = 'Общие коэффициенты рождаемости' THEN indicator_value END) AS Рождаемость,
        MAX(CASE WHEN indicator_name = 'Общие коэффициенты смертности' THEN indicator_value END) AS Смертность
    FROM regions
    WHERE year = 2023
      AND indicator_name IN ('Общие коэффициенты рождаемости', 'Общие коэффициенты смертности')
    GROUP BY object_name
)
SELECT 
    Регион, 
    Рождаемость, 
    Смертность, 
    (Рождаемость - Смертность) AS Прирост
FROM RegionStats
WHERE Рождаемость > Смертность
ORDER BY Прирост DESC;
