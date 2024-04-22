alter table big_movie
drop column budget;

alter table big_movie
drop column production_countries;

ALTER TABLE BIG_MOVIE
ADD FOREIGN KEY (id) REFERENCES MOVIES(movie_id);

UPDATE big_movie
JOIN movies on original_title = movies.movie_name
SET id = movies.movie_id

select * from big_movie