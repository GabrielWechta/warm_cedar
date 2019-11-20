DROP PROCEDURE IF EXISTS checkHaslo;
DELIMITER $$

CREATE PROCEDURE checkHaslo(IN imieL VARCHAR(20), IN hasloL VARCHAR(40))
BEGIN 
	SELECT DISTINCT haslo INTO @var FROM hasla INNER JOIN osoba ON osoba.id = hasla.id WHERE osoba.imie = imieL;

	IF @var = SHA1(hasloL) THEN
		SET @dat = (SELECT dataUrodzenia FROM osoba WHERE osoba.imie = imieL);
	ELSE
		SET @MIN = '1919-04-30 14:53:27';
		SET @MAX = '2000-04-30 14:53:27';
		SET @dat = (SELECT TIMESTAMPADD(SECOND, FLOOR(RAND() * TIMESTAMPDIFF(SECOND, @MIN, @MAX)), @MIN));
	END IF;

	SELECT @dat;

END; $$
DELIMITER ;
