CREATE VIEW hobbiesAndNumber AS 
SELECT nazwa, osoba from nauka inner join hobby on nauka.id = hobby.id WHERE hobby.typ = "nauka"
UNION
SELECT nazwa, osoba from sport inner join hobby on sport.id = hobby.id WHERE hobby.typ = "sport"
UNION 
SELECT nazwa, osoba from inne inner join hobby on inne.id = hobby.id WHERE hobby.typ = "inne";

CREATE VIEW hobbiesAndMultiplicity AS
SELECT nazwa, COUNT(*) AS mnogosc FROM hobbiesAndNumber
GROUP BY nazwa;
