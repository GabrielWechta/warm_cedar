DELIMITER $$
CREATE TRIGGER age_trigger
BEFORE INSERT ON osoba
FOR EACH ROW 
BEGIN
	IF (new.dataUrodzenia - CURDATE()) >= -180000
	THEN 
	 SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = "We are only adults here";
	END IF;

END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER age_trigger_edit
BEFORE UPDATE ON osoba
FOR EACH ROW 
BEGIN
	IF (new.dataUrodzenia - CURDATE()) >= -180000
	THEN 
	 SIGNAL SQLSTATE '02000' SET MESSAGE_TEXT = "We are only adults here must stay that way";
	END IF;

END$$
DELIMITER ;
