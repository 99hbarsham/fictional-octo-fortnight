select movie_name
from movies m
WHERE movie_id IN
	(SELECT movie_id
    FROM big_movie
    WHERE revenue > 1000000)
