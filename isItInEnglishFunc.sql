 

select original_language from big_movie where original_language != "en"

select country_code, l.salesRegion, m.movie_name, b.original_language
from locations l
join customers c on c.country = l.country_name
join transactions t on t.customer_id = c.person_id
join movies m on m.movie_id = t.movie_id
join big_movie b on m.movie_name = b.original_title
where t.transaction_id between 101 and 105

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

-- drop

DROP FUNCTION isItInEnglish

-- test

select movie_name, isItInEnglish(234) from movies where movie_id = 234
