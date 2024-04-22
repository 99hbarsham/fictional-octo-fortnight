-- MORE FILTERING FUNCTIONS
DELIMITER //

CREATE PROCEDURE filmFactsGenerator(IN anytext VARCHAR (50))
BEGIN	
	SELECT DISTINCT movie_name, movie_genre, movie_releaseDate, original_language, revenue, runtime
	FROM movies
	JOIN big_movie ON movie_name = original_title
	WHERE movie_name LIKE
		(SELECT CONCAT('%',anytext,'%'))
    ORDER BY movie_name DESC;
END //
;

-- drop function
DROP PROCEDURE filmFactsGenerator

-- execute function
CALL filmFactsGenerator('TO');