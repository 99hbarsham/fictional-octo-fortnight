CREATE TABLE PRODUCTS (
	product_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    product_name VARCHAR (50),
    product_category VARCHAR (50),
    product_RentPricePerWeek DECIMAL (4,2),
    since_date DATE,
    until_date DATE)
;


UPDATE PRODUCTS
SET product_id = NULL
WHERE
	product_id is not NULL;
    
ALTER TABLE PRODUCTS
MODIFY product_id INT AUTO_INCREMENT;

ALTER TABLE PRODUCTS
MODIFY product_category INT;

ALTER TABLE PRODUCTS
ADD FOREIGN KEY (product_category) REFERENCES CATEGORIES(category_id);


INSERT INTO PRODUCTS
	(product_name, product_category, product_RentPricePerWeek, since_date, until_date)
VALUES
	("To Kill a Mockingbird", 1,"9.80","2022-10-24","2024-04-25"),
	("Dyson V8", 4, "67.94","2023-07-8","2024-10-4"),
	("Sponge", 3,"0.63","2023-08-15","2024-01-1"),
	("Lawnmower", 5,"25.09","2023-03-6","2023-12-8"),
	("Bathroom cleaning service", 3,"88.60","2023-10-3","2024-05-27"),
	("Trowel", 5,"18.79","2022-02-21","2024-02-2"),
	("Blender", 2,"99.44","2023-02-16","2024-06-26"),
	("Macbook Air", 6,"87.41","2023-03-10","2023-11-24"),
	("Stick Blender", 2,"43.02","2023-05-9","2023-12-16"),
	("Electric razor", 3,"53.89","2023-04-4","2023-12-28");

INSERT INTO PRODUCTS
	(product_category)
VALUES
	(1),
    (4),
    (3),
    (5),
    (2),
    (6),
    (2),
    (3),
    (1),
    (1);
  
  
  ## CHANGING TAC - GOING FOR MOVIES

ALTER TABLE TRANSACTIONS
DROP CONSTRAINT transactions_ibfk_2

TRUNCATE TABLE PRODUCTS;

RENAME TABLE PRODUCTS TO MOVIES

INSERT INTO MOVIES
	(product_name, product_RentPricePerWeek, since_date, until_date)
VALUES
	('Me & Isaac Newton', 70.62, '2023-06-23', '2023-11-24'),
	('Break-Up, The', 33.95, '2023-05-18', '2024-06-01'),
	('Boats', 65.79, '2023-07-06', '2023-12-06'),
	('Spend It All', 62.63, '2022-12-26', '2024-06-19'),
	('Hunchback of Notre Dame, The', 28.16, '2023-08-17', '2024-05-12'),
	('Frozen Land (Paha maa)', 41.5, '2023-05-16', '2024-11-09'),
	('While You Were Sleeping', 62.09, '2022-11-25', '2024-04-30'),
	('Claymation Comedy of Horrors', 50.1, '2023-08-11', '2024-06-25'),
	('Hamlet', 39.22, '2023-03-07', '2024-07-24'),
	('Waking Up in Reno', 3.56, '2023-07-22', '2024-08-10'),
	('Princess Tam-Tam (Princesse Tam-Tam)', 18.95, '2022-10-25', '2023-11-27'),
	('Battle of Shaker Heights, The', 4.48, '2023-10-05', '2024-06-17'),
	('The Beast Kills in Cold Blood', 28.37, '2022-11-30', '2024-06-11'),
	('Last Train from Gun Hill', 56.19, '2023-07-31', '2023-12-13'),
	('Rat Pfink a Boo Boo', 59.64, '2023-04-18', '2024-06-01'),
	('44 Inch Chest', 18.19, '2023-08-31', '2024-06-28'),
	('Shall We Dance? (Shall We Dansu?)', 13.11, '2023-01-08', '2024-06-15'),
	('Bad Company', 17.58, '2023-05-08', '2024-06-11'),
	('Duma', 32.37, '2023-04-23', '2024-08-30'),
	('Spellbound', 79.89, '2023-03-30', '2024-11-13'),
	('Dangerous Liaisons', 74.1, '2023-08-11', '2024-02-04'),
	('Silent Night, Deadly Night III: Better Watch Out!', 60.83, '2023-10-10', '2024-03-03'),
	('There Be Dragons', 99.26, '2023-06-15', '2024-04-28'),
	('The Police Serve the Citizens?', 66.01, '2023-10-11', '2023-12-06'),
	('Shakes the Clown', 91.03, '2023-08-17', '2024-07-30'),
	('Harry Potter and the Deathly Hallows: Part 2', 50.34, '2022-11-12', '2024-10-21'),
	('Hotel Reserve', 47.94, '2023-02-15', '2024-09-05'),
	('Newcastle', 82.42, '2023-05-29', '2024-01-10'),
	('Moment After 2, The: The Awakening', 45.62, '2022-11-23', '2024-05-05'),
	('Ray Harryhausen: Special Effects Titan',	20.43, '2022-11-30', '2024-02-08');


