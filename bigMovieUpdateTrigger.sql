-- trigger to update movie table whenever big_movie is updated
DELIMITER //

CREATE TRIGGER movieInsertTrigger
AFTER INSERT on big_movie
FOR EACH ROW
BEGIN
	IF NEW.original_title NOT IN
		(SELECT movie_name
			FROM MOVIES)
		THEN
		INSERT INTO MOVIES (movie_name)
		VALUES (NEW.original_title);
	END IF;
END//

DELIMITER ;

-- drop
DROP TRIGGER movieInsertTrigger
        
-- test
select * from movies
WHERE movie_name = "a test data set"

SELECT * from movies order by movie_id desc

-- reset for testing
DELETE FROM movies WHERE movie_genre IS NULL

DELETE FROM big_movie
WHERE original_title = "a test data set";

insert into big_movie
	(original_title)
VALUES
	("a test data set")