CREATE OR REPLACE VIEW euSalesTeam
AS 
	SELECT CONCAT(FORENAME, " ", SURNAME) AS Name, city, country, l.salesRegion, count(transaction_id) AS Transactions
	FROM CUSTOMERS c
	JOIN LOCATIONS l ON country = l.country_name
    JOIN TRANSACTIONS t ON t.customer_id = c.person_id
	GROUP BY Name, city, country, salesRegion
	HAVING l.salesRegion = "EU"


select * from euSalesTeam