#set foreign key
ALTER TABLE MOVIES
ADD FOREIGN KEY (movie_genre) REFERENCES GENRES(category_id);

ALTER TABLE MOVIES
RENAME COLUMN movie_genre to movie_genre_id

# adding new data, changing rent price to uniform value, dropping since/until date columns

ALTER TABLE MOVIES
DROP COLUMN since_date

ALTER TABLE MOVIES
DROP COLUMN until_date

UPDATE MOVIES
SET product_rentPricePerWeek = 10
WHERE product_rentPricePerWeek is not null;

ALTER TABLE MOVIES
ADD COLUMN movie_genre VARCHAR (200)

ALTER TABLE MOVIES
ADD COLUMN movie_releasedate DATE

ALTER TABLE MOVIES
MODIFY movie_name VARCHAR (100)

INSERT INTO MOVIES (movie_name, movie_genre, movie_releasedate)
SELECT DISTINCT original_title, genres, release_date
FROM BIG_MOVIE

## change rent price based on genre (test)

select product_rentPricePerWeek from movies
WHERE movie_genre LIKE '%Animation%'

UPDATE MOVIES
SET product_rentPricePerWeek = 8.5
WHERE movie_genre LIKE '%Animation%'


#data cleaning
UPDATE MOVIES
SET movie_genre = REPLACE(movie_genre, "{'id':", "")
WHERE movie_genre LIKE "%{'id':%"

UPDATE MOVIES
SET movie_genre = REPLACE(movie_genre, "'name':", "")
WHERE movie_genre LIKE "%'name':%"

UPDATE MOVIES
SET movie_genre = REPLACE(movie_genre, "}", "")
WHERE movie_genre LIKE "%}%";

UPDATE MOVIES
SET movie_genre = replace(movie_genre, '[', '');
UPDATE MOVIES
SET movie_genre = replace (movie_genre, ']', '');
UPDATE MOVIES
SET movie_genre = replace (movie_genre, "'", "");
UPDATE MOVIES
	SET movie_genre =  replace (movie_genre, ",", "");

-- add accurate(ish) price (from pricegenerator function)
ALTER TABLE MOVIES
RENAME COLUMN product_RentPricePerWeek to monthlyRentalCost

UPDATE MOVIES
JOIN GENRES
ON MOVIES.movie_genre = GENRES.category_name 
SET monthlyRentalCost = (SELECT ROUND(price + YEAR(movie_releasedate)/100,2))

-- add foreign key from genres table
ALTER TABLE MOVIES
ADD COLUMN movie_genre_id INT

UPDATE MOVIES
JOIN GENRES
ON MOVIES.movie_genre = GENRES.category_name
SET MOVIES.movie_genre_id = GENRES.category_id

ALTER TABLE MOVIES
ADD FOREIGN KEY (movie_genre_id) REFERENCES genres(category_id)

alter table MOVIES
DROP COLUMN movie_genre_id


select * from movies

-- price update
UPDATE MOVIES
JOIN genres g ON movie_genre = category_name
JOIN big_movie b ON b.original_title = movie_name
SET monthlyRentalCost = ROUND((price + YEAR(movie_releasedate)/100)/2,2)
