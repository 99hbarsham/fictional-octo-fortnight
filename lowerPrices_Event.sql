-- event scheduler

SET GLOBAL event_scheduler = ON;

SET GLOBAL event_scheduler = OFF;

-- setting an event to lower prices

CREATE EVENT IF NOT EXISTS blackFridayRentalDeal
ON SCHEDULE AT CURRENT_TIMESTAMP
ON COMPLETION PRESERVE
DO
UPDATE movies
SET monthlyRentalCost = monthlyRentalCost * 0.5;

-- test
select movie_id, new_price, changed_at from movie_price_changes WHERE movie_id = 1033 ORDER BY changed_at DESC;

-- drop
DROP EVENT IF EXISTS blackFridayRentalDeal

-- undo

CREATE EVENT IF NOT EXISTS reverseBlackFridayRentalDeal
ON SCHEDULE AT CURRENT_TIMESTAMP
ON COMPLETION PRESERVE
DO
UPDATE movies
SET monthlyRentalCost = monthlyRentalCost*2;

-- drop
DROP EVENT IF EXISTS reverseBlackFridayRentalDeal

-- test
select movie_id, new_price, changed_at from movie_price_changes WHERE movie_id = 1033 ORDER BY changed_at DESC;