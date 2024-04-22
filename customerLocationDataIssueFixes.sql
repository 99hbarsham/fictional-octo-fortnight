-- fixing screwey data

select *
FROM transactions
WHERE salesRegion is null

UPDATE CUSTOMERS
SET country_id = 121
WHERE country_id is NULL
AND country LIKE "South Korea"

UPDATE LOCATIONS
SET country_name = "United States"
WHERE country_name = "United States of America";
UPDATE LOCATIONS
SET country_name = "Russia"
WHERE country_name = "Russian Federation";