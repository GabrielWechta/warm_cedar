DROP PROCEDURE IF EXISTS populateHasla;
DELIMITER $$

CREATE PROCEDURE populateHasla ()
BEGIN 
	DECLARE koniec INT UNSIGNED;
	DECLARE temp_id INT UNSIGNED DEFAULT 1;
	DECLARE temp_imie VARCHAR(20);
	DECLARE kursor CURSOR FOR SELECT id, imie FROM osoba ORDER BY id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET koniec = 1;
	OPEN kursor;
	petla: LOOP 
		FETCH kursor INTO temp_id, temp_imie;
		INSERT INTO hasla VALUES (temp_id, SHA1(CONCAT(temp_imie, 2*temp_id)));
		IF koniec = 1 
			THEN LEAVE petla;
		END IF;
	END LOOP petla;
END; $$

DELIMITER ;
