DELIMITER $$
DROP FUNCTION IF EXISTS mostIntrested;
DROP VIEW IF EXISTS personAndNumberOfHobbies;
	CREATE VIEW personAndNumberOfHobbies AS 
	SELECT osoba, COUNT(osoba) AS ilosc FROM hobby GROUP BY osoba; 
CREATE FUNCTION mostIntrested() RETURNS VARCHAR(50) READS SQL DATA
BEGIN 

	DECLARE done INT DEFAULT FALSE;
	DECLARE Imie VARCHAR(20);
	DECLARE Wiek INT;
	DECLARE myCursor CURSOR FOR 
	(Select imie, YEAR(CURDATE())-YEAR(dataUrodzenia) AS wiek FROM personAndNumberOfHobbies INNER JOIN osoba ON osoba = osoba.id WHERE ilosc = (Select MAX(ilosc) FROM personAndNumberOfHobbies) );

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

	OPEN myCursor;
	FETCH myCursor INTO Imie, Wiek;
	CLOSE myCursor;
	RETURN CONCAT("Imie: ", Imie);
END $$

DELIMITER ;

SELECT mostIntrested();



