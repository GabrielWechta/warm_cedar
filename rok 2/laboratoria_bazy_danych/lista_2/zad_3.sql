zmodyfikowałem tabele zwierzak tak aby przedstawiala się następująco

+---------------+------------------+------+-----+---------+-------+
| Field         | Type             | Null | Key | Default | Extra |
+---------------+------------------+------+-----+---------+-------+
| name          | varchar(20)      | YES  |     | NULL    |       |
| ID            | int(10) unsigned | YES  | MUL | NULL    |       |
| species       | varchar(20)      | YES  |     | NULL    |       |
| sex           | char(1)          | YES  |     | NULL    |       |
| birth         | date             | YES  |     | NULL    |       |
| dataUrodzenia | varchar(20)      | NO   |     | NULL    |       |
| plec          | char(1)          | NO   |     | NULL    |       |
+---------------+------------------+------+-----+---------+-------+

następnie 
Insert INTO osoba (imie, dataUrodzenia, plec) (Select Distinct owner, dataUrodzenia, plec FROM zwierzak);

