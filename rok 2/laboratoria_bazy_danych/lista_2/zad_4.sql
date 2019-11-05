ALTER TABLE zwierzak ADD COLUMN ID INT UNSIGNED AFTER owner;

ALTER TABLE osoba ADD COLUMN nazwisko VARCHAR(50) NULL;

Update zwierzak 
    -> inner join osoba on zwierzak.owner = osoba.imie
    -> Set zwierzak.ID = osoba.id ;

