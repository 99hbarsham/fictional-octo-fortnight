-- Trigger - price changes

select monthlyRentalCost from movies

CREATE TABLE MOVIE_PRICE_CHANGES (
	movie_id INT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    old_price DECIMAL (5,2),
    new_price DECIMAL (5.2),
    PRIMARY KEY (movie_id, changed_at)
);

DELIMITER //
CREATE TRIGGER beforeUpdatePrice
BEFORE UPDATE on movies
FOR EACH ROW
BEGIN
	IF OLD.monthlyRentalCost <> NEW.monthlyRentalCost
		THEN
		INSERT INTO MOVIE_PRICE_CHANGES(movie_id, old_price, new_price)
		VALUES (NEW.movie_id, OLD.monthlyRentalCost, NEW.monthlyRentalCost);
	END IF;
END//
​
DELIMITER ;

-- drop
DROP TRIGGER beforeUpdatePrice

-- test

select movie_name, monthlyRentalCost
FROM movies
WHERE monthlyRentalCost = 12