DELIMITER $$
DROP PROCEDURE IF EXISTS allHobbies;
CREATE PROCEDURE allHobbies(IN idOsoby INT)
BEGIN
	SELECT nazwa FROM nazwyHobby WHERE osoba = idOsoby
	Union
	SElECT Distinct species FROM zwierzak WHERE ID = idOsoby;
END$$
DELIMITER ; 

CALL allHobbies(27);
call allHobbies(3);
