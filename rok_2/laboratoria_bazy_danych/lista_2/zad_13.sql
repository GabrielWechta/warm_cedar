DELIMITER $$
DROP TRIGGER IF EXISTS destroyHobbyFromScienceAfterDelete$$
DROP TRIGGER IF EXISTS destroyHobbyFromScienceAfterUpdate$$

CREATE TRIGGER destroyHobbyFromScienceAfterDelete AFTER DELETE ON nauka
FOR EACH ROW 
BEGIN
	DELETE FROM hobby WHERE OLD.id = hobby.id AND typ = "nauka";
END;$$

CREATE TRIGGER destroyHobbyFromScienceAfterUpdate AFTER UPDATE ON nauka
FOR EACH ROW 
BEGIN
	IF (OLD.nazwa <> NEW.nazwa) THEN DELETE FROM hobby WHERE OLD.id = hobby.id AND typ = "nauka";
	END IF;
END$$
DELIMITER ;



