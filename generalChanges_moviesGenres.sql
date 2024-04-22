-- cleaup - getting rid of null values (genres/movies)

select * from genres where category_name = "No genre specified"

INSERT INTO GENRES (category_name)
VALUES ("No genre specified")

-- copying info from genres table create file - adding values for 'no genre specified'

UPDATE GENRES SET ROMANCE = 0 where category_name NOT LIKE '%Romance%';
UPDATE GENRES SET Crime = 0 where category_name NOT LIKE '%Crime%';
UPDATE GENRES SET Music = 0 where category_name NOT LIKE '%Music%';
UPDATE GENRES SET Western = 0 where category_name NOT LIKE '%Western%';

UPDATE GENRES SET ScienceFiction = 0 where category_name NOT LIKE '%ScienceFiction%';
UPDATE GENRES SET Fantasy = 0 where category_name NOT LIKE '%Fantasy%';
UPDATE GENRES SET COMEDY = 0 where category_name NOT LIKE '%COMEDY%';
UPDATE GENRES SET THRILLER = 0 where category_name NOT LIKE '%THRILLER%';
UPDATE GENRES SET Animation = 0 where category_name NOT LIKE '%Animation%';
UPDATE GENRES SET Adventure = 0 where category_name NOT LIKE '%Adventure%';
UPDATE GENRES SET Action = 0 where category_name NOT LIKE '%Action%';
UPDATE GENRES SET Drama = 0 where category_name NOT LIKE '%Drama%';
UPDATE GENRES SET War = 0 where category_name NOT LIKE '%War%';
UPDATE GENRES SET Documentary = 0 where category_name NOT LIKE '%Documentary%';
UPDATE GENRES SET Mystery = 0 where category_name NOT LIKE '%Mystery%';
UPDATE GENRES SET Horror = 0 where category_name NOT LIKE '%Horror%';

UPDATE GENRES SET Family = 0 where category_name NOT LIKE '%Family%';

-- coalesce data for price
UPDATE GENRES SET PRICE =  COALESCE(FAMILY) + COALESCE(ROMANCE) + COALESCE(Crime) + COALESCE(Music) + COALESCE(Western) + COALESCE(ScienceFiction) + COALESCE(Fantasy) + COALESCE(COMEDY) + COALESCE(THRILLER) + COALESCE(Animation) + COALESCE(Adventure) + COALESCE(Action) + COALESCE(Drama) + COALESCE(War) + COALESCE(Documentary) + COALESCE(Mystery) + COALESCE(Horror)


DELETE from GENRES where category_name IS NULL

-- fix null values on movie table

UPDATE MOVIES
SET movie_genre_id = 624
WHERE movie_genre_id IS NULL

-- fix duplicate foreign keys

ALTER TABLE MOVIES
DROP CONSTRAINT movies_ibfk_2;

ALTER TABLE MOVIES
DROP CONSTRAINT movies_ibfk_3

-- price changes (more realistic)

UPDATE movies
SET monthlyRentalCost = monthlyRentalCost * 1.2
WHERE monthlyRentalCost = 10

SELECT * from MOVIE_PRICE_CHANGES
ORDER BY changed_at ASC