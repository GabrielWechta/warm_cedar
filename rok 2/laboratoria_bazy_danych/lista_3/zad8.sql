DROP PROCEDURE IF EXISTS sabrina;
DELIMITER $$

CREATE PROCEDURE sabrina (IN profession VARCHAR(30))
BEGIN
	DECLARE koniec, roller INT UNSIGNED;
	DECLARE temp_id, temp_zarobki, thisMax INT UNSIGNED;

	DECLARE kursor CURSOR FOR SELECT id_osoby, zarobki FROM praca INNER JOIN zawody ON id_zawody = id WHERE nazwa = profession;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET koniec = 1;
   	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET roller = 1;

	OPEN kursor;
	SET autocommit = 1;
	SET thisMAX = (SELECT DISTINCT pensja_max FROM zawody WHERE nazwa = profession);
 	START TRANSACTION;
	petla: LOOP
		FETCH kursor INTO temp_id, temp_zarobki;
		IF koniec = 1 
			THEN LEAVE petla;
		END IF;

		SET temp_zarobki = temp_zarobki * 1.1;

		IF temp_zarobki > thisMax
			THEN SET roller = 1;
			LEAVE petla;
		END IF;
		
		UPDATE praca SET zarobki = temp_zarobki WHERE id_osoby = temp_id;

	END LOOP petla;

    	IF roller = 1 THEN
       		ROLLBACK;
    	ELSE
        	COMMIT;
   	END IF;
END$$

DELIMITER ;
