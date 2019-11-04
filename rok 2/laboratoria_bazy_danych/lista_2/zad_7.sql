DROP PROCEDURE IF EXISTS generate;
DELIMITER $$
CREATE PROCEDURE generate(IN name VARCHAR(20), num INT) 
BEGIN
	DECLARE i INT DEFAULT 1;
		CASE
			WHEN name = "osoba" THEN
				
				START TRANSACTION;
				WHILE i <= num DO
					INSERT INTO osoba VALUES (null, "Gabi", "1999-10-31", 'm', null);
					SET i = i + 1;
				END WHILE;
				COMMIT;
			ELSE 
				BEGIN;
				END;
		END CASE;
	END$$
DELIMITER ;
