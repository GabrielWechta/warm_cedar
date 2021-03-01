DROP PROCEDURE IF EXISTS abcd;
DELIMITER $$
CREATE PROCEDURE abcd (
	IN name VARCHAR(30),
	IN num INT) 
BEGIN
	DECLARE i INT;
	SET i = 1;
	IF (name = "osoba")
			THEN
			BEGIN
			START TRANSACTION;
			WHILE i <= num DO
				INSERT INTO osoba(imie, dataUrodzenia, plec, nazwisko) VALUES (CONCAT("Gabi",i), DATE("1999-10-31" - INTERVAL FLOOR(RAND() * 14) DAY), 'm', null);
				SET i = i + 1;
			END WHILE;
			COMMIT;
			END;
	END IF;

	IF (name = "sport")
			THEN
			BEGIN
			START TRANSACTION;
			WHILE i <= num DO
				INSERT INTO sport (nazwa, typ, lokacja) VALUES (CONCAT("szachy dla ",i, " osob"), 'indywidualny', null);
				SET i = i + 1;
			END WHILE;
			COMMIT;
			END;
	END IF;

	IF (name = "nauka")
			THEN
			BEGIN
			START TRANSACTION;
			WHILE i <= num DO
				INSERT INTO nauka (nazwa, lokacja) VALUES (CONCAT(i," Teoria mnogosci"), "PWR");
				SET i = i + 1;
			END WHILE;
			COMMIT;
			END;
	END IF;

	IF (name = "inne")
			THEN
			BEGIN
			START TRANSACTION;
			WHILE i <= num DO
				INSERT INTO inne (nazwa, lokacja, towarzysze) VALUES (CONCAT("licze do",i), null, 1);
				SET i = i + 1;
			END WHILE;
			COMMIT;
			END;
	END IF;

	IF (name = "hobby")
			THEN
			BEGIN
			START TRANSACTION;
			WHILE i <= num DO
				INSERT INTO hobby (osoba, id, typ) VALUES (22+i,i,'sport');
				SET i = i + 1;
			END WHILE;
			COMMIT;
			END;
	END IF;
END$$
DELIMITER ;
