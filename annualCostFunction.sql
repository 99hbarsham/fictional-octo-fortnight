-- function to know how much a rental would cost for a year

DELIMITER //
CREATE FUNCTION annualCost(
    monthlyRentalPrice INT
) 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE yearlyTotal INT;
	SET yearlyTotal = (monthlyRentalPrice*12);
    RETURN (yearlyTotal);
END//

DELIMITER ;

-- drop
DROP FUNCTION annualCost

select movie_name, monthlyRentalCost, annualCost(monthlyRentalCost) from movies
WHERE year(movie_releaseDate) = 1996
