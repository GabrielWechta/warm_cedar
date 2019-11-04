alter table zwierzak add foreign key (ID) REFERENCES osoba(id) 
    -> ON DELETE CASCADE
    -> ON UPDATE CASCADE;
alter table hobby add foreign key (osoba) REFERENCES osoba(id) 
    -> ON DELETE CASCADE
    -> ON UPDATE CASCADE;

