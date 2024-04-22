CREATE TABLE CATEGORIES (
	category_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    category_name VARCHAR (50),
    availableEU BOOL,
    availableMEA BOOL,
    availableNSA BOOL
);

DROP TABLE categories;

## RENAME - pivoting to lending movies

RENAME TABLE CATEGORIES TO GENRES

TRUNCATE TABLE GENRES

ALTER TABLE PRODUCTS
DROP CONSTRAINT products_ibfk_1

INSERT INTO GENRES
	(category_name)
VALUES
	('Documentary'), 
    ('Comedy|Drama|Romance'), 
    ('Comedy'), 
    ('Documentary'), 
    ('Drama|Horror'), 
    ('Drama'), 
    ('Comedy|Romance'), 
    ('Animation'), 
    ('Crime|Drama|Romance'), 
    ('Comedy|Romance'), 
    ('Comedy|Drama'), 
    ('Comedy|Drama|Romance'), 
    ('Horror|Mystery|Thriller'), 
    ('Drama|Western'), 
    ('Action|Comedy'), 
    ('Crime|Drama'), 
    ('Comedy|Drama|Romance'), 
    ('Action|Crime|Drama'), 
    ('Adventure|Drama'), 
    ('Mystery|Romance|Thriller'), 
    ('Comedy|Crime|Drama|Mystery'), 
    ('Horror'), 
    ('Drama|War'), 
    ('Action|Crime'), 
    ('Comedy'), 
    ('Action|Adventure|Drama|Fantasy|Mystery|IMAX'), 
    ('Thriller'), 
    ('Drama'), 
    ('Drama|Sci-Fi|Thriller'), 
    ('Documentary');
    
## REMOVING DUPES
CREATE TABLE ALL_GENRES (
	genre_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	genre_name VARCHAR (50));
    
INSERT INTO ALL_GENRES (genre_name)
SELECT DISTINCT category_name
FROM GENRES

TRUNCATE TABLE GENRES

ALTER TABLE MOVIES
DROP CONSTRAINT movies_ibfk_1

INSERT INTO GENRES (category_name)
SELECT genre_name
FROM ALL_GENRES

ALTER TABLE MOVIES
ADD FOREIGN KEY (movie_genre_id) REFERENCES GENRES(category_id);

select * from genres

## ADD AVAILABILITY

UPDATE GENRES
SET availableNSA = 1

## drop availability

ALTER TABLE GENRES
DROP COLUMN availableMEA

#insert big movie data

ALTER TABLE GENRES
MODIFY category_name VARCHAR(200)

INSERT INTO GENRES (category_name)
SELECT (movie_genre)
FROM movies

#test for genre x price setting
alter table GENRES
ADD COLUMN Romance BOOL

#clean

ALTER TABLE MOVIES
DROP CONSTRAINT movies_ibfk_1

TRUNCATE TABLE GENRES

INSERT INTO GENRES (category_name)
SELECT DISTINCT (movie_genre)
FROM movies

UPDATE GENRES
SET ROMANCE = 0
where category_name NOT LIKE '%Romance%'

## try and pull out each specific genre (will this be a function? lol)

UPDATE GENRES
SET category_name = replace(category_name, '[', '');

UPDATE GENRES
SET category_name = replace (category_name, ']', '');
UPDATE GENRES
SET category_name = replace (category_name, "'", "");
UPDATE GENRES
	SET category_name =  replace (category_name, ",", "");

### PRICING

ALTER TABLE GENRES
ADD COLUMN COMEDY INT;
ALTER TABLE GENRES
ADD COLUMN THRILLER INT;


ALTER TABLE GENRES
ADD COLUMN Animation INT;
ALTER TABLE GENRES
ADD COLUMN Action INT;
ALTER TABLE GENRES
ADD COLUMN Adventure INT;
ALTER TABLE GENRES
ADD COLUMN Drama INT;
ALTER TABLE GENRES
ADD COLUMN War INT;
ALTER TABLE GENRES
ADD COLUMN Documentary INT;
ALTER TABLE GENRES
ADD COLUMN Mystery INT;
ALTER TABLE GENRES
ADD COLUMN Horror INT;
ALTER TABLE GENRES
ADD COLUMN Family INT;
ALTER TABLE GENRES
ADD COLUMN Fantasy INT;
ALTER TABLE GENRES
ADD COLUMN ScienceFiction INT;
ALTER TABLE GENRES
ADD COLUMN Western INT;
ALTER TABLE GENRES
ADD COLUMN Music INT;
ALTER TABLE GENRES
ADD COLUMN Crime INT;

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
UPDATE GENRES SET Family = 1 where category_name LIKE '%Family%';



ALTER TABLE GENRES
ADD COLUMN PRICE INT

UPDATE GENRES SET PRICE =  COALESCE(FAMILY) + COALESCE(ROMANCE) + COALESCE(Crime) + COALESCE(Music) + COALESCE(Western) + COALESCE(ScienceFiction) + COALESCE(Fantasy) + COALESCE(COMEDY) + COALESCE(THRILLER) + COALESCE(Animation) + COALESCE(Adventure) + COALESCE(Action) + COALESCE(Drama) + COALESCE(War) + COALESCE(Documentary) + COALESCE(Mystery) + COALESCE(Horror)


DELETE from genres WHERE category_name IS NULL

select * from genres