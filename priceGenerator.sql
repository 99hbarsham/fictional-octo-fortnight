
-- create function to calculate rental price per month
DELIMITER //

CREATE PROCEDURE priceGenerator(IN the_movie_id INT)
BEGIN
	SELECT movie_id, movie_name, movie_genre, ROUND((price + YEAR(movie_releasedate)/100)/2,2) as cost
    FROM movies m
    JOIN genres g 
    JOIN big_movie b
    WHERE movie_genre = category_name
    AND b.original_title = m.movie_name
    AND movie_id = the_movie_id;
END //
    
;

-- drop function
DROP PROCEDURE priceGenerator


-- execute
CALL priceGenerator(180);


