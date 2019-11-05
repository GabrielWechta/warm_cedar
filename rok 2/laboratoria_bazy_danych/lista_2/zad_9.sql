DELIMITER $$
DROP PROCEDURE IF EXISTS allHobbies;
CREATE PROCEDURE allHobbies(IN idOsoby INT)
BEGIN
	SELECT nazwa FROM nazwyHobby WHERE osoba=idOsoby;
END$$
DELIMITER ; 

CALL allHobbies(27);
