DROP PROCEDURE IF EXISTS populatePraca;
DELIMITER $$

CREATE PROCEDURE populatePraca ()
BEGIN 
	DECLARE koniec, minimum INT UNSIGNED DEFAULT 0;
	DECLARE temp_id, zawod_id INT UNSIGNED DEFAULT 1;
	DECLARE kursor CURSOR FOR SELECT id FROM osoba ORDER BY id;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET koniec = 1;
	OPEN kursor;
	petla: LOOP 
		FETCH kursor INTO temp_id;
		SET minimum = (SELECT pensja_min FROM zawody WHERE id = zawod_id);
		INSERT INTO praca VALUES (temp_id, zawod_id, minimum + 200);
		SET zawod_id = MOD(zawod_id, 11);
		SET zawod_id = zawod_id + 1;
		IF koniec = 1 
			THEN LEAVE petla;
		END IF;
	END LOOP petla;
END; $$

DELIMITER ;
