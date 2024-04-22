-- table creation/data insert - 6 tables with data inserted
-- create products table

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
DROP CONSTRAINT transactions_ibfk_2;

TRUNCATE TABLE PRODUCTS;

RENAME TABLE PRODUCTS TO MOVIES;

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
RENAME COLUMN movie_genre to movie_genre_id;

# adding new data, changing rent price to uniform value, dropping since/until date columns

ALTER TABLE MOVIES
DROP COLUMN since_date;

ALTER TABLE MOVIES
DROP COLUMN until_date;

UPDATE MOVIES
SET product_rentPricePerWeek = 10
WHERE product_rentPricePerWeek is not null;

ALTER TABLE MOVIES
ADD COLUMN movie_genre VARCHAR (200);

ALTER TABLE MOVIES
ADD COLUMN movie_releasedate DATE;

ALTER TABLE MOVIES
MODIFY movie_name VARCHAR (100);

INSERT INTO MOVIES (movie_name, movie_genre, movie_releasedate)
SELECT DISTINCT original_title, genres, release_date
FROM BIG_MOVIE;

## change rent price based on genre (test)

select product_rentPricePerWeek from movies
WHERE movie_genre LIKE '%Animation%';

UPDATE MOVIES
SET product_rentPricePerWeek = 8.5
WHERE movie_genre LIKE '%Animation%';


#data cleaning
UPDATE MOVIES
SET movie_genre = REPLACE(movie_genre, "{'id':", "")
WHERE movie_genre LIKE "%{'id':%";

UPDATE MOVIES
SET movie_genre = REPLACE(movie_genre, "'name':", "")
WHERE movie_genre LIKE "%'name':%";

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
RENAME COLUMN product_RentPricePerWeek to monthlyRentalCost;

UPDATE MOVIES
JOIN GENRES
ON MOVIES.movie_genre = GENRES.category_name 
SET monthlyRentalCost = (SELECT ROUND(price + YEAR(movie_releasedate)/100,2));

-- add foreign key from genres table
ALTER TABLE MOVIES
ADD COLUMN movie_genre_id INT;

UPDATE MOVIES
JOIN GENRES
ON MOVIES.movie_genre = GENRES.category_name
SET MOVIES.movie_genre_id = GENRES.category_id;

ALTER TABLE MOVIES
ADD FOREIGN KEY (movie_genre_id) REFERENCES genres(category_id);

alter table MOVIES
DROP COLUMN movie_genre_id;


select * from movies;

-- price update
UPDATE MOVIES
JOIN genres g ON movie_genre = category_name
JOIN big_movie b ON b.original_title = movie_name
SET monthlyRentalCost = ROUND((price + YEAR(movie_releasedate)/100)/2,2);


-- table 2 - big movie
CREATE TABLE BIG_MOVIE (
	budget INT,
    genres VARCHAR (200),
    id INT,
    original_language VARCHAR (2),
    original_title VARCHAR (50),
    production_countries VARCHAR (200),
    release_date DATE,
    revenue INT,
    runtime INT);
    
ALTER TABLE BIG_MOVIE
MODIFY original_title varchar (200);
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
	("[{'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Toy Story",'1995-10-30',373554033,81.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10751, 'name': 'Family'}]","en","Jumanji",'1995-12-15',262797249,104.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}]","en","Grumpier Old Men",'1995-12-22',0,101.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Waiting to Exhale",'1995-12-22',81452156,127.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Father of the Bride Part II",'1995-02-10',76578911,106.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Heat",'1995-12-15',187436818,170.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Sabrina",'1995-12-15',0,127.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Tom and Huck",'1995-12-22',0,97.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Sudden Death",'1995-12-22',64350171,106.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","GoldenEye",'1995-11-16',352194034,130.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The American President",'1995-11-17',107879496,106.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 27, 'name': 'Horror'}]","en","Dracula: Dead and Loving It",'1995-12-22',0,88.0),
	("[{'id': 10751, 'name': 'Family'}, {'id': 16, 'name': 'Animation'}, {'id': 12, 'name': 'Adventure'}]","en","Balto",'1995-12-22',11348324,78.0),
	("[{'id': 36, 'name': 'History'}, {'id': 18, 'name': 'Drama'}]","en","Nixon",'1995-12-22',13681765,192.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}]","en","Cutthroat Island",'1995-12-22',10017322,119.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Casino",'1995-11-22',116112375,178.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Sense and Sensibility",'1995-12-13',135000000,136.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 35, 'name': 'Comedy'}]","en","Four Rooms",'1995-12-09',4300000,98.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 35, 'name': 'Comedy'}, {'id': 12, 'name': 'Adventure'}]","en","Ace Ventura: When Nature Calls",'1995-11-10',212385533,90.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Money Train",'1995-11-21',35431113,103.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Get Shorty",'1995-10-20',115101622,105.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Copycat",'1995-10-27',0,124.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Assassins",'1995-10-06',30303072,132.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Powder",'1995-10-27',0,111.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Leaving Las Vegas",'1995-10-27',49800000,112.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Othello",'1995-12-15',0,123.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Now and Then",'1995-10-20',27400000,100.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Persuasion",'1995-09-27',0,104.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 12, 'name': 'Adventure'}]","fr","La Cité des Enfants Perdus",'1995-05-16',1738611,108.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","zh","摇啊摇，摇到外婆桥",'1995-04-30',0,108.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Dangerous Minds",'1995-08-11',180000000,99.0),
	("[{'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}]","en","Twelve Monkeys",'1995-12-29',168840000,129.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 12, 'name': 'Adventure'}]","fr","Guillaumet, les ailes du courage",'1996-09-18',0,50.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Babe",'1995-07-18',254134910,89.0),
	("[{'id': 36, 'name': 'History'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Carrington",'1995-11-08',0,121.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Dead Man Walking",'1995-12-29',39363635,122.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 36, 'name': 'History'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Across the Sea of Time",'1995-10-20',0,51.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}]","en","It Takes Two",'1995-11-17',0,101.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Clueless",'1995-07-19',0,97.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Cry, the Beloved Country",'1995-12-15',676525,106.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}]","en","Richard III",'1995-12-29',0,104.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Dead Presidents",'1995-10-06',0,119.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Restoration",'1995-12-29',0,117.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 14, 'name': 'Fantasy'}]","en","Mortal Kombat",'1995-08-18',122195920,101.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}]","en","To Die For",'1995-05-20',21284514,106.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","How To Make An American Quilt",'1995-10-06',23574130,116.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Se7en",'1995-09-22',327311859,127.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 16, 'name': 'Animation'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Pocahontas",'1995-06-14',346079773,81.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","When Night Is Falling",'1995-05-05',0,96.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","The Usual Suspects",'1995-07-19',23341568,106.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}]","en","Guardian Angel",'1994-11-22',0,93.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Mighty Aphrodite",'1995-09-13',6700000,95.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}]","it","Lamerica",'1994-01-01',0,116.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Big Green",'1995-09-29',0,100.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Georgia",'1995-05-19',0,115.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Home for the Holidays",'1995-11-02',17519169,103.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","it","Il postino",'1994-09-22',0,108.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","fr","Le confessionnal",'1995-09-29',0,100.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","The Indian in the Cupboard",'1995-07-14',0,96.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Eye for an Eye",'1996-01-12',0,101.0),
	("[{'id': 10402, 'name': 'Music'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Mr. Holland's Opus",'1995-12-29',106269971,137.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Don't Be a Menace to South Central While Drinking Your Juice in the Hood",'1996-01-12',0,89.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Two If by Sea",'1996-01-12',0,96.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Bio-Dome",'1996-01-12',0,88.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 878, 'name': 'Science Fiction'}]","en","Lawnmower Man 2: Beyond Cyberspace",'1996-01-12',2409225,92.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Two Bits",'1995-10-22',0,85.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","fr","Gazon maudit",'1995-02-08',0,95.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Friday",'1995-04-26',28215918,91.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","From Dusk Till Dawn",'1996-01-19',25836616,108.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 10749, 'name': 'Romance'}]","en","Fair Game",'1995-11-03',11534477,91.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Kicking and Screaming",'1995-10-06',718490,96.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","fr","Les misérables",'1995-03-22',0,175.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Bed of Roses",'1996-01-26',19030691,87.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Big Bully",'1996-01-26',2042530,90.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}]","en","Screamers",'1995-09-08',5781885,108.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","Nico Icon",'1995-02-18',0,70.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Crossing Guard",'1995-11-15',0,111.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Juror",'1996-02-02',0,118.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Things to Do in Denver When You're Dead",'1995-12-01',529766,116.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","nl","Antonia",'1995-09-12',0,102.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","Once Upon a Time... When We Were Colored",'1996-01-26',0,115.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Angels and Insects",'1995-09-10',0,118.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}]","en","White Squall",'1996-02-02',10300000,129.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Dunston Checks In",'1996-01-12',0,88.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Black Sheep",'1996-02-01',32,87.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Nick of Time",'1995-11-22',8175346,90.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The Journey of August King",'1995-09-14',0,91.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}, {'id': 10749, 'name': 'Romance'}]","en","Mary Reilly",'1996-02-23',12379402,104.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 27, 'name': 'Horror'}, {'id': 10749, 'name': 'Romance'}]","en","Vampire in Brooklyn",'1995-10-26',19800000,100.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Beautiful Girls",'1996-02-09',0,112.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Broken Arrow",'1996-02-09',150270147,108.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","A Midwinter's Tale",'1995-12-01',0,99.0),
	("[{'id': 18, 'name': 'Drama'}]","fr","La Haine",'1995-05-31',0,98.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Shopping",'1994-12-06',0,105.0);
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
	("[{'id': 99, 'name': 'Documentary'}]","en","Heidi Fleiss: Hollywood Madam",'1995-12-27',0,106.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","City Hall",'1996-02-16',0,111.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Bottle Rocket",'1996-02-21',560069,91.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Mr. Wrong",'1996-02-16',0,96.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Unforgettable",'1996-02-23',0,106.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Happy Gilmore",'1996-02-16',41205099,92.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Bridges of Madison County",'1995-05-28',182016617,135.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","de","Keiner liebt mich",'1994-11-07',0,104.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}, {'id': 10751, 'name': 'Family'}, {'id': 12, 'name': 'Adventure'}]","en","Muppet Treasure Island",'1996-02-16',34327391,100.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","Catwalk",'1995-12-08',0,95.0),
	("[{'id': 80, 'name': 'Crime'}]","en","Headless Body in Topless Bar",'1995-05-20',0,110.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10752, 'name': 'War'}]","en","Braveheart",'1995-05-24',210000000,177.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Taxi Driver",'1976-02-07',28262574,114.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Before and After",'1996-02-23',0,108.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Margaret's Museum",'1995-09-13',0,114.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Le Bonheur est dans le pré",'1995-01-31',0,106.0);

INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
	("[{'id': 99, 'name': 'Documentary'}, {'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}]","en","Anne Frank Remembered",'1995-06-08',1,117.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","The Young Poisoner's Handbook",'1995-01-20',0,99.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","If Lucy Fell",'1996-03-08',0,92.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Steal Big Steal Little",'1995-09-29',6278139,113.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Race the Sun",'1996-03-22',0,100.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The Boys of St. Vincent",'1992-12-06',0,90.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Boomerang",'1992-06-30',70100000,117.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","cn","重慶森林",'1994-07-14',0,102.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","it","L'uomo delle stelle",'1995-09-21',0,113.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Flirting with Disaster",'1996-03-22',14702438,92.0),
	("[{'id': 14, 'name': 'Fantasy'}]","en","The NeverEnding Story III",'1994-10-26',0,95.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Pie in the Sky",'1996-02-09',0,95.0);
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Angela",'1995-01-01',0,99.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","en","Frankie Starlight",'1995-11-22',0,101.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}]","en","Jade",'1995-10-13',9851610,95.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","es","Nueba Yol",'1995-08-16',0,102.0),
	("[{'id': 10402, 'name': 'Music'}, {'id': 99, 'name': 'Documentary'}]","en","Sonic Outlaws",'1995-08-01',0,87.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Down Periscope",'1996-03-01',0,92.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","From the Journals of Jean Seberg",'1995-09-08',0,97.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Man of the Year",'1995-09-15',209935,86.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The Neon Bible",'1995-08-23',0,91.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Up Close & Personal",'1996-03-01',0,119.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","The Birdcage",'1996-03-08',185260553,117.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Gospa",'1995-10-12',0,125.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Brothers McMullen",'1995-08-09',0,98.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Bad Boys",'1995-04-07',141407024,118.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","The Amazing Panda Adventure",'1995-08-25',0,81.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","The Basketball Diaries",'1995-04-21',0,102.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","An Awfully Big Adventure",'1995-07-21',851545,113.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Amateur",'1994-08-05',0,105.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Apollo 13",'1995-06-30',355237933,140.0),
	("[{'id': 12, 'name': 'Adventure'}]","en","Rob Roy",'1995-04-13',31596911,139.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}]","en","The Addiction",'1995-01-10',0,82.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 14, 'name': 'Fantasy'}]","en","Batman Forever",'1995-06-16',336529144,121.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","fr","Belle de jour",'1967-05-24',0,101.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Beyond Rangoon",'1995-05-24',0,100.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Blue in the Face",'1995-09-15',1275000,83.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","Canadian Bacon",'1995-06-08',178104,91.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Casper",'1995-05-26',287928194,100.0),
	("[{'id': 9648, 'name': 'Mystery'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Clockers",'1995-09-15',13071518,128.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Congo",'1995-06-09',152022101,109.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}]","en","Crimson Tide",'1995-05-12',157387195,116.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","Crumb",'1994-09-10',3174695,119.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}]","en","Desperado",'1995-08-25',25405445,104.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Devil in a Blue Dress",'1995-09-15',16140822,102.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Die Hard: With a Vengeance",'1995-05-19',366101666,128.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","The Doom Generation",'1995-10-27',0,80.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Feast of July",'1995-10-12',0,116.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","First Knight",'1995-07-07',127600435,134.0),
	("[{'id': 12, 'name': 'Adventure'}]","en","Free Willy 2 - The Adventure Home",'1995-07-19',0,95.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}]","en","Hackers",'1995-09-14',7563728,107.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Jeffrey",'1995-08-18',0,92.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Johnny Mnemonic",'1995-05-26',19075720,97.0),
	("[{'id': 878, 'name': 'Science Fiction'}]","en","Judge Dredd",'1995-06-30',113493481,96.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Jury Duty",'1995-04-12',17014653,88.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Kids",'1995-07-28',7412216,91.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Living in Oblivion",'1995-01-20',1148752,89.0),
	("[{'id': 9648, 'name': 'Mystery'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Lord of Illusions",'1995-08-25',0,119.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Love & Human Remains",'1993-05-20',0,100.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}]","en","Mad Love",'1995-05-26',15453274,95.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}]","en","Mallrats",'1995-10-20',2122561,94.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Mighty Morphin Power Rangers: The Movie",'1995-06-30',66000000,92.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Moonlight and Valentino",'1995-09-29',0,100.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 10769, 'name': 'Foreign'}]","en","Mute Witness",'1995-09-28',1,95.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Nadja",'1994-09-13',0,93.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}, {'id': 28, 'name': 'Action'}]","en","The Net",'1995-07-28',110627965,114.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Nine Months",'1995-07-12',69660733,103.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Party Girl",'1995-06-09',472370,94.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","The Prophecy",'1995-09-01',16,98.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Reckless",'1995-11-17',0,91.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Safe",'1995-06-23',0,119.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10749, 'name': 'Romance'}]","en","The Scarlet Letter",'1995-10-13',10382407,135.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","The Show",'1995-08-25',0,93.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Showgirls",'1995-09-22',20350754,128.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Smoke",'1995-06-09',8349430,112.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Something to Talk About",'1995-08-04',50892160,106.0),
	("[{'id': 878, 'name': 'Science Fiction'}, {'id': 27, 'name': 'Horror'}, {'id': 28, 'name': 'Action'}]","en","Species",'1995-07-07',113374103,108.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The Stars Fell on Henrietta",'1995-09-15',0,109.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Strange Days",'1995-10-13',7959291,145.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","fr","Les parapluies de Cherbourg",'1964-02-19',0,91.0),
	("[{'id': 53, 'name': 'Thriller'}]","en","The Tie That Binds",'1995-09-08',5780000,99.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}]","en","Three Wishes",'1995-10-27',7025496,115.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Total Eclipse",'1995-11-02',339889,111.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","To Wong Foo, Thanks for Everything! Julie Newmar",'1995-09-07',47774193,105.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Under Siege 2: Dark Territory",'1995-07-13',104324083,100.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Unstrung Heroes",'1995-09-15',0,93.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","Unzipped",'1995-08-11',0,73.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","A Walk in the Clouds",'1995-08-11',50012507,103.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}]","en","Waterworld",'1995-07-28',264218220,135.0),
	("[{'id': 18, 'name': 'Drama'}]","en","White Man's Burden",'1995-12-01',0,89.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 37, 'name': 'Western'}]","en","Wild Bill",'1995-12-01',0,98.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The Browning Version",'1994-10-12',0,97.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 10751, 'name': 'Family'}]","en","Bushwhacked",'1995-08-04',0,90.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}]","en","Before the Rain",'1994-06-09',763847,113.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Before Sunrise",'1995-01-27',5535405,105.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Billy Madison",'1995-02-10',26488734,89.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Babysitter",'1995-10-17',0,90.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Boys on the Side",'1995-02-03',23450000,115.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","The Cure",'1995-04-21',0,97.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}]","en","Castle Freak",'1995-08-04',0,95.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}]","en","Circle of Friends",'1995-03-16',0,103.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Clerks",'1994-09-13',3151130,92.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Don Juan DeMarco",'1994-10-01',22200000,97.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}]","en","Disclosure",'1994-12-09',214015089,123.0),
	("[{'id': 53, 'name': 'Thriller'}]","en","Dream Man",'1995-01-01',0,0.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Drop Zone",'1994-12-08',0,101.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}]","it","Destiny Turns on the Radio",'1995-04-28',0,0.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}]","en","Death and the Maiden",'1994-05-04',0,103.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","en","Dolores Claiborne",'1995-03-24',0,132.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Dumb and Dumber",'1994-12-16',247275374,107.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","en","Exotica",'1994-09-24',0,103.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 10749, 'name': 'Romance'}]","en","Exit to Eden",'1994-10-14',6841570,113.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Ed Wood",'1994-09-27',5887457,127.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","French Kiss",'1995-05-05',0,111.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Forget Paris",'1995-05-19',0,101.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Far from Home: The Adventures of Yellow Dog",'1995-01-13',0,87.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}, {'id': 35, 'name': 'Comedy'}, {'id': 12, 'name': 'Adventure'}]","en","A Goofy Movie",'1995-04-07',35348597,78.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Hideaway",'1995-03-03',12201255,103.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Fluke",'1995-06-02',0,96.0),
	("[{'id': 36, 'name': 'History'}, {'id': 18, 'name': 'Drama'}]","fr","Farinelli",'1994-12-07',0,111.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Gordy",'1995-05-12',3992809,90.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 16, 'name': 'Animation'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","Gumby: The Movie",'1995-12-01',0,77.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","The Glass Shield",'1994-09-16',0,109.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","Hoop Dreams",'1994-09-12',7830611,171.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}]","en","Heavenly Creatures",'1994-09-02',3049135,99.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Houseguest",'1995-01-06',26325256,113.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","Immortal Beloved",'1994-12-16',0,121.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 18, 'name': 'Drama'}]","en","Heavyweights",'1995-02-17',17689177,100.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","The Hunted",'1995-02-24',0,106.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","I.Q.",'1994-12-24',0,100.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 10749, 'name': 'Romance'}]","en","Interview with the Vampire",'1994-11-11',223664608,123.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Jefferson in Paris",'1995-03-31',2474000,139.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","The Jerky Boys",'1995-02-03',0,82.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}]","en","Junior",'1994-11-22',37000000,109.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Just Cause",'1995-02-17',0,102.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","A Kid in King Arthur's Court",'1995-08-11',0,89.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Kiss of Death",'1995-04-21',0,101.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 878, 'name': 'Science Fiction'}]","en","Star Wars",'1977-05-25',775398007,121.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Little Women",'1994-12-21',0,115.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","A Little Princess",'1995-05-10',0,97.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Ladybird Ladybird",'1994-02-18',0,101.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","fr","L'Enfer",'1994-02-16',0,100.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","es","Como agua para chocolate",'1992-04-16',21665468,105.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","en","Legends of the Fall",'1994-12-16',160638883,133.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Major Payne",'1995-03-24',0,95.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}]","en","Little Odessa",'1994-10-27',0,98.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Mi Vida Loca",'1994-06-08',0,92.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Love Affair",'1994-10-21',0,108.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Losing Isaiah",'1995-03-17',7603766,106.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","The Madness of King George",'1994-12-28',0,107.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10749, 'name': 'Romance'}]","en","Frankenstein",'1994-11-04',112006296,123.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Man of the House",'1995-03-03',0,96.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Mixed Nuts",'1994-12-21',0,97.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Milk Money",'1994-08-31',18137661,108.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Miracle on 34th Street",'1994-11-18',46264384,114.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Miami Rhapsody",'1995-01-27',5,95.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","My Family",'1995-05-03',0,128.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Murder in the First",'1995-01-20',17381942,122.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Nobody's Fool",'1994-12-23',0,110.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Nell",'1994-12-23',106683817,112.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","New Jersey Drive",'1995-04-19',0,98.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","New York Cop",'1993-08-14',0,93.0),
	("[{'id': 27, 'name': 'Horror'}]","en","Beyond Bedlam",'1994-04-22',0,89.0),
	("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Nemesis 2 - Nebula",'1995-09-26',0,83.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Nina Takes a Lover",'1995-03-03',0,100.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}]","en","Natural Born Killers",'1994-08-25',50282766,119.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Only You",'1994-09-17',0,115.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Once Were Warriors",'1994-09-02',2201126,99.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","Poison Ivy II: Lily",'1996-01-16',0,106.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Outbreak",'1995-03-10',189859560,127.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","fr","Léon",'1994-09-14',45284974,110.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Perez Family",'1995-05-12',2832826,113.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","A Pyromaniac's Love Story",'1995-04-28',0,94.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Pulp Fiction",'1994-09-10',213928762,154.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Panther",'1995-11-10',6834525,124.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Priest",'1994-01-01',4176932,98.0),
	("[{'id': 36, 'name': 'History'}, {'id': 18, 'name': 'Drama'}]","en","Quiz Show",'1994-09-16',0,133.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Picture Bride",'1995-05-05',0,94.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","fr","La Reine Margot",'1994-05-13',0,162.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 37, 'name': 'Western'}]","en","The Quick and the Dead",'1995-02-09',18552460,107.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","sv","Roommates",'1995-03-01',12400000,108.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Prêt-à-Porter",'1994-12-23',11300653,133.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}]","fr","Trois couleurs : Rouge",'1994-05-27',0,99.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}, {'id': 9648, 'name': 'Mystery'}]","fr","Trois couleurs : Bleu",'1993-01-10',0,98.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","fr","Trois couleurs : Blanc",'1994-01-26',0,91.0),
	("[{'id': 18, 'name': 'Drama'}]","zh","Pao Da Shuang Deng",'1994-10-14',0,111.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 10770, 'name': 'TV Movie'}]","en","Rent-a-Kid",'1995-01-01',0,85.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 18, 'name': 'Drama'}]","en","Relative Fear",'1995-10-03',0,90.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Stuart Saves His Family",'1995-04-12',0,95.0),
	("[{'id': 16, 'name': 'Animation'}]","en","The Swan Princess",'1994-11-18',9771658,89.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","The Secret of Roan Inish",'1994-01-01',0,97.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","The Specialist",'1994-10-07',170362582,110.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 878, 'name': 'Science Fiction'}]","en","Stargate",'1994-10-27',196567262,121.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Santa Clause",'1994-11-10',189833357,97.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","The Shawshank Redemption",'1994-09-23',28341469,142.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Shallow Grave",'1994-12-22',0,92.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Suture",'1993-09-14',102780,96.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","es","Fresa y chocolate",'1993-01-01',0,108.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 35, 'name': 'Comedy'}]","en","Swimming with Sharks",'1994-09-10',0,101.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Sum of Us",'1994-07-12',0,100.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Senior Trip",'1995-09-08',0,91.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}]","en","Tank Girl",'1995-03-31',4064495,98.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}]","en","Tales from the Crypt: Demon Knight",'1995-01-13',0,92.0),
	("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Star Trek: Generations",'1994-11-17',120000000,118.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Tales from the Hood",'1995-05-24',12000000,98.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Tom & Viv",'1994-04-15',0,115.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}]","en","Village of the Damned",'1995-04-28',0,99.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Tommy Boy",'1995-03-31',32648673,97.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Vanya on 42nd Street",'1994-09-13',0,119.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","The Underneath",'1995-04-28',0,99.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}]","en","The Walking Dead",'1995-02-24',0,88.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","What's Eating Gilbert Grape",'1993-12-17',10032765,118.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Virtuosity",'1995-08-04',24048000,106.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","While You Were Sleeping",'1995-04-21',182057016,103.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The War",'1994-11-04',0,126.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Double Happiness",'1994-09-07',759393,87.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Muriel's Wedding",'1994-09-29',15119639,106.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","The Baby-Sitters Club",'1995-08-18',0,94.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 9648, 'name': 'Mystery'}]","en","Ace Ventura: Pet Detective",'1994-02-04',107217396,86.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","The Adventures of Priscilla, Queen of the Desert",'1994-05-31',11220670,104.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}]","en","Backbeat",'1994-04-01',0,100.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Bitter Moon",'1992-09-02',1862805,139.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}]","en","Bullets Over Broadway",'1994-10-14',0,98.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Clear and Present Danger",'1994-08-03',215887717,141.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}]","en","The Client",'1994-07-20',117615211,119.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}]","en","Corrina, Corrina",'1994-08-12',0,115.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Crooklyn",'1994-05-13',0,115.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","The Crow",'1994-05-11',94000000,102.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Cobb",'1994-12-02',1007583,128.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Flintstones",'1994-05-26',341631208,91.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Forrest Gump",'1994-07-06',677945399,142.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Four Weddings and a Funeral",'1994-03-09',254700832,117.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Higher Learning",'1995-01-11',38290723,127.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","I Like It Like That",'1994-10-14',1777020,104.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","I Love Trouble",'1994-06-29',61947267,123.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","It Could Happen to You",'1994-07-29',0,101.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","The Jungle Book",'1994-12-23',0,111.0),
	("[{'id': 99, 'name': 'Documentary'}, {'id': 10769, 'name': 'Foreign'}]","en","Die Macht der Bilder: Leni Riefenstahl",'1993-09-11',449707,180.0),
	("[{'id': 10751, 'name': 'Family'}, {'id': 16, 'name': 'Animation'}, {'id': 18, 'name': 'Drama'}]","en","The Lion King",'1994-06-23',788241776,89.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Little Buddha",'1993-12-01',4858139,140.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}, {'id': 14, 'name': 'Fantasy'}]","en","New Nightmare",'1994-10-13',18090181,112.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 14, 'name': 'Fantasy'}]","en","The Mask",'1994-07-29',351583407,101.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 37, 'name': 'Western'}]","en","Maverick",'1994-05-20',0,127.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Mrs. Parker and the Vicious Circle",'1994-09-07',0,125.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","The Naked Gun 33⅓: The Final Insult",'1994-03-18',51132598,83.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The Paper",'1994-03-18',0,112.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Reality Bites",'1994-02-18',20079850,99.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Red Rock West",'1993-07-08',2000000,98.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Ri¢hie Ri¢h",'1994-12-19',0,95.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Safe Passage",'1994-12-01',0,98.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","The River Wild",'1994-09-30',0,111.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}]","en","Speed",'1994-06-09',350448145,116.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Speechless",'1994-12-16',0,99.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}]","en","Timecop",'1994-09-15',101646581,99.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","True Lies",'1994-07-14',378882411,141.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","When a Man Loves a Woman",'1994-04-29',50021959,126.0),
	("[{'id': 14, 'name': 'Fantasy'}]","en","Wolf",'1994-06-17',0,125.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 37, 'name': 'Western'}]","en","Wyatt Earp",'1994-06-24',25052000,191.0),
	("[{''id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","Bad Company",'1995-01-20',0,108.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","A Man of No Importance",'1994-12-22',953,99.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","S.F.W.",'1994-09-15',0,96.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","A Low Down Dirty Shame",'1994-11-23',29392418,100.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Boys Life: Three Stories of Love, Lust, and Liberation",'1994-09-30',0,91.0),
	("[{'id': 18, 'name': 'Drama'}]","fr","Le colonel Chabert",'1994-01-01',0,110.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}]","en","Faster, Pussycat! Kill! Kill!",'1965-08-06',0,83.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Jason's Lyric",'1994-09-28',20851521,119.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Secret Adventures of Tom Thumb",'1993-12-10',0,61.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Street Fighter",'1994-12-22',99423521,102.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","Coldblooded",'1995-09-15',0,92.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Fall Time",'1995-05-13',0,88.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","The Fear",'1995-01-20',0,98.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","Frank and Ollie",'1995-10-20',0,89.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Girl in the Cadillac",'1995-10-24',0,89.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}]","en","Homage",'1995-05-03',0,97.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Mirage",'1995-11-21',0,92.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Open Season",'1996-05-03',0,97.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","Brother Minister: The Assassination of Malcolm X",'1995-03-01',0,115.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}]","en","Highlander III: The Sorcerer",'1994-11-29',36800000,99.0),
	("","en","Federal Hill",'1995-02-24',0,97.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","In the Mouth of Madness",'1994-12-12',8946600,95.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","8 Seconds",'1994-02-25',0,105.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Above the Rim",'1994-03-23',0,96.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Addams Family Values",'1993-11-19',48919043,94.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Martin Lawrence: You So Crazy",'1994-04-27',0,84.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Age of Innocence",'1993-09-17',32255440,139.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 10402, 'name': 'Music'}]","en","Airheads",'1994-08-05',0,92.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Air Up There",'1994-01-07',21011500,107.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","Another Stakeout",'1993-07-22',0,105.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 37, 'name': 'Western'}]","en","Bad Girls",'1994-04-22',15240435,99.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Barcelona",'1994-07-29',0,100.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}]","en","Being Human",'1994-05-06',0,122.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","The Beverly Hillbillies",'1993-10-15',0,93.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Beverly Hills Cop III",'1994-05-24',119208989,104.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Black Beauty",'1994-07-29',0,88.0),
	("[{'id': 9648, 'name': 'Mystery'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Blink",'1994-01-26',16668552,106.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Blown Away",'1994-07-01',30156002,121.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Blue Chips",'1994-02-18',0,108.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Blue Sky",'1994-09-16',0,101.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Body Snatchers",'1993-06-09',428868,87.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Boxing Helena",'1993-06-18',1796389,107.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","A Bronx Tale",'1993-09-14',17287898,121.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Cabin Boy",'1994-01-07',3662459,80.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Calendar Girl",'1993-09-03',2570145,90.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Carlito's Way",'1993-11-10',36516012,144.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 37, 'name': 'Western'}]","en","City Slickers II: The Legend of Curly's Gold",'1994-06-10',0,116.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}]","en","Clean Slate",'1994-05-06',7355425,107.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Cliffhanger",'1993-05-28',255000211,112.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","Coneheads",'1993-07-23',0,88.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","Color of Night",'1994-08-19',19726050,121.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Cops & Robbersons",'1994-04-15',0,93.0),
	("[{'id': 37, 'name': 'Western'}, {'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","The Cowboy Way",'1994-06-03',0,102.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Dangerous Game",'1993-11-19',0,108.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Dave",'1993-05-07',63000000,110.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Dazed and Confused",'1993-09-24',7993039,102.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 28, 'name': 'Action'}, {'id': 878, 'name': 'Science Fiction'}]","en","Demolition Man",'1993-10-08',159055768,115.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","The Endless Summer 2",'1994-06-03',0,109.0),
	("[{'id': 37, 'name': 'Western'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Even Cowgirls Get the Blues",'1994-05-13',0,96.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Fatal Instinct",'1993-10-29',0,91.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","The Favor",'1994-04-29',0,97.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Fearless",'1993-10-15',0,122.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Fear of a Black Hat",'1994-10-28',0,88.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","With Honors",'1994-04-29',0,103.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}]","en","Flesh and Bone",'1993-11-05',9488998,126.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}, {'id': 10769, 'name': 'Foreign'}]","en","Widows' Peak",'1994-05-13',0,101.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","For Love or Money",'1993-10-01',11146270,94.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Firm",'1993-06-30',270248367,154.0),
	("[{'id': 10751, 'name': 'Family'}, {'id': 12, 'name': 'Adventure'}]","en","Free Willy",'1993-07-16',153698625,112.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Fresh",'1994-08-24',0,114.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}]","en","The Fugitive",'1993-08-06',368875760,130.0),
	("[{'id': 36, 'name': 'History'}, {'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 37, 'name': 'Western'}]","en","Geronimo: An American Legend",'1993-12-10',18635620,115.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","The Getaway",'1994-02-11',30,115.0),
	("[{'id': 10751, 'name': 'Family'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Getting Even with Dad",'1994-06-17',0,109.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Go Fish",'1994-06-10',0,83.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","A Good Man in Africa",'1994-07-14',0,94.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Guilty as Sin",'1993-06-04',22886222,107.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Hard Target",'1993-08-20',74189677,97.0),
	("[{'id': 36, 'name': 'History'}, {'id': 10752, 'name': 'War'}, {'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}]","en","Heaven & Earth",'1993-12-24',0,140.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 10752, 'name': 'War'}]","en","Hot Shots! Part Deux",'1993-05-21',133752825,86.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Live Nude Girls",'1995-12-08',0,95.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","The Englishman Who Went Up a Hill But Came Down a Mountain",'1995-05-12',0,99.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","The House of the Spirits",'1993-10-19',0,140.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","House Party 3",'1994-01-01',0,100.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The Hudsucker Proxy",'1994-03-11',0,111.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","I'll Do Anything",'1994-02-04',0,115.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","In the Army Now",'1994-08-12',28881266,91.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}]","en","In the Line of Fire",'1993-07-08',176997168,128.0),
	("[{'id': 18, 'name': 'Drama'}]","en","In the Name of the Father",'1993-12-12',65796862,133.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Inkwell",'1994-04-22',8880705,110.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}]","en","What's Love Got to Do with It",'1993-06-09',0,118.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Jimmy Hollywood",'1994-03-30',0,112.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Judgment Night",'1993-10-15',12136938,110.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 878, 'name': 'Science Fiction'}]","en","Jurassic Park",'1993-06-11',920100000,127.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Kalifornia",'1993-09-01',2395231,117.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Killing Zoe",'1993-10-01',418961,96.0),
	("[{'id': 18, 'name': 'Drama'}]","en","King of the Hill",'1993-08-20',0,103.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Lassie",'1994-07-22',0,94.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Last Action Hero",'1993-06-18',137298489,130.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Life With Mikey",'1993-06-04',0,91.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 37, 'name': 'Western'}]","en","Lightning Jack",'1994-03-11',0,98.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","M. Butterfly",'1993-09-09',1499795,101.0);
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES    
	("[{'id': 35, 'name': 'Comedy'}]","en","Made in America",'1993-05-27',0,111.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Malice",'1993-09-29',46405336,107.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The Man without a Face",'1993-08-25',24760338,114.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 9648, 'name': 'Mystery'}]","en","Manhattan Murder Mystery",'1993-08-18',11285588,104.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}]","en","Menace II Society",'1993-05-26',27900000,97.0);
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES      
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Executive Decision",'1996-03-15',121969216,133.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","What Happened Was...",'1994-09-09',0,91.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Much Ado About Nothing",'1993-05-07',0,111.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Mr. Jones",'1993-10-08',0,114.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Mr. Wonderful",'1993-10-15',0,98.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Mrs. Doubtfire",'1993-11-24',441286195,125.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Naked",'1993-09-14',0,131.0),
	("[{'id': 12, 'name': 'Adventure'}]","en","The Next Karate Kid",'1994-07-18',15826984,107.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The New Age",'1994-09-16',0,112.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","No Escape",'1994-04-29',15340000,118.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}]","en","North",'1994-07-22',0,87.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}]","en","Orlando",'1992-09-01',0,93.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","A Perfect World",'1993-11-24',135130999,138.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Philadelphia",'1993-12-22',206678440,125.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Piano",'1993-05-19',116700000,121.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Poetic Justice",'1993-07-23',27515786,109.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The Program",'1993-09-24',23042200,112.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","The Puppet Masters",'1994-10-21',8638072,109.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}]","en","Radioland Murders",'1994-10-21',0,108.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","The Ref",'1994-03-09',11439193,97.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Remains of the Day",'1993-11-05',23237911,134.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10752, 'name': 'War'}]","en","Renaissance Man",'1994-06-03',24332324,128.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Rising Sun",'1993-07-30',107198790,125.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","The Road to Wellville",'1994-10-28',0,118.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","RoboCop 3",'1993-04-17',10696210,104.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Robin Hood: Men in Tights",'1993-07-28',35739755,104.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Romeo Is Bleeding",'1993-09-13',3275585,100.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Romper Stomper",'1992-03-05',0,94.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Ruby in Paradise",'1993-10-08',1001437,114.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Rudy",'1993-09-17',22750363,114.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The Saint of Fort Washington",'1993-11-03',0,99.0),
	("[{'id': 18, 'name': 'Drama'}]","fr","Les Nuits Fauves",'1992-08-19',0,126.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10752, 'name': 'War'}]","en","Schindler's List",'1993-11-29',321365567,195.0),
	("[{''id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The Scout",'1994-09-30',0,101.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Searching for Bobby Fischer",'1993-08-13',7266383,110.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Second Best",'1994-09-30',0,105.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","The Secret Garden",'1993-08-13',0,102.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Serial Mom",'1994-04-13',7820688,95.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Shadow",'1994-07-01',48063435,108.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Shadowlands",'1993-12-25',0,131.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Short Cuts",'1993-09-05',6110979,187.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","A Simple Twist of Fate",'1994-09-02',0,106.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Sirens",'1993-10-01',7770731,98.0),
	("[{'id': 9648, 'name': 'Mystery'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Six Degrees of Separation",'1993-12-08',0,112.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Sleepless in Seattle",'1993-06-24',227799884,105.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Sliver",'1993-05-21',116300000,108.0),
	("[{'id': 878, 'name': 'Science Fiction'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Blade Runner",'1982-06-25',33139618,117.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Son in Law",'1993-07-02',36448200,95.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 10749, 'name': 'Romance'}]","en","So I Married an Axe Murderer",'1993-07-30',11585483,93.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 28, 'name': 'Action'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Striking Distance",'1993-09-17',0,102.0),
	("[{'id': 36, 'name': 'History'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Harem",'1985-11-20',0,113.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Super Mario Bros.",'1993-05-28',20915465,104.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Surviving the Game",'1994-04-15',7690013,96.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Terminal Velocity",'1994-09-23',16478900,102.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}]","en","Thirty Two Short Films About Glenn Gould",'1993-11-26',0,93.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}]","en","Threesome",'1994-04-08',0,93.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}]","en","The Nightmare Before Christmas",'1993-10-09',75634409,76.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}]","en","The Three Musketeers",'1993-11-11',53898845,105.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 37, 'name': 'Western'}]","en","Tombstone",'1993-12-25',56505065,130.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Trial by Jury",'1994-09-09',0,107.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 10749, 'name': 'Romance'}]","en","True Romance",'1993-09-09',12281551,120.0),
	("[{'id': 99, 'name': 'Documentary'}, {'id': 36, 'name': 'History'}]","en","The War Room",'1993-12-05',0,96.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}, {'id': 16, 'name': 'Animation'}]","en","The Pagemaster",'1994-11-23',13670688,80.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Paris, France",'1994-02-04',0,112.0),
	("","en","The Beans of Egypt, Maine",'1994-01-01',0,0.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Killer",'1994-09-14',0,97.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Welcome to the Dollhouse",'1995-05-24',0,88.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Germinal",'1993-09-29',0,160.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Chasers",'1994-04-22',1596687,102.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Cronos",'1993-09-12',0,94.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Naked in New York",'1993-11-10',0,95.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","es","Kika",'1993-10-28',0,117.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Bhaji on the Beach",'1994-01-21',0,100.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Little Big League",'1994-06-29',0,119.0),
	("[{'id': 18, 'name': 'Drama'}]","sv","Kådisbellan",'1993-09-24',0,102.0),
	("[{'id': 10770, 'name': 'TV Movie'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}]","en","Wide Eyed and Legless",'1993-09-05',0,102.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Foreign Student",'1994-07-29',0,90.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10769, 'name': 'Foreign'}]","en","Io speriamo che me la cavo",'1992-10-01',0,100.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Spanking the Monkey",'1994-01-15',0,106.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Little Rascals",'1994-08-05',67308282,82.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","À la mode",'1993-09-10',0,82.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 12, 'name': 'Adventure'}]","en","Andre",'1994-08-17',0,94.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","","La scorta",'1993-01-01',0,92.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 9648, 'name': 'Mystery'}]","en","Princess Caraboo",'1994-09-16',3021629,97.0),
	("[{'id': 36, 'name': 'History'}, {'id': 99, 'name': 'Documentary'}]","en","The Celluloid Closet",'1996-01-30',0,102.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 10769, 'name': 'Foreign'}]","en","Métisse",'1993-01-01',0,94.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","","Caro diario",'1993-10-12',0,100.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","De eso no se habla",'1993-05-20',0,106.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","The Brady Bunch Movie",'1995-02-16',0,84.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Home Alone",'1990-11-09',476684675,103.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}]","en","Ghost",'1990-07-12',505000000,127.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}, {'id': 35, 'name': 'Comedy'}, {'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10749, 'name': 'Romance'}]","en","Aladdin",'1992-11-25',504050219,90.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}]","en","Terminator 2: Judgment Day",'1991-07-01',520000000,137.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 37, 'name': 'Western'}]","en","Dances with Wolves",'1990-11-09',424208848,181.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}]","en","Tough and Deadly",'1995-02-14',0,92.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 28, 'name': 'Action'}]","en","Batman",'1989-06-23',411348924,126.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Silence of the Lambs",'1991-02-01',272742922,119.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}]","en","Snow White and the Seven Dwarfs",'1937-12-20',184925486,83.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 10751, 'name': 'Family'}, {'id': 16, 'name': 'Animation'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10402, 'name': 'Music'}]","en","Beauty and the Beast",'1991-11-13',377350553,84.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}]","en","Pinocchio",'1940-02-23',84300000,88.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}]","en","Pretty Woman",'1990-03-23',463000000,119.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 37, 'name': 'Western'}]","en","The Wild Bunch",'1969-06-17',638641,145.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Love and a .45",'1994-11-23',0,101.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}, {'id': 10749, 'name': 'Romance'}]","en","The Wooden Man's Bride",'1994-02-05',0,113.0),
	("","en","A Great Day in Harlem",'1994-09-27',0,60.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Bye Bye Love",'1995-03-16',0,106.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","One Fine Day",'1996-12-20',97529550,108.0),
	("[{'id': 27, 'name': 'Horror'}]","en","Candyman: Farewell to the Flesh",'1995-03-17',13940383,93.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","Century",'1993-12-31',0,112.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Fargo",'1996-04-05',60611975,98.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Homeward Bound II: Lost in San Francisco",'1996-03-08',32709423,89.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 878, 'name': 'Science Fiction'}]","en","Heavy Metal",'1981-08-07',0,90.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}]","en","Hellraiser: Bloodline",'1996-03-08',16675000,86.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","The Pallbearer",'1996-05-03',0,97.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Jane Eyre",'1996-02-09',0,112.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Loaded",'1996-04-12',0,91.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10769, 'name': 'Foreign'}]","it","Pane e cioccolata",'1974-05-05',0,100.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 12, 'name': 'Adventure'}]","en","The Aristocats",'1970-12-23',55675257,78.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","es","La flor de mi secreto",'1995-09-22',0,107.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Two Much",'1996-02-14',0,118.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Ed",'1996-03-15',0,94.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 99, 'name': 'Documentary'}]","de","Schrei aus Stein",'1991-01-01',0,105.0),
	("[{'id': 18, 'name': 'Drama'}]","fr","Ma saison préférée",'1993-05-14',0,127.0),
	("","en","A Modern Affair",'1996-09-06',0,90.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}]","en","Condition Red",'1995-12-08',0,83.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Asfour Stah",'1990-01-01',0,98.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 10749, 'name': 'Romance'}]","en","A Thin Line Between Love and Hate",'1996-04-04',0,108.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","The Last Supper",'1995-09-08',442965,92.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Primal Fear",'1996-04-03',102616183,129.0),
	("","en","Rude",'1995-09-08',0,89.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Carried Away",'1996-01-26',0,109.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}, {'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}]","en","All Dogs Go to Heaven 2",'1996-03-29',8620678,82.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10752, 'name': 'War'}, {'id': 10749, 'name': 'Romance'}]","en","Land and Freedom",'1995-01-01',0,109.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Denise Calls Up",'1995-05-17',0,80.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","Theodore Rex",'1995-12-14',0,92.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","A Family Thing",'1996-03-29',0,109.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Frisk",'1996-03-22',0,88.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Sgt. Bilko",'1996-03-29',0,90.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Jack & Sarah",'1995-06-02',218626,110.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Girl 6",'1996-03-22',4939939,108.0);
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES    
	("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Diabolique",'1996-03-22',0,107.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","fr","Un indien dans la ville",'1994-12-14',0,90.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","de","Roula - Dunkle Geheimnisse",'1995-09-11',0,97.0);

INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES    
	("[{'id': 35, 'name': 'Comedy'}]","de","Peanuts – Die Bank zahlt alles",'1996-03-21',0,0),
	("[{'id': 35, 'name': 'Comedy'}]","de","Happy Weekend",'1996-03-14',65335,0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","fr","Nelly & Monsieur Arnaud",'1996-04-12',0,106.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10752, 'name': 'War'}]","en","Courage Under Fire",'1996-07-04',100860818,117.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Mission: Impossible",'1996-05-22',457696359,110.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","de","Á köldum klaka",'1995-02-10',0,85.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Moll Flanders",'1996-06-14',0,123.0);
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES    
	("[{'id': 35, 'name': 'Comedy'}]","de","Das Superweib",'1996-03-06',0,86.0),
	("[{'id': 14, 'name': 'Fantasy'}]","en","DragonHeart",'1996-05-31',115267375,103.0),
	("[{'id': 18, 'name': 'Drama'}]","de","Und keiner weint mir nach",'1996-02-29',0,0),
	("[{'id': 18, 'name': 'Drama'}]","de","My Mother's Courage",'1995-09-12',0,93.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","Eddie",'1996-05-31',0,100.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Yankee Zulu",'1993-12-01',0,100.0),
	("","en","Billy's Holiday",'1995-07-26',0,92.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","fr","Plein soleil",'1960-03-10',0,115.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","August",'1996-08-08',0,94.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}]","en","James and the Giant Peach",'1996-04-12',28921264,79.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 10749, 'name': 'Romance'}]","en","Fear",'1996-04-12',0,97.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Kids in the Hall: Brain Candy",'1996-04-02',0,89.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Faithful",'1996-04-03',9789900,91.0),
	("[{'id': 10752, 'name': 'War'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","sr","Podzemlje",'1995-04-11',0,170.0),
	("[{'id': 10752, 'name': 'War'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","sv","Lust och fägring stor",'1995-03-08',0,130.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Bloodsport II",'1996-03-01',684351,90.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}]","en","Mystery Science Theater 3000: The Movie",'1996-04-19',0,73.0),
	("","en","Tarantella",'1996-03-15',0,100.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Space Jam",'1996-11-15',250200000,88.0),
	("[{'id': 878, 'name': 'Science Fiction'}]","en","Barbarella",'1968-10-10',2500000,98.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}]","en","Hostile Intentions",'1995-01-01',0,90.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}]","en","They Bite",'1996-01-01',0,98.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Some Folks Call It a Sling Blade",'1994-03-26',0,25.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Run of the Country",'1995-09-22',0,0.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 9648, 'name': 'Mystery'}]","fr","Alphaville, une étrange aventure de Lemmy Caution",'1965-05-05',0,100.0),
	("[{'id': 18, 'name': 'Drama'}]","fr","Coup de torchon",'1981-11-04',0,128.0),
	("[{'id': 99, 'name': 'Documentary'}, {'id': 10769, 'name': 'Foreign'}]","en","Tigrero: A Film That Was Never Made",'1994-01-01',0,75.0),
	("","en","L'oeil de Vichy",'1993-05-20',0,110.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Windows",'1980-01-18',0,96.0),
	("[{'id': 18, 'name': 'Drama'}]","en","It's My Party",'1996-03-22',0,110.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Country Life",'1994-10-27',0,118.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Operation Dumbo Drop",'1995-07-28',0,107.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","de","Das Versprechen",'1995-02-16',0,115.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","Mrs. Winterbourne",'1996-04-19',10070000,105.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Solo",'1996-10-23',0,94.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}]","he","Etz Hadomim Tafus",'1994-01-01',0,0.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","The Substitute",'1996-04-19',0,114.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","True Crime",'1996-03-12',0,94.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","Butterfly Kiss",'1995-08-18',0,88.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Feeling Minnesota",'1996-09-13',0,99.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Delta of Venus",'1995-06-09',62949,99.0),
	("","en","To Cross the Rubicon",'1991-01-01',0,0.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}]","en","Angus",'1995-09-15',0,90.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","nl","Daens",'1992-09-01',0,138.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Faces",'1968-11-24',0,130.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","en","Boys",'1996-05-10',0,86.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}]","en","The Quest",'1996-04-19',57400547,95.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Cosi",'1996-03-04',0,102.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Sunset Park",'1996-04-26',0,99.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Mulholland Falls",'1996-04-26',0,107.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","The Truth About Cats & Dogs",'1996-04-26',0,93.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Oliver & Company",'1988-11-18',74151346,74.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Celtic Pride",'1996-04-19',0,91.0);
    
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
	("[{'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}]","en","Flipper",'1996-05-17',20080020,95.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}]","en","Captives",'1994-05-03',0,100.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Of Love and Shadows",'1994-05-10',0,103.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}, {'id': 37, 'name': 'Western'}]","en","Dead Man",'1995-12-23',0,121.0),
	("[{'id': 10752, 'name': 'War'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Le Hussard sur le toit",'1995-09-20',15000000,135.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Switchblade Sisters",'1975-01-05',0,91.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10769, 'name': 'Foreign'}]","es","Boca a boca",'1995-11-10',0,106.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}]","fr","Les visiteurs",'1993-01-27',0,107.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}]","en","Multiplicity",'1996-07-19',0,117.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","The Haunted World of Edward D. Wood, Jr.",'1996-05-01',0,112.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}]","en","Due Amici",'2002-03-20',0,86.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","The Craft",'1996-05-03',24769466,101.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The Great White Hype",'1996-05-03',0,91.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Last Dance",'1996-05-02',5,103.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Cold Comfort Farm",'1995-01-01',0,95.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 18, 'name': 'Drama'}]","en","Institute Benjamenta, or This Dream People Call Human Life",'1995-08-01',0,104.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Heaven's Prisoners",'1996-05-17',0,132.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Original Gangstas",'1996-05-10',3014000,99.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","The Rock",'1996-06-06',335062621,136.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Getting Away with Murder",'1996-04-12',0,91.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}]","it","Dellamorte Dellamore",'1994-03-25',0,105.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}]","en","Twister",'1996-05-10',494471524,113.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 878, 'name': 'Science Fiction'}]","en","Barb Wire",'1996-05-02',3793614,98.0),
	("[{'id': 18, 'name': 'Drama'}]","fr","Le garçu",'1995-10-31',0,102.0),
	("[{'id': 35, 'name': 'Comedy'}]","de","Honigmond",'1996-04-11',0,92.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 16, 'name': 'Animation'}, {'id': 878, 'name': 'Science Fiction'}]","ja","GHOST IN THE SHELL",'1995-11-18',2287714,83.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Thinner",'1996-10-25',0,92.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","Spy Hard",'1996-05-24',0,81.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Brothers in Trouble",'1995-08-23',0,102.0),
	("[{'id': 10751, 'name': 'Family'}, {'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}]","en","A Close Shave",'1995-12-24',0,30.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}]","en","Force of Evil",'1948-12-25',0,78.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Stupids",'1996-08-30',0,94.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 9648, 'name': 'Mystery'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","The Arrival",'1996-05-31',14048372,115.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}]","en","The Man from Down Under",'1943-08-04',0,103.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10752, 'name': 'War'}]","en","Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb",'1964-01-29',9440272,95.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}]","en","Careful",'1992-09-30',0,100.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","A Month by the Lake",'1995-09-11',0,92.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Gold Diggers: The Secret of Bear Mountain",'1995-11-03',0,94.0),
	("[{'id': 10751, 'name': 'Family'}, {'id': 12, 'name': 'Adventure'}]","en","Kim",'1950-12-07',0,113.0),
	("[{'id': 99, 'name': 'Documentary'}]","pt","Carmen Miranda: Bananas Is My Business",'1995-04-13',0,91.0),
	("","en","Khomreh",'1994-04-01',0,86.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","Maya Lin: A Strong Clear Vision",'1995-11-10',0,105.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10752, 'name': 'War'}]","de","Stalingrad",'1993-01-21',0,134.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}]","en","The Phantom",'1996-06-06',17300889,100.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Striptease",'1996-06-28',113309743,115.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","The Last of the High Kings",'1996-12-06',0,102.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Heavy",'1995-01-20',0,105.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}]","en","Jack",'1996-08-09',58620973,113.0),
	("[{'id': 18, 'name': 'Drama'}]","en","I Shot Andy Warhol",'1996-05-01',1814290,103.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","The Grass Harp",'1995-09-10',0,107.0),
	("[{'id': 18, 'name': 'Drama'}]","sr","Tuđa Amerika",'1995-09-09',0,96.0),
	("[{'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","fr","La vie est belle",'1987-11-17',0,80.0),
	("","en","Quartier Mozart",'1992-05-26',0,80.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","wo","Touki-Bouki",'1973-07-01',0,85.0),
	("[{'id': 18, 'name': 'Drama'}]","fr","Wend Kuuni",'1982-01-01',0,75.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 27, 'name': 'Horror'}]","fr","Histoires extraordinaires",'1968-05-16',0,121.0),
	("","en","Babyfever",'1994-05-04',0,109.0),
	("[{'id': 37, 'name': 'Western'}, {'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}]","en","Pharaoh's  Army",'1995-01-01',0,90.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Trainspotting",'1996-02-23',16491080,93.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Til There Was You",'1997-05-30',0,113.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 878, 'name': 'Science Fiction'}]","en","Independence Day",'1996-06-25',816969268,145.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Stealing Beauty",'1996-03-29',0,116.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Fan",'1996-08-15',18626419,116.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}]","en","The Hunchback of Notre Dame",'1996-06-21',100138851,91.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Cable Guy",'1996-06-10',102825796,96.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Kingpin",'1996-07-04',25023434,113.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Eraser",'1996-06-21',242295562,115.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","The Gate of Heavenly Peace",'1995-01-01',0,180.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Nutty Professor",'1996-06-26',128769345,95.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}]","es","Yo, la peor de todas",'1990-08-09',0,105.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","ro","Un été inoubliable",'1994-05-15',65352,82.0),
	("","en","Hol volt, hol nem volt",'1987-01-01',0,97.0);
    
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
	("","en","En compagnie d'Antonin Artaud",'1993-01-01',0,90.0),
	("","en","Sibak",'1994-09-09',0,100.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Somebody to Love",'1994-09-27',0,102.0),
	("[{'id': 18, 'name': 'Drama'}]","en","A Very Natural Thing",'1974-01-01',0,80.0),
	("[{'id': 35, 'name': 'Comedy'}]","fr","La vieille qui marchait dans la mer",'1991-09-18',0,0.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Daylight",'1996-12-06',159212469,115.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}]","en","The Frighteners",'1996-07-18',29359216,110.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}]","en","Lone Star",'1996-06-21',13269963,135.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Harriet the Spy",'1996-07-10',0,100.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10749, 'name': 'Romance'}, {'id': 878, 'name': 'Science Fiction'}]","en","Phenomenon",'1996-07-05',152036382,123.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Walking and Talking",'1996-07-17',0,86.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","She's the One",'1996-08-26',9482579,96.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","A Time to Kill",'1996-07-24',152266007,149.0),
	("[{'id': 18, 'name': 'Drama'}]","en","American Buffalo",'1996-09-13',665450,88.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}]","fr","Les Rendez-vous de Paris",'1995-03-22',0,94.0),
	("[{'id': 12, 'name': 'Adventure'}]","en","Alaska",'1996-08-14',0,109.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}]","en","Fled",'1996-07-19',17193231,98.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","Kazaam",'1996-07-17',0,93.0),
	("[{'id': 10751, 'name': 'Family'}, {'id': 35, 'name': 'Comedy'}]","en","Larger Than Life",'1996-10-31',0,93.0),
	("","en","A Boy Called Hate",'1996-05-22',0,0.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Power 98",'1996-05-17',0,89.0),
	("[{'id': 10752, 'name': 'War'}, {'id': 18, 'name': 'Drama'}]","en","Two Deaths",'1995-09-10',0,102.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","A Very Brady Sequel",'1996-08-23',0,90.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Stefano Quantestorie",'1993-05-26',0,82.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}]","fr","La mort en ce jardin",'1956-09-21',0,104.0),
	("[{'id': 10752, 'name': 'War'}, {'id': 18, 'name': 'Drama'}]","cy","Hedd Wyn",'1992-01-01',0,123.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","fr","La Collectionneuse",'1967-03-02',0,89.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}]","de","Kaspar Hauser",'1993-09-11',0,139.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10769, 'name': 'Foreign'}]","de","Echte Kerle",'1996-05-30',0,100.0),
	("[{'id': 18, 'name': 'Drama'}]","de","Diebinnen",'1996-06-20',0,0),
	("[{'id': 53, 'name': 'Thriller'}]","en","O Convento",'1995-09-06',0,91.0);
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
	("[{'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","The Adventures of Pinocchio",'1996-07-26',0,90.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}]","en","Joe's Apartment",'1996-07-26',4619014,78.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","The First Wives Club",'1996-09-20',116400000,102.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Stonewall",'1995-10-01',0,99.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Ransom",'1996-11-08',309492681,117.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","High School High",'1996-10-25',21302121,86.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Phat Beach",'1996-08-02',0,89.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Foxfire",'1996-08-23',258263,102.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Chain Reaction",'1996-08-02',60209334,107.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Matilda",'1996-08-02',33459416,98.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Emma",'1996-08-02',22231658,121.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 14, 'name': 'Fantasy'}, {'id': 53, 'name': 'Thriller'}]","en","The Crow: City of Angels",'1996-08-29',17917287,84.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","House Arrest",'1996-08-14',0,108.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","fr","Les Yeux sans visage",'1960-01-11',0,90.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}]","en","Bordello of Blood",'1996-08-16',5600000,87.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Lotto Land",'1995-06-01',0,87.0),
	("","en","The Story of Xinghua",'1994-03-30',0,90.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Flirt",'1995-09-14',0,85.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The Big Squeeze",'1996-09-06',0,98.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The Spitfire Grill",'1996-08-23',12643776,117.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Escape from L.A.",'1996-08-09',42277365,97.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Basquiat",'1996-08-09',3011195,108.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Tin Cup",'1996-08-16',53854588,135.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}]","en","Dingo",'1991-06-02',300000,109.0),
	("[{'id': 18, 'name': 'Drama'}]","fr","Un week-end sur deux",'1990-08-28',0,104.0),
	("","en","Wuya yu maque",'1949-01-01',0,113.0);
    
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
	("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","The Godfather",'1972-03-14',245066411,175.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","de","Der bewegte Mann",'1994-10-05',0,90.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Manny & Lo",'1996-01-22',431326,88.0),
	("[{'id': 18, 'name': 'Drama'}]","ja","Tsuma",'1953-04-29',0,89.0),
	("","en","Small Faces",'1996-04-05',0,108.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","Bound",'1996-09-13',7011317,108.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Carpool",'1996-08-23',0,89.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Death in Brunswick",'1990-11-08',0,109.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}, {'id': 80, 'name': 'Crime'}]","en","Kansas City",'1996-08-16',0,116.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Gone Fishin'",'1997-05-30',0,94.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}]","de","Lover's Knot",'1996-07-12',0,82.0),
	("[{'id': 18, 'name': 'Drama'}]","de","Schatten der Engel",'1976-01-31',0,101.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Killer: A Journal of Murder",'1996-09-06',0,91.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Nothing to Lose",'1994-01-01',0,0.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Girls Town",'1996-08-21',0,90.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Bye-Bye",'1995-08-30',0,104.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Relic",'1997-01-10',33956608,110.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Island of Dr. Moreau",'1996-08-23',49627779,96.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","First Kid",'1996-08-30',0,101.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Trigger Effect",'1996-08-30',0,94.0),
	("","en","Sweet Nothing",'1995-06-08',0,89.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Bogus",'1996-09-06',0,110.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}]","en","Bulletproof",'1996-09-06',22611954,84.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","en","Talk of Angels",'1998-10-30',0,96.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}]","en","The Land Before Time III: The Time of the Great Giving",'1995-03-16',0,71.0),
	("","nl","6",'1994-09-01',0,0.0),
	("[{'id': 53, 'name': 'Thriller'}]","fr","Baton Rouge",'1988-10-08',0,0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Halloween: The Curse of Michael Myers",'1995-09-29',15116634,88.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Twelfth Night",'1996-10-31',0,134.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Mother Night",'1996-11-01',0,114.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","de","Liebelei",'1933-03-10',0,88.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Wenecja",'2010-05-25',0,110.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","fr","Les Roseaux Sauvages",'1994-05-05',0,115.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","For Whom the Bell Tolls",'1943-07-12',0,170.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","The Philadelphia Story",'1940-12-05',0,112.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","Singin' in the Rain",'1952-04-10',7200000,103.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","An American in Paris",'1951-08-08',4500000,113.0),
	("[{'id': 10402, 'name': 'Music'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Funny Face",'1957-02-13',0,103.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Breakfast at Tiffany's",'1961-10-05',9500000,110.0),
	("[{'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","Vertigo",'1958-05-09',28000000,128.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Rear Window",'1954-08-01',36764313,112.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","It Happened One Night",'1934-02-22',4500000,105.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Gaslight",'1944-05-04',0,114.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","The Gay Divorcee",'1934-10-12',0,107.0),
	("[{'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","North by Northwest",'1959-07-07',13275000,136.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Apartment",'1960-06-15',25000000,125.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Some Like It Hot",'1959-03-18',25000000,122.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","Charade",'1963-12-05',13474588,113.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Casablanca",'1942-11-26',10462500,102.0),
	("[{'id': 9648, 'name': 'Mystery'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","The Maltese Falcon",'1941-11-18',1000000,100.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","My Fair Lady",'1964-10-21',72070731,170.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Sabrina",'1954-09-28',10000000,113.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Roman Holiday",'1953-09-02',12000000,119.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Little Princess",'1939-03-17',0,93.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","Meet Me in St. Louis",'1944-11-23',0,113.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","The Wizard of Oz",'1939-08-15',33754967,102.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","en","Gone with the Wind",'1939-12-15',400176459,238.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","My Favorite Year",'1982-10-01',0,92.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Sunset Boulevard",'1950-08-10',5000000,110.0),
	("[{'id': 9648, 'name': 'Mystery'}, {'id': 18, 'name': 'Drama'}]","en","Citizen Kane",'1941-04-30',23217674,119.0),
	("[{'id': 878, 'name': 'Science Fiction'}, {'id': 9648, 'name': 'Mystery'}, {'id': 12, 'name': 'Adventure'}]","en","2001: A Space Odyssey",'1968-04-10',68700000,149.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 10749, 'name': 'Romance'}]","en","Golden Earrings",'1947-08-27',0,95.0),
	("[{'id': 18, 'name': 'Drama'}]","en","All About Eve",'1950-11-09',63463,138.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The Women",'1939-01-01',2270000,133.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","en","Rebecca",'1940-04-12',6000000,130.0),
	("[{'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}, {'id': 10752, 'name': 'War'}]","en","Foreign Correspondent",'1940-08-16',0,120.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Notorious",'1946-08-15',24464742,102.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Spellbound",'1945-12-28',7000000,111.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","An Affair to Remember",'1957-07-11',0,111.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","To Catch a Thief",'1955-08-03',8750000,106.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}]","en","Father of the Bride",'1950-06-16',0,92.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}]","en","The Band Wagon",'1953-08-07',0,112.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Ninotchka",'1939-10-06',2279000,110.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Love in the Afternoon",'1957-06-30',0,130.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","Gigi",'1958-04-15',0,116.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","","The Reluctant Debutante",'1958-01-01',0,94.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 10749, 'name': 'Romance'}]","en","The Adventures of Robin Hood",'1938-05-13',3981000,102.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 37, 'name': 'Western'}]","en","The Mark of Zorro",'1940-11-08',0,94.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","en","Laura",'1944-10-11',2000000,88.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 10749, 'name': 'Romance'}, {'id': 9648, 'name': 'Mystery'}]","en","The Ghost and Mrs. Muir",'1947-06-26',0,104.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","en","Lost Horizon",'1937-09-01',0,97.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","Top Hat",'1935-09-06',3202000,101.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10752, 'name': 'War'}]","en","To Be or Not to Be",'1942-03-05',0,99.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","My Man Godfrey",'1936-09-17',0,94.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 37, 'name': 'Western'}]","en","Giant",'1956-10-10',35000000,201.0),
	("[{'id': 18, 'name': 'Drama'}]","en","East of Eden",'1955-03-09',5,115.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}]","en","The Thin Man",'1934-05-25',1423000,93.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","His Girl Friday",'1940-01-18',0,92.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10749, 'name': 'Romance'}]","en","Around the World in Eighty Days",'1956-10-17',42000000,167.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","It's a Wonderful Life",'1946-12-20',9644124,130.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Mr. Smith Goes to Washington",'1939-10-19',9600000,129.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Bringing Up Baby",'1938-02-18',0,102.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Penny Serenade",'1941-04-24',0,119.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The Scarlet Letter",'1926-08-09',0,115.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}]","en","Lady of Burlesque",'1943-06-01',0,91.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Of Human Bondage",'1934-07-20',0,83.0);
    
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
	("[{'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10749, 'name': 'Romance'}]","en","Angel on My Shoulder",'1946-09-20',0,100.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Little Lord Fauntleroy",'1936-03-06',0,102.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","en","They Made Me a Criminal",'1939-01-28',0,92.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","The Inspector General",'1949-12-31',0,101.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 37, 'name': 'Western'}]","en","Angel and the Badman",'1947-02-15',0,100.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}]","en","The 39 Steps",'1935-06-01',0,86.0),
	("[{'id': 10752, 'name': 'War'}, {'id': 18, 'name': 'Drama'}]","en","A Walk in the Sun",'1945-12-25',0,117.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 37, 'name': 'Western'}]","en","The Outlaw",'1943-02-05',0,116.0),
	("[{'id': 27, 'name': 'Horror'}]","en","Night of the Living Dead",'1968-10-01',30000000,96.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 10752, 'name': 'War'}, {'id': 10749, 'name': 'Romance'}]","en","The African Queen",'1951-12-03',10750000,105.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Beat the Devil",'1953-11-24',0,89.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Cat on a Hot Tin Roof",'1958-02-17',17570324,108.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","The Last Time I Saw Paris",'1954-01-01',105,116.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Meet John Doe",'1941-03-12',0,122.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}]","en","Algiers",'1938-06-28',0,96.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Something to Sing About",'1937-09-30',0,93.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","en","A Farewell to Arms",'1932-12-08',25,89.0),
	("[{'id': 10402, 'name': 'Music'}, {'id': 9648, 'name': 'Mystery'}]","en","Moonlight Murder",'1936-03-27',0,65.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Nothing Personal",'1996-10-18',0,83.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Dangerous Ground",'1997-02-12',3028094,95.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Picnic",'1955-11-18',0,115.0),
	("","en","Madagascar Skin",'1995-01-26',0,96.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","The Pompatus of Love",'1996-07-26',0,99.0),
	("[{'id': 99, 'name': 'Documentary'}, {'id': 10751, 'name': 'Family'}]","en","Small Wonders",'1995-01-01',0,77.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Fly Away Home",'1996-09-13',0,107.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Bliss",'1997-04-14',294064,103.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}]","en","Grace of My Heart",'1996-09-13',0,116.0),
	("[{'id': 18, 'name': 'Drama'}]","de","Schlafes Bruder",'1995-09-08',0,127.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Maximum Risk",'1996-09-13',51702483,100.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Michael Collins",'1996-10-25',16900000,132.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Rich Man's Wife",'1996-09-13',8538318,94.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Infinity",'1996-10-04',0,119.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Big Night",'1996-09-20',0,107.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Last Man Standing",'1996-09-20',47267001,101.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Caught",'1996-01-24',0,110.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}]","en","Set It Off",'1996-11-06',41590886,118.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","2 Days in the Valley",'1996-09-11',0,104.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Curdled",'1996-09-06',49620,88.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","L'associé",'1979-08-22',0,94.0),
	("","en","Ed's Next Move",'1996-10-18',0,88.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Extreme Measures",'1996-09-27',17380126,118.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Glimmer Man",'1996-10-04',0,92.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","D3: The Mighty Ducks",'1996-10-04',22955097,104.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","The Chamber",'1996-10-11',22540359,113.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Apple Dumpling Gang",'1975-07-01',0,100.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}, {'id': 37, 'name': 'Western'}]","en","Davy Crockett, King of the Wild Frontier",'1955-05-25',0,93.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","Escape to Witch Mountain",'1975-03-21',20000000,97.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","The Love Bug",'1968-12-22',0,107.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Herbie Rides Again",'1974-02-14',0,88.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 37, 'name': 'Western'}]","en","Old Yeller",'1957-12-25',0,83.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Parent Trap",'1961-06-12',0,129.0),
	("[{'id': 12, 'name': 'Adventure'}]","en","Pollyanna",'1960-05-19',0,134.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Homeward Bound: The Incredible Journey",'1993-02-03',0,84.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Shaggy Dog",'1959-03-19',0,104.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}]","en","Swiss Family Robinson",'1960-12-21',0,126.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 35, 'name': 'Comedy'}]","en","That Darn Cat!",'1965-12-02',0,112.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}]","en","20,000 Leagues Under the Sea",'1954-12-23',28200000,127.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Cool Runnings",'1993-09-30',154864401,98.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Angels in the Outfield",'1994-07-15',50236831,102.0),
	("[{'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}, {'id': 16, 'name': 'Animation'}, {'id': 10749, 'name': 'Romance'}]","en","Cinderella",'1950-03-04',263591415,74.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}]","en","Winnie the Pooh and the Blustery Day",'1968-12-20',0,25.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}]","en","The Three Caballeros",'1944-07-21',0,71.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}]","en","The Sword in the Stone",'1963-12-25',22182353,79.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","So Dear to My Heart",'1948-11-29',0,79.0),
	("[{'id': 12, 'name': 'Adventure'}]","en","Robin Hood: Prince of Thieves",'1991-06-14',390493908,143.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Mary Poppins",'1964-08-27',102272727,139.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}]","en","Dumbo",'1941-10-22',1600000,64.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Pete's Dragon",'1977-11-03',0,128.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}]","en","Bedknobs and Broomsticks",'1971-10-07',17900000,117.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Alice in Wonderland",'1951-07-03',572000000,75.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 16, 'name': 'Animation'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","The Fox and the Hound",'1981-07-10',29800000,82.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Freeway",'1996-08-23',0,110.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","The Sound of Music",'1965-03-02',286214286,174.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Die Hard",'1988-07-15',140767956,131.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Lawnmower Man",'1992-03-05',32101000,108.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Unhook the Stars",'1996-09-04',0,103.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","Synthetic Pleasures",'1995-09-13',0,85.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Secret Agent",'1996-11-08',0,95.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Secrets & Lies",'1996-05-24',13417292,142.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","That Thing You Do!",'1996-10-04',34585416,108.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","To Gillian on Her 37th Birthday",'1996-10-18',4137645,93.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Surviving Picasso",'1996-09-04',1985001,125.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Love Is All There Is",'1996-05-10',0,105.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Beautiful Thing",'1996-06-21',1500000,90.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 28, 'name': 'Action'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Long Kiss Goodnight",'1996-10-11',89456761,120.0),
	("[{'id': 12, 'name': 'Adventure'}]","en","The Ghost and the Darkness",'1996-10-11',75000000,109.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","Looking for Richard",'1996-10-11',0,112.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Trees Lounge",'1996-10-11',0,95.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The Proprietor",'1996-09-09',0,0.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Normal Life",'1996-01-26',0,101.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Get on the Bus",'1996-10-16',5731103,120.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Shadow Conspiracy",'1997-01-31',2154540,103.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Jude",'1996-02-06',405000,123.0),
	("[{'id': 10402, 'name': 'Music'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Everyone Says I Love You",'1996-12-06',0,101.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","es","Azúcar amarga",'1996-02-10',0,102.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Romeo + Juliet",'1996-10-31',147298761,120.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Swingers",'1996-10-18',4505922,94.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Sleepers",'1996-10-18',165615285,147.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The Sunchaser",'1996-05-29',0,122.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Johns",'1996-12-10',0,96.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}]","en","Aladdin and the King of Thieves",'1996-05-20',0,81.0),
	("[{'id': 9648, 'name': 'Mystery'}]","en","The Woman in Question",'1952-02-18',0,88.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","Shall We Dance",'1937-05-07',0,109.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","A Damsel in Distress",'1937-11-19',0,101.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Crossfire",'1947-07-22',0,86.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Murder, My Sweet",'1944-12-09',0,95.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Macao",'1952-04-30',0,81.0),
	("[{'id': 10752, 'name': 'War'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 28, 'name': 'Action'}]","en","For the Moment",'1993-10-01',0,115.0),
	("[{'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Willy Wonka & the Chocolate Factory",'1971-06-29',4000000,100.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","fr","La vie sexuelle des Belges 1950-1978",'1994-01-28',0,85.0),
	("[{'id': 27, 'name': 'Horror'}]","en","The Innocents",'1961-12-25',0,100.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 878, 'name': 'Science Fiction'}]","en","Sleeper",'1973-12-17',18344729,89.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Bananas",'1971-04-28',11833696,82.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","A Fish Called Wanda",'1988-07-15',62493712,108.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Life of Brian",'1979-08-17',20045115,94.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","Victor/Victoria",'1982-04-25',28215453,132.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The Candidate",'1972-08-23',0,110.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}]","en","The Great Race",'1965-07-01',25333333,160.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Bonnie and Clyde",'1967-07-18',50700000,111.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}]","en","The Old Man and the Sea",'1958-10-07',0,86.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Dial M for Murder",'1954-05-29',3000000,104.0),
	("","en","Madame Butterfly",'1995-11-22',0,135.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","Dirty Dancing",'1987-08-21',213954274,100.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Reservoir Dogs",'1992-09-02',14661007,99.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}, {'id': 28, 'name': 'Action'}]","en","Platoon",'1986-12-18',138530565,120.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Weekend at Bernie's",'1989-07-05',30218387,97.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}]","en","Basic Instinct",'1992-03-20',352927224,127.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}]","en","The Doors",'1991-03-01',34416893,140.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Crying Game",'1992-09-02',62548947,112.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","en","Glengarry Glen Ross",'1992-09-15',10725228,100.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Sophie's Choice",'1982-12-08',30036000,151.0),
	("[{'id': 878, 'name': 'Science Fiction'}, {'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","E.T. the Extra-Terrestrial",'1982-04-03',792965326,115.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","The Search for One-eye Jimmy",'1994-11-14',0,80.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","A Christmas Carol",'1938-12-16',0,69.0),
	("[{'id': 12, 'name': 'Adventure'}]","en","Days of Thunder",'1990-06-27',157920733,107.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","en","Top Gun",'1986-05-16',356830601,110.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","American Strays",'1996-09-12',1910,97.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Rebel Without a Cause",'1955-10-27',0,111.0),
	("[{'id': 18, 'name': 'Drama'}]","en","A Streetcar Named Desire",'1951-09-18',8000000,125.0),
	("[{'id': 27, 'name': 'Horror'}]","en","Children of the Corn IV: The Gathering",'1996-10-08',0,85.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","The Leopard Son",'1996-09-27',0,87.0),
	("[{'id': 35, 'name': 'Comedy'}]","de","Charms Zwischenfälle",'1996-10-03',0,88.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","es","Bird of Prey",'1995-09-12',0,105.0),
	("[{'id': 99, 'name': 'Documentary'}]","fr","Microcosmos : Le Peuple de l'herbe",'1996-05-20',0,80.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Palookaville",'1995-09-07',0,92.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","The Associate",'1996-10-25',0,114.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","The Funeral",'1996-01-26',1227324,99.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 27, 'name': 'Horror'}]","en","The Sleepover",'2013-10-12',0,6.0),
	("[{'id': 18, 'name': 'Drama'}]","fr","La fille seule",'1995-05-29',0,90.0),
	("[{'id': 18, 'name': 'Drama'}]","fr","Le huitième jour",'1996-01-01',0,118.0),
	("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 37, 'name': 'Western'}]","en","North Star",'1996-01-03',0,90.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Drunks",'1997-03-14',0,90.0),
	("[{'id': 18, 'name': 'Drama'}]","en","The People vs. Larry Flynt",'1996-10-12',20300385,129.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Glory Daze",'1995-10-01',0,100.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","A Perfect Candidate",'1996-06-19',0,105.0),
	("[{'id': 18, 'name': 'Drama'}]","en","On Golden Pond",'1981-12-04',19255967,109.0),
	("[{'id': 9648, 'name': 'Mystery'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","The Return of the Pink Panther",'1975-05-21',41833347,113.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10751, 'name': 'Family'}]","en","Drop Dead Fred",'1991-04-19',13878334,103.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Abyss",'1989-08-09',90000098,139.0),
	("[{'id': 27, 'name': 'Horror'}]","en","The Fog",'1980-02-08',21378361,89.0),
	("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}]","en","Escape from New York",'1981-05-22',50244700,99.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}]","en","The Howling",'1981-04-03',17985893,91.0),
	("[{'id': 18, 'name': 'Drama'}]","fr","Jean de Florette",'1986-08-27',0,120.0),
	("[{'id': 18, 'name': 'Drama'}]","fr","Manon des Sources",'1986-11-19',0,120.0),
	("[{'id': 18, 'name': 'Drama'}]","es","Johnny cien pesos",'1993-01-01',0,90.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Private Benjamin",'1980-10-06',0,109.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}]","en","Monty Python and the Holy Grail",'1975-03-13',5028948,91.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","Hustler White",'1996-07-19',127251,79.0),
	("","en","Dadetown",'1995-09-02',0,93.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Everything Relative",'1996-09-13',0,110.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Entertaining Angels - The Dorothy Day Story",'1996-09-27',0,112.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Trois vies et une seule mort",'1996-05-15',0,123.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","The Line King: The Al Hirschfeld Story",'1996-09-27',0,86.0),
	("[{'id': 99, 'name': 'Documentary'}]","de","Snowriders",'1996-10-17',2035470,96.0),
	("","en","Curtis's Charm",'1995-09-18',0,74.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","When We Were Kings",'1996-10-25',2666118,89.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Wrong Trousers",'1993-12-17',0,30.0),
	("[{'id': 99, 'name': 'Documentary'}]","fr","JLG/JLG - autoportrait de décembre",'1995-03-08',0,62.0),
	("[{'id': 9648, 'name': 'Mystery'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10749, 'name': 'Romance'}]","fr","Le Retour de Martin Guerre",'1982-05-12',0,122.0),
	("[{'id': 16, 'name': 'Animation'}, {'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}]","cs","Faust",'1994-09-10',0,97.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","He Walked by Night",'1948-11-24',0,79.0),
	("[{'id': 80, 'name': 'Crime'}]","en","Raw Deal",'1948-05-26',0,79.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","T-Men",'1947-12-15',0,92.0),
	("[{'id': 18, 'name': 'Drama'}]","en","La symphonie pastorale",'1946-09-26',0,110.0),
	("","en","Here Comes Cookie",'1935-09-10',0,65.0),
	("","en","Love In Bloom",'1935-04-20',0,75.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","Six of a Kind",'1934-02-09',0,62.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10752, 'name': 'War'}]","de","Die Blechtrommel",'1979-05-02',0,142.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","The Ruling Class",'1972-09-13',0,154.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","fr","Mina Tannenbaum",'1994-03-02',0,0.0);
    
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","fr","Deux ou trois choses que je sais d'elle",'1967-03-17',0,100.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Bloody Child",'1996-10-26',0,85.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Dear God",'1996-11-01',0,112.0),
("[{'id': 27, 'name': 'Horror'}]","en","Bad Moon",'1996-11-01',1100000,80.0),
("[{'id': 99, 'name': 'Documentary'}]","en","American Dream",'1990-09-28',269823,98.0),
("[{'id': 28, 'name': 'Action'}]","en","Best of the Best 3: No Turning Back",'1995-05-17',0,90.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Bob Roberts",'1992-09-04',0,102.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","The Cook, the Thief, His Wife & Her Lover",'1989-09-10',0,125.0),
("[{'id': 35, 'name': 'Comedy'}]","fr","Grosse fatigue",'1994-05-18',0,0.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 14, 'name': 'Fantasy'}]","fr","Delicatessen",'1991-04-17',1794187,99.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","fr","La double vie de Véronique",'1991-05-15',1999955,97.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","Enchanted April",'1991-11-06',13200170,89.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}]","en","Paths of Glory",'1957-09-18',0,88.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","The Grifters",'1990-09-14',13446769,110.0);

INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
("[{'id': 35, 'name': 'Comedy'}, {'id': 10769, 'name': 'Foreign'}]","en","Hear My Song",'1991-12-27',0,113.0),
("[{'id': 37, 'name': 'Western'}]","en","The Shooter",'1997-10-23',0,91.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","en","The English Patient",'1996-11-14',231976425,162.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","it","Mediterraneo",'1991-01-31',4532791,96.0),
("[{'id': 18, 'name': 'Drama'}]","en","My Left Foot: The Story of Christy Brown",'1989-07-21',14743391,103.0),
("[{'id': 18, 'name': 'Drama'}]","en","Sex, Lies, and Videotape",'1989-08-18',0,100.0),
("[{'id': 18, 'name': 'Drama'}]","en","Passion Fish",'1992-12-11',0,135.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Strictly Ballroom",'1992-08-20',33946224,94.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 99, 'name': 'Documentary'}, {'id': 80, 'name': 'Crime'}]","en","The Thin Blue Line",'1988-08-28',0,103.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","es","¡Átame!",'1989-12-12',0,111.0),
("[{'id': 99, 'name': 'Documentary'}, {'id': 10402, 'name': 'Music'}]","en","Madonna: Truth or Dare",'1991-05-10',29,119.0),
("[{'id': 99, 'name': 'Documentary'}]","en","Paris is Burning",'1990-03-13',3779620,71.0),
("[{'id': 18, 'name': 'Drama'}]","en","One Flew Over the Cuckoo's Nest",'1975-11-18',108981275,133.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Up in Smoke",'1978-01-01',41590893,86.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Empire Strikes Back",'1980-05-17',538400000,124.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","The Princess Bride",'1987-09-18',30857814,98.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}]","en","Raiders of the Lost Ark",'1981-06-12',389925971,115.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}]","en","Brazil",'1985-02-20',0,132.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}]","en","Aliens",'1986-07-18',183316455,137.0),
("[{'id': 37, 'name': 'Western'}]","it","Il buono, il brutto, il cattivo",'1966-12-23',6000000,161.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Withnail & I",'1987-01-01',0,107.0),
("[{'id': 18, 'name': 'Drama'}]","en","12 Angry Men",'1957-03-25',1000000,96.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10752, 'name': 'War'}]","en","Lawrence of Arabia",'1962-12-10',69995385,216.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 18, 'name': 'Drama'}]","en","A Clockwork Orange",'1971-12-18',26589000,136.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","To Kill a Mockingbird",'1962-12-25',13129846,129.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}]","en","Apocalypse Now",'1979-08-15',89460381,153.0),
("[{'id': 37, 'name': 'Western'}]","it","Cera una volta il West",'1968-12-21',5321508,175.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 878, 'name': 'Science Fiction'}]","en","Return of the Jedi",'1983-05-23',572700000,135.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10749, 'name': 'Romance'}]","de","Der Himmel über Berlin",'1987-01-01',3200000,128.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}]","en","The Third Man",'1949-08-31',596349,104.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","GoodFellas",'1990-09-12',46836394,145.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}]","en","Alien",'1979-05-25',104931801,117.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}]","en","Army of Darkness",'1992-10-09',0,81.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","fr","Le Grand Bleu",'1988-05-11',0,168.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","ja","乱",'1985-06-01',4069653,162.0),
("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","cn","喋血雙雄",'1989-07-06',0,110.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Psycho",'1960-06-16',32000000,109.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 35, 'name': 'Comedy'}, {'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}]","en","The Blues Brothers",'1980-06-17',115229890,133.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","The Godfather: Part II",'1974-12-20',47542841,200.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}]","en","Full Metal Jacket",'1987-06-26',46357676,116.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","A Grand Day Out",'1990-05-18',0,23.0),
("[{'id': 10752, 'name': 'War'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 28, 'name': 'Action'}, {'id': 10749, 'name': 'Romance'}]","en","Henry V",'1989-10-05',0,137.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10402, 'name': 'Music'}]","en","Amadeus",'1984-10-26',51973029,160.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Quiet Man",'1952-07-21',0,129.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Once Upon a Time in America",'1984-02-16',0,229.0);


INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
("[{'id': 18, 'name': 'Drama'}]","en","Raging Bull",'1980-11-14',23000000,129.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Annie Hall",'1977-04-19',38251425,93.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","The Right Stuff",'1983-10-20',21500000,193.0),
("['{'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","ru","Сталкер",'1979-04-16',0,163.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10752, 'name': 'War'}, {'id': 12, 'name': 'Adventure'}]","de","Das Boot",'1981-09-16',85000000,149.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","The Sting",'1973-12-25',159616327,129.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Harold and Maude",'1971-12-20',0,91.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Trust",'1990-09-09',0,107.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}]","sv","Det sjunde inseglet",'1957-02-16',0,96.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Local Hero",'1983-02-17',0,111.0),
("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Terminator",'1984-10-26',78371200,108.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}]","en","Braindead",'1992-08-13',242623,104.0),
("[{'id': 10752, 'name': 'War'}]","en","Glory",'1989-12-15',26828365,122.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Rosencrantz & Guildenstern Are Dead",'1991-02-08',0,117.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Manhattan",'1979-04-25',39946780,96.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Miller's Crossing",'1990-09-21',5080409,115.0),
("[{'id': 18, 'name': 'Drama'}]","en","Dead Poets Society",'1989-06-02',235860116,129.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Graduate",'1967-12-21',104945305,106.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Touch of Evil",'1958-04-23',2247465,95.0),
("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","fr","Nikita",'1990-02-21',5000000,115.0);

INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10752, 'name': 'War'}]","en","The Bridge on the River Kwai",'1957-10-02',27200000,161.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Chinatown",'1974-06-20',30000000,130.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","The Day the Earth Stood Still",'1951-09-17',0,92.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 37, 'name': 'Western'}]","en","The Treasure of the Sierra Madre",'1948-01-24',4307000,126.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}]","en","Bad Taste",'1987-12-01',0,91.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Duck Soup",'1933-11-17',0,68.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Better Off Dead...",'1985-10-11',10297601,97.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","The Shining",'1980-05-22',44017374,144.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Stand by Me",'1986-08-22',52287414,89.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","de","M",'1931-05-11',0,117.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}]","en","Evil Dead II",'1987-03-13',5923044,84.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 53, 'name': 'Thriller'}, {'id': 10752, 'name': 'War'}]","en","The Great Escape",'1963-06-20',11744471,172.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}]","en","The Deer Hunter",'1978-12-08',50000000,183.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}, {'id': 53, 'name': 'Thriller'}]","fr","Diva",'1981-03-11',0,117.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Groundhog Day",'1993-02-11',70906973,101.0),
("[{'id': 37, 'name': 'Western'}]","en","Unforgiven",'1992-08-07',159157447,131.0);

INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
("[{'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Manchurian Candidate",'1962-10-24',96105910,126.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 18, 'name': 'Drama'}]","en","Pump up the Volume",'1990-08-22',11541758,105.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Arsenic and Old Lace",'1944-09-23',0,118.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","Back to the Future",'1985-07-03',381109762,116.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Fried Green Tomatoes",'1991-12-27',119418501,130.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10752, 'name': 'War'}]","en","Patton",'1970-01-25',89800000,172.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Down by Law",'1986-05-01',0,107.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 16, 'name': 'Animation'}]","ja","アキラ",'1988-07-16',553171,124.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 14, 'name': 'Fantasy'}]","en","Highlander",'1986-03-07',5900000,116.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Cool Hand Luke",'1967-06-22',16217773,126.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 36, 'name': 'History'}, {'id': 10749, 'name': 'Romance'}]","fr","Cyrano de Bergerac",'1990-03-28',0,137.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}]","en","Young Frankenstein",'1974-12-15',86273333,106.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Night on Earth",'1991-10-03',2015810,129.0),
("[{'id': 18, 'name': 'Drama'}]","zh","大红灯笼高高挂",'1991-12-20',0,125.0),
("[{'id': 35, 'name': 'Comedy'}]","en","The Great Dictator",'1940-10-15',11000000,125.0),
("[{'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}]","en","Fantasia",'1940-11-13',83320000,124.0),
("[{'id': 37, 'name': 'Western'}]","en","High Noon",'1952-03-27',8000000,85.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Big Sleep",'1946-08-23',0,116.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Heathers",'1988-10-01',1108462,102.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10749, 'name': 'Romance'}]","en","Somewhere in Time",'1980-10-02',0,103.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Ben-Hur",'1959-12-26',146900000,212.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}]","en","This Is Spinal Tap",'1984-05-04',4736202,82.0),
("[{'id': 99, 'name': 'Documentary'}, {'id': 10402, 'name': 'Music'}]","en","Koyaanisqatsi",'1982-06-06',1723872,87.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Some Kind of Wonderful",'1987-02-27',18553948,95.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}]","en","Indiana Jones and the Last Crusade",'1989-05-24',474171806,127.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Being There",'1979-12-19',30177511,130.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Gandhi",'1982-11-30',77737889,191.0),
("['{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","The Unbearable Lightness of Being",'1988-02-05',10006806,171.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","A Room with a View",'1985-12-13',20966644,117.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Real Genius",'1985-08-07',13000000,106.0),
("[{'id': 10402, 'name': 'Music'}]","en","Pink Floyd: The Wall",'1982-07-14',22244207,95.0);

INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
	("[{'id': 10752, 'name': 'War'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","The Killing Fields",'1984-11-02',34700291,141.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","sv","Mitt liv som hund",'1985-12-12',0,101.0);
    

INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES    
	("[{'id': 12, 'name': 'Adventure'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}]","en","Forbidden Planet",'1956-03-15',3250000,98.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}]","en","Field of Dreams",'1989-04-21',84431625,107.0),
	("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}]","en","The Man Who Would Be King",'1975-12-03',0,129.0),
	("[{'id': 36, 'name': 'History'}, {'id': 18, 'name': 'Drama'}, {'id': 37, 'name': 'Western'}, {'id': 80, 'name': 'Crime'}]","en","Butch Cassidy and the Sundance Kid",'1969-09-23',102308889,110.0),
	("[{'id': 18, 'name': 'Drama'}]","en","Paris, Texas",'1984-05-19',2181987,147.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}]","de","Bis ans Ende der Welt",'1991-09-12',0,287.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","When Harry Met Sally...",'1989-07-21',92823546,96.0),
	("","en","I Shot a Man in Vegas",'1996-10-18',0,86.0),
	("","en","Parallel Sons",'1995-01-01',0,93.0);
    

INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES    
	("[{'id': 99, 'name': 'Documentary'}, {'id': 10402, 'name': 'Music'}]","en","Hype!",'1996-11-08',0,84.0),
	("[{'id': 10751, 'name': 'Family'}, {'id': 35, 'name': 'Comedy'}]","en","Santa with Muscles",'1996-11-08',0,93.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Female Perversions",'1996-01-22',0,119.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Mad Dog Time",'1996-11-08',0,93.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}]","en","Breathing Room",'1996-11-08',0,90.0),
	("[{'id': 99, 'name': 'Documentary'}]","en","Paris Was a Woman",'1996-02-19',0,75.0),
	("[{'id': 35, 'name': 'Comedy'}]","en","I'm Not Rappaport",'1996-12-24',0,135.0),
	("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Blue Juice",'1995-09-15',0,90.0),
	("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 27, 'name': 'Horror'}]","en","Alien³",'1992-05-22',159773545,114.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}]","en","An American Werewolf in London",'1981-08-21',31973249,97.0);
	

INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
    ("[{'id': 27, 'name': 'Horror'}]","en","Amityville: It's About Time",'1992-07-16',0,91.0),    
	("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Amityville 3-D",'1983-11-18',6333135,105.0),
	("[{'id': 27, 'name': 'Horror'}]","en","Amityville: Dollhouse",'1996-10-02',0,93.0),
	("[{'id': 27, 'name': 'Horror'}]","en","Amityville: A New Generation",'1993-09-29',0,90.0),
	("[{'id': 27, 'name': 'Horror'}]","en","Amityville II: The Possession",'1982-09-24',12534817,104.0),
	("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","The Amityville Horror",'1979-07-27',86432000,117.0),
	("[{'id': 27, 'name': 'Horror'}]","en","The Amityville Curse",'1989-12-01',0,91.0),
	("[{'id': 27, 'name': 'Horror'}]","en","Blood for Dracula",'1974-08-13',0,103.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}]","en","April Fool's Day",'1986-03-27',0,89.0),
	("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Audrey Rose",'1977-04-06',0,113.0),
	("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Believers",'1987-06-09',18753438,114.0),
	("[{'id': 27, 'name': 'Horror'}]","en","The Birds",'1963-03-28',11403529,119.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Blob",'1958-09-12',0,86.0),
	("[{'id': 878, 'name': 'Science Fiction'}, {'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}]","en","Blood Beach",'1980-09-01',0,92.0),
	("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Body Parts",'1991-08-02',0,88.0),
	("[{'id': 53, 'name': 'Thriller'}, {'id': 27, 'name': 'Horror'}]","en","The Body Snatcher",'1945-05-25',0,77.0),
	("[{'id': 10749, 'name': 'Romance'}, {'id': 27, 'name': 'Horror'}]","en","Dracula",'1992-11-13',215862692,128.0);    
    
INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES   
("[{'id': 27, 'name': 'Horror'}]","en","Burnt Offerings",'1976-10-18',0,116.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Cape Fear",'1991-11-15',182300000,128.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Cape Fear",'1962-04-12',0,105.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Carrie",'1976-11-03',33800000,98.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Cat People",'1982-04-02',0,118.0),
("[{'id': 27, 'name': 'Horror'}]","en","A Nightmare on Elm Street",'1984-11-14',25504513,91.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 27, 'name': 'Horror'}]","de","Nosferatu, eine Symphonie des Grauens",'1922-03-15',0,94.0),
("[{'id': 27, 'name': 'Horror'}]","en","Nosferatu a Venezia",'1988-09-15',0,97.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","The Omen",'1976-06-06',60922980,111.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Blood and Wine",'1996-10-03',0,101.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Albino Alligator",'1996-09-09',0,97.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Mirror Has Two Faces",'1996-11-15',0,126.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","da","Breaking the Waves",'1996-05-13',3803298,159.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Nightwatch",'1997-01-31',1179002,102.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Star Trek: First Contact",'1996-11-21',150000000,111.0),
("[{'id': 18, 'name': 'Drama'}]","en","Shine",'1996-01-21',0,105.0),
("[{'id': 18, 'name': 'Drama'}]","en","Sling Blade",'1996-08-30',24444121,135.0),
("[{'id': 10751, 'name': 'Family'}, {'id': 35, 'name': 'Comedy'}]","en","Jingle All the Way",'1996-11-15',129832389,89.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","it","Identificazione di una donna",'1982-10-21',0,128.0),
("[{'id': 99, 'name': 'Documentary'}, {'id': 18, 'name': 'Drama'}]","en","Paradise Lost: The Child Murders at Robin Hood Hills",'1996-12-03',0,150.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10749, 'name': 'Romance'}, {'id': 10751, 'name': 'Family'}]","en","The Preacher's Wife",'1996-12-13',48093211,124.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","no","Kjærlighetens kjøtere",'1995-09-29',0,118.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Ridicule",'1996-05-09',2503829,102.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","The Crucible",'1996-11-27',0,124.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","101 Dalmatians",'1996-11-17',320689294,103.0),
("[{'id': 18, 'name': 'Drama'}]","it","Il Cristo proibito",'1951-06-08',0,0.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","fr","J'ai pas sommeil",'1994-05-18',0,112.0),
("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Die Hard 2",'1990-07-02',240031094,124.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 12, 'name': 'Adventure'}, {'id': 9648, 'name': 'Mystery'}]","en","Star Trek: The Motion Picture",'1979-12-06',139000000,132.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Star Trek VI: The Undiscovered Country",'1991-12-05',96900000,113.0);


INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Star Trek V: The Final Frontier",'1989-06-09',70200000,107.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Star Trek II: The Wrath of Khan",'1982-06-03',96800000,113.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Star Trek III: The Search for Spock",'1984-05-31',87000000,105.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 12, 'name': 'Adventure'}]","en","Star Trek IV: The Voyage Home",'1986-11-25',133000000,119.0),
("[{'id': 28, 'name': 'Action'}, {'id': 14, 'name': 'Fantasy'}]","en","Batman Returns",'1992-06-19',280000000,126.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 37, 'name': 'Western'}]","en","Young Guns",'1988-08-12',44726644,107.0),
("[{'id': 37, 'name': 'Western'}, {'id': 12, 'name': 'Adventure'}]","en","Young Guns II",'1990-08-01',0,132.0),
("[{'id': 10749, 'name': 'Romance'}]","en","Grease",'1978-07-07',181813770,110.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","Grease 2",'1982-06-11',15171476,115.0),
("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Marked for Death",'1990-10-05',46044400,94.0),
("[{'id': 28, 'name': 'Action'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Adrenalin: Fear the Rush",'1996-11-29',0,77.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Substance of Fire",'1996-09-11',0,97.0),
("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Under Siege",'1992-10-08',156563139,103.0),
("[{'id': 28, 'name': 'Action'}, {'id': 37, 'name': 'Western'}]","en","Terror in a Texas Town",'1958-09-01',0,80.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}, {'id': 12, 'name': 'Adventure'}]","en","Jaws",'1975-06-18',470654000,124.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Jaws 2",'1978-06-16',187884007,116.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 27, 'name': 'Horror'}]","en","Jaws 3-D",'1983-03-16',87987055,99.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","My Fellow Americans",'1996-12-20',0,101.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}]","en","Mars Attacks!",'1996-12-12',101371017,106.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Citizen Ruth",'1996-12-13',153155,104.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Jerry Maguire",'1996-12-06',273552592,139.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Raising Arizona",'1987-03-01',29180280,94.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Tin Men",'1987-03-06',0,112.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Sneakers",'1992-09-09',105232691,126.0),
("[{'id': 18, 'name': 'Drama'}]","en","Bastard Out of Carolina",'1996-12-15',0,97.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","In Love and War",'1996-12-18',0,113.0),
("[{'id': 18, 'name': 'Drama'}]","en","Marvin's Room",'1996-12-18',12803305,98.0),
("[{'id': 18, 'name': 'Drama'}]","en","Somebody Is Waiting",'1996-12-19',0,96.0),
("[{'id': 36, 'name': 'History'}, {'id': 18, 'name': 'Drama'}]","en","Ghosts of Mississippi",'1996-12-20',0,130.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Night Falls on Manhattan",'1996-10-22',0,113.0),
("[{'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}]","en","Beavis and Butt-Head Do America",'1996-12-15',0,81.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","fr","La Cérémonie",'1995-08-30',0,111.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}]","en","Scream",'1996-12-20',173046663,111.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","en","The Last of the Mohicans",'1992-09-25',75505856,112.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}]","en","Michael",'1996-12-25',119718203,105.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10751, 'name': 'Family'}, {'id': 35, 'name': 'Comedy'}]","en","The Evening Star",'1996-12-25',0,129.0),
("[{'id': 18, 'name': 'Drama'}]","en","Hamlet",'1996-12-25',0,242.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Some Mother's Son",'1996-12-25',0,112.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Whole Wide World",'1996-12-20',0,106.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Mother",'1996-12-25',0,104.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","fr","Les voleurs",'1996-08-21',0,117.0),
("[{'id': 36, 'name': 'History'}, {'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}]","en","Evita",'1996-12-14',141047179,134.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Portrait of a Lady",'1996-10-18',3692836,144.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}]","en","Walkabout",'1971-07-01',0,95.0),
("[{'id': 99, 'name': 'Documentary'}, {'id': 10402, 'name': 'Music'}]","en","Message to Love: The Isle of Wight Festival",'1996-02-15',0,127.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Murder at 1600",'1997-04-18',25804707,107.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 99, 'name': 'Documentary'}, {'id': 10749, 'name': 'Romance'}, {'id': 10769, 'name': 'Foreign'}]","en","Hearts and Minds",'1995-08-29',0,113.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 10770, 'name': 'TV Movie'}]","en","Inside",'1996-08-25',0,94.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Fierce Creatures",'1997-01-24',9381260,93.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}]","en","Zeus & Roxanne",'1997-01-24',0,98.0),
("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Turbulence",'1997-01-09',11466088,100.0),
("[{'id': 18, 'name': 'Drama'}]","en","Angel Baby",'1995-09-09',0,105.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","cn","警察故事4之簡單任務",'1996-02-10',21890845,107.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}]","en","Underworld",'1996-06-01',0,95.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","Beverly Hills Ninja",'1997-01-17',0,88.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Metro",'1997-01-16',31987563,117.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}]","en","La machine",'1994-05-28',0,0.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Falling in Love Again",'1980-11-21',0,103.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Cement Garden",'1993-02-20',322975,105.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Dante's Peak",'1997-02-07',178127760,108.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Meet Wally Sparks",'1997-01-01',0,105.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","Amos & Andrew",'1993-03-05',0,96.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Benny & Joon",'1993-04-16',23202734,98.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Prefontaine",'1997-01-24',589304,106.0),
("[{'id': 99, 'name': 'Documentary'}]","en","A Tickle in the Heart",'1996-11-21',0,90.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 10769, 'name': 'Foreign'}]","es","Guantanamera",'1995-01-01',0,105.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","McHale's Navy",'1997-04-18',4529843,108.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","cs","Kolja",'1996-05-05',5770254,105.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Gridlock'd",'1997-01-29',0,91.0),
("[{'id': 99, 'name': 'Documentary'}]","en","Fire on the Mountain",'1996-11-29',0,72.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 35, 'name': 'Comedy'}]","en","Waiting for Guffman",'1996-01-31',0,84.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}]","ru","Кавказский пленник",'1996-03-15',0,99.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","The Beautician and the Beast",'1997-02-07',0,105.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","SubUrbia",'1996-02-07',656747,121.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10769, 'name': 'Foreign'}, {'id': 10749, 'name': 'Romance'}]","en","Hotel de Love",'1996-12-19',0,95.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","The Pest",'1997-02-07',0,82.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Fools Rush In",'1997-02-14',29481428,109.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}, {'id': 10749, 'name': 'Romance'}]","en","Touch",'1997-02-14',0,96.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Absolute Power",'1997-02-14',50068310,121.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","That Darn Cat",'1997-02-14',0,89.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Vegas Vacation",'1997-02-13',36400360,93.0),
("","en","Unforgotten: Twenty-Five Years After Willowbrook",'1997-02-14',0,0.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","That Old Feeling",'1997-04-04',0,105.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}]","en","Lost Highway",'1997-01-15',3675201,134.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Rosewood",'1997-02-21',13130349,140.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Donnie Brasco",'1997-02-27',41954997,127.0),
("[{'id': 35, 'name': 'Comedy'}]","fr","Salut cousin !",'1996-11-20',0,0.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Booty Call",'1997-02-26',20060051,79.0),
("[{'id': 99, 'name': 'Documentary'}]","en","Rhyme & Reason",'1997-03-04',0,0.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Boys Life 2",'1997-03-07',532654,74.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}]","en","City of Industry",'1997-03-14',0,97.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Best Men",'1997-01-01',0,90.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Jungle 2 Jungle",'1997-03-07',0,97.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10749, 'name': 'Romance'}]","en","Kama Sutra - A Tale of Love",'1996-09-11',4109095,117.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Private Parts",'1997-03-07',41230799,109.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Love Jones",'1997-03-14',0,104.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 28, 'name': 'Action'}, {'id': 10749, 'name': 'Romance'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 12, 'name': 'Adventure'}]","en","The Saint",'1997-04-03',118063304,116.0),
("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Smilla's Sense of Snow",'1997-02-13',0,121.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The Van",'1996-05-11',0,100.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 10749, 'name': 'Romance'}]","en","Crash",'1996-07-17',0,100.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","en","The Daytrippers",'1996-01-01',0,87.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Liar Liar",'1997-03-21',302710615,86.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}]","en","The Quiet Room",'1996-03-21',0,93.0),
("[{'id': 18, 'name': 'Drama'}]","en","Selena",'1997-03-21',60000000,127.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}]","en","The Devil's Own",'1997-03-12',140807547,107.0),
("[{'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}]","en","Cats Don't Dance",'1997-03-26',3566637,75.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","B.A.P.S.",'1997-03-28',7240837,90.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]", "en", "Love and Other Catastrophes",'1996-08-01',0,78.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Turbo: A Power Rangers Movie",'1997-03-27',17979739,99.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Anna Karenina",'1997-04-04',791830,108.0),
("[{'id': 28, 'name': 'Action'}, {'id': 878, 'name': 'Science Fiction'}]","en","Double Team",'1997-04-04',0,93.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Inventing the Abbotts",'1997-04-04',5926128,110.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Anaconda",'1997-04-11',136885767,89.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}, {'id': 10749, 'name': 'Romance'}]","en","Grosse Pointe Blank",'1997-04-11',28084357,107.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Keys to Tulsa",'1997-04-11',57252,113.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","Kissed",'1996-09-07',0,78.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","8 Heads in a Duffel Bag",'1997-04-18',0,95.0),
("[{'id': 18, 'name': 'Drama'}]","en","Hollow Reed",'1996-06-24',0,102.0),
("[{'id': 10752, 'name': 'War'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Paradise Road",'1997-04-11',0,122.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Traveller",'1997-04-18',0,101.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","All Over Me",'1997-02-15',0,93.0),
("[{'id': 18, 'name': 'Drama'}]","en","A Brother's Kiss",'1997-04-25',0,92.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 10769, 'name': 'Foreign'}]","fr","Shekvarebuli kulinaris ataserti retsepti",'1996-06-06',0,100.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Romy and Michele's High School Reunion",'1997-04-25',29235353,92.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}, {'id': 10749, 'name': 'Romance'}]","zh","Feng yue",'1996-05-09',0,130.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Volcano",'1997-04-25',0,104.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Children of the Revolution",'1996-06-14',0,101.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Austin Powers: International Man of Mystery",'1997-05-02',67683989,94.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Breakdown",'1997-05-02',50159144,95.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","Broken English",'1996-09-09',0,92.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Commandments",'1997-05-02',0,88.0),
("[{'id': 18, 'name': 'Drama'}]","en","Ripe",'1996-09-10',0,92.0),
("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","Truth or Consequences, N.M.",'1997-01-01',0,106.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Turning",'1992-01-01',0,87.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 10751, 'name': 'Family'}, {'id': 28, 'name': 'Action'}]","en","Warriors of Virtue",'1997-05-02',0,103.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Fathers' Day",'1997-05-09',0,89.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Fifth Element",'1997-05-07',263920180,126.0),
("","en","Intimate Relations",'1996-01-01',0,105.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Nowhere",'1997-05-09',27354,82.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Losing Chase",'1996-08-18',0,98.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Sprung",'1997-05-14',7553105,105.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","de","Das Versprechen",'1995-02-16',0,115.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","fr","Le bonheur",'1965-02-10',0,79.0),
("[{'id': 18, 'name': 'Drama'}]","de","Love! Valour! Compassion!",'1997-05-16',2900000,108.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","ja","Shall we ダンス?",'1996-01-27',0,136.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}]","en","The Second Jungle Book: Mowgli & Baloo",'1997-05-16',479099,88.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Twin Town",'1997-04-11',0,99.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Addicted to Love",'1997-05-23',34673095,100.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","Brassed Off",'1996-11-01',0,107.0),
("","en","The Designated Mourner",'1997-05-23',0,94.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Lost World: Jurassic Park",'1997-05-23',229074524,129.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}]","fr","Ponette",'1996-09-10',0,97.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Schizopolis",'1996-09-13',0,96.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Shiloh",'1996-11-30',0,93.0),
("[{'id': 18, 'name': 'Drama'}]","en","The War at Home",'1996-11-20',0,119.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 14, 'name': 'Fantasy'}]","en","Rough Magic",'1995-09-07',0,100.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Trial and Error",'1997-05-30',0,98.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Buddy",'1997-06-06',0,84.0);


INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Con Air",'1997-06-01',224012234,115.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}, {'id': 10749, 'name': 'Romance'}]","en","The Pillow Book",'1996-05-12',0,126.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","En avoir (ou pas)",'1995-12-27',0,89.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Speed 2: Cruise Control",'1997-06-13',164508066,121.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Squeeze",'1997-06-06',10300,95.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}]","en","Sudden Manhattan",'1996-10-11',0,80.0),
("","en","The Next Step",'1997-06-13',0,0.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Wedding Bell Blues",'1996-10-18',44000,102.0),
("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 14, 'name': 'Fantasy'}]","en","Batman & Robin",'1997-06-20',238207122,125.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Dream with the Fishes",'1997-01-01',0,97.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","Roseanna's Grave",'1997-03-06',0,98.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}]","en","Head Above Water",'1996-11-07',0,92.0),
("[{'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Hercules",'1997-06-26',252712101,93.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Last Time I Committed Suicide",'1997-06-20',0,92.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","MURDER and murder",'1996-09-10',0,113.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","My Best Friend's Wedding",'1997-06-19',299288605,105.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 27, 'name': 'Horror'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","ja","Tetsuo II: Body Hammer",'1992-01-01',0,83.0),
("[{'id': 35, 'name': 'Comedy'}]","fr","Chacun Cherche Son Chat",'1996-04-03',0,91.0),
("[{'id': 18, 'name': 'Drama'}]","fr","Le Mépris",'1963-10-21',528428,103.0),
("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Face/Off",'1997-06-27',245676146,138.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Fall",'1997-06-20',0,93.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}]","fa","گبه",'1996-06-26',0,75.0),
("[{'id': 18, 'name': 'Drama'}]","fr","Mondo",'1995-06-01',0,80.0),
("[{'id': 53, 'name': 'Thriller'}]","fr","The Innocent Sleep",'1996-01-25',0,110.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10752, 'name': 'War'}]","en","For Ever Mozart",'1996-11-27',0,84.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}]","en","Men in Black",'1997-07-02',589390539,98.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Out to Sea",'1997-07-02',0,106.0),
("[{'id': 10751, 'name': 'Family'}]","en","Wild America",'1997-07-02',0,106.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","A Simple Wish",'1997-07-11',8345056,86.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 9648, 'name': 'Mystery'}]","en","Contact",'1997-07-11',171120329,150.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10769, 'name': 'Foreign'}, {'id': 10749, 'name': 'Romance'}]","en","Love Serenade",'1996-10-10',0,101.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}]","en","G.I. Jane",'1997-08-22',48169156,125.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 28, 'name': 'Action'}]","en","Conan the Barbarian",'1982-04-02',79114085,129.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}]","en","George of the Jungle",'1997-07-15',0,92.0),
("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Cop Land",'1997-08-15',44862187,104.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 9648, 'name': 'Mystery'}]","en","Event Horizon",'1997-08-15',26673242,96.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Spawn",'1997-07-31',87840042,96.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 18, 'name': 'Drama'}]","en","Air Bud",'1997-08-01',23144499,98.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Picture Perfect",'1997-08-01',44332015,105.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","In the Company of Men",'1997-01-19',0,97.0),
("[{'id': 12, 'name': 'Adventure'}]","en","Free Willy 3: The Rescue",'1997-08-08',0,86.0),
("[{'id': 18, 'name': 'Drama'}]","en","Career Girls",'1997-06-01',0,83.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Conspiracy Theory",'1997-08-07',136982834,135.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Desperate Measures",'1998-01-30',0,100.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}]","en","Steel",'1997-08-15',1686429,97.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","She's So Lovely",'1997-08-29',0,100.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Hoodlum",'1997-08-27',0,130.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Leave it to Beaver",'1997-08-22',0,84.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Mimic",'1997-08-22',25480490,105.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}]","en","Money Talks",'1997-08-22',0,97.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Excess Baggage",'1997-08-29',0,101.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 28, 'name': 'Action'}, {'id': 878, 'name': 'Science Fiction'}]","en","Kull the Conqueror",'1997-08-29',0,95.0),
("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Air Force One",'1997-07-25',315156409,124.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","One Eight Seven",'1997-07-29',5716080,119.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","The Hunt for Red October",'1990-03-02',199200000,134.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","My Own Private Idaho",'1991-10-17',0,104.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Kiss Me, Guido",'1997-07-18',0,86.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Star Maps",'1997-07-23',0,86.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","In & Out",'1997-09-10',0,90.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}]","en","The Edge",'1997-09-06',43312294,117.0),
("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","The Peacemaker",'1997-09-26',0,124.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","L.A. Confidential",'1997-09-19',126216940,138.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Seven Years in Tibet",'1997-09-12',131457682,136.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Kiss the Girls",'1997-10-03',60527873,115.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Soul Food",'1997-09-26',0,114.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Kicked in the Head",'1997-09-26',0,87.0),
("[{'id': 27, 'name': 'Horror'}]","en","Wishmaster",'1997-09-19',15719109,90.0),
("[{'id': 18, 'name': 'Drama'}]","en","A Thousand Acres",'1997-09-17',0,105.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}]","en","The Game",'1997-09-12',109423648,129.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Fire Down Below",'1997-09-05',16000000,105.0),
("[{'id': 53, 'name': 'Thriller'}]","en","U Turn",'1997-10-03',6682098,125.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Locusts",'1997-10-03',10082,124.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","The Matchmaker",'1997-10-03',0,97.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}]","en","The Assignment",'1997-09-28',0,119.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","A Smile Like Yours",'1997-08-27',0,98.0),
("[{'id': 18, 'name': 'Drama'}]","en","Ulee's Gold",'1997-06-13',0,112.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Ice Storm",'1997-09-27',8038061,112.0),
("[{'id': 53, 'name': 'Thriller'}]","en","Stag",'1997-04-01',0,91.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Chasing Amy",'1997-04-04',12021272,113.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","How to Be a Player",'1997-08-06',13960203,93.0),
("[{'id': 35, 'name': 'Comedy'}]","en","The Full Monty",'1997-08-13',257850122,91.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Indian Summer",'1996-11-08',0,98.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10749, 'name': 'Romance'}]","en","Mrs Brown",'1997-07-18',0,105.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}]","en","I Know What You Did Last Summer",'1997-10-17',125586134,100.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Devil's Advocate",'1997-10-17',152944660,144.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 878, 'name': 'Science Fiction'}]","en","RocketMan",'1997-10-10',0,95.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Playing God",'1997-10-17',4000000,94.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The House of Yes",'1997-10-10',626057,85.0),
("[{'id': 99, 'name': 'Documentary'}]","en","Fast, Cheap & Out of Control",'1997-10-03',832735,83.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Washington Square",'1997-10-10',1,115.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 18, 'name': 'Drama'}]","de","Telling Lies In America",'1997-08-02',0,101.0),
("[{'id': 99, 'name': 'Documentary'}, {'id': 10402, 'name': 'Music'}]","en","Year of the Horse",'1997-10-08',0,106.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10749, 'name': 'Romance'}]","en","Gattaca",'1997-09-07',12532777,106.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 10751, 'name': 'Family'}]","en","FairyTale: A True Story",'1997-01-01',14000000,99.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Phantoms",'1998-01-23',5624282,91.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Swept from the Sea",'1998-01-23',0,113.0),
("[{'id': 99, 'name': 'Documentary'}]","en","Wonderland",'1997-10-17',0,0.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10749, 'name': 'Romance'}]","en","A Life Less Ordinary",'1997-10-24',0,103.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Hurricane Streets",'1997-01-21',0,86.0),
("[{'id': 18, 'name': 'Drama'}]","en","Eve's Bayou",'1997-09-07',0,109.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Switchback",'1997-10-31',6482195,118.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}]","en","Gang Related",'1997-10-08',5790448,102.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","Stripes",'1981-06-25',85300000,106.0),
("[{'id': 18, 'name': 'Drama'}]","fr","Nénette et Boni",'1997-01-29',0,103.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Bean",'1997-07-03',251212670,85.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Hugo Pool",'1997-01-01',0,92.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Mad City",'1997-11-07',10541523,114.0),
("[{'id': 18, 'name': 'Drama'}]","en","One Night Stand",'1997-11-14',2642983,102.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}, {'id': 10769, 'name': 'Foreign'}]","en","The Tango Lesson",'1997-11-28',0,100.0),
("[{'id': 10752, 'name': 'War'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Welcome to Sarajevo",'1997-05-09',0,103.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Deceiver",'1997-08-31',0,106.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","The Rainmaker",'1997-11-18',45916769,135.0),
("[{'id': 18, 'name': 'Drama'}]","en","Boogie Nights",'1997-09-11',43101594,155.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","Witness",'1985-02-08',68706993,113.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Incognito",'1997-11-14',0,108.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}]","en","Starship Troopers",'1997-11-06',121214377,129.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Critical Care",'1997-10-31',0,107.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Joy Luck Club",'1993-09-08',32861136,139.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Chairman of the Board",'1998-03-13',0,95.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10749, 'name': 'Romance'}]","en","Sliding Doors",'1998-04-23',58000000,99.0),
("[{'id': 28, 'name': 'Action'}, {'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}]","en","Mortal Kombat: Annihilation",'1997-11-21',51376861,95.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The Truman Show",'1998-06-04',264118201,103.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Wings of the Dove",'1997-11-07',0,102.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Mrs. Dalloway",'1997-09-01',3309421,97.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}]","en","I Love You, I Love You Not",'1996-08-28',0,88.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Red Corner",'1997-10-30',0,122.0),
("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}]","en","The Jackal",'1997-11-14',159330280,124.0),
("[{'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}]","en","Anastasia",'1997-11-20',139804348,94.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 28, 'name': 'Action'}]","en","The Man Who Knew Too Little",'1997-11-14',13801755,97.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 27, 'name': 'Horror'}, {'id': 28, 'name': 'Action'}]","en","Alien: Resurrection",'1997-11-12',162000000,109.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}]","en","Alien Escape",'1996-01-01',0,85.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 9648, 'name': 'Mystery'}]","en","Amistad",'1997-12-03',74000000,155.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Apostle",'1997-10-09',0,134.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","fr","Artemisia",'1997-09-10',0,98.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10749, 'name': 'Romance'}]","en","Bent",'1997-11-26',0,105.0),
("[{'id': 18, 'name': 'Drama'}]","en","Bang",'1995-09-09',0,98.0),
("[{'id': 35, 'name': 'Comedy'}]","fr","Les Boys",'1997-12-12',0,107.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The Butcher Boy",'1997-07-13',0,110.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Deconstructing Harry",'1997-08-26',10686841,96.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 878, 'name': 'Science Fiction'}]","en","Flubber",'1997-11-26',177977226,93.0),
("[{'id': 35, 'name': 'Comedy'}]","en","For Richer or Poorer",'1997-12-11',31611225,115.0),
("[{'id': 18, 'name': 'Drama'}]","en","Good Will Hunting",'1997-12-05',225933435,126.0),
("","en","Guy",'1997-12-17',0,91.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Home Alone 3",'1997-12-12',79082515,102.0),
("[{'id': 18, 'name': 'Drama'}]","en","Ill Gotten Gains",'1997-12-05',0,101.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 18, 'name': 'Drama'}]","en","Man of Her Dreams",'1997-11-18',0,94.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Midnight in the Garden of Good and Evil",'1997-11-21',25105255,155.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","MouseHunt",'1997-12-19',122417389,98.0),
("","en","Never Met Picasso",'1996-01-01',0,0.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Office Killer",'1997-01-01',0,82.0),
("[{'id': 18, 'name': 'Drama'}]","en","Other Voices Other Rooms",'1995-09-15',0,0.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}]","en","Scream 2",'1997-12-09',172363301,120.0),
("[{'id': 53, 'name': 'Thriller'}]","en","Stranger in the House",'1997-01-01',0,94.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Sweet Hereafter",'1997-05-14',3263585,112.0),
("[{'id': 878, 'name': 'Science Fiction'}]","en","Time Tracers",'1997-12-16',0,101.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","en","Titanic",'1997-11-18',1845034188,194.0),
("['{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Tomorrow Never Dies",'1997-12-11',333011068,119.0),
("[{'id': 18, 'name': 'Drama'}]","en","Twisted",'1996-11-14',0,100.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","fr","À Toute vitesse",'1996-09-25',0,85.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Education of Little Tree",'1997-12-25',0,115.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 12, 'name': 'Adventure'}]","en","The Postman",'1997-12-25',17626234,177.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Horse Whisperer",'1998-05-14',186883563,170.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Winter Guest",'1997-12-27',0,108.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 10749, 'name': 'Romance'}]","en","Jackie Brown",'1997-12-24',39673162,154.0),
("[{'id': 18, 'name': 'Drama'}]","en","Kundun",'1997-12-25',5684789,134.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Mr. Magoo",'1997-12-25',0,84.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","The Big Lebowski",'1998-03-06',46189568,117.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}]","en","Afterglow",'1997-12-26',2465960,119.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","fr","Ma vie en rose",'1997-05-28',0,88.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Great Expectations",'1998-01-19',55494066,111.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","3 Ninjas: High Noon at Mega Mountain",'1998-04-10',0,93.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}]","en","Men of Means",'1999-05-25',0,80.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Caught Up",'1998-02-27',0,97.0),
("","en","Arguing the World",'1998-01-07',0,0.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Firestorm",'1998-01-08',0,89.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","pt","Senseless",'1998-02-20',13035599,93.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Wag the Dog",'1997-12-25',64256513,97.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 878, 'name': 'Science Fiction'}]","en","Dark City",'1998-02-27',27200316,100.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Leading Man",'1996-12-12',0,100.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}, {'id': 878, 'name': 'Science Fiction'}]","en","Star Kid",'1997-01-16',7,101.0),
("[{'id': 53, 'name': 'Thriller'}]","en","Hard Rain",'1998-01-16',19870567,97.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Half Baked",'1998-01-16',17460020,82.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 14, 'name': 'Fantasy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Fallen",'1998-01-16',25232289,124.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Shooting Fish",'1997-08-22',302204,109.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","The Prophecy II",'1998-01-20',0,87.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 10749, 'name': 'Romance'}]","cn","墮落天使",'1995-09-06',0,96.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}, {'id': 36, 'name': 'History'}, {'id': 53, 'name': 'Thriller'}]","pt","O Que é Isso, Companheiro?",'1997-05-01',310724,110.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}]","en","Spice World",'1997-12-19',100000000,93.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}]","en","Deep Rising",'1998-01-30',11203026,106.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 35, 'name': 'Comedy'}]","en","Tainted",'1998-05-18',0,108.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}]","en","A Letter from Death Row",'1998-11-17',0,89.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Music from Another Room",'1998-04-24',0,104.0),
("[{'id': 18, 'name': 'Drama'}]","ru","Мать и сын",'1997-02-20',0,73.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","The Replacement Killers",'1998-02-06',19204929,87.0);


INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
("[{'id': 10749, 'name': 'Romance'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","B. Monkey",'1998-11-07',0,94.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 27, 'name': 'Horror'}, {'id': 14, 'name': 'Fantasy'}]","en","The Night Flier",'1997-04-30',91549,93.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Blues Brothers 2000",'1998-02-05',14051384,123.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","ja","Tokyo Fist",'1995-01-01',0,87.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Ride",'1998-03-27',0,90.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}]","en","The Wedding Singer",'1998-02-13',123306987,95.0),
("[{'id': 878, 'name': 'Science Fiction'}]","en","Sphere",'1998-02-13',13100000,134.0),
("[{'id': 99, 'name': 'Documentary'}]","en","Ayn Rand: A Sense of Life",'1998-02-13',0,145.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 10749, 'name': 'Romance'}]","en","A Further Gesture",'1997-01-01',0,96.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Little City",'1997-04-04',0,90.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 80, 'name': 'Crime'}]","en","Palmetto",'1998-02-20',0,114.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","As Good as It Gets",'1997-12-19',314178011,139.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","King of New York",'1990-07-18',2554476,103.0),
("[{'id': 99, 'name': 'Documentary'}]","en","A Paralyzing Fear: The Story of Polio in America",'1998-03-04',0,90.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Men with Guns",'1998-03-06',0,89.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Twilight",'1998-03-06',0,94.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 28, 'name': 'Action'}]","en","U.S. Marshals",'1998-03-06',102367405,131.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}, {'id': 12, 'name': 'Adventure'}]","en","Welcome to Woop Woop",'1998-08-13',0,106.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10769, 'name': 'Foreign'}]","en","Love and Death on Long Island",'1997-01-01',0,93.0),
("[{'id': 18, 'name': 'Drama'}]","es","El Callejón de los Milagros",'1995-05-05',0,140.0),
("[{'id': 12, 'name': 'Adventure'}]","en","In God's Hands",'1998-04-24',0,96.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 99, 'name': 'Documentary'}]","en","Everest",'1998-03-06',76447420,44.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Hush",'1998-03-06',0,95.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Suicide Kings",'1997-09-06',0,106.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}]","en","The Man in the Iron Mask",'1998-03-12',0,132.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}]","en","The Newton Boys",'1998-03-26',76000000,113.0),
("[{'id': 53, 'name': 'Thriller'}]","en","Wild Things",'1998-03-20',67200000,108.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Paulie",'1998-04-17',0,91.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","A Cool, Dry Place",'1998-01-29',0,97.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","ja","はなび",'1997-09-03',0,103.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Primary Colors",'1998-03-20',0,143.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Niagara, Niagara",'1997-08-30',168462,93.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Wide Awake",'1998-03-20',0,88.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","A Price Above Rubies",'1998-03-26',1081957,117.0),
("[{'id': 18, 'name': 'Drama'}]","en","Eden",'1996-01-01',0,106.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Two Girls and a Guy",'1997-09-07',2057193,84.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","No Looking Back",'1998-03-27',0,96.0),
("[{'id': 99, 'name': 'Documentary'}]","en","Storefront Hitchcock",'1998-03-27',0,77.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Proposition",'1998-03-26',0,110.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Object of My Affection",'1998-04-17',46905889,111.0),
("[{'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Meet the Deedles",'1998-03-27',4562146,93.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Homegrown",'1998-01-01',271375,102.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Players Club",'1998-04-08',0,104.0),
("[{'id': 10751, 'name': 'Family'}]","en","Barney's Great Adventure",'1998-01-01',0,76.0),
("[{'id': 99, 'name': 'Documentary'}]","en","The Big One",'1997-09-06',720074,91.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Chinese Box",'1997-09-04',0,99.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}, {'id': 878, 'name': 'Science Fiction'}]","en","Lost in Space",'1998-04-03',136159423,130.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Heaven's Burning",'1997-09-04',0,96.0),
("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Mercury Rising",'1998-04-03',0,111.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Spanish Prisoner",'1997-09-08',13835130,110.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10749, 'name': 'Romance'}]","en","City of Angels",'1998-04-10',198685114,114.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Last Days of Disco",'1998-05-29',0,113.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}]","en","The Odd Couple II",'1998-04-09',0,97.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","My Giant",'1998-04-10',7985929,103.0),
("[{'id': 18, 'name': 'Drama'}]","en","He Got Game",'1998-05-01',21567853,136.0),
("[{'id': 53, 'name': 'Thriller'}]","en","The Gingerbread Man",'1998-01-23',0,114.0),
("","en","Illtown",'1996-07-09',0,103.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}]","en","Slappy and the Stinkers",'1998-01-23',0,78.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 53, 'name': 'Thriller'}]","es","Carne trémula",'1997-10-28',1535558,103.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Zero Effect",'1998-01-30',1980338,116.0),
("[{'id': 18, 'name': 'Drama'}]","en","Nil by Mouth",'1997-05-08',0,128.0),
("[{'id': 53, 'name': 'Thriller'}]","en","Ratchet",'1996-09-12',0,114.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Borrowers",'1997-12-05',0,86.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}]","en","Prince Valiant",'1997-07-24',0,91.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","fr","I Love You, Don't Touch Me!",'1997-01-21',0,86.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Leather Jacket Love Story",'1998-02-20',0,85.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Love Walked In",'1997-01-18',0,95.0),
("[{'id': 35, 'name': 'Comedy'}]","en","An Alan Smithee Film: Burn, Hollywood, Burn",'1998-02-20',45779,86.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Kissing a Fool",'1998-02-27',0,93.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Krippendorf's Tribe",'1998-02-27',0,94.0),
("[{'id': 99, 'name': 'Documentary'}, {'id': 10402, 'name': 'Music'}]","en","Kurt & Courtney",'1998-02-27',0,95.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Real Blonde",'1997-09-14',0,105.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","cn","一個好人",'1997-01-31',18814720,113.0),
("[{'id': 18, 'name': 'Drama'}]","fa","طعم گيلاس",'1997-09-28',0,95.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}, {'id': 36, 'name': 'History'}]","nl","Karakter",'1997-04-17',0,122.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}]","nb","Budbringeren",'1997-02-21',0,83.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 27, 'name': 'Horror'}]","en","Species II",'1998-04-10',19165560,93.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Major League: Back to the Minors",'1998-04-17',3572443,107.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Sour Grapes",'1998-01-01',0,91.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 99, 'name': 'Documentary'}]","en","Wild Man Blues",'1997-01-16',425788,105.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}]","en","The Big Hit",'1998-04-24',27007143,91.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}]","en","Tarzan and the Lost City",'1998-04-24',0,83.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Black Dog",'1998-05-01',0,88.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Dancer, Texas Pop. 81",'1998-05-01',565592,97.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Priyatel Pokoynika",'1997-09-10',0,100.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}, {'id': 10770, 'name': 'TV Movie'}]","en","Go Now",'1995-09-16',0,81.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10749, 'name': 'Romance'}]","en","Les Misérables",'1998-05-01',14096321,134.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Still Breathing",'1997-09-01',0,109.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Clockwatchers",'1997-01-01',0,96.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Deep Impact",'1998-05-08',140464664,120.0),
("","en","Little Men",'1998-05-08',0,98.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Woo",'1998-05-08',8026971,84.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Hanging Garden",'1997-01-01',0,91.0),
("[{'id': 18, 'name': 'Drama'}]","en","Lawn Dogs",'1997-11-21',0,101.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 16, 'name': 'Animation'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10751, 'name': 'Family'}]","en","Quest for Camelot",'1998-05-15',38172500,86.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}]","en","Godzilla",'1998-05-20',379014294,139.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Bulworth",'1998-05-15',29202884,108.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Fear and Loathing in Las Vegas",'1998-05-22',10680275,118.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The Opposite of Sex",'1998-05-22',5879254,105.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","I Got the Hook Up",'1998-05-27',0,93.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 37, 'name': 'Western'}]","en","Almost Heroes",'1998-05-29',0,90.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Hope Floats",'1998-05-29',0,114.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","no","Insomnia",'1997-03-14',0,96.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Little Boy Blue",'1997-06-01',0,99.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","fr","The Ugly",'1997-08-26',0,93.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}]","en","A Perfect Murder",'1998-06-05',128038368,107.0),
("[{'id': 18, 'name': 'Drama'}]","de","Jenseits der Stille",'1996-12-18',0,109.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Six Days Seven Nights",'1998-06-12',164000000,98.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Can't Hardly Wait",'1998-06-12',25605015,100.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Cousin Bette",'1998-06-12',0,108.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","High Art",'1998-06-12',1929168,101.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","en","The Land Girls",'1998-09-25',0,111.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 12, 'name': 'Adventure'}]","en","Passion in the Desert",'1997-08-31',0,91.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","fa",",بچه‌های آسمان",'1997-08-01',900000,89.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Dream for an Insomniac",'1996-04-18',24,90.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Hav Plenty",'1997-09-11',0,92.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Henry Fool",'1997-09-07',1334786,137.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Marie Baie des Anges",'1998-06-19',0,90.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Mr. Jealousy",'1997-09-11',0,105.0),
("[{'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}, {'id': 12, 'name': 'Adventure'}]","en","Mulan",'1998-06-18',304320254,88.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Resurrection Man",'1998-02-13',0,102.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","The X Files",'1998-06-19',189198313,121.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","I Went Down",'1997-10-03',0,97.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Doctor Dolittle",'1998-06-22',294456605,85.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Out of Sight",'1998-06-26',77745568,123.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","en","Picnic at Hanging Rock",'1975-09-02',0,115.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Smoke Signals",'1998-01-16',0,89.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10769, 'name': 'Foreign'}]","pt","Viagem ao Princípio do Mundo",'1997-05-05',0,95.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","Buffalo '66",'1998-01-20',2375097,110.0),
("[{'id': 28, 'name': 'Action'}, {'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 12, 'name': 'Adventure'}]","en","Armageddon",'1998-07-01',553799566,151.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Lethal Weapon 4",'1998-07-10',285444603,127.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Madeline",'1998-07-10',0,89.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}]","en","Small Soldiers",'1998-07-10',54682547,110.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Pi",'1998-07-10',3221152,84.0),
("[{'id': 18, 'name': 'Drama'}]","en","Whatever",'1998-07-10',0,112.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}]","en","There's Something About Mary",'1998-07-15',369884651,119.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 27, 'name': 'Horror'}]","en","Plan 9 from Outer Space",'1959-07-22',0,79.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","en","Wings",'1927-08-12',0,141.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","The Broadway Melody",'1929-02-08',4358000,100.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}]","en","All Quiet on the Western Front",'1930-04-29',0,133.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 37, 'name': 'Western'}]","en","Cimarron",'1931-02-09',0,123.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Grand Hotel",'1932-05-25',2594000,112.0),
("[{'id': 18, 'name': 'Drama'}]","en","Cavalcade",'1933-02-08',7630000,110.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10749, 'name': 'Romance'}]","en","Mutiny on the Bounty",'1935-11-08',4460000,132.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","The Great Ziegfeld",'1936-04-08',0,176.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Life of Emile Zola",'1937-10-02',0,116.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","You Can't Take It With You",'1938-08-23',7433101,126.0),
("[{'id': 18, 'name': 'Drama'}]","en","How Green Was My Valley",'1941-10-28',6000000,118.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","en","Mrs. Miniver",'1942-06-04',13500000,134.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 10402, 'name': 'Music'}]","en","Going My Way",'1944-05-15',16300000,130.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Lost Weekend",'1945-11-25',11000000,101.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10749, 'name': 'Romance'}]","en","The Best Years of Our Lives",'1946-12-25',23650000,172.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Gentleman's Agreement",'1947-11-11',7800000,118.0),
("[{'id': 18, 'name': 'Drama'}]","en","Hamlet",'1948-03-25',0,155.0),
("[{'id': 18, 'name': 'Drama'}]","en","All the King's Men",'1949-11-08',0,109.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Greatest Show on Earth",'1952-01-10',36000000,152.0),
("[{'id': 10752, 'name': 'War'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","From Here to Eternity",'1953-08-28',30500000,118.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","On the Waterfront",'1954-06-22',9600000,108.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Marty",'1955-04-11',3000000,90.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}]","en","West Side Story",'1961-10-18',43656822,152.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 36, 'name': 'History'}, {'id': 10749, 'name': 'Romance'}]","en","Tom Jones",'1963-10-06',37600000,128.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","A Man for All Seasons",'1966-12-12',28350000,120.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","In the Heat of the Night",'1967-08-02',27379978,109.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}]","en","Oliver!",'1968-09-26',37402877,153.0),
("[{'id': 18, 'name': 'Drama'}]","en","Midnight Cowboy",'1969-05-25',44785053,113.0),
("[{'id': 28, 'name': 'Action'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","The French Connection",'1971-10-09',41158757,104.0),
("[{'id': 18, 'name': 'Drama'}]","en","Rocky",'1976-11-21',117235147,119.0),
("[{'id': 18, 'name': 'Drama'}]","en","Kramer vs. Kramer",'1979-12-18',106260000,105.0),
("[{'id': 18, 'name': 'Drama'}]","en","Ordinary People",'1980-09-19',0,124.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","Chariots of Fire",'1981-05-15',58972904,123.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Terms of Endearment",'1983-11-20',0,132.0),
("[{'id': 18, 'name': 'Drama'}]","en","Out of Africa",'1985-12-20',128499205,161.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}]","en","The Last Emperor",'1987-10-21',43984230,163.0),
("[{'id': 18, 'name': 'Drama'}]","en","Rain Man",'1988-12-11',412800000,133.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Driving Miss Daisy",'1989-12-13',145793296,99.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Take the Money and Run",'1969-08-18',0,85.0),
("[{'id': 9648, 'name': 'Mystery'}]","en","Klute",'1971-06-21',0,114.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Repo Man",'1984-02-20',2300000,92.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Metropolitan",'1990-08-03',0,98.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Labyrinth",'1986-06-27',12729917,101.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","The Breakfast Club",'1985-02-15',51525171,97.0),
("[{'id': 27, 'name': 'Horror'}]","en","A Nightmare on Elm Street Part 2: Freddy's Revenge",'1985-10-31',29999213,87.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","A Nightmare on Elm Street 3: Dream Warriors",'1987-02-27',44793222,96.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","A Nightmare on Elm Street 4: The Dream Master",'1988-08-19',72500000,99.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","A Nightmare on Elm Street 5: The Dream Child",'1989-08-11',22168359,89.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}, {'id': 35, 'name': 'Comedy'}]","en","Freddy's Dead: The Final Nightmare",'1991-09-05',34872033,89.0),
("[{'id': 27, 'name': 'Horror'}]","en","Friday the 13th",'1980-05-09',59754601,95.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Friday the 13th Part 2",'1981-05-01',21722776,87.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Friday the 13th Part III",'1982-08-13',36690067,95.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Friday the 13th: The Final Chapter",'1984-04-13',32980880,91.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Friday the 13th: A New Beginning",'1985-03-22',21930418,92.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Friday the 13th Part VI: Jason Lives",'1986-08-01',19472057,86.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Friday the 13th Part VII: The New Blood",'1988-05-13',19170001,88.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Friday the 13th Part VIII: Jason Takes Manhattan",'1989-07-28',14000000,100.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Halloween",'1978-10-25',70000000,91.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Halloween II",'1981-10-30',25533818,92.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}, {'id': 878, 'name': 'Science Fiction'}]","en","Halloween III: Season of the Witch",'1982-10-22',14400000,98.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Halloween 4: The Return of Michael Myers",'1988-10-21',17768757,88.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Halloween 5: The Revenge of Michael Myers",'1989-10-12',11642254,96.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Prom Night",'1980-07-18',14796236,92.0),
("[{'id': 27, 'name': 'Horror'}]","en","Hello Mary Lou: Prom Night II",'1987-11-13',2683519,97.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 35, 'name': 'Comedy'}, {'id': 27, 'name': 'Horror'}]","en","Prom Night III: The Last Kiss",'1990-03-30',0,97.0),
("[{'id': 27, 'name': 'Horror'}]","en","Prom Night IV: Deliver Us from Evil",'1992-02-14',0,92.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Child's Play",'1988-11-08',44196684,87.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}]","en","Child's Play 2",'1990-11-09',35763605,84.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 27, 'name': 'Horror'}, {'id': 28, 'name': 'Action'}]","en","Child's Play 3",'1991-08-30',20560255,90.0),
("[{'id': 27, 'name': 'Horror'}]","en","Poltergeist",'1982-06-04',122200000,114.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Poltergeist II: The Other Side",'1986-05-23',40996665,91.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Poltergeist III",'1988-06-10',14144000,98.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","The Exorcist",'1973-12-26',441306145,122.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}, {'id': 14, 'name': 'Fantasy'}]","en","Exorcist II: The Heretic",'1977-06-17',30749142,118.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 27, 'name': 'Horror'}, {'id': 9648, 'name': 'Mystery'}]","en","The Exorcist III",'1990-08-17',39024251,110.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Lethal Weapon",'1987-03-06',120207127,110.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Lethal Weapon 2",'1989-07-07',227853986,114.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Lethal Weapon 3",'1992-05-15',321731527,118.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}]","en","Gremlins",'1984-06-07',153083102,106.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 27, 'name': 'Horror'}, {'id': 14, 'name': 'Fantasy'}]","en","Gremlins 2: The New Batch",'1990-06-15',41482207,106.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Goonies",'1985-06-06',61503218,114.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}]","en","The Mask of Zorro",'1998-07-16',250288523,136.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Polish Wedding",'1998-01-16',0,105.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","This World, Then the Fireworks",'1997-07-11',0,100.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","Soylent Green",'1973-04-19',3600000,97.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 878, 'name': 'Science Fiction'}]","de","Metropolis",'1927-01-10',650422,153.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 878, 'name': 'Science Fiction'}]","en","Back to the Future Part II",'1989-11-20',332000000,108.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 878, 'name': 'Science Fiction'}]","en","Back to the Future Part III",'1990-05-25',244527583,118.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}]","en","The Poseidon Adventure",'1972-12-01',84563118,117.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Freaky Friday",'1976-12-17',0,95.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Absent-Minded Professor",'1961-03-16',0,96.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 37, 'name': 'Western'}]","en","The Apple Dumpling Gang Rides Again",'1979-06-27',0,88.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","Babes in Toyland",'1961-12-14',0,106.0),
("[{'id': 16, 'name': 'Animation'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Bambi",'1942-08-14',267447150,70.0);


