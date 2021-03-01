DELIMITER $$
CREATE TRIGGER fillHobby AFTER INSERT ON hobby
FOR EACH ROW 
BEGIN
	IF (NEW.typ = "nauka") 
		THEN 
		IF NEW.id NOT IN (SELECT id FROM nauka) 
			THEN INSERT INTO nauka (id,nazwa) VALUES (NEW.id, "trigger_Made_Science");
		END IF;
	END IF;

	IF (NEW.typ = "sport") 
		THEN 
		IF NEW.id NOT IN (SELECT id FROM sport) 
			THEN INSERT INTO sport (id,nazwa,typ) VALUES (NEW.id, "trigger_Made_Sport",'druzynowy');
		END IF;
	END IF;

	IF (NEW.typ = "inne") 
		THEN 
		IF NEW.id NOT IN (SELECT id FROM inne) 
			THEN INSERT INTO inne (id,nazwa,towarzysze) VALUES (NEW.id, "trigger_Made_other", 1);
		END IF;
	END IF;
END$$
DELIMITER ;

