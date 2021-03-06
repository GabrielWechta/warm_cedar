DELIMITER $$
DROP TRIGGER IF EXISTS animalShelter $$

CREATE TRIGGER animalShelter AFTER DELETE ON osoba
FOR EACH ROW 
BEGIN
	DELETE FROM hobby WHERE hobby.osoba = OLD.id;
	UPDATE zwierzak SET ID = (SELECT ID FROM osoba LIMIT 1) WHERE ID = OLD.id;
END$$

DELIMITER ;
