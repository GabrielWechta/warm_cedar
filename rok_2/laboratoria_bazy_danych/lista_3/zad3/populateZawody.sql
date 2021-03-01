DROP PROCEDURE IF EXISTS populateZawody;
DELIMITER $$

CREATE PROCEDURE populateZawody ()
BEGIN 
	DECLARE i INT;
	SET i = 1;
	WHILE i < 12 DO 
		INSERT INTO zawody VALUES(null, CONCAT("wykladowca na W",i), i*1000 - i*100, i*1000); 
		SET i = i + 1;
	END WHILE;
END; $$

DELIMITER ;
