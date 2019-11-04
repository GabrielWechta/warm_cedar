ALTER TABLE zwierzak ADD COLUMN ID INT UNSIGNED AFTER owner;

Update zwierzak 
    -> inner join osoba on zwierzak.owner = osoba.imie
    -> Set zwierzak.ID = osoba.id ;

