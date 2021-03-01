DELIMITER $$
DROP FUNCTION IF EXISTS mostIntrested;
DROP VIEW IF EXISTS personAndNumberOfHobbies;
	CREATE VIEW personAndNumberOfHobbies AS 
	SELECT osoba, COUNT(osoba) AS ilosc FROM hobby GROUP BY osoba; 
CREATE FUNCTION mostIntrested() RETURNS VARCHAR(50) READS SQL DATA
BEGIN 
	(Select imie, YEAR(CURDATE())-YEAR(dataUrodzenia) AS wiek INTO @Imie, @Wiek FROM personAndNumberOfHobbies INNER JOIN osoba ON osoba = osoba.id WHERE ilosc = (Select MAX(ilosc) FROM personAndNumberOfHobbies) );

	RETURN CONCAT("Imie: ", @Imie, ", Wiek: ", @Wiek);
END $$

DELIMITER ;

SELECT mostIntrested();



