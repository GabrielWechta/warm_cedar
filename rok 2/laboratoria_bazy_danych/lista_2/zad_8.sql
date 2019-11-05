DROP VIEW IF EXISTS nazwyHobby;
CREATE VIEW nazwyHobby AS
    SELECT osoba, nazwa, hobby.typ FROM hobby JOIN nauka ON nauka.id = hobby.id WHERE hobby.typ = 'nauka' UNION
    SELECT osoba, nazwa, hobby.typ FROM hobby JOIN sport ON sport.id = hobby.id WHERE hobby.typ = 'sport' UNION
    SELECT osoba, nazwa, hobby.typ FROM hobby JOIN inne ON inne.id = hobby.id WHERE hobby.typ = 'inne';

PREPARE wszytskieHobbyOsoby FROM 'SELECT nazwa FROM nazwyHobby WHERE osoba = ? AND typ = ?';

SET @id = 30;
SET @typ = 'sport';
EXECUTE wszytskieHobbyOsoby USING @id, @typ;
