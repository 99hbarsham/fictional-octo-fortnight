USE MAD ALPACA;

-- function for filtering for films by genre
DELIMITER //

CREATE PROCEDURE genreGenerator(IN genre VARCHAR (50))
BEGIN
	SELECT movie_name, IF(INSTR(movie_genre,genre)>0,'YES','NO') AS selectGenre, movie_releaseDate
    FROM movies
    ORDER BY selectGenre DESC;
END //
    
;

-- drop function
DROP PROCEDURE genreGenerator

-- execute function
CALL genreGenerator('Fantasy');

-- extra one for filtering by genre and year
DELIMITER //

CREATE PROCEDURE genreAndYearGenerator(IN genre VARCHAR (50), enteredYear YEAR)
BEGIN
	SELECT movie_name, IF(INSTR(movie_genre,genre)>0,'YES','NO') AS selectGenre, movie_releaseDate
    FROM movies
    WHERE YEAR(movie_releaseDate) = enteredYear
    ORDER BY selectGenre DESC;
END //
    
;

-- drop 
DROP PROCEDURE genreAndYearGenerator

-- execute
CALL genreAndYearGenerator('Fantasy', 1995)

-- subquery procedure - transactions for films in a certain year

DELIMITER //
CREATE PROCEDURE transaction_filmDate(IN entereddate YEAR)
BEGIN
	select transaction_id, t.movie_id
    FROM TRANSACTIONS t
    WHERE 
		movie_id IN (SELECT 
			movie_id
			FROM movies
			WHERE YEAR(movie_releasedate) = entereddate)
    ORDER BY t.transaction_id;
    
END //
​
DELIMITER ;

DROP PROCEDURE transaction_filmDate

CALL transaction_filmDate(1995)
