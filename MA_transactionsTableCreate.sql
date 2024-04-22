CREATE TABLE TRANSACTIONS (
	transaction_id INTEGER,
    transaction_location VARCHAR (50),
    product_id INTEGER,
    weeks_loaned INTEGER,
    transaction_cost DECIMAL (4,2))
;
## primary key
ALTER TABLE TRANSACTIONS
MODIFY transaction_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY
## foreign key from cmer table
ALTER TABLE TRANSACTIONS
ADD COLUMN customer_id INT

ALTER TABLE TRANSACTIONS
MODIFY transaction_cost DECIMAL (5,2)

ALTER TABLE TRANSACTIONS
RENAME COLUMN product_id to movie_id

ALTER TABLE TRANSACTIONS
ADD FOREIGN KEY (movie_id) REFERENCES MOVIES(movie_id);


INSERT INTO TRANSACTIONS
	(transaction_location, product_id, customer_id, weeks_loaned, transaction_cost)
VALUES
	('Sheffield', 7, 1, 42, 330.79),
	('Xinchengzi', 9, 17, 48, 988.83),
	('Khombole', 5, 9, 13, 603.15);

SELECT * FROM TRANSACTIONS