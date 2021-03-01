DROP PROCEDURE IF EXISTS a;
DELIMITER $$

CREATE PROCEDURE a(IN kol VARCHAR(20), IN agg VARCHAR(20))
BEGIN
	IF kol = 'dataUrodzenia' THEN 
		SET @str = CONCAT('SELECT FROM_UNIXTIME(', agg,'(UNIX_TIMESTAMP(', kol,'))) INTO @var FROM osoba;');
	ELSE
		SET @str = CONCAT('SELECT ', agg,'(', kol,') INTO @var FROM osoba;');
	END IF;

	PREPARE stmt FROM @str;
	EXECUTE stmt;
	SELECT kol, agg, @var;
	DEALLOCATE PREPARE stmt;
	
END;$$

DELIMITER ;
