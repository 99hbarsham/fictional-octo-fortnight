CREATE TABLE CUSTOMERS (
	person_id INTEGER,
    forename VARCHAR (50),
    surname VARCHAR (50),
    email VARCHAR (60),
    city VARCHAR (50),
    region VARCHAR (50),
    country VARCHAR (50))
;

drop TABLE CUSTOMERS

ALTER TABLE CUSTOMERS
MODIFY person_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY

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
ADD COLUMN country_id INT

ALTER TABLE CUSTOMERS
ADD FOREIGN KEY (country_id) REFERENCES LOCATIONS(country_id);