INSERT INTO BIG_MOVIE
	(genres, original_language, original_title, release_date, revenue, runtime)
VALUES
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}]","ja","七人の侍",'1954-04-26',271841,207.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Dangerous Liaisons",'1988-12-16',34670720,119.0),
("[{'id': 28, 'name': 'Action'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 12, 'name': 'Adventure'}]","en","Dune",'1984-12-14',30925690,137.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Last Temptation of Christ",'1988-08-12',8373585,164.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Godfather: Part III",'1990-12-24',136766062,162.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 18, 'name': 'Drama'}]","en","The Rapture",'1991-10-04',1277401,100.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Lolita",'1997-09-27',1060056,137.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}]","en","Disturbing Behavior",'1998-07-24',17507368,84.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Jane Austen's Mafia!",'1998-07-24',19000000,84.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 10752, 'name': 'War'}]","en","Saving Private Ryan",'1998-07-24',481840909,169.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Billy's Hollywood Screen Kiss",'1998-07-24',2020700,92.0),
("[{'id': 18, 'name': 'Drama'}]","zh","东宫西宫",'1996-01-01',0,90.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Million Dollar Duck",'1971-06-30',0,89.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Barefoot Executive",'1971-03-17',0,96.0),
("[{'id': 16, 'name': 'Animation'}]","en","The Black Cauldron",'1985-07-24',21288692,80.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}]","en","The Black Hole",'1979-12-18',35841901,98.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Blackbeard's Ghost",'1968-02-08',0,106.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Blank Check",'1994-02-11',0,93.0),
("[{'id': 10751, 'name': 'Family'}]","en","Candleshoe",'1977-12-16',0,101.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Cat from Outer Space",'1978-06-09',0,104.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Cheetah",'1989-08-18',8153677,83.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Computer Wore Tennis Shoes",'1969-12-29',0,91.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}]","en","Condorman",'1981-07-02',0,90.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","D2: The Mighty Ducks",'1994-03-25',45610410,106.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","Darby O'Gill and the Little People",'1959-06-29',0,93.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","The Devil and Max Devlin",'1981-03-06',0,96.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 12, 'name': 'Adventure'}]","en","A Far Off Place",'1993-03-12',12890752,100.0),
("[{'id': 10751, 'name': 'Family'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 12, 'name': 'Adventure'}]","en","Flight of the Navigator",'1986-07-30',18564613,90.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Gnome-Mobile",'1967-07-17',0,85.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}]","en","The Great Mouse Detective",'1986-07-02',38625550,74.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}]","en","The Happiest Millionaire",'1967-06-26',0,172.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 12, 'name': 'Adventure'}]","en","Herbie Goes Bananas",'1980-06-25',0,110.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}]","en","Herbie Goes To Monte Carlo",'1977-06-24',0,105.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Hocus Pocus",'1993-07-16',39514713,96.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 878, 'name': 'Science Fiction'}]","en","Honey I Blew Up the Kid",'1992-07-16',58662452,89.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 878, 'name': 'Science Fiction'}]","en","Honey, I Shrunk the Kids",'1989-06-22',222724172,93.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 37, 'name': 'Western'}]","en","Hot Lead & Cold Feet",'1978-07-05',0,90.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","In Search of the Castaways",'1962-12-01',0,98.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}]","en","The Incredible Journey",'1963-11-20',0,80.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Negotiator",'1998-07-29',44547681,140.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","The Parent Trap",'1998-07-28',0,127.0),
("[{'id': 35, 'name': 'Comedy'}]","en","BASEketball",'1998-07-28',7027290,103.0),
("[{'id': 99, 'name': 'Documentary'}]","en","Full Tilt Boogie",'1997-09-09',0,97.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","The Governess",'1998-07-31',0,115.0),
("[{'id': 18, 'name': 'Drama'}]","fr","Le septième ciel",'1997-12-17',0,91.0),
("[{'id': 99, 'name': 'Documentary'}, {'id': 36, 'name': 'History'}]","en","Roger & Me",'1989-09-01',6706368,91.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","The Purple Rose of Cairo",'1985-03-01',10631333,82.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Out of the Past",'1947-11-13',0,97.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 10752, 'name': 'War'}]","en","Doctor Zhivago",'1965-12-22',111858363,197.0),
("['{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","sv","Fanny och Alexander",'1982-12-17',4971340,188.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Trip to Bountiful",'1985-12-20',7218340,108.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","Tender Mercies",'1983-04-02',0,92.0),
("[{'id': 18, 'name': 'Drama'}]","en","And the Band Played On",'1993-09-11',0,140.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","The 'Burbs",'1989-02-17',36602000,101.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Fandango",'1985-01-25',0,91.0),
("[{'id': 18, 'name': 'Drama'}]","en","Il portiere di notte",'1974-04-03',0,118.0),
("[{'id': 18, 'name': 'Drama'}]","de","Mephisto",'1981-04-29',0,144.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Blue Velvet",'1986-08-01',8551228,120.0),
("[{'id': 12, 'name': 'Adventure'}]","en","The Journey of Natty Gann",'1985-09-25',2135577,101.0),
("[{'id': 10751, 'name': 'Family'}, {'id': 16, 'name': 'Animation'}, {'id': 12, 'name': 'Adventure'}]","en","The Jungle Book",'1967-10-17',205843612,78.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Kidnapped",'1960-01-01',0,97.0),
("[{'id': 10751, 'name': 'Family'}, {'id': 16, 'name': 'Animation'}]","en","Lady and the Tramp",'1955-06-16',93600000,76.0),
("[{'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}]","en","The Little Mermaid",'1989-11-17',222300000,83.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Mighty Ducks",'1992-10-01',50752337,101.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}]","en","The Muppet Christmas Carol",'1992-12-10',27281507,85.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}, {'id': 10751, 'name': 'Family'}]","en","Newsies",'1992-04-10',0,121.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 16, 'name': 'Animation'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","One Hundred and One Dalmatians",'1961-01-25',215880014,79.0),
("[{'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","One Magic Christmas",'1985-11-22',0,88.0),
("[{'id': 16, 'name': 'Animation'}, {'id': 10402, 'name': 'Music'}, {'id': 10751, 'name': 'Family'}, {'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}]","en","Peter Pan",'1953-02-05',87404651,77.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}]","en","Popeye",'1980-12-12',0,114.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 16, 'name': 'Animation'}, {'id': 80, 'name': 'Crime'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","The Rescuers Down Under",'1990-11-16',47431461,77.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 10751, 'name': 'Family'}, {'id': 16, 'name': 'Animation'}, {'id': 12, 'name': 'Adventure'}]","en","The Rescuers",'1977-06-22',71215869,78.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","Return from Witch Mountain",'1978-03-10',16393000,95.0),
("[{'id': 10751, 'name': 'Family'}, {'id': 12, 'name': 'Adventure'}, {'id': 16, 'name': 'Animation'}, {'id': 10749, 'name': 'Romance'}]","en","The Return of Jafar",'1994-12-15',0,69.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}]","en","Return to Oz",'1985-06-21',11137801,109.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 10751, 'name': 'Family'}]","en","The Rocketeer",'1991-06-21',62000000,108.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","The Shaggy D.A.",'1976-12-17',0,91.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 16, 'name': 'Animation'}, {'id': 10749, 'name': 'Romance'}, {'id': 10751, 'name': 'Family'}]","en","Sleeping Beauty",'1959-01-28',51000000,75.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Something Wicked This Way Comes",'1983-04-29',5656087,95.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}]","en","Son of Flubber",'1963-01-16',0,100.0),
("[{'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}]","en","Song of the South",'1946-11-12',0,91.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10749, 'name': 'Romance'}]","en","Splash",'1984-03-09',69821334,111.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Squanto: A Warrior's Tale",'1994-10-28',3337685,102.0),
("[{'id': 16, 'name': 'Animation'}]","en","Steamboat Willie",'1928-11-18',0,8.0),
("[{'id': 12, 'name': 'Adventure'}]","en","Tall Tale",'1995-03-24',0,98.0),
("[{'id': 18, 'name': 'Drama'}]","en","Tex",'1982-07-30',0,103.0),
("[{'id': 878, 'name': 'Science Fiction'}, {'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}]","en","Tron",'1982-07-09',33000000,96.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 18, 'name': 'Drama'}]","en","Swing Kids",'1993-03-05',5632086,112.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Halloween: H20",'1998-08-05',55041738,86.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}, {'id': 10749, 'name': 'Romance'}]","en","L.A. Story",'1991-02-08',0,95.0),
("[{'id': 35, 'name': 'Comedy'}]","en","The Jerk",'1979-12-14',73961419,94.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 9648, 'name': 'Mystery'}]","en","Dead Men Don't Wear Plaid",'1982-05-21',18196170,89.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Man with Two Brains",'1983-06-10',0,93.0),
("[{'id': 18, 'name': 'Drama'}]","en","Grand Canyon",'1991-12-25',0,134.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}]","en","Graveyard Shift",'1990-10-26',11582891,89.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","The Outsiders",'1983-03-25',33697647,91.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}]","en","Indiana Jones and the Temple of Doom",'1984-05-23',333000000,118.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 18, 'name': 'Drama'}, {'id': 16, 'name': 'Animation'}, {'id': 12, 'name': 'Adventure'}]","en","The Lord of the Rings",'1978-11-15',30471420,132.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 878, 'name': 'Science Fiction'}]","en","Nineteen Eighty-Four",'1984-10-10',0,113.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 53, 'name': 'Thriller'}]","en","The Dead Zone",'1983-10-21',20766616,103.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}]","en","Maximum Overdrive",'1986-07-25',7433663,97.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}]","en","Needful Things",'1993-08-27',0,120.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Cujo",'1983-08-10',21200000,91.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Children of the Corn",'1984-03-09',14000000,93.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}, {'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}]","en","All Dogs Go to Heaven",'1989-11-17',27100027,89.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}, {'id': 14, 'name': 'Fantasy'}]","en","The Addams Family",'1991-11-22',191502426,99.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}, {'id': 35, 'name': 'Comedy'}]","en","EverAfter",'1998-07-31',65705772,121.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}]","en","Snake Eyes",'1998-08-07',103891409,98.0),
("[{'id': 18, 'name': 'Drama'}]","en","First Love, Last Rites",'1998-08-07',40542,94.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}]","en","Safe Men",'1998-08-17',0,88.0),
("[{'id': 99, 'name': 'Documentary'}, {'id': 10769, 'name': 'Foreign'}]","en","Die Salzmänner von Tibet",'1997-04-25',0,108.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Atlantic City",'1980-09-02',12729678,104.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 18, 'name': 'Drama'}]","sv","Höstsonaten",'1978-10-08',0,90.0),
("[{'id': 18, 'name': 'Drama'}]","en","Who's Afraid of Virginia Woolf?",'1966-06-21',33736689,131.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 12, 'name': 'Adventure'}]","en","Adventures in Babysitting",'1987-07-01',34368475,102.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}, {'id': 14, 'name': 'Fantasy'}]","en","Weird Science",'1985-08-01',38934048,94.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","Doctor Dolittle",'1967-12-19',9000000,152.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}, {'id': 10749, 'name': 'Romance'}, {'id': 878, 'name': 'Science Fiction'}]","en","The Nutty Professor",'1963-06-04',0,107.0),
("[{'id': 16, 'name': 'Animation'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","Charlotte's Web",'1973-03-01',0,94.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 16, 'name': 'Animation'}, {'id': 18, 'name': 'Drama'}]","en","Watership Down",'1978-10-14',3713768,88.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 16, 'name': 'Animation'}, {'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}]","en","The Secret of NIMH",'1982-06-17',14665733,82.0),
("[{'id': 14, 'name': 'Fantasy'}]","en","The Dark Crystal",'1982-12-17',40577001,93.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 16, 'name': 'Animation'}, {'id': 12, 'name': 'Adventure'}]","en","An American Tail",'1986-11-21',84542002,80.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 16, 'name': 'Animation'}, {'id': 10751, 'name': 'Family'}]","en","An American Tail: Fievel Goes West",'1991-11-21',40766041,75.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 14, 'name': 'Fantasy'}]","en","Legend",'1985-07-19',15502112,94.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Sixteen Candles",'1984-05-04',23686027,93.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Pretty in Pink",'1986-02-28',40471663,96.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","St. Elmo's Fire",'1985-06-20',37803872,110.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}]","en","The Clan of the Cave Bear",'1986-01-17',0,98.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 27, 'name': 'Horror'}]","en","House",'1986-02-28',0,93.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 27, 'name': 'Horror'}, {'id': 35, 'name': 'Comedy'}]","en","House II: The Second Story",'1987-05-14',7800000,88.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","The Gods Must Be Crazy",'1980-09-10',60000000,109.0),
("[{'id': 28, 'name': 'Action'}, {'id': 35, 'name': 'Comedy'}]","en","The Gods Must Be Crazy II",'1989-07-01',0,98.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10751, 'name': 'Family'}]","en","Air Bud: Golden Receiver",'1998-08-14',10224116,90.0),
("[{'id': 53, 'name': 'Thriller'}]","en","The Avengers",'1998-08-13',48585416,89.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","How Stella Got Her Groove Back",'1998-08-14',37672350,124.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}]","en","Slums of Beverly Hills",'1998-08-14',0,91.0),
("[{'id': 18, 'name': 'Drama'}]","en","La femme de chambre du Titanic",'1997-10-10',0,100.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Henry II, Portrait of a Serial Killer",'1996-10-10',0,84.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 27, 'name': 'Horror'}, {'id': 53, 'name': 'Thriller'}]","en","Henry: Portrait of a Serial Killer",'1986-09-24',0,83.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","en","Rosemary's Baby",'1968-06-12',33395426,136.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}, {'id': 12, 'name': 'Adventure'}]","en","The Neverending Story",'1984-04-05',20158808,102.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10751, 'name': 'Family'}, {'id': 14, 'name': 'Fantasy'}, {'id': 12, 'name': 'Adventure'}]","en","The Neverending Story II: The Next Chapter",'1990-10-24',16283667,89.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}]","en","Attack of the Killer Tomatoes!",'1978-10-01',0,87.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 878, 'name': 'Science Fiction'}]","en","Surf Nazis Must Die",'1987-07-03',0,83.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}]","en","Your Friends & Neighbors",'1998-02-04',4710749,100.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 10749, 'name': 'Romance'}]","en","Return to Paradise",'1998-08-10',0,109.0),
("[{'id': 27, 'name': 'Horror'}, {'id': 28, 'name': 'Action'}]","en","Blade",'1998-08-21',131183530,120.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10402, 'name': 'Music'}, {'id': 10749, 'name': 'Romance'}]","en","Dance with Me",'1998-08-21',15,126.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Dead Man on Campus",'1998-08-21',0,96.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 35, 'name': 'Comedy'}]","en","Wrongfully Accused",'1998-08-21',0,87.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Next Stop Wonderland",'1998-08-21',0,96.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Strike!",'1998-08-21',0,97.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 14, 'name': 'Fantasy'}, {'id': 9648, 'name': 'Mystery'}]","en","The Navigator: A Medieval Odyssey",'1988-09-16',0,90.0),
("[{'id': 14, 'name': 'Fantasy'}, {'id': 35, 'name': 'Comedy'}]","en","Beetlejuice",'1988-02-29',73326666,92.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","Déjà Vu",'1998-04-22',0,117.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Rope",'1948-08-23',2200000,80.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","Family Plot",'1976-04-09',7900000,121.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Frenzy",'1972-05-25',12600000,116.0),
("[{'id': 28, 'name': 'Action'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Topaz",'1969-12-18',6000000,143.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Torn Curtain",'1966-07-13',13000000,128.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Marnie",'1964-07-09',7000000,130.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}]","en","The Wrong Man",'1956-12-22',2000000,105.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Man Who Knew Too Much",'1956-06-01',10250000,120.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Trouble with Harry",'1955-10-03',7000000,99.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}]","en","I Confess",'1953-02-28',0,95.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Strangers on a Train",'1951-06-18',7000000,101.0),
("[{'id': 53, 'name': 'Thriller'}]","en","Stage Fright",'1950-02-23',0,110.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 18, 'name': 'Drama'}]","en","54",'1998-08-28',16757163,106.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 35, 'name': 'Comedy'}, {'id': 16, 'name': 'Animation'}]","en","I Married a Strange Person!",'1998-08-28',203,72.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Why Do Fools Fall In Love",'1998-08-28',12413650,116.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 10749, 'name': 'Romance'}]","en","Keep the Aspidistra Flying",'1997-11-20',0,101.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","fr","Regarde la Mer",'1997-12-03',0,52.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 18, 'name': 'Drama'}, {'id': 28, 'name': 'Action'}]","en","Willow",'1988-05-01',57269863,126.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 36, 'name': 'History'}, {'id': 53, 'name': 'Thriller'}]","en","The Untouchables",'1987-06-02',76270454,119.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Dirty Work",'1998-06-12',0,82.0),
("[{'id': 28, 'name': 'Action'}, {'id': 12, 'name': 'Adventure'}, {'id': 53, 'name': 'Thriller'}]","en","Knock Off",'1998-09-04',0,91.0),
("[{'id': 10749, 'name': 'Romance'}, {'id': 18, 'name': 'Drama'}]","en","Firelight",'1997-09-14',0,103.0),
("[{'id': 99, 'name': 'Documentary'}]","en","Modulations",'1998-09-18',0,75.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}, {'id': 10749, 'name': 'Romance'}]","en","Phoenix",'1998-09-04',0,107.0),
("[{'id': 18, 'name': 'Drama'}]","en","Under Capricorn",'1949-09-08',0,108.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}, {'id': 53, 'name': 'Thriller'}]","en","The Paradine Case",'1947-12-31',0,125.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 10752, 'name': 'War'}]","en","Lifeboat",'1944-01-11',0,96.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Shadow of a Doubt",'1943-01-16',0,108.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 10752, 'name': 'War'}]","en","Saboteur",'1942-04-24',0,108.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 10749, 'name': 'Romance'}]","en","Mr. & Mrs. Smith",'1941-01-30',0,95.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Suspicion",'1941-11-14',4500000,99.0),
("[{'id': 12, 'name': 'Adventure'}, {'id': 80, 'name': 'Crime'}]","en","Jamaica Inn",'1939-05-11',0,108.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","The Lady Vanishes",'1938-07-26',0,96.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Young and Innocent",'1937-11-01',0,83.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 9648, 'name': 'Mystery'}]","en","Sabotage",'1936-12-02',0,76.0),
("[{'id': 53, 'name': 'Thriller'}]","en","Secret Agent",'1936-06-12',0,86.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Man Who Knew Too Much",'1934-11-30',0,75.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Number Seventeen",'1932-07-18',0,63.0),
("[{'id': 35, 'name': 'Comedy'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Rich and Strange",'1931-12-10',0,83.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Skin Game",'1931-02-26',0,77.0),
("[{'id': 10402, 'name': 'Music'}, {'id': 35, 'name': 'Comedy'}]","en","Elstree Calling",'1930-02-01',0,86.0),
("[{'id': 18, 'name': 'Drama'}]","en","Juno and the Paycock",'1930-06-29',0,85.0),
("[{'id': 9648, 'name': 'Mystery'}, {'id': 53, 'name': 'Thriller'}]","en","Murder!",'1930-07-31',0,104.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Manxman",'1929-01-21',0,100.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}, {'id': 80, 'name': 'Crime'}]","en","Blackmail",'1929-06-30',0,84.0),
("[{'id': 35, 'name': 'Comedy'}]","en","Champagne",'1928-08-19',0,93.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Farmer's Wife",'2012-06-20',0,18.0),
("[{'id': 18, 'name': 'Drama'}]","en","Downhill",'1927-10-24',0,110.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","Easy Virtue",'1928-03-05',0,79.0),
("[{'id': 18, 'name': 'Drama'}]","en","The Ring",'1927-10-01',0,116.0),
("[{'id': 80, 'name': 'Crime'}, {'id': 18, 'name': 'Drama'}, {'id': 53, 'name': 'Thriller'}]","en","The Lodger: A Story of the London Fog",'1927-02-14',0,99.0),
("[{'id': 18, 'name': 'Drama'}]","de","The Pleasure Garden",'1925-11-03',0,75.0),
("[{'id': 18, 'name': 'Drama'}, {'id': 80, 'name': 'Crime'}]","en","Rounders",'1998-09-11',22921898,121.0),
("[{'id': 53, 'name': 'Thriller'}, {'id': 878, 'name': 'Science Fiction'}, {'id': 9648, 'name': 'Mystery'}]","en","Cube",'1997-09-09',501818,90.0),
("[{'id': 18, 'name': 'Drama'}]","en","Digging to China",'1997-07-07',33556,98.0);

-- big movie table edits

alter table big_movie
drop column budget;

alter table big_movie
drop column production_countries;

ALTER TABLE BIG_MOVIE
ADD FOREIGN KEY (id) REFERENCES MOVIES(movie_id);

UPDATE big_movie
JOIN movies on original_title = movies.movie_name
SET id = movies.movie_id;

-- create transactions table

CREATE TABLE TRANSACTIONS (
	transaction_id INTEGER,
    transaction_location VARCHAR (50),
    product_id INTEGER,
    weeks_loaned INTEGER,
    transaction_cost DECIMAL (4,2))
;
## primary key
ALTER TABLE TRANSACTIONS
MODIFY transaction_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY;
## foreign key from cmer table
ALTER TABLE TRANSACTIONS
ADD COLUMN customer_id INT;

ALTER TABLE TRANSACTIONS
MODIFY transaction_cost DECIMAL (5,2);

ALTER TABLE TRANSACTIONS
RENAME COLUMN product_id to movie_id;

ALTER TABLE TRANSACTIONS
ADD FOREIGN KEY (movie_id) REFERENCES MOVIES(movie_id);


INSERT INTO TRANSACTIONS
	(transaction_location, movie_id, customer_id, weeks_loaned, transaction_cost)
VALUES
	('Sheffield', 7, 1, 42, 330.79),
	('Xinchengzi', 9, 17, 48, 988.83),
	('Khombole', 5, 9, 13, 603.15);

-- big test - gonna import fake data and use other data to populate

ALTER TABLE TRANSACTIONS
DROP CONSTRAINT transactions_ibfk_2;


INSERT INTO TRANSACTIONS
	(transaction_location, movie_id, weeks_loaned, customer_id)
VALUES
('Yantang', 1706, 2, 294),
('Sunja', 781, 3, 461),
('Guder Lao', 1504, 4, 185),
('Gameleira', 1078, 2, 132),
('Guogan', 2063, 4, 399),
('Uruguaiana', 1546, 3, 258),
('Red Hill', 655, 1, 263),
('Waitakere', 249, 2, 397),
('Město', 371, 1, 272),
('Hodošan', 1579, 2, 19),
('Gempolan Wetan', 2065, 2, 179),
('Võhma', 895, 1, 266),
('Chengyang', 171, 2, 181),
('Xingshou', 931, 3, 451),
('Tegalsari', 1480, 4, 485),
('Paris La Défense', 1010, 4, 160),
('Villefontaine', 1781, 1, 457),
('Kislyakovskaya', 1845, 1, 339),
('Byera Village', 1244, 3, 227),
('Savonranta', 516, 4, 463),
('Non Sila', 1530, 2, 256),
('Ad Dujayl', 1436, 3, 301),
('Sykiés', 990, 2, 429),
('Banjaranyar', 991, 3, 228),
('Sucun', 693, 3, 342),
('Krasnyye Barrikady', 364, 2, 354),
('Fenghuo', 65, 2, 165),
('Trondheim', 277, 2, 495),
('Cibaregbeg', 2058, 4, 128),
('Genova', 1100, 3, 403),
('Chepareria', 314, 4, 407),
('Dongjie', 1536, 4, 50),
('Maintang', 1843, 4, 514),
('Zrenjanin', 1133, 3, 12),
('Velké Meziříčí', 591, 4, 312),
('Nueva Fuerza', 1386, 4, 142),
('As Sawdā', 1561, 2, 394),
('San Vicente', 1684, 4, 520),
('Telêmaco Borba', 661, 4, 115),
('Lingsar', 151, 2, 133),
('Singaparna', 2042, 3, 130),
('Guozhai', 490, 4, 18),
('Haliut', 220, 4, 238),
('Stockholm', 1739, 1, 284),
('Pļaviņas', 1473, 1, 38),
('Kuhmo', 1457, 2, 272),
('Kirtipur', 533, 2, 204),
('Chkalov', 2081, 2, 189),
('Engure', 1260, 4, 26),
('Rizal', 1796, 2, 153),
('Cimuncang', 576, 2, 274),
('Huaikan', 1767, 1, 268),
('Incheon', 2080, 4, 296),
('San Agustín', 262, 2, 512),
('København', 846, 4, 233),
('Ikongo', 747, 3, 354),
('Prakhon Chai', 1068, 1, 376),
('Kotabumi', 1002, 3, 5),
('Krujë', 609, 3, 126),
('Kuta', 926, 4, 222),
('Ghāt', 755, 4, 502),
('Qingshan', 1983, 1, 210),
('Horta', 1225, 4, 9),
('Batatais', 1472, 4, 483),
('Bagombong', 841, 4, 45),
('El Hamma', 916, 2, 399),
('Sobreira', 1404, 4, 511),
('Västanfjärd', 1036, 4, 320),
('Nasavrky', 2012, 2, 213),
('Białołeka', 1143, 1, 384),
('La Dorada', 836, 4, 326),
('Shāhīn Shahr', 1316, 1, 195),
('Karangsari', 944, 2, 108),
('Makato', 741, 2, 197),
('La’ershan', 1398, 3, 501),
('Janowice', 1995, 1, 443),
('Semikarakorsk', 147, 4, 365),
('Ḩabābah', 1835, 4, 394),
('Vogan', 853, 1, 42),
('Ḩawf', 1466, 2, 374),
('Bang Kaeo', 1124, 4, 62),
('Vishnyeva', 798, 2, 455),
('Nguigmi', 610, 1, 377),
('Dateng', 227, 4, 281),
('Kotovs’k', 114, 3, 515),
('Huaping', 504, 3, 131),
('Lianghe', 1605, 3, 447),
('Tsimlyansk', 103, 2, 433),
('Kashihara-shi', 1130, 3, 94),
('San José del Guaviare', 817, 4, 211),
('Vitim', 123, 3, 139),
('Palmira', 1258, 2, 72),
('Guder Lao', 255, 2, 421),
('Chavarría', 1738, 2, 434),
('Nóvita', 230, 2, 144),
('Xiaoduchuan', 107, 1, 314),
('Wukang', 1534, 1, 245),
('Markala', 200, 1, 295),
('Uusikaupunki', 887, 3, 88),
('Stavyshche', 2009, 1, 333),
('Koltushi', 163, 3, 256),
('Banja Luka', 1080, 3, 405),
('Non Sung', 855, 4, 378),
('Bous', 248, 2, 462),
('Tsurusaki', 313, 3, 18),
('Tawangsari', 727, 4, 495),
('Alta', 351, 3, 514),
('Korydallós', 1744, 2, 37),
('Bledzew', 1112, 4, 410),
('Huayuan', 1230, 1, 256),
('Vedène', 835, 4, 207),
('Rožďalovice', 908, 4, 511),
('Gaphatshwe', 473, 2, 278),
('Elimäki', 1147, 1, 70),
('Potoci', 518, 4, 381),
('Uijeongbu-si', 370, 3, 42),
('Jadowniki', 459, 3, 511),
('Czerniewice', 1672, 4, 60),
('Hema', 1571, 4, 514),
('Bolaoit', 551, 4, 505),
('Xunqiao', 561, 3, 47),
('Capâo Bonito', 2052, 1, 200),
('Ilhéus', 1069, 2, 519),
('Machikou', 590, 3, 183),
('Vichuga', 1492, 2, 355),
('Brive-la-Gaillarde', 980, 3, 44),
('Senadan', 441, 1, 114),
('Espanola', 1356, 3, 505),
('Sparwood', 1704, 3, 59),
('Umeå', 1436, 3, 305),
('Nanyang', 174, 1, 302),
('Sakaidechō', 1807, 2, 304),
('Sobral', 1946, 3, 190),
('Ḩājī Khēl', 1705, 1, 460),
('Thị Trấn Nho Quan', 564, 3, 80),
('Tangzhuang', 781, 2, 120),
('Wengtian', 1274, 4, 123),
('Sicheng', 949, 4, 158),
('Yangambi', 338, 2, 349),
('Crnilište', 286, 2, 7),
('Cabiao', 490, 2, 377),
('Banjar Taro Kelod', 2021, 3, 170),
('Viedma', 614, 1, 35),
('Alcoy', 1688, 4, 70),
('Gaoqiao', 1011, 1, 52),
('Tiebiancheng', 745, 1, 288),
('Foshan', 747, 2, 294),
('Vila de Rei', 637, 3, 435),
('Lalig', 1736, 1, 209),
('Cabusao', 999, 2, 213),
('Montpellier', 51, 4, 151),
('Dahay', 1596, 3, 129),
('Innoshima', 1775, 2, 340),
('Rio Piracicaba', 1194, 2, 13),
('Wengaingo', 1426, 4, 173),
('Domampot', 1517, 4, 238),
('Nyandoma', 706, 4, 356),
('Ampatuan', 42, 1, 497),
('Konstantynów', 1986, 4, 66),
('Eydhafushi', 1740, 1, 248),
('Passal', 612, 3, 466),
('Kungälv', 987, 2, 31),
('Herong', 334, 3, 308),
('Toulon', 167, 1, 439),
('Anadia', 1863, 4, 448),
('Chadi', 590, 2, 209),
('Kitakyūshū', 1907, 3, 121),
('Xinji', 451, 3, 126),
('Sendung', 1866, 2, 167),
('Pittsburgh', 871, 3, 89),
('Port Nolloth', 47, 2, 128),
('Futaleufú', 792, 3, 227),
('Kusheriki', 430, 2, 360),
('Wuluhan', 571, 1, 37),
('Tanout', 1111, 3, 192),
('Tunggulsari', 1210, 4, 208),
('Quintãs', 1141, 1, 50),
('Oshnavīyeh', 1649, 4, 330),
('Npongge', 713, 1, 163),
('Vilhena', 251, 4, 223),
('Ar Ruways', 780, 2, 428),
('Candoso', 760, 3, 395),
('Tartu', 1376, 1, 172),
('Shanshi', 338, 1, 367),
('Anqing', 463, 1, 451),
('Kurmanayevka', 283, 4, 210),
('Brant', 1700, 4, 158),
('Zaliztsi', 903, 2, 200),
('Pylaía', 1552, 2, 154),
('Bordeaux', 144, 1, 243),
('Phùng', 1933, 3, 210),
('‘Arīshah', 960, 3, 263),
('Bodø', 1916, 1, 344),
('Chiara', 390, 1, 470),
('Caijiazha', 1590, 4, 210),
('Kostinbrod', 1890, 3, 492),
('Maricá', 1654, 3, 191),
('São Miguel', 1979, 3, 307),
('Ferraria', 693, 2, 457),
('Zhenping Chengguanzhen', 237, 4, 503),
('Shishan', 1105, 2, 125),
('Kamloops', 182, 4, 316),
('Ternovka', 313, 3, 231),
('Sangju', 1656, 1, 489),
('Uhlove', 1859, 1, 172),
('Býšť', 1123, 2, 175),
('Iktābah', 677, 4, 228),
('Aqqan', 2097, 2, 38),
('Ad Dimnah', 1269, 4, 226),
('Purral', 1198, 2, 333),
('Bajina Bašta', 88, 1, 230),
('Birzai', 638, 4, 379),
('Liberia', 1582, 3, 124),
('Conceição da Barra', 785, 3, 306),
('Nguékhokh', 319, 4, 63),
('Monte Francisco', 1351, 1, 185),
('Umpak', 2097, 1, 509),
('Shangfang', 182, 4, 284),
('Xintang', 777, 3, 186),
('Mesyagutovo', 875, 4, 202),
('Shicheng', 950, 2, 257),
('Al Fayyūm', 87, 2, 30),
('Pulupandan', 1001, 4, 46),
('Shīeli', 1556, 2, 153),
('Bopu', 1490, 2, 221),
('Baoxing', 752, 4, 222),
('Ciechanów', 1469, 1, 381),
('Souto do Meio', 1817, 2, 353),
('Castelões', 334, 1, 236),
('Uubulan', 1038, 2, 85),
('Shangzhuang', 1497, 1, 315),
('Ferreira', 1180, 3, 149),
('Pingli', 1512, 3, 309),
('Pinara', 1826, 1, 204),
('Salas', 670, 1, 104),
('Longxi', 1956, 4, 356),
('San Mateo', 221, 1, 45),
('Bánov', 609, 3, 169),
('Oke Mesi', 951, 2, 141),
('Zhaoyuan', 670, 1, 246),
('Grevená', 432, 2, 371),
('Bizhou', 702, 1, 41),
('Vitanje', 856, 3, 461),
('Dallas', 1822, 2, 289),
('Wierzawice', 1926, 4, 117),
('Hejia', 1411, 4, 287),
('Spytkowice', 1208, 2, 196),
('Haicheng', 664, 4, 145),
('Log pri Brezovici', 801, 3, 324),
('Marovoay', 1319, 1, 246),
('Tangfang', 988, 4, 271),
('Hamburg', 1665, 2, 58),
('Babirik', 1931, 1, 501),
('Železniki', 1011, 1, 102),
('Āwash', 223, 4, 453),
('Yulin', 1754, 3, 344),
('Ford', 1136, 2, 106),
('Ziyuan', 1575, 4, 161),
('Lingtou', 1260, 4, 279),
('Al Ya‘rubīyah', 839, 1, 422),
('Tianchi', 563, 4, 244),
('Juwana', 1398, 1, 465),
('Mỏ Cày', 2075, 3, 267),
('Huacrachuco', 1245, 4, 155),
('Mnelalete', 770, 1, 140),
('Independencia', 618, 3, 483),
('Songwon', 44, 1, 211),
('Newmarket on Fergus', 569, 2, 229),
('Langádhia', 502, 3, 318),
('Cassanayan', 307, 4, 514),
('Beidajie', 1907, 3, 240),
('Yongle', 1353, 4, 382),
('Maogang', 1141, 2, 409),
('Cabeço de Vide', 214, 1, 214),
('Kadugede', 1084, 4, 371),
('Rožmitál pod Třemšínem', 451, 1, 392),
('Martigues', 1469, 1, 459),
('Lefkoniko', 1033, 4, 450),
('Queenstown', 561, 3, 366),
('Juan Santiago', 1731, 1, 320),
('Phibun Mangsahan', 1723, 4, 286),
('Dallas', 1555, 3, 479),
('San Jose', 516, 2, 435),
('Lakinsk', 7, 3, 16),
('Olszówka', 963, 1, 408),
('Karachi', 1276, 1, 58),
('Magisterial', 1491, 1, 96),
('Sunne', 612, 3, 301),
('Xinyan', 1018, 1, 442),
('Diébougou', 1472, 3, 397),
('Huliao', 145, 4, 202),
('Port Elizabeth', 1691, 4, 28),
('Pyinmana', 822, 2, 170),
('Tucano', 313, 1, 410),
('Sukarame', 138, 1, 45),
('Aveleda', 970, 4, 161),
('Maracha', 1469, 3, 127),
('Goz Beïda', 2067, 4, 151),
('Itako', 2085, 1, 43),
('Ea T’ling', 2081, 2, 242),
('Lampitak', 274, 4, 141),
('Aldeia do Bispo', 659, 1, 123),
('Watublapi', 606, 4, 114),
('Cibunar', 1685, 1, 17),
('Wellington', 1606, 4, 287),
('Pueblo Nuevo', 73, 1, 293),
('Ferkessédougou', 728, 1, 45),
('Paclolo', 1674, 4, 189),
('Goundam', 1207, 3, 391),
('Umm Şalāl ‘Alī', 35, 4, 223),
('Sap Yai', 379, 2, 160),
('Makoba', 1036, 1, 301),
('Vyshchetarasivka', 1040, 3, 97),
('København', 1170, 4, 84),
('Chakwāl', 882, 3, 318),
('Gardawice', 1895, 4, 14),
('Dahedian', 1186, 4, 473),
('Poitiers', 1047, 4, 45),
('Sol’tsy', 906, 1, 221),
('Salto', 642, 1, 412),
('Kokstad', 1714, 2, 347),
('Smedjebacken', 1429, 1, 225),
('Nowe Skalmierzyce', 1017, 4, 91),
('Lyubertsy', 706, 2, 478),
('Aramecina', 437, 2, 204),
('Jing’an', 658, 4, 133),
('Sumberkindagan', 1804, 4, 149),
('Ambelókipoi', 56, 4, 285),
('Yinla', 437, 3, 231),
('Ulan Us', 144, 3, 186),
('Ljungsbro', 900, 2, 283),
('Jabłonica Polska', 436, 2, 146),
('Peruc', 1672, 2, 272),
('Elbasan', 1522, 4, 217),
('Timur', 1644, 1, 63),
('Vršac', 285, 4, 68),
('Mantar', 701, 4, 343),
('Pueblo Nuevo', 1855, 4, 503),
('Izobil’nyy', 1368, 4, 239),
('Las Palomas', 676, 4, 91),
('Zimovniki', 773, 1, 349),
('Yanahuanca', 303, 1, 441),
('Gvardeysk', 925, 3, 444),
('Sembung', 1703, 1, 239),
('Tarhuna', 994, 1, 510),
('Pexiligais', 820, 3, 420),
('Järfälla', 122, 1, 29),
('Sanlidian', 1317, 1, 147),
('Margorejo', 1417, 1, 79),
('Campos Gerais', 797, 1, 397),
('Bojawa', 359, 3, 385),
('Mainit', 396, 1, 387),
('Menzel Abderhaman', 1541, 2, 143),
('Kranjska Gora', 873, 3, 280),
('Peliyagoda', 412, 1, 136),
('Baoping', 4, 4, 240),
('Bratislava', 958, 1, 157),
('Bejsce', 2041, 3, 109),
('Strömstad', 1552, 2, 313),
('Kuczbork-Osada', 1326, 2, 27),
('Costa Sacate', 512, 3, 500),
('Silodakon', 301, 2, 255),
('Lensk', 451, 3, 74),
('Aveleda', 213, 4, 435),
('Bol’shoye Skuratovo', 633, 2, 347),
('Ambat', 1147, 1, 138),
('Kuzhu', 987, 1, 483),
('Corquín', 1613, 1, 442),
('Żyraków', 1691, 1, 240),
('Hasan', 624, 1, 118),
('Hufeng', 329, 3, 499),
('Wangchang', 1073, 3, 108),
('Zhabagly', 782, 1, 149),
('Emmaboda', 956, 3, 280),
('Stockholm', 254, 3, 222),
('Leskovec pri Krškem', 641, 2, 281),
('Sake', 907, 3, 321),
('Kurjan', 516, 1, 371),
('Dimovo', 2027, 3, 246),
('Pagersari', 637, 4, 435),
('Télimélé', 1004, 2, 461),
('Santa Lucía', 747, 3, 506),
('Jiaogong', 1559, 2, 69),
('Wierzchucino', 540, 4, 117),
('Consuelo', 185, 4, 337),
('Shangzhuang', 398, 2, 440),
('Rixi', 737, 3, 484),
('Sumberejo', 502, 3, 9),
('Enschede', 1694, 2, 383),
('Jiacun', 813, 1, 449),
('Rizal', 800, 3, 179),
('Dazhangzhuang', 1628, 1, 143),
('Roermond', 1784, 4, 205),
('Mitsukaidō', 289, 1, 484),
('Lille', 501, 4, 117),
('Comalapa', 1545, 2, 483),
('Changtang', 120, 3, 112),
('Quintong', 1852, 3, 73),
('Kauit', 940, 3, 161),
('Kąty Wrocławskie', 890, 1, 453),
('Ludza', 779, 1, 155),
('Cheremnoye', 1496, 3, 371),
('Hirado', 1964, 2, 455),
('Quinocay', 1495, 2, 261),
('Velika', 523, 1, 74),
('Iwatsuki', 1612, 4, 90),
('Los Cedrales', 1357, 3, 287),
('Kazinka', 1183, 1, 156),
('Pirg', 113, 2, 363),
('Avranches', 277, 4, 63),
('Macaíba', 1626, 1, 321),
('Pondokkaha Kelod', 1947, 4, 354),
('Phayakkhaphum Phisai', 1277, 2, 416),
('Lucas', 1354, 4, 97),
('Chang’an', 1351, 2, 421),
('Fuhai', 1052, 1, 406),
('Lakota', 1861, 1, 160),
('Pawak', 720, 4, 347),
('Inari', 490, 2, 407),
('Maastricht', 899, 1, 376),
('Hengli', 1032, 3, 347),
('Niquero', 970, 3, 121),
('Faḩmah', 240, 3, 189),
('Monte', 528, 1, 256),
('Sharga', 1560, 1, 351),
('Brengkok', 275, 4, 350),
('Aldeia da Mata', 753, 3, 7),
('Fontinha', 1868, 3, 507),
('Temperak', 1835, 3, 159),
('Su’ao', 970, 4, 216),
('Xinhe', 649, 3, 55),
('Pesisir', 1533, 2, 231),
('Zhoujia', 888, 1, 504),
('Volodymyrets’', 1745, 3, 354),
('Ubatuba', 196, 2, 517),
('Micheng', 1033, 4, 447),
('Kaytitinga', 1689, 2, 492),
('Mizhuang', 698, 3, 147),
('Boršice', 1764, 2, 11),
('Luleå', 768, 4, 237),
('Batán', 159, 3, 270),
('Bunutan', 1848, 2, 252),
('Hadyach', 71, 2, 14),
('Ḩuraytān', 313, 4, 378),
('Huoshaodian', 1126, 3, 196),
('Tuamese', 147, 1, 29),
('Laventille', 1046, 2, 262),
('Granada', 1521, 1, 163),
('Xianqiao', 1201, 2, 394),
('Chuarrancho', 1372, 3, 124),
('Skelivka', 296, 2, 305),
('‘Irbīn', 1119, 1, 216),
('Tengah', 1962, 4, 243),
('Ferreiras', 2009, 4, 143),
('Kysyl-Syr', 658, 3, 37),
('Kościerzyna', 397, 2, 324),
('Lidköping', 720, 1, 159),
('Zhongtang', 738, 4, 360),
('La Cañada', 1933, 1, 355),
('Ridder', 1451, 2, 332),
('Ergong', 1196, 1, 515),
('Moinhos', 7, 2, 415),
('Lady Grey', 736, 3, 62),
('Kotel’niki', 1152, 1, 472),
('Nové Sedlo', 964, 3, 411),
('Graikochóri', 1311, 1, 59),
('Anjia', 1953, 4, 340),
('Marulanda', 617, 4, 94),
('San Juan Opico', 954, 3, 251),
('Sapat', 1498, 3, 413),
('Chittagong', 1588, 3, 392),
('Afonsoeiro', 912, 2, 472),
('Gutian', 146, 1, 320),
('Tân Hiệp', 639, 2, 352),
('18 de Marzo', 389, 4, 329),
('Daxin', 1678, 1, 145),
('Hongqiao', 1666, 1, 163),
('Jawor', 631, 2, 236),
('Xinji', 713, 3, 248),
('Cunha', 1224, 3, 310),
('Oslo', 1235, 4, 519),
('Pisang', 1441, 3, 292),
('Dazu', 1911, 3, 382),
('Turnišče', 639, 3, 116),
('Senangkhanikhom', 806, 4, 496),
('Sobrosa', 11, 4, 366),
('Zhangfang', 1023, 2, 177),
('High River', 1178, 3, 503),
('Vuokatti', 1568, 3, 325),
('Baitashan', 1660, 3, 455),
('Méru', 1734, 1, 46),
('Carmo do Paranaíba', 1538, 1, 435),
('Caballococha', 2030, 4, 23),
('Cherëmushki', 41, 4, 214),
('Cisantri', 1227, 1, 43),
('Buyende', 550, 4, 501),
('Nailung', 1906, 1, 248),
('Miches', 1409, 4, 118),
('Šimanovci', 1798, 1, 243),
('Kladi', 851, 2, 195);

-- customer table
CREATE TABLE CUSTOMERS (
	person_id INTEGER,
    forename VARCHAR (50),
    surname VARCHAR (50),
    email VARCHAR (60),
    city VARCHAR (50),
    region VARCHAR (50),
    country VARCHAR (50))
;

ALTER TABLE CUSTOMERS
MODIFY person_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

INSERT INTO CUSTOMERS
	(forename, surname, email, city, region, country)
VALUES
  ("Chaney","Mcmillan","molestie.sodales@hotmail.edu","Choa Chu Kang","West Region","Singapore"),
  ("Magee","Lambert","dui.fusce@yahoo.org","Jönköping","Jönköpings län","Sweden"),
  ("Wyoming","Espinoza","dolor@aol.org","Rae-Edzo","Northwest Territories","Canada"),
  ("Gil","Figueroa","phasellus.at@aol.ca","Zwelitsha","Eastern Cape","South Africa"),
  ("Hyacinth","Livingston","amet.faucibus@outlook.edu","Stavanger","Rogaland","Norway"),
  ("Rae","Logan","nunc.sed@outlook.net","Hereford","Herefordshire","United Kingdom"),
  ("Leo","Mack","a@icloud.edu","Filignano","Molise","Italy"),
  ("Caleb","Roberts","adipiscing.lobortis@yahoo.net","Piła","Wielkopolskie","Poland"),
  ("Kennedy","Hodge","tempor.arcu@aol.org","Alajuela","Alajuela","Costa Rica"),
  ("Rhona","Slater","sodales.at.velit@hotmail.com","Vilvoorde","Vlaams-Brabant","Belgium"),
  ("Octavia","Bean","vehicula.et.rutrum@yahoo.org","Kupang","East Nusa Tenggara","Indonesia"),
  ("Ali","White","turpis.aliquam.adipiscing@hotmail.org","Melilla","Melilla","Spain"),
  ("Blythe","Booker","sed.hendrerit@aol.ca","Pervomaisk","Mykolaiv oblast","Ukraine"),
  ("Fleur","Paul","fames.ac@hotmail.com","Witney","Oxfordshire","United Kingdom"),
  ("Kenneth","Manning","tincidunt.tempus@yahoo.org","Pamplona","Navarra","Spain"),
  ("Dane","Mercer","donec.felis.orci@outlook.couk","Hong Kong","Zhōngnán","China"),
  ("Chase","Harris","tellus@icloud.edu","Las Vegas","Nevada","United States"),
  ("Beau","Ratliff","magnis@google.ca","Soledad de Graciano Sánchez","San Luis Potosí","Mexico"),
  ("Zenaida","Moody","libero@icloud.org","Flushing","Zeeland","Netherlands"),
  ("Aurora","Huff","vitae.semper.egestas@hotmail.ca","Renaico","Araucanía","Chile");

DELETE FROM customers
WHERE
	location is NULL;
    
## foreign key matching locations

ALTER TABLE CUSTOMERS
ADD COLUMN country_id INT;

ALTER TABLE CUSTOMERS
ADD FOREIGN KEY (country_id) REFERENCES LOCATIONS(country_id);

-- populate cmer country id
UPDATE CUSTOMERS
JOIN LOCATIONS
ON customers.country = LOCATIONS.country_name
SET customers.country_id = LOCATIONS.country_id;

-- remove region
ALTER TABLE CUSTOMERS
DROP COLUMN region;

-- more data

INSERT INTO CUSTOMERS
	(forename, surname, email, city, country)
VALUES
('Romeo', 'Voden', 'rvoden0@alexa.com', 'Mpumalanga', 'South Africa'),
('Crista', 'Moehle', 'cmoehle1@opera.com', 'Tobias Fornier', 'Philippines'),
('Amalee', 'Bleue', 'ableue2@vinaora.com', 'Abbotsford', 'Canada'),
('Felecia', 'Daffern', 'fdaffern3@spotify.com', 'Mỏ Cày', 'Vietnam'),
('Florry', 'Gamon', 'fgamon4@reddit.com', 'Xiashan', 'China'),
('Hamel', 'Michele', 'hmichele5@ted.com', 'Poponcol', 'Indonesia'),
('Winnah', 'Patzelt', 'wpatzelt6@boston.com', 'Venustiano Carranza', 'Mexico'),
('Shaylah', 'Schulze', 'sschulze7@spiegel.de', 'Hotaka', 'Japan'),
('Sherri', 'O''Doghesty', 'sodoghesty8@princeton.edu', 'Bhokadoke', 'Indonesia'),
('Koralle', 'Summerlad', 'ksummerlad9@ning.com', 'Mirsk', 'Poland'),
('Cristy', 'Durgan', 'cdurgana@google.com', 'Kukulu', 'Indonesia'),
('Brig', 'Markey', 'bmarkeyb@admin.ch', 'Zárkos', 'Greece'),
('Morlee', 'Linguard', 'mlinguardc@drupal.org', 'Kolsh', 'Albania'),
('Kissie', 'Carbery', 'kcarberyd@chronoengine.com', 'Wulan Haye', 'China'),
('Obidiah', 'Brimley', 'obrimleye@gov.uk', 'Tiraspol', 'Moldova'),
('Mozes', 'Jeffrey', 'mjeffreyf@craigslist.org', 'Songkan', 'China'),
('Tiena', 'Gooders', 'tgoodersg@google.com', 'Pardubice', 'Czech Republic'),
('Avie', 'Pountain', 'apountainh@drupal.org', 'Jinchuan', 'China'),
('Wallie', 'Raubenheim', 'wraubenheimi@miibeian.gov.cn', 'São Roque', 'Brazil'),
('Rebe', 'Leale', 'rlealej@rediff.com', 'Nonsan', 'South Korea'),
('Morena', 'Edkins', 'medkinsk@blinklist.com', 'Arneiro', 'Portugal'),
('Tracee', 'Ainscough', 'tainscoughl@yellowbook.com', 'Sypniewo', 'Poland'),
('Christa', 'Peppard', 'cpeppardm@barnesandnoble.com', 'Jezzîne', 'Lebanon'),
('Ginnifer', 'Gaffer', 'ggaffern@forbes.com', 'Independencia', 'Mexico'),
('Gilberte', 'Francois', 'gfrancoiso@github.com', 'Kalodu', 'Indonesia'),
('Kynthia', 'Fydo', 'kfydop@auda.org.au', 'Irbid', 'Jordan'),
('Zebulon', 'Hallex', 'zhallexq@uol.com.br', 'Krajan Atas Suger Lor', 'Indonesia'),
('Rikki', 'Bunn', 'rbunnr@go.com', 'Agudos', 'Brazil'),
('Warner', 'Burrows', 'wburrowss@telegraph.co.uk', 'Sanbaishan', 'China'),
('Nathanial', 'Langman', 'nlangmant@economist.com', 'San Juan del Cesar', 'Colombia'),
('Sarita', 'Bartoloma', 'sbartolomau@ask.com', 'Qintong', 'China'),
('Franky', 'Grabbam', 'fgrabbamv@cornell.edu', 'Ise', 'Japan'),
('Eddie', 'Ivasyushkin', 'eivasyushkinw@merriam-webster.com', 'Ros’', 'Belarus'),
('Hortensia', 'Saunier', 'hsaunierx@xinhuanet.com', 'Mstów', 'Poland'),
('Janeva', 'Sandom', 'jsandomy@icq.com', 'Jenang Selatan', 'Indonesia'),
('Maddy', 'York', 'myorkz@goodreads.com', 'Burrel', 'Albania'),
('Teodora', 'Broader', 'tbroader10@sfgate.com', 'Balakhninskiy', 'Russia'),
('Halli', 'Affron', 'haffron11@networksolutions.com', 'Hörby', 'Sweden'),
('Gavra', 'Siverns', 'gsiverns12@nature.com', 'Beltinci', 'Slovenia'),
('Gilberte', 'Ferreira', 'gferreira13@cam.ac.uk', 'Khorramdarreh', 'Iran'),
('Wini', 'Foulkes', 'wfoulkes14@usda.gov', 'Novyye Gorki', 'Russia'),
('Nester', 'Egarr', 'negarr15@smugmug.com', 'Gävle', 'Sweden'),
('Cilka', 'Fibbens', 'cfibbens16@163.com', 'Independencia', 'Mexico'),
('Levy', 'Scotchmoor', 'lscotchmoor17@163.com', 'Sendai-shi', 'Japan'),
('Jeth', 'Digger', 'jdigger18@ucla.edu', 'Dąbrowa', 'Poland'),
('Alysa', 'Brandom', 'abrandom19@who.int', 'Zevgolateió', 'Greece'),
('Bekki', 'Guilloneau', 'bguilloneau1a@cafepress.com', 'Panyingkiran', 'Indonesia'),
('Antonino', 'Towey', 'atowey1b@mapy.cz', 'Sawin', 'Poland'),
('Arabele', 'Goforth', 'agoforth1c@illinois.edu', 'Krupanj', 'Serbia'),
('Wrennie', 'Studart', 'wstudart1d@mapy.cz', 'Juru', 'Brazil'),
('Ford', 'Bestall', 'fbestall1e@moonfruit.com', 'Morales', 'Colombia'),
('Michale', 'Stoppard', 'mstoppard1f@ihg.com', 'Bayangol', 'Mongolia'),
('Norean', 'Mettrick', 'nmettrick1g@163.com', 'Pueblo Viejo', 'Panama'),
('Reeba', 'Byforth', 'rbyforth1h@mtv.com', 'Ḩurayḑah', 'Yemen'),
('Filippa', 'Matthai', 'fmatthai1i@booking.com', 'Zhongxiang', 'China'),
('Ladonna', 'Gannicott', 'lgannicott1j@about.com', 'Libertad', 'Philippines'),
('Mahmud', 'McAnalley', 'mmcanalley1k@nyu.edu', 'Xihe', 'China'),
('Susette', 'Tedman', 'stedman1l@posterous.com', 'Danilov', 'Russia'),
('Shadow', 'Gribbell', 'sgribbell1m@alexa.com', 'Vetluzhskiy', 'Russia'),
('Alexandro', 'Mc Grath', 'amcgrath1n@economist.com', 'Budenovetc', 'Russia'),
('Brig', 'Tanton', 'btanton1o@mayoclinic.com', 'Antalaha', 'Madagascar'),
('Cesar', 'Fantham', 'cfantham1p@dion.ne.jp', 'Guintubhan', 'Philippines'),
('Flori', 'Altofts', 'faltofts1q@cloudflare.com', 'Xiaomenjia', 'China'),
('Marta', 'Maccrea', 'mmaccrea1r@chronoengine.com', 'Stari Bar', 'Montenegro'),
('Guglielma', 'Zolini', 'gzolini1s@blogtalkradio.com', 'Hvar', 'Croatia'),
('Sydel', 'O''Kieran', 'sokieran1t@icio.us', 'Sumberpandan', 'Indonesia'),
('Ruthann', 'Mackney', 'rmackney1u@comcast.net', 'Pirot', 'Serbia'),
('Evyn', 'Mc Caughen', 'emccaughen1v@foxnews.com', 'Hecun', 'China'),
('Paulina', 'Feare', 'pfeare1w@amazon.co.jp', 'Compiègne', 'France'),
('Jo', 'Sharram', 'jsharram1x@nymag.com', 'Sepīdān', 'Iran'),
('Walton', 'Peascod', 'wpeascod1y@craigslist.org', 'Boca de Uchire', 'Venezuela'),
('Ollie', 'Cordoba', 'ocordoba1z@cloudflare.com', 'Šardice', 'Czech Republic'),
('Manolo', 'Nicely', 'mnicely20@dedecms.com', 'Palaífyto', 'Greece'),
('Rakel', 'Ownsworth', 'rownsworth21@hao123.com', 'Stoszowice', 'Poland'),
('Averyl', 'Stanlick', 'astanlick22@i2i.jp', 'Caldas da Felgueira', 'Portugal'),
('Yehudi', 'Garrold', 'ygarrold23@privacy.gov.au', 'Guizi', 'China'),
('Eddy', 'Ralton', 'eralton24@guardian.co.uk', 'Shypyntsi', 'Ukraine'),
('Angil', 'Eilers', 'aeilers25@huffingtonpost.com', 'Amman', 'Jordan'),
('Sadye', 'Sodo', 'ssodo26@newsvine.com', 'Ipoh', 'Malaysia'),
('Laverna', 'O''Kennedy', 'lokennedy27@dmoz.org', 'Zhamao', 'China'),
('Livvy', 'Keatch', 'lkeatch28@npr.org', 'Skara', 'Sweden'),
('Debi', 'Littlefair', 'dlittlefair29@trellian.com', 'Dargaz', 'Iran'),
('Ermina', 'Karlowicz', 'ekarlowicz2a@ucsd.edu', 'Le Mans', 'France'),
('Gwennie', 'Mitchiner', 'gmitchiner2b@sphinn.com', 'Ananindeua', 'Brazil'),
('Wanda', 'Neylon', 'wneylon2c@exblog.jp', 'Al Fayyūm', 'Egypt'),
('Cassondra', 'Habbeshaw', 'chabbeshaw2d@yellowbook.com', 'Baishi', 'China'),
('Lynde', 'Wivell', 'lwivell2e@buzzfeed.com', 'Zhijiang', 'China'),
('Patrizius', 'Probet', 'pprobet2f@sbwire.com', 'Wan Yai', 'Thailand'),
('Fons', 'Schneidau', 'fschneidau2g@dot.gov', 'Angan', 'Indonesia'),
('Sindee', 'Crowthe', 'scrowthe2h@drupal.org', 'San Vicente', 'Chile'),
('Christie', 'McIlheran', 'cmcilheran2i@utexas.edu', 'Luena', 'Angola'),
('Allie', 'Farbrother', 'afarbrother2j@shop-pro.jp', 'Kalianda', 'Indonesia'),
('Talbot', 'Elion', 'telion2k@vk.com', 'Sabanitas', 'Panama'),
('Bel', 'Pfeffel', 'bpfeffel2l@netvibes.com', 'Ostankinskiy', 'Russia'),
('Aidan', 'Sheeres', 'asheeres2m@skype.com', 'Ratnapura', 'Sri Lanka'),
('Torrin', 'Gabey', 'tgabey2n@sina.com.cn', 'Bao’an', 'China'),
('Doy', 'McQuilkin', 'dmcquilkin2o@gnu.org', 'Tielu', 'China'),
('Joseito', 'Coltart', 'jcoltart2p@harvard.edu', 'Khon San', 'Thailand'),
('Keelia', 'Van der Spohr', 'kvanderspohr2q@uiuc.edu', 'Gedongmulyo', 'Indonesia'),
('Jere', 'Meeny', 'jmeeny2r@ezinearticles.com', 'Turinsk', 'Russia'),
('Minta', 'Stannislawski', 'mstannislawski2s@sohu.com', 'Skarbimierz Osiedle', 'Poland'),
('Tim', 'Michiel', 'tmichiel2t@ucoz.ru', 'Daping', 'China'),
('Daphene', 'Rebbeck', 'drebbeck2u@theatlantic.com', 'Caminaca', 'Peru'),
('Myrlene', 'Whitmore', 'mwhitmore2v@cloudflare.com', 'Kopashnovo', 'Ukraine'),
('Kerby', 'McArthur', 'kmcarthur2w@aol.com', 'Valence', 'France'),
('Sephira', 'Instrell', 'sinstrell2x@pinterest.com', 'Perivólia', 'Cyprus'),
('Jean', 'Grier', 'jgrier2y@a8.net', 'Popovo', 'Russia'),
('Fayre', 'LAbbet', 'flabbet2z@google.fr', 'Lobuk', 'Indonesia'),
('Nelson', 'Sreenan', 'nsreenan30@harvard.edu', 'Charlotte', 'United States'),
('Gail', 'Tonner', 'gtonner31@admin.ch', 'Chixi', 'China'),
('Nil', 'Dachey', 'ndachey32@rakuten.co.jp', 'Bradashesh', 'Albania'),
('Neale', 'Goodban', 'ngoodban33@mayoclinic.com', 'Yangkang', 'China'),
('Efrem', 'Eykelbosch', 'eeykelbosch34@shareasale.com', 'Iwata', 'Japan'),
('Hatty', 'Hatchette', 'hhatchette35@ovh.net', 'Heqiao', 'China'),
('Lazar', 'Clark', 'lclark36@foxnews.com', 'Ungus-Ungus', 'Philippines'),
('Kristian', 'Knowlman', 'kknowlman37@fda.gov', 'San Jose', 'Philippines'),
('Hedvige', 'Rottenbury', 'hrottenbury38@tinypic.com', 'Huangtu', 'China'),
('Oralla', 'Simmank', 'osimmank39@tiny.cc', 'Saintes', 'France'),
('Felizio', 'Creedland', 'fcreedland3a@opensource.org', 'Kunwi', 'South Korea'),
('Danya', 'Kuhnert', 'dkuhnert3b@desdev.cn', 'Jasień', 'Poland'),
('Delphine', 'Laite', 'dlaite3c@reference.com', 'Miyata', 'Japan'),
('Mala', 'Tindle', 'mtindle3d@squidoo.com', 'Dem’yanovo', 'Russia'),
('Lindy', 'Moreing', 'lmoreing3e@amazon.com', 'Bago', 'Indonesia'),
('Dylan', 'Boater', 'dboater3f@psu.edu', 'Falënki', 'Russia'),
('Clint', 'Tunmore', 'ctunmore3g@printfriendly.com', 'Opochka', 'Russia'),
('Jeth', 'Lomen', 'jlomen3h@google.com.hk', 'Xubao', 'China'),
('Catherine', 'Dwight', 'cdwight3i@comcast.net', 'Taha Man Zu', 'China'),
('Ethyl', 'Layson', 'elayson3j@myspace.com', 'Manay', 'Philippines'),
('Wren', 'Seson', 'wseson3k@reddit.com', 'Sztum', 'Poland'),
('Karla', 'Morley', 'kmorley3l@sitemeter.com', 'Az Zabadānī', 'Syria'),
('Petrina', 'Lacotte', 'placotte3m@sina.com.cn', 'Couto', 'Portugal'),
('Willabella', 'Wellbeloved', 'wwellbeloved3n@baidu.com', 'Myasnikyan', 'Armenia'),
('Simmonds', 'Praundlin', 'spraundlin3o@columbia.edu', 'Heshengbao', 'China'),
('Meagan', 'Normandale', 'mnormandale3p@sakura.ne.jp', 'Saint-Paul', 'Reunion'),
('Moyra', 'Bartol', 'mbartol3q@hatena.ne.jp', 'Bajingmeduro', 'Indonesia'),
('Gaile', 'Clem', 'gclem3r@go.com', 'Yabrūd', 'Syria'),
('Shawna', 'Losano', 'slosano3s@businessinsider.com', 'Sennoy', 'Russia'),
('Avril', 'Rack', 'arack3t@cam.ac.uk', 'Thị Trấn Tam Sơn', 'Vietnam'),
('Elia', 'Enderwick', 'eenderwick3u@forbes.com', 'Aykhal', 'Russia'),
('Rob', 'Limrick', 'rlimrick3v@cam.ac.uk', 'Kapunduk', 'Indonesia'),
('Anastasie', 'Ingram', 'aingram3w@shinystat.com', 'Działdowo', 'Poland'),
('Abigail', 'Breeze', 'abreeze3x@washingtonpost.com', 'Pylaía', 'Greece'),
('Marga', 'Goodinson', 'mgoodinson3y@mysql.com', 'Leuwidamar', 'Indonesia'),
('Loise', 'Hallsworth', 'lhallsworth3z@hhs.gov', 'Gongnong', 'China'),
('Sella', 'Zavattari', 'szavattari40@macromedia.com', 'Limoges', 'France'),
('Darin', 'Cope', 'dcope41@patch.com', 'Maurole', 'Indonesia'),
('Renard', 'Sutterby', 'rsutterby42@desdev.cn', 'Goba', 'Ethiopia'),
('Myrah', 'Waters', 'mwaters43@deliciousdays.com', 'Täby', 'Sweden'),
('Max', 'Screas', 'mscreas44@fc2.com', 'Przodkowo', 'Poland'),
('Pren', 'Rizzetti', 'prizzetti45@infoseek.co.jp', 'Tianyu', 'China'),
('Dorelle', 'Bolam', 'dbolam46@paypal.com', 'Diré', 'Mali'),
('Normy', 'Sallows', 'nsallows47@answers.com', 'Znamenskoye', 'Russia'),
('Kippar', 'Zamora', 'kzamora48@arizona.edu', 'Presidente Venceslau', 'Brazil'),
('Bert', 'Howsin', 'bhowsin49@reverbnation.com', 'Bruxelles', 'Belgium'),
('Flo', 'Lefeaver', 'flefeaver4a@nymag.com', 'Alqueva', 'Portugal'),
('Barn', 'Eastam', 'beastam4b@pcworld.com', 'Zborovice', 'Czech Republic'),
('Tallie', 'Middas', 'tmiddas4c@amazon.co.jp', 'Salerno', 'Italy'),
('Kaiser', 'Pech', 'kpech4d@symantec.com', 'Mangseng', 'Indonesia'),
('Joby', 'D''Aeth', 'jdaeth4e@angelfire.com', 'Nahrīn', 'Afghanistan'),
('Wood', 'Ciric', 'wciric4f@meetup.com', 'Horta', 'Portugal'),
('Katheryn', 'Chung', 'kchung4g@paypal.com', 'Xike', 'China'),
('Pepillo', 'Luna', 'pluna4h@ifeng.com', 'Koroška Bela', 'Slovenia'),
('Ardis', 'Odams', 'aodams4i@mozilla.org', 'Vermoim', 'Portugal'),
('Nealson', 'Marmion', 'nmarmion4j@nhs.uk', 'Kronshtadt', 'Russia'),
('Ellswerth', 'Allworthy', 'eallworthy4k@youtu.be', 'Zehak', 'Iran'),
('Homerus', 'Pottage', 'hpottage4l@odnoklassniki.ru', 'Kobylanka', 'Poland'),
('Sayers', 'McCulley', 'smcculley4m@bloglines.com', 'Pedro Miguel', 'Portugal'),
('Drud', 'Swains', 'dswains4n@scribd.com', 'Gondar', 'Ethiopia'),
('Wait', 'Broomer', 'wbroomer4o@google.co.jp', 'Chantilly', 'France'),
('Beaufort', 'Huzzey', 'bhuzzey4p@yale.edu', 'Sumbuya', 'Sierra Leone'),
('Kimberly', 'Bignold', 'kbignold4q@smh.com.au', 'Zátor', 'Czech Republic'),
('Liva', 'Kevane', 'lkevane4r@multiply.com', 'Machetá', 'Colombia'),
('Robinet', 'Ebhardt', 'rebhardt4s@ning.com', 'Tomar', 'Portugal'),
('Norene', 'Snipe', 'nsnipe4t@gmpg.org', 'Tours', 'France'),
('Gert', 'Tarbin', 'gtarbin4u@skype.com', 'Yurkivka', 'Ukraine'),
('Tiffany', 'Hartington', 'thartington4v@microsoft.com', 'Malbork', 'Poland'),
('Codie', 'De Meyer', 'cdemeyer4w@scribd.com', 'Metsemotlhaba', 'Botswana'),
('Delcine', 'Baughan', 'dbaughan4x@live.com', 'Soho', 'Indonesia'),
('Evaleen', 'Kleszinski', 'ekleszinski4y@storify.com', 'Triandría', 'Greece'),
('Jud', 'Whitley', 'jwhitley4z@posterous.com', 'Jelcz', 'Poland'),
('Early', 'Waith', 'ewaith50@people.com.cn', 'Lima Pampa', 'Peru'),
('Viviene', 'Layburn', 'vlayburn51@storify.com', 'Huangjia', 'China'),
('Jana', 'Klazenga', 'jklazenga52@cpanel.net', 'Alderetes', 'Argentina'),
('Salvador', 'Lambdon', 'slambdon53@sfgate.com', 'Morfovoúni', 'Greece'),
('Pincus', 'Ranklin', 'pranklin54@w3.org', 'Volokolamsk', 'Russia'),
('Tonya', 'Adger', 'tadger55@histats.com', 'Nantes', 'France'),
('Rip', 'Iorizzo', 'riorizzo56@google.nl', 'Mpigi', 'Uganda'),
('Nicolea', 'Venning', 'nvenning57@redcross.org', 'Syrostan', 'Russia'),
('Torie', 'Labbati', 'tlabbati58@imdb.com', 'Vovchans’k', 'Ukraine'),
('Ayn', 'Murrells', 'amurrells59@dropbox.com', 'Rundeng', 'Indonesia'),
('Ilsa', 'Fisbey', 'ifisbey5a@va.gov', 'Poponcol', 'Indonesia'),
('Grannie', 'Jahnke', 'gjahnke5b@hostgator.com', 'Salvacion', 'Philippines'),
('Nester', 'Robillard', 'nrobillard5c@adobe.com', 'San Diego', 'Philippines'),
('Felecia', 'Hoggins', 'fhoggins5d@bbc.co.uk', 'Baoshui', 'China'),
('Bonita', 'Ruby', 'bruby5e@ca.gov', 'Kwangju', 'South Korea'),
('Cornie', 'Tyer', 'ctyer5f@intel.com', 'Vidzy', 'Belarus'),
('Glen', 'Hagart', 'ghagart5g@seattletimes.com', 'Prior Velho', 'Portugal'),
('Bevan', 'Ganders', 'bganders5h@shinystat.com', 'Barra do Bugres', 'Brazil'),
('Corine', 'Lisett', 'clisett5i@t-online.de', 'Dahedian', 'China'),
('Olly', 'Sailor', 'osailor5j@ebay.co.uk', 'Tarogong', 'Indonesia'),
('Selene', 'Hadgraft', 'shadgraft5k@redcross.org', 'Guarabira', 'Brazil'),
('Bernadene', 'Martinon', 'bmartinon5l@geocities.jp', 'Almere Stad', 'Netherlands'),
('Gerardo', 'Mellsop', 'gmellsop5m@so-net.ne.jp', 'Fangyan', 'China'),
('Jeffy', 'Sandwick', 'jsandwick5n@statcounter.com', 'Riachão do Jacuípe', 'Brazil'),
('Kori', 'Benterman', 'kbenterman5o@jiathis.com', 'Vel’sk', 'Russia'),
('Nathalia', 'Drioli', 'ndrioli5p@1688.com', 'Independencia', 'Mexico'),
('Hyacinthia', 'Gouda', 'hgouda5q@patch.com', 'Pingfeng', 'China'),
('Alyson', 'Piggott', 'apiggott5r@mayoclinic.com', 'Ryjewo', 'Poland'),
('Diego', 'Islip', 'dislip5s@about.me', 'Pshada', 'Russia'),
('Doyle', 'Maffey', 'dmaffey5t@google.pl', 'Puncaksempur', 'Indonesia'),
('Frances', 'Ruppel', 'fruppel5u@altervista.org', 'Dubrovka', 'Russia'),
('Vassili', 'Neilson', 'vneilson5v@digg.com', 'Har-Us', 'Mongolia'),
('Greta', 'Trenbay', 'gtrenbay5w@live.com', 'Uticyacu', 'Peru'),
('Caresa', 'Ladbrook', 'cladbrook5x@spotify.com', 'Lloque', 'Peru'),
('Jobey', 'Retallick', 'jretallick5y@oaic.gov.au', 'Smithers', 'Canada'),
('Erna', 'McKeney', 'emckeney5z@latimes.com', 'Skärholmen', 'Sweden'),
('Kathrine', 'Render', 'krender60@omniture.com', 'Cool űrhajó', 'Afghanistan'),
('Cobby', 'Laddle', 'claddle61@mail.ru', 'Arani', 'Bolivia'),
('Crysta', 'Challender', 'cchallender62@com.com', 'Buena Vista', 'Bolivia'),
('Lemmie', 'Philler', 'lphiller63@europa.eu', 'Videm pri Ptuju', 'Slovenia'),
('Consalve', 'Greaves', 'cgreaves64@yahoo.co.jp', 'Novotitarovskaya', 'Russia'),
('Chucho', 'Anslow', 'canslow65@yahoo.co.jp', 'Komorów', 'Poland'),
('Ogden', 'Smorthit', 'osmorthit66@hibu.com', 'Rumelange', 'Luxembourg'),
('Melania', 'Fines', 'mfines67@dailymotion.com', 'Dukuhpicung', 'Indonesia'),
('Jorry', 'Goodrick', 'jgoodrick68@webeden.co.uk', 'Tegaldowo', 'Indonesia'),
('Adelheid', 'O''Reilly', 'aoreilly69@tuttocitta.it', 'Youkounkoun', 'Guinea'),
('Heall', 'Morgen', 'hmorgen6a@latimes.com', 'Teplice', 'Czech Republic'),
('Arluene', 'Payton', 'apayton6b@utexas.edu', 'Krzyżowice', 'Poland'),
('Britney', 'Ridger', 'bridger6c@goodreads.com', 'Visoko', 'Bosnia and Herzegovina'),
('Sascha', 'Lancastle', 'slancastle6d@addthis.com', 'Salinungan Proper', 'Philippines'),
('Laurice', 'Gorry', 'lgorry6e@studiopress.com', 'Abaeté', 'Brazil'),
('Poul', 'Beamish', 'pbeamish6f@admin.ch', 'Xincheng', 'China'),
('Audre', 'Forsdicke', 'aforsdicke6g@wikispaces.com', 'Barras', 'Brazil'),
('Hamilton', 'Easson', 'heasson6h@hubpages.com', 'Zhuangta', 'China'),
('Monti', 'Korting', 'mkorting6i@google.it', 'Viso', 'Portugal'),
('Celie', 'Stoyles', 'cstoyles6j@answers.com', 'Allacapan', 'Philippines'),
('Vachel', 'Iverson', 'viverson6k@baidu.com', 'Kokologo', 'Burkina Faso'),
('Riki', 'Biset', 'rbiset6l@rediff.com', 'Gandra', 'Portugal'),
('Devi', 'Haggleton', 'dhaggleton6m@sun.com', 'Khujirt', 'Mongolia'),
('Cole', 'Fruchter', 'cfruchter6n@google.pl', 'Kamogatachō-kamogata', 'Japan'),
('Cyb', 'Rubinsky', 'crubinsky6o@theatlantic.com', 'Skomlin', 'Poland'),
('Isac', 'Presman', 'ipresman6p@purevolume.com', 'Elbasan', 'Albania'),
('Stepha', 'Sapena', 'ssapena6q@google.fr', 'Boshkengash', 'Tajikistan'),
('Ignazio', 'Barajas', 'ibarajas6r@netscape.com', 'Rancaseneng', 'Indonesia'),
('Leticia', 'Burdass', 'lburdass6s@soup.io', 'Elektrėnai', 'Lithuania'),
('Cherilyn', 'Garralts', 'cgarralts6t@si.edu', 'Bitobe', 'Indonesia'),
('Gena', 'Hinstock', 'ghinstock6u@example.com', 'Changchuan', 'China'),
('Abbie', 'Imm', 'aimm6v@furl.net', 'Kedunglo', 'Indonesia'),
('Miller', 'Guswell', 'mguswell6w@discovery.com', 'Fengjiang', 'China'),
('Gawen', 'Sansbury', 'gsansbury6x@jalbum.net', 'Maceda', 'Portugal'),
('Gaylene', 'Mulkerrins', 'gmulkerrins6y@hud.gov', 'Kamenka', 'Russia'),
('Gaynor', 'Anker', 'ganker6z@google.es', 'Tulu Bolo', 'Ethiopia'),
('Alissa', 'MacAulay', 'amacaulay70@marketwatch.com', 'Ol’gino', 'Russia'),
('West', 'Doyley', 'wdoyley71@slate.com', 'Pedregulho', 'Brazil'),
('Quinn', 'Zorzetti', 'qzorzetti72@msn.com', 'Lin’an', 'China'),
('Thelma', 'Linder', 'tlinder73@biglobe.ne.jp', 'Pameungpeuk', 'Indonesia'),
('Boot', 'Vitet', 'bvitet74@mapy.cz', 'Rafael Hernandez Ochoa', 'Mexico'),
('Paulita', 'Fallow', 'pfallow75@feedburner.com', 'Issia', 'Ivory Coast'),
('Enid', 'Casone', 'ecasone76@ucoz.com', 'Hujiaba', 'China'),
('Lita', 'Timmermann', 'ltimmermann77@chron.com', 'Washington', 'United States'),
('Foster', 'MacRannell', 'fmacrannell78@forbes.com', 'Shuanggang', 'China'),
('Hamlin', 'Applegarth', 'happlegarth79@wikipedia.org', 'Qingtang', 'China'),
('Ara', 'Klimentyonok', 'aklimentyonok7a@jimdo.com', 'Caibarién', 'Cuba'),
('Fabiano', 'Bewlie', 'fbewlie7b@tripadvisor.com', 'Colca', 'Peru'),
('Morgen', 'Haycroft', 'mhaycroft7c@indiatimes.com', 'Jiangxiangzhen', 'China'),
('Ardith', 'Elcomb', 'aelcomb7d@yolasite.com', 'Copa', 'Peru'),
('Karrie', 'Maytom', 'kmaytom7e@linkedin.com', 'Rossosh’', 'Russia'),
('Beverie', 'Di Boldi', 'bdiboldi7f@mayoclinic.com', 'Deranitan', 'Indonesia'),
('Briana', 'Colston', 'bcolston7g@google.com.au', 'Chajarí', 'Argentina'),
('Billy', 'Pitceathly', 'bpitceathly7h@google.fr', 'Seremban', 'Malaysia'),
('Krystle', 'Balint', 'kbalint7i@wikia.com', 'Ketanggi', 'Indonesia'),
('Sandra', 'Perl', 'sperl7j@spiegel.de', 'San Casimiro', 'Venezuela'),
('Gregoor', 'Melby', 'gmelby7k@sun.com', 'Niigata-shi', 'Japan'),
('Grove', 'Deaton', 'gdeaton7l@ted.com', 'Pärnu', 'Estonia'),
('Jonathan', 'Scoggins', 'jscoggins7m@ebay.co.uk', 'Kaum Kaler', 'Indonesia'),
('Dagmar', 'Higgan', 'dhiggan7n@wikia.com', 'Skeldon', 'Guyana'),
('Rosette', 'Ilsley', 'rilsley7o@harvard.edu', 'Wonosobo', 'Indonesia'),
('Bronson', 'Randle', 'brandle7p@php.net', 'Suvorov', 'Russia'),
('Davis', 'Deeley', 'ddeeley7q@slate.com', 'Davyd-Haradok', 'Belarus'),
('Kerianne', 'Bercher', 'kbercher7r@so-net.ne.jp', 'Lityn', 'Ukraine'),
('Sansone', 'Hightown', 'shightown7s@boston.com', 'Nové Sedlo', 'Czech Republic'),
('Arlie', 'Tabart', 'atabart7t@unicef.org', 'Goulmima', 'Morocco'),
('Julia', 'Loude', 'jloude7u@odnoklassniki.ru', 'Bologoye', 'Russia'),
('Eben', 'Goakes', 'egoakes7v@cmu.edu', 'Hongyi', 'China'),
('Khalil', 'Harsant', 'kharsant7w@a8.net', 'Yaroslavskiy', 'Russia'),
('Jim', 'Pointin', 'jpointin7x@msn.com', 'Karangmulyo', 'Indonesia'),
('Marris', 'Camin', 'mcamin7y@senate.gov', 'Nantes', 'France'),
('Leopold', 'Sedgemond', 'lsedgemond7z@columbia.edu', 'San Borja', 'Bolivia'),
('Boycey', 'Ablett', 'bablett80@yelp.com', 'Quxi', 'China'),
('Querida', 'Jerzykiewicz', 'qjerzykiewicz81@vk.com', 'Nong Ki', 'Thailand'),
('Florette', 'Fessions', 'ffessions82@harvard.edu', 'Bodzechów', 'Poland'),
('Shanan', 'Rubes', 'srubes83@deliciousdays.com', 'Sokolac', 'Bosnia and Herzegovina'),
('Jacquelynn', 'Gravestone', 'jgravestone84@hatena.ne.jp', 'Paraty', 'Brazil'),
('Allsun', 'Olsson', 'aolsson85@tinyurl.com', 'Mangarine', 'Philippines'),
('Pansie', 'Sharnock', 'psharnock86@quantcast.com', 'Kowang Utara', 'Indonesia'),
('Constantia', 'Vallack', 'cvallack87@hao123.com', 'Persen', 'Indonesia'),
('Emlyn', 'Meere', 'emeere88@nps.gov', 'Pskov', 'Russia'),
('Shaylah', 'Brogi', 'sbrogi89@yellowpages.com', 'Laško', 'Slovenia'),
('Tarrance', 'L''Episcopi', 'tlepiscopi8a@ucoz.ru', 'Cikulina', 'Indonesia'),
('Lorry', 'Doerffer', 'ldoerffer8b@fda.gov', 'Krajan Sumurtawang', 'Indonesia'),
('Zarah', 'Waghorn', 'zwaghorn8c@wikimedia.org', 'Pocrí', 'Panama'),
('Leah', 'De Anesy', 'ldeanesy8d@infoseek.co.jp', 'Sambilawang', 'Indonesia'),
('Baxter', 'Castanone', 'bcastanone8e@nifty.com', 'Sighnaghi', 'Georgia'),
('Jeni', 'Wrassell', 'jwrassell8f@apache.org', 'Pantanal', 'Brazil'),
('Wittie', 'Pendre', 'wpendre8g@umn.edu', 'Lanxi', 'China'),
('Jeno', 'Gadeaux', 'jgadeaux8h@omniture.com', 'Pasirangin Tiga', 'Indonesia'),
('Delano', 'Furlonge', 'dfurlonge8i@fotki.com', 'Moss', 'Norway'),
('Sybil', 'Kineton', 'skineton8j@soundcloud.com', 'Wenbi', 'China'),
('Catherina', 'Dressell', 'cdressell8k@edublogs.org', 'Mujur Satu', 'Indonesia'),
('Anissa', 'Ledur', 'aledur8l@cpanel.net', 'The Valley', 'Anguilla'),
('Sheeree', 'Miere', 'smiere8m@accuweather.com', 'María la Baja', 'Colombia'),
('Fannie', 'Pogson', 'fpogson8n@google.fr', 'Bagok', 'Indonesia'),
('Evy', 'Bardwall', 'ebardwall8o@last.fm', 'Timeng', 'China'),
('Dorie', 'Pendleton', 'dpendleton8p@vkontakte.ru', 'Shiqiao', 'China'),
('Trude', 'Millgate', 'tmillgate8q@1und1.de', 'Sigaozhuang', 'China'),
('Kelbee', 'Rabley', 'krabley8r@google.de', 'Tampa', 'United States'),
('Robby', 'Dunmore', 'rdunmore8s@harvard.edu', 'Murtajih', 'Indonesia'),
('Micky', 'Ghidini', 'mghidini8t@homestead.com', 'Nunleu', 'Indonesia'),
('Victoir', 'Dummer', 'vdummer8u@etsy.com', 'Jām Sāhib', 'Pakistan'),
('Cody', 'McArdell', 'cmcardell8v@fotki.com', 'Al Lagowa', 'Sudan'),
('Aaron', 'Riddall', 'ariddall8w@themeforest.net', 'Oranmore', 'Ireland'),
('Tam', 'Benneyworth', 'tbenneyworth8x@upenn.edu', 'Persen', 'Indonesia'),
('Dominga', 'Torricina', 'dtorricina8y@google.es', 'Tornio', 'Finland'),
('Franklyn', 'Peele', 'fpeele8z@ca.gov', 'Dasuhe', 'China'),
('Susanetta', 'Annets', 'sannets90@apache.org', 'Milevsko', 'Czech Republic'),
('Alf', 'Farthin', 'afarthin91@engadget.com', 'Dalupirip', 'Philippines'),
('Kathrine', 'Schmuhl', 'kschmuhl92@timesonline.co.uk', 'Tocota', 'Peru'),
('Thia', 'Rutter', 'trutter93@paypal.com', 'As Salţ', 'Jordan'),
('Fawnia', 'Gontier', 'fgontier94@unicef.org', 'Caringin', 'Indonesia'),
('Howard', 'Peye', 'hpeye95@goodreads.com', 'Yaring', 'Thailand'),
('Miles', 'Bozward', 'mbozward96@seattletimes.com', 'Sawin', 'Poland'),
('Clarie', 'Gocher', 'cgocher97@usa.gov', 'Palmeira', 'Brazil'),
('Donella', 'Blasing', 'dblasing98@google.co.uk', 'Sangat', 'Philippines'),
('Haley', 'Cardoo', 'hcardoo99@last.fm', 'Nagrak', 'Indonesia'),
('Dottie', 'Thewles', 'dthewles9a@sphinn.com', 'Longwantun', 'China'),
('Rice', 'Heatly', 'rheatly9b@a8.net', 'Rennes', 'France'),
('Cleo', 'Prescott', 'cprescott9c@last.fm', 'Guanghou', 'China'),
('Monique', 'Freckingham', 'mfreckingham9d@auda.org.au', 'Luchenza', 'Malawi'),
('Colette', 'Burhill', 'cburhill9e@i2i.jp', 'Changxuanling', 'China'),
('Rey', 'Snibson', 'rsnibson9f@myspace.com', 'Granada', 'Philippines'),
('Miriam', 'Leipoldt', 'mleipoldt9g@geocities.com', 'Pulau Pinang', 'Malaysia'),
('Shaine', 'Chown', 'schown9h@studiopress.com', 'Timbulsari', 'Indonesia'),
('Bil', 'Lindley', 'blindley9i@webmd.com', 'Kampungbaru', 'Indonesia'),
('Tanney', 'Flewin', 'tflewin9j@webeden.co.uk', 'La Concepción', 'Nicaragua'),
('Alleen', 'Apedaile', 'aapedaile9k@hp.com', 'Puerto Asís', 'Colombia'),
('Rodrigo', 'Stendall', 'rstendall9l@cargocollective.com', 'Kotabunan', 'Indonesia'),
('Heinrick', 'Dalgleish', 'hdalgleish9m@smh.com.au', 'Kitahiroshima', 'Japan'),
('Thibaut', 'Schultz', 'tschultz9n@1und1.de', 'Huanshan', 'China'),
('Corie', 'McGriffin', 'cmcgriffin9o@shareasale.com', 'Melíki', 'Greece'),
('Eugine', 'Caddie', 'ecaddie9p@technorati.com', 'Barreiras', 'Portugal'),
('Mela', 'Blowers', 'mblowers9q@state.tx.us', 'Hūn', 'Libya'),
('Rubetta', 'Iveans', 'riveans9r@addtoany.com', 'Jevišovice', 'Czech Republic'),
('Karena', 'Dryden', 'kdryden9s@naver.com', 'Zhongshan Donglu', 'China'),
('Thorvald', 'Titterton', 'ttitterton9t@artisteer.com', 'Widorokandang', 'Indonesia'),
('Celestine', 'Couch', 'ccouch9u@washingtonpost.com', 'Pasrūr', 'Pakistan'),
('Marietta', 'Pandya', 'mpandya9v@ifeng.com', 'Kaliuda', 'Indonesia'),
('Andi', 'Jeannequin', 'ajeannequin9w@nifty.com', 'Kista', 'Sweden'),
('Katti', 'Piwall', 'kpiwall9x@auda.org.au', 'Bilaran', 'Philippines'),
('Basil', 'Harflete', 'bharflete9y@naver.com', 'Lañgub', 'Philippines'),
('Maxie', 'Jasik', 'mjasik9z@opensource.org', 'Glinojeck', 'Poland'),
('Annalee', 'Tilbury', 'atilburya0@npr.org', 'Nart', 'Mongolia'),
('Francklyn', 'Izzett', 'fizzetta1@typepad.com', 'Fonte da Aldeia', 'Portugal'),
('Bernetta', 'Thorald', 'bthoralda2@amazon.co.jp', 'Íquira', 'Colombia'),
('Candy', 'Child', 'cchilda3@pcworld.com', 'Frampol', 'Poland'),
('Jens', 'Lebourn', 'jlebourna4@t-online.de', 'Ribeiro', 'Portugal'),
('Jerrie', 'Deamer', 'jdeamera5@alibaba.com', 'Lafayette', 'United States'),
('Torre', 'Shrimpling', 'tshrimplinga6@nhs.uk', 'San Vicente', 'Philippines'),
('Benedict', 'Tomenson', 'btomensona7@creativecommons.org', 'Genyem', 'Indonesia'),
('Tiffanie', 'Ennew', 'tennewa8@parallels.com', 'Tsukumiura', 'Japan'),
('Johannes', 'Filov', 'jfilova9@newyorker.com', 'Oemollo', 'Indonesia'),
('Kathy', 'Kopisch', 'kkopischaa@wired.com', 'Rowokangkung', 'Indonesia'),
('Lemmie', 'Quinney', 'lquinneyab@alibaba.com', 'Bejsce', 'Poland'),
('Bord', 'Hessel', 'bhesselac@loc.gov', 'Rameshki', 'Russia'),
('Godfrey', 'Phipson', 'gphipsonad@ovh.net', 'Bacag', 'Philippines'),
('Francklin', 'Mosen', 'fmosenae@spiegel.de', 'Moulay Bouchta', 'Morocco'),
('Euell', 'Grgic', 'egrgicaf@google.com.hk', 'Jiahe', 'China'),
('Andrei', 'Brideoke', 'abrideokeag@boston.com', 'Sopo', 'Indonesia'),
('Madella', 'Witchard', 'mwitchardah@scientificamerican.com', 'Lapuan', 'Philippines'),
('Belia', 'Setchfield', 'bsetchfieldai@wp.com', 'Jablunkov', 'Czech Republic'),
('Leola', 'Sparrowhawk', 'lsparrowhawkaj@netlog.com', 'Xingquan', 'China'),
('Steward', 'Maughan', 'smaughanak@discovery.com', 'Serowe', 'Botswana'),
('Conroy', 'Koppeck', 'ckoppeckal@wordpress.org', 'Calasgasan', 'Philippines'),
('Harrie', 'Gladdolph', 'hgladdolpham@pagesperso-orange.fr', 'Catalão', 'Brazil'),
('Martie', 'Gartery', 'mgarteryan@etsy.com', 'Hailin', 'China'),
('Gratiana', 'Mackinder', 'gmackinderao@java.com', 'Pung-Pang', 'Philippines'),
('Ramsay', 'Gabbett', 'rgabbettap@ask.com', 'Jiling', 'China'),
('Sharron', 'Rosenbush', 'srosenbushaq@sun.com', 'Abomey-Calavi', 'Benin'),
('Valaria', 'Kiledal', 'vkiledalar@eventbrite.com', 'Staryy Oskol', 'Russia'),
('Marnie', 'Fullun', 'mfullunas@tripadvisor.com', 'Alto Río Senguer', 'Argentina'),
('Isador', 'Hards', 'ihardsat@hostgator.com', 'Thaton', 'Myanmar'),
('Fidel', 'Ismead', 'fismeadau@google.pl', 'Zhulan', 'China'),
('Roanna', 'Fewlass', 'rfewlassav@a8.net', 'Al Kiswah', 'Syria'),
('Sherman', 'Eppson', 'seppsonaw@boston.com', 'Dalun', 'China'),
('Mavra', 'Voase', 'mvoaseax@twitpic.com', 'Xinan', 'China'),
('Rodge', 'Armiger', 'rarmigeray@noaa.gov', 'São Martinho de Árvore', 'Portugal'),
('Alfie', 'Duckering', 'aduckeringaz@ow.ly', 'Vinica', 'Macedonia'),
('Brianna', 'Hyndes', 'bhyndesb0@salon.com', 'Guxian', 'China'),
('Adrianna', 'Vlasyev', 'avlasyevb1@over-blog.com', 'Kýthnos', 'Greece'),
('Jaquelyn', 'Southard', 'jsouthardb2@goodreads.com', 'Xinglong', 'China'),
('Halimeda', 'Crathern', 'hcrathernb3@netscape.com', 'Beilun', 'China'),
('Sylvester', 'Chansonne', 'schansonneb4@facebook.com', 'Lapachito', 'Argentina'),
('Sidoney', 'Elvey', 'selveyb5@sina.com.cn', 'Qiaotou', 'China'),
('Victor', 'MacKartan', 'vmackartanb6@tinypic.com', 'Peicheng', 'China'),
('Heida', 'Vannet', 'hvannetb7@latimes.com', 'Onzaga', 'Colombia'),
('Bertram', 'Huffa', 'bhuffab8@rakuten.co.jp', 'Paseyan', 'Indonesia'),
('Max', 'Grunnell', 'mgrunnellb9@ustream.tv', 'Emiliano Zapata', 'Mexico'),
('My', 'Fullager', 'mfullagerba@answers.com', 'Suzëmka', 'Russia'),
('Vere', 'Blumer', 'vblumerbb@economist.com', 'Kaduketug', 'Indonesia'),
('Loy', 'Bailes', 'lbailesbc@dailymail.co.uk', 'Estância Velha', 'Brazil'),
('Pierette', 'Palser', 'ppalserbd@nyu.edu', 'Grimstad', 'Norway'),
('Dwayne', 'Harrod', 'dharrodbe@zdnet.com', 'Albufeira', 'Portugal'),
('Stanford', 'Slany', 'sslanybf@hud.gov', 'Golacir', 'Indonesia'),
('Fancie', 'Shawyer', 'fshawyerbg@house.gov', 'Mashava', 'Zimbabwe'),
('Elset', 'Kelcher', 'ekelcherbh@mtv.com', 'Wilmington', 'United States'),
('Georgianne', 'McCoish', 'gmccoishbi@vimeo.com', 'Phoenix', 'United States'),
('Waiter', 'Dewhurst', 'wdewhurstbj@netvibes.com', 'Gränna', 'Sweden'),
('Ulises', 'Luckcuck', 'uluckcuckbk@cbsnews.com', 'Zhengcun', 'China'),
('Alonso', 'Nockalls', 'anockallsbl@webnode.com', 'Glamang', 'Philippines'),
('Ginger', 'Gwynn', 'ggwynnbm@phpbb.com', 'Bejsce', 'Poland'),
('Josephina', 'Sutcliff', 'jsutcliffbn@is.gd', 'Jefferson City', 'United States'),
('Wilfred', 'Dowse', 'wdowsebo@blog.com', 'Bongao', 'Philippines'),
('Early', 'Abry', 'eabrybp@ebay.com', 'Hongmiao', 'China'),
('Clarita', 'Bourgour', 'cbourgourbq@wiley.com', 'Macedo de Cavaleiros', 'Portugal'),
('Jeremy', 'Vasyunkin', 'jvasyunkinbr@pagesperso-orange.fr', 'Sim', 'Russia'),
('Cyndy', 'Wymer', 'cwymerbs@about.com', 'Libouchec', 'Czech Republic'),
('Klarika', 'Elmes', 'kelmesbt@dmoz.org', 'Thị Trấn Mường Khến', 'Vietnam'),
('Abbey', 'Iorizzo', 'aiorizzobu@gnu.org', 'Dallas', 'United States'),
('Brooke', 'Petyanin', 'bpetyaninbv@phoca.cz', 'Shuangnian', 'China'),
('Lilias', 'Pembery', 'lpemberybw@umich.edu', 'Liudu', 'China'),
('Fielding', 'Abramamovh', 'fabramamovhbx@theatlantic.com', 'Falun', 'Sweden'),
('Celesta', 'Haslehurst', 'chaslehurstby@usa.gov', 'Olyka', 'Ukraine'),
('Fergus', 'Ingrey', 'fingreybz@goo.gl', 'Watublapi', 'Indonesia'),
('Modesta', 'Chagg', 'mchaggc0@icq.com', 'Zagórze', 'Poland'),
('Kaela', 'Dudenie', 'kdudeniec1@cnn.com', 'Columbus', 'United States'),
('Annmaria', 'Rooke', 'arookec2@vkontakte.ru', 'Dalu', 'China'),
('Sayers', 'Hendrickson', 'shendricksonc3@biglobe.ne.jp', 'Quảng Ngãi', 'Vietnam'),
('Gustave', 'Clewes', 'gclewesc4@mtv.com', 'Mangai', 'Democratic Republic of the Congo'),
('Aimee', 'Kalinsky', 'akalinskyc5@mapquest.com', 'Kruengraya', 'Indonesia'),
('Tess', 'Cable', 'tcablec6@zimbio.com', 'Katrineholm', 'Sweden'),
('Kimbra', 'Gaskal', 'kgaskalc7@apple.com', 'Nanqi', 'China'),
('Reggis', 'Keemar', 'rkeemarc8@t.co', 'Fort Lauderdale', 'United States'),
('Leia', 'MacIntosh', 'lmacintoshc9@foxnews.com', 'Wuxia', 'China'),
('Paxon', 'McGiveen', 'pmcgiveenca@sciencedaily.com', 'Oslo', 'Norway'),
('Clarice', 'Crole', 'ccrolecb@seattletimes.com', 'Bocowanti', 'Indonesia'),
('Chaim', 'Otson', 'cotsoncc@ucoz.com', 'Duobao', 'China'),
('Kailey', 'Aronov', 'karonovcd@csmonitor.com', 'Kamenjane', 'Macedonia'),
('Thurston', 'Beldam', 'tbeldamce@arizona.edu', 'Lokolande', 'Indonesia'),
('Davidson', 'Lyddiard', 'dlyddiardcf@parallels.com', 'Leuweheq', 'Indonesia'),
('Jereme', 'Belding', 'jbeldingcg@taobao.com', 'Casal da Anja', 'Portugal'),
('Roby', 'Spink', 'rspinkch@sbwire.com', 'Yandev', 'Nigeria'),
('Ardelis', 'Gercken', 'agerckenci@icq.com', 'Shazhuang', 'China'),
('Belvia', 'Itzig', 'bitzigcj@hp.com', 'Francisco Villa', 'Mexico'),
('Nerte', 'Bonson', 'nbonsonck@latimes.com', 'Fort Wayne', 'United States'),
('Christa', 'St Leger', 'cstlegercl@ucsd.edu', 'Marseille', 'France'),
('Hakeem', 'Gooda', 'hgoodacm@webs.com', 'Leigongmiao', 'China'),
('Dennison', 'Trenholm', 'dtrenholmcn@over-blog.com', 'Flin Flon', 'Canada'),
('Penny', 'Kinge', 'pkingeco@mashable.com', 'São Domingos de Rana', 'Portugal'),
('Carmita', 'Desport', 'cdesportcp@wordpress.com', 'Zhaojia', 'China'),
('Cello', 'Bichener', 'cbichenercq@typepad.com', 'Sotíra', 'Cyprus'),
('Clemens', 'Burden', 'cburdencr@miibeian.gov.cn', 'Przystajń', 'Poland'),
('Sherwood', 'Aleksandrev', 'saleksandrevcs@ox.ac.uk', 'Penamacor', 'Portugal'),
('Talya', 'Boxhall', 'tboxhallct@jugem.jp', 'Bjästa', 'Sweden'),
('Eliot', 'Sylvester', 'esylvestercu@aol.com', 'Baofeng', 'China'),
('Emera', 'Mouncher', 'emounchercv@123-reg.co.uk', 'Sedlice', 'Czech Republic'),
('Elspeth', 'Frie', 'efriecw@chicagotribune.com', 'Rio Brilhante', 'Brazil'),
('Fairfax', 'Bramsen', 'fbramsencx@bravesites.com', 'Shiqiao', 'China'),
('Renee', 'Rolfe', 'rrolfecy@state.gov', 'Kaburon', 'Indonesia'),
('Zsazsa', 'Steynor', 'zsteynorcz@spotify.com', 'Andarapa', 'Peru'),
('Lynne', 'Balazs', 'lbalazsd0@mapy.cz', 'Hongtang', 'China'),
('Crichton', 'Sealey', 'csealeyd1@123-reg.co.uk', 'Lahuaytambo', 'Peru'),
('Rosella', 'Bewshea', 'rbewshead2@dyndns.org', 'Cihambali', 'Indonesia'),
('Rey', 'Hubback', 'rhubbackd3@seesaa.net', 'Kamyshin', 'Russia'),
('Tiertza', 'Bittleson', 'tbittlesond4@domainmarket.com', 'Clogherhead', 'Ireland'),
('Marlee', 'McCrow', 'mmccrowd5@goodreads.com', 'Yangxu', 'China'),
('Celine', 'Weatherhill', 'cweatherhilld6@cpanel.net', 'Honghualiangzi', 'China'),
('Clemmy', 'Renowden', 'crenowdend7@epa.gov', 'Katy', 'United States'),
('Piotr', 'Rebeiro', 'prebeirod8@vk.com', 'Shchelkovo', 'Russia'),
('Mufi', 'Tarquinio', 'mtarquiniod9@php.net', 'Chayek', 'Kyrgyzstan'),
('Tedie', 'Bilsford', 'tbilsfordda@ca.gov', 'Qingshu', 'China'),
('Tore', 'Grise', 'tgrisedb@foxnews.com', 'Las Ánimas', 'Honduras'),
('Calv', 'Dorot', 'cdorotdc@weibo.com', 'Faraulep', 'Micronesia'),
('Nicolle', 'Chaldecott', 'nchaldecottdd@eepurl.com', 'Jezzîne', 'Lebanon'),
('Ralf', 'Tibbles', 'rtibblesde@princeton.edu', 'Bherāmāra', 'Bangladesh'),
('Susana', 'Pickthorne', 'spickthornedf@bluehost.com', 'Marne-la-Vallée', 'France'),
('Susette', 'Limeburn', 'slimeburndg@ed.gov', 'Kendung Timur', 'Indonesia'),
('Carce', 'Sarll', 'csarlldh@smugmug.com', 'Sake', 'Democratic Republic of the Congo'),
('Whitman', 'Bassil', 'wbassildi@networksolutions.com', 'Lahān', 'Nepal'),
('Gaspard', 'Sanpere', 'gsanperedj@pcworld.com', 'Halimpu', 'Indonesia'),
('Madonna', 'Cashman', 'mcashmandk@constantcontact.com', 'Acacías', 'Colombia'),
('Heddie', 'Embleton', 'hembletondl@1und1.de', 'Migues', 'Uruguay'),
('Delcina', 'Dover', 'ddoverdm@meetup.com', 'Rozhniv', 'Ukraine'),
('Laure', 'Enderlein', 'lenderleindn@tamu.edu', 'Angono', 'Philippines'),
('Lindy', 'Makeswell', 'lmakeswelldo@unicef.org', 'Haruai', 'Indonesia'),
('Rudolf', 'Vere', 'rveredp@wunderground.com', 'Yujia’ao', 'China'),
('Helli', 'Iaduccelli', 'hiaduccellidq@gmpg.org', 'Charenton-le-Pont', 'France'),
('Maddie', 'Martland', 'mmartlanddr@google.fr', 'La Motte-Servolex', 'France'),
('Minerva', 'Delacroux', 'mdelacrouxds@weibo.com', 'Bireun', 'Indonesia'),
('Shandeigh', 'Hearst', 'shearstdt@ifeng.com', 'Vila Franca de Xira', 'Portugal'),
('Malvin', 'Aslie', 'masliedu@uiuc.edu', 'Gaimán', 'Argentina'),
('Budd', 'Klimpt', 'bklimptdv@yellowpages.com', 'Thị Trấn Phong Thổ', 'Vietnam');

-- genres table

CREATE TABLE CATEGORIES (
	category_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    category_name VARCHAR (50),
    availableEU BOOL,
    availableMEA BOOL,
    availableNSA BOOL
);

DROP TABLE categories;

## RENAME - pivoting to lending movies

RENAME TABLE CATEGORIES TO GENRES;

TRUNCATE TABLE GENRES;

ALTER TABLE PRODUCTS
DROP CONSTRAINT products_ibfk_1;

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
FROM GENRES;

TRUNCATE TABLE GENRES;

ALTER TABLE MOVIES
DROP CONSTRAINT movies_ibfk_1;

INSERT INTO GENRES (category_name)
SELECT genre_name
FROM ALL_GENRES;

ALTER TABLE MOVIES
ADD FOREIGN KEY (movie_genre_id) REFERENCES GENRES(category_id);

select * from genres;

## ADD AVAILABILITY

UPDATE GENRES
SET availableNSA = 1;

## drop availability

ALTER TABLE GENRES
DROP COLUMN availableMEA;

#insert big movie data

ALTER TABLE GENRES
MODIFY category_name VARCHAR(200);

INSERT INTO GENRES (category_name)
SELECT (movie_genre)
FROM movies;

#test for genre x price setting
alter table GENRES
ADD COLUMN Romance BOOL;

#clean

ALTER TABLE MOVIES
DROP CONSTRAINT movies_ibfk_1;

TRUNCATE TABLE GENRES;

INSERT INTO GENRES (category_name)
SELECT DISTINCT (movie_genre)
FROM movies;

UPDATE GENRES
SET ROMANCE = 0
where category_name NOT LIKE '%Romance%';

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
ADD COLUMN PRICE INT;

UPDATE GENRES SET PRICE =  COALESCE(FAMILY) + COALESCE(ROMANCE) + COALESCE(Crime) + COALESCE(Music) + COALESCE(Western) + COALESCE(ScienceFiction) + COALESCE(Fantasy) + COALESCE(COMEDY) + COALESCE(THRILLER) + COALESCE(Animation) + COALESCE(Adventure) + COALESCE(Action) + COALESCE(Drama) + COALESCE(War) + COALESCE(Documentary) + COALESCE(Mystery) + COALESCE(Horror);


DELETE from genres WHERE category_name IS NULL;

-- cleaup - getting rid of null values (genres/movies)

select * from genres where category_name = "No genre specified";

INSERT INTO GENRES (category_name)
VALUES ("No genre specified");

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
UPDATE GENRES SET PRICE =  COALESCE(FAMILY) + COALESCE(ROMANCE) + COALESCE(Crime) + COALESCE(Music) + COALESCE(Western) + COALESCE(ScienceFiction) + COALESCE(Fantasy) + COALESCE(COMEDY) + COALESCE(THRILLER) + COALESCE(Animation) + COALESCE(Adventure) + COALESCE(Action) + COALESCE(Drama) + COALESCE(War) + COALESCE(Documentary) + COALESCE(Mystery) + COALESCE(Horror);


DELETE from GENRES where category_name IS NULL;

-- fix null values on movie table

UPDATE MOVIES
SET movie_genre_id = 624
WHERE movie_genre_id IS NULL;

-- fix duplicate foreign keys

ALTER TABLE MOVIES
DROP CONSTRAINT movies_ibfk_2;

ALTER TABLE MOVIES
DROP CONSTRAINT movies_ibfk_3;

-- price changes (more realistic)

UPDATE movies
SET monthlyRentalCost = monthlyRentalCost * 1.2
WHERE monthlyRentalCost = 10;

SELECT * from MOVIE_PRICE_CHANGES
ORDER BY changed_at ASC;



-- locations table
CREATE TABLE LOCATIONS (
	country_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    country_name VARCHAR (50),
    salesRegion VARCHAR (50)
);
## for recreating
DROP TABLE LOCATIONS;

TRUNCATE TABLE LOCATIONS;

## took out location and region - keeping it simple
ALTER TABLE LOCATIONS
DROP COLUMN region_name;
## copied data from cmer table
INSERT INTO LOCATIONS ( country_name)
SELECT country
FROM CUSTOMERS;
## removing null values
DELETE FROM LOCATIONS
WHERE
	location_name is NULL;
    
## setting sales regions
UPDATE LOCATIONS
SET salesRegion = "Europe"
WHERE country_name IN ("Albania", "Andorra", "Armenia", "Austria", "Belarus","Belgium", "Bosnia and Herzegovina", "Bulgaria", "Croatia", "Cyprus", "Czechia", "Denmark", "Estonia", "Finland", "France", "Germany", "Greece", "Hungary", "Iceland", "Ireland", "Italy", "Kosovo", "Latvia", "Liechtenstein", "Lithuania"
"Luxembourg", "Malta", "Moldova", "Monaco", "Montenegro", "Netherlands", "North Macedonia", "Norway", "Poland", "Portugal", "Romania", "Russia", "San Marino", "Serbia", "Slovakia", "Slovenia", "Spain", "Sweden", "Switzerland", "Turkey", "Ukraine", "United Kingdom", "Vatican City");


## adding more countries
INSERT INTO LOCATIONS (country_name)
SELECT DISTINCT LOC
FROM ALL_LOCATIONS;

select * from locations;

## add more regional identifiers
select GROUP_CONCAT(DISTINCT country_name
	ORDER BY country_name ASC
    SEPARATOR ', ')
from locations;

## NB. ended up just finding a better table online :)
## ADDING IN ALL COUNTRIES AND CONTINENTAL CODES
ALTER TABLE LOCATIONS
ADD COLUMN country_code VARCHAR (2);

ALTER TABLE CUSTOMERS
DROP CONSTRAINT customers_ibfk_1;

TRUNCATE TABLE LOCATIONS;

INSERT INTO LOCATIONS
	(country_code, country_name, salesRegion)
VALUES
	('AD', 'Andorra', 'EU'),
	('AE', 'United Arab Emirates', 'AS'),
	('AF', 'Afghanistan', 'AS'),
	('AG', 'Antigua and Barbuda', 'NA'),
	('AI', 'Anguilla', 'NA'),
	('AL', 'Albania', 'EU'),
	('AM', 'Armenia', 'AS'),
	('AN', 'Netherlands Antilles', 'NA'),
	('AO', 'Angola', 'AF'),
	('AQ', 'Antarctica', 'AN'),
	('AR', 'Argentina', 'SA'),
	('AS', 'American Samoa', 'OC'),
	('AT', 'Austria', 'EU'),
	('AU', 'Australia', 'OC'),
	('AW', 'Aruba', 'NA'),
	('AX', 'Åland', 'EU'),
	('AZ', 'Azerbaijan', 'AS'),
	('BA', 'Bosnia and Herzegovina', 'EU'),
	('BB', 'Barbados', 'NA'),
	('BD', 'Bangladesh', 'AS'),
	('BE', 'Belgium', 'EU'),
	('BF', 'Burkina Faso', 'AF'),
	('BG', 'Bulgaria', 'EU'),
	('BH', 'Bahrain', 'AS'),
	('BI', 'Burundi', 'AF'),
	('BJ', 'Benin', 'AF'),
	('BL', 'Saint Barthélemy', 'NA'),
	('BM', 'Bermuda', 'NA'),
	('BN', 'Brunei Darussalam', 'AS'),
	('BO', 'Bolivia', 'SA'),
	('BR', 'Brazil', 'SA'),
	('BS', 'Bahamas', 'NA'),
	('BT', 'Bhutan', 'AS'),
	('BV', 'Bouvet Island', 'AN'),
	('BW', 'Botswana', 'AF'),
	('BY', 'Belarus', 'EU'),
	('BZ', 'Belize', 'NA'),
	('CA', 'Canada', 'NA'),
	('CC', 'Cocos (Keeling) Islands', 'AS'),
	('CD', 'Congo (Kinshasa)', 'AF'),
	('CF', 'Central African Republic', 'AF'),
	('CG', 'Congo (Brazzaville)', 'AF'),
	('CH', 'Switzerland', 'EU'),
	('CI', 'Côte dIvoire', 'AF'),
	('CK', 'Cook Islands', 'OC'),
	('CL', 'Chile', 'SA'),
	('CM', 'Cameroon', 'AF'),
	('CN', 'China', 'AS'),
	('CO', 'Colombia', 'SA'),
	('CR', 'Costa Rica', 'NA'),
	('CU', 'Cuba', 'NA'),
	('CV', 'Cape Verde', 'AF'),
	('CX', 'Christmas Island', 'AS'),
	('CY', 'Cyprus', 'AS'),
	('CZ', 'Czech Republic', 'EU'),
	('DE', 'Germany', 'EU'),
	('DJ', 'Djibouti', 'AF'),
	('DK', 'Denmark', 'EU'),
	('DM', 'Dominica', 'NA'),
	('DO', 'Dominican Republic', 'NA'),
	('DZ', 'Algeria', 'AF'),
	('EC', 'Ecuador', 'SA'),
	('EE', 'Estonia', 'EU'),
	('EG', 'Egypt', 'AF'),
	('EH', 'Western Sahara', 'AF'),
	('ER', 'Eritrea', 'AF'),
	('ES', 'Spain', 'EU'),
	('ET', 'Ethiopia', 'AF'),
	('FI', 'Finland', 'EU'),
	('FJ', 'Fiji', 'OC'),
	('FK', 'Falkland Islands', 'SA'),
	('FM', 'Micronesia', 'OC'),
	('FO', 'Faroe Islands', 'EU'),
	('FR', 'France', 'EU'),
	('GA', 'Gabon', 'AF'),
	('GB', 'United Kingdom', 'EU'),
	('GD', 'Grenada', 'NA'),
	('GE', 'Georgia', 'AS'),
	('GF', 'French Guiana', 'SA'),
	('GG', 'Guernsey', 'EU'),
	('GH', 'Ghana', 'AF'),
	('GI', 'Gibraltar', 'EU'),
	('GL', 'Greenland', 'NA'),
	('GM', 'Gambia', 'AF'),
	('GN', 'Guinea', 'AF'),
	('GP', 'Guadeloupe', 'NA'),
	('GQ', 'Equatorial Guinea', 'AF'),
	('GR', 'Greece', 'EU'),
	('GS', 'South Georgia and South Sandwich Islands', 'AN'),
	('GT', 'Guatemala', 'NA'),
	('GU', 'Guam', 'OC'),
	('GW', 'Guinea-Bissau', 'AF'),
	('GY', 'Guyana', 'SA'),
	('HK', 'Hong Kong', 'AS'),
	('HM', 'Heard and McDonald Islands', 'AN'),
	('HN', 'Honduras', 'NA'),
	('HR', 'Croatia', 'EU'),
	('HT', 'Haiti', 'NA'),
	('HU', 'Hungary', 'EU'),
	('ID', 'Indonesia', 'AS'),
	('IE', 'Ireland', 'EU'),
	('IL', 'Israel', 'AS'),
	('IM', 'Isle of Man', 'EU'),
	('IN', 'India', 'AS'),
	('IO', 'British Indian Ocean Territory', 'AS'),
	('IQ', 'Iraq', 'AS'),
	('IR', 'Iran', 'AS'),
	('IS', 'Iceland', 'EU'),
	('IT', 'Italy', 'EU'),
	('JE', 'Jersey', 'EU'),
	('JM', 'Jamaica', 'NA'),
	('JO', 'Jordan', 'AS'),
	('JP', 'Japan', 'AS'),
	('KE', 'Kenya', 'AF'),
	('KG', 'Kyrgyzstan', 'AS'),
	('KH', 'Cambodia', 'AS'),
	('KI', 'Kiribati', 'OC'),
	('KM', 'Comoros', 'AF'),
	('KN', 'Saint Kitts and Nevis', 'NA'),
	('KP', 'Korea, North', 'AS'),
	('KR', 'Korea, South', 'AS'),
	('KW', 'Kuwait', 'AS'),
	('KY', 'Cayman Islands', 'NA'),
	('KZ', 'Kazakhstan', 'AS'),
	('LA', 'Laos', 'AS'),
	('LB', 'Lebanon', 'AS'),
	('LC', 'Saint Lucia', 'NA'),
	('LI', 'Liechtenstein', 'EU'),
	('LK', 'Sri Lanka', 'AS'),
	('LR', 'Liberia', 'AF'),
	('LS', 'Lesotho', 'AF'),
	('LT', 'Lithuania', 'EU'),
	('LU', 'Luxembourg', 'EU'),
	('LV', 'Latvia', 'EU'),
	('LY', 'Libya', 'AF'),
	('MA', 'Morocco', 'AF'),
	('MC', 'Monaco', 'EU'),
	('MD', 'Moldova', 'EU'),
	('ME', 'Montenegro', 'EU'),
	('MF', 'Saint Martin (French part)', 'NA'),
	('MG', 'Madagascar', 'AF'),
	('MH', 'Marshall Islands', 'OC'),
	('MK', 'Macedonia', 'EU'),
	('ML', 'Mali', 'AF'),
	('MM', 'Myanmar', 'AS'),
	('MN', 'Mongolia', 'AS'),
	('MO', 'Macau', 'AS'),
	('MP', 'Northern Mariana Islands', 'OC'),
	('MQ', 'Martinique', 'NA'),
	('MR', 'Mauritania', 'AF'),
	('MS', 'Montserrat', 'NA'),
	('MT', 'Malta', 'EU'),
	('MU', 'Mauritius', 'AF'),
	('MV', 'Maldives', 'AS'),
	('MW', 'Malawi', 'AF'),
	('MX', 'Mexico', 'NA'),
	('MY', 'Malaysia', 'AS'),
	('MZ', 'Mozambique', 'AF'),
	('NA', 'Namibia', 'AF'),
	('NC', 'New Caledonia', 'OC'),
	('NE', 'Niger', 'AF'),
	('NF', 'Norfolk Island', 'OC'),
	('NG', 'Nigeria', 'AF'),
	('NI', 'Nicaragua', 'NA'),
	('NL', 'Netherlands', 'EU'),
	('NO', 'Norway', 'EU'),
	('NP', 'Nepal', 'AS'),
	('NR', 'Nauru', 'OC'),
	('NU', 'Niue', 'OC'),
	('NZ', 'New Zealand', 'OC'),
	('OM', 'Oman', 'AS'),
	('PA', 'Panama', 'NA'),
	('PE', 'Peru', 'SA'),
	('PF', 'French Polynesia', 'OC'),
	('PG', 'Papua New Guinea', 'OC'),
	('PH', 'Philippines', 'AS'),
	('PK', 'Pakistan', 'AS'),
	('PL', 'Poland', 'EU'),
	('PM', 'Saint Pierre and Miquelon', 'NA'),
	('PN', 'Pitcairn', 'OC'),
	('PR', 'Puerto Rico', 'NA'),
	('PS', 'Palestine', 'AS'),
	('PT', 'Portugal', 'EU'),
	('PW', 'Palau', 'OC'),
	('PY', 'Paraguay', 'SA'),
	('QA', 'Qatar', 'AS'),
	('RE', 'Reunion', 'AF'),
	('RO', 'Romania', 'EU'),
	('RS', 'Serbia', 'EU'),
	('RU', 'Russian Federation', 'EU'),
	('RW', 'Rwanda', 'AF'),
	('SA', 'Saudi Arabia', 'AS'),
	('SB', 'Solomon Islands', 'OC'),
	('SC', 'Seychelles', 'AF'),
	('SD', 'Sudan', 'AF'),
	('SE', 'Sweden', 'EU'),
	('SG', 'Singapore', 'AS'),
	('SH', 'Saint Helena', 'AF'),
	('SI', 'Slovenia', 'EU'),
	('SJ', 'Svalbard and Jan Mayen Islands', 'EU'),
	('SK', 'Slovakia', 'EU'),
	('SL', 'Sierra Leone', 'AF'),
	('SM', 'San Marino', 'EU'),
	('SN', 'Senegal', 'AF'),
	('SO', 'Somalia', 'AF'),
	('SR', 'Suriname', 'SA'),
	('ST', 'Sao Tome and Principe', 'AF'),
	('SV', 'El Salvador', 'NA'),
	('SY', 'Syria', 'AS'),
	('SZ', 'Swaziland', 'AF'),
	('TC', 'Turks and Caicos Islands', 'NA'),
	('TD', 'Chad', 'AF'),
	('TF', 'French Southern Lands', 'AN'),
	('TG', 'Togo', 'AF'),
	('TH', 'Thailand', 'AS'),
	('TJ', 'Tajikistan', 'AS'),
	('TK', 'Tokelau', 'OC'),
	('TL', 'Timor-Leste', 'AS'),
	('TM', 'Turkmenistan', 'AS'),
	('TN', 'Tunisia', 'AF'),
	('TO', 'Tonga', 'OC'),
	('TR', 'Turkey', 'AS'),
	('TT', 'Trinidad and Tobago', 'NA'),
	('TV', 'Tuvalu', 'OC'),
	('TW', 'Taiwan', 'AS'),
	('TZ', 'Tanzania', 'AF'),
	('UA', 'Ukraine', 'EU'),
	('UG', 'Uganda', 'AF'),
	('UM', 'United States Minor Outlying Islands', 'OC'),
	('US', 'United States of America', 'NA'),
	('UY', 'Uruguay', 'SA'),
	('UZ', 'Uzbekistan', 'AS'),
	('VA', 'Vatican City', 'EU'),
	('VC', 'Saint Vincent and the Grenadines', 'NA'),
	('VE', 'Venezuela', 'SA'),
	('VG', 'Virgin Islands, British', 'NA'),
	('VI', 'Virgin Islands, U.S.', 'NA'),
	('VN', 'Vietnam', 'AS'),
	('VU', 'Vanuatu', 'OC'),
	('WF', 'Wallis and Futuna Islands', 'OC'),
	('WS', 'Samoa', 'OC'),
	('YE', 'Yemen', 'AS'),
	('YT', 'Mayotte', 'AF'),
	('ZA', 'South Africa', 'AF'),
	('ZM', 'Zambia', 'AF'),
	('ZW', 'Zimbabwe', 'AF');

ALTER TABLE CUSTOMERS
ADD FOREIGN KEY (country_id) REFERENCES LOCATIONS(country_id);


-- data analysis

-- big movie, main movie dataset - not super clean, but contains LOTS of raw (ish) movie data
select * from big_movie;

-- movies, contains cleaner (& reduced in scope) movie data, also contains calculations for monthly rental price, done (initially) through a combination of the number of genres a movie has and the year it was released
select * from movies;

-- contains genre data, where I did a lot of 'genre related cleaning' and also worked out (through a long form method as I couldn't figure out how to do it any other way!) how many categories each movie had 
select * from genres;

-- customer data (manufactured from mockaroo) - contains info on customer name, email, location
select * from customers;

-- transaction (order) data - contains mocked information on transaction locations, movies rented, sales region of transaction
select * from transactions;

-- location data lifted from a separate public dataset to ensure a full spread of nations, includes country codes and sales regions (eg. EU, Asia)
select * from locations;

-- views
-- eu sales view
CREATE OR REPLACE VIEW euSalesTeam
AS 
	SELECT CONCAT(FORENAME, " ", SURNAME) AS Name, city, country, l.salesRegion, count(transaction_id) AS Transactions
	FROM CUSTOMERS c
	JOIN LOCATIONS l ON country = l.country_name
    JOIN TRANSACTIONS t ON t.customer_id = c.person_id
	GROUP BY Name, city, country, salesRegion
	HAVING l.salesRegion = "EU";


select * from euSalesTeam;

-- asia sales view
CREATE OR REPLACE VIEW asiaSalesTeam
AS 
	SELECT GROUP_CONCAT(FORENAME, " ", SURNAME
		ORDER BY FORENAME, SURNAME
		SEPARATOR ',') AS Name, city, country, l.salesRegion, count(transaction_id) AS Transactions
	FROM CUSTOMERS c
	JOIN LOCATIONS l ON country = l.country_name
    JOIN TRANSACTIONS t ON t.customer_id = c.person_id
	GROUP BY city, country, l.country_name, l.salesRegion
	HAVING l.salesRegion = "AS";

    
SELECT * FROM ASIASALESTEAM;

-- events
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
DROP EVENT IF EXISTS blackFridayRentalDeal;

-- undo

CREATE EVENT IF NOT EXISTS reverseBlackFridayRentalDeal
ON SCHEDULE AT CURRENT_TIMESTAMP
ON COMPLETION PRESERVE
DO
UPDATE movies
SET monthlyRentalCost = monthlyRentalCost*2;

-- test
select movie_id, new_price, changed_at from movie_price_changes WHERE movie_id = 1033 ORDER BY changed_at DESC;

-- triggers
-- Trigger - price changes

select monthlyRentalCost from movies;

CREATE TABLE MOVIE_PRICE_CHANGES (
	movie_id INT,
    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    old_price DECIMAL (5,2),
    new_price DECIMAL (5.2),
    PRIMARY KEY (movie_id, changed_at)
);

DELIMITER //
CREATE TRIGGER beforeUpdatePrice
BEFORE UPDATE on movies
FOR EACH ROW
BEGIN
	IF OLD.monthlyRentalCost <> NEW.monthlyRentalCost
		THEN
		INSERT INTO MOVIE_PRICE_CHANGES(movie_id, old_price, new_price)
		VALUES (NEW.movie_id, OLD.monthlyRentalCost, NEW.monthlyRentalCost);
	END IF;
END//
​
DELIMITER ;

-- test

select movie_name, monthlyRentalCost
FROM movies
WHERE monthlyRentalCost = 12

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
        
-- test
select * from movies
WHERE movie_name = "a test data set";

SELECT * from movies order by movie_id desc;

-- reset for testing
DELETE FROM movies WHERE movie_genre IS NULL;

DELETE FROM big_movie
WHERE original_title = "a test data set";

insert into big_movie
	(original_title)
VALUES
	("a test data set");
    
-- functions and procedures

-- function for filtering for films by genre
DELIMITER //

CREATE PROCEDURE genreGenerator(IN genre VARCHAR (50))
BEGIN
	SELECT movie_name, IF(INSTR(movie_genre,genre)>0,'YES','NO') AS selectGenre, movie_releaseDate
    FROM movies
    ORDER BY selectGenre DESC;
END //
    
;



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


-- execute
CALL genreAndYearGenerator('Fantasy', 1995);

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



-- call proc

CALL transaction_filmDate(1995);



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




-- execute
CALL priceGenerator(180);

-- function to know how much a rental would cost for a year

DELIMITER //
CREATE FUNCTION annualCost(
    monthlyRentalPrice INT
) 
RETURNS INT DETERMINISTIC
BEGIN
    DECLARE yearlyTotal INT;
	SET yearlyTotal = (monthlyRentalPrice*12);
    RETURN (yearlyTotal);
END//

DELIMITER ;



-- test
select movie_name, monthlyRentalCost, annualCost(monthlyRentalCost) from movies
WHERE year(movie_releaseDate) = 1996;

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



-- execute function
CALL filmFactsGenerator('TO');

-- function to return boolean value if movie is in english (can use to update price)


DELIMITER //
CREATE FUNCTION isItInEnglish(
    movId INT
)
RETURNS BOOL DETERMINISTIC
BEGIN
	DECLARE lang VARCHAR (2);
    DECLARE mov VARCHAR (100);
    DECLARE isEnglish BOOL;
    SET isEnglish = 0;
    SET mov = (SELECT movie_name from movies WHERE movie_id = movId);
    SET lang = (SELECT original_language from big_movie WHERE original_title = mov);
	IF lang = "en" THEN SET isEnglish = 1;
    END IF;
    RETURN (isEnglish);
END//

DELIMITER ;



-- test

select movie_name, isItInEnglish(234) from movies where movie_id = 234;

-- subquery

select movie_name
from movies m
WHERE movie_id IN
	(SELECT movie_id
    FROM big_movie
    WHERE revenue > 1000000)



