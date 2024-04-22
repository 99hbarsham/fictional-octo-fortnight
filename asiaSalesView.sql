select country_name from locations where salesRegion = "AN"

CREATE OR REPLACE VIEW asiaSalesTeam
AS 
	SELECT GROUP_CONCAT(FORENAME, " ", SURNAME
		ORDER BY FORENAME, SURNAME
		SEPARATOR ',') AS Name, city, country, l.salesRegion, count(transaction_id) AS Transactions
	FROM CUSTOMERS c
	JOIN LOCATIONS l ON country = l.country_name
    JOIN TRANSACTIONS t ON t.customer_id = c.person_id
	GROUP BY city, country, l.country_name, l.salesRegion
	HAVING l.salesRegion = "AS"

    
SELECT * FROM ASIASALESTEAM