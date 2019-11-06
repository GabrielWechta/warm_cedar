CREATE VIEW personAndHobbyAndAnimals AS
SELECT imie, nazwisko, nazwa FROM osoba INNER JOIN nazwyHobby ON osoba.id = nazwyHobby.osoba
UNION 
SELECT imie, nazwisko, name AS nazwa FROM osoba INNER JOIN zwierzak ON osoba.id = zwierzak.ID; 
