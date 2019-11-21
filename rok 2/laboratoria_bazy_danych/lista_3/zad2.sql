used EXPLAIN *

SELECT plec FROM osoba WHERE imie LIKE "A%";
+----+-------------+-------+------------+-------+---------------+------------+---------+------+------+----------+-----------------------+
| id | select_type | table | partitions | type  | possible_keys | key        | key_len | ref  | rows | filtered | Extra                 |
+----+-------------+-------+------------+-------+---------------+------------+---------+------+------+----------+-----------------------+
|  1 | SIMPLE      | osoba | NULL       | range | Name_index    | Name_index | 22      | NULL |    1 |   100.00 | Using index condition |
+----+-------------+-------+------------+-------+---------------+------------+---------+------+------+----------+-----------------------+

SELECT nazwa FROM sport WHERE typ = "druzynowy" ORDER BY nazwa;
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra                       |
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+
|  1 | SIMPLE      | sport | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   16 |    33.33 | Using where; Using filesort |
+----+-------------+-------+------------+------+---------------+------+---------+------+------+----------+-----------------------------+

SELECT A.id, B.id FROM sport AS A INNER JOIN sport AS B ON A.lokacja = B.lokacja WHERE A.id > B.id AND A.lokacja IS NOT NULL AND A.typ = "indywidualny" ;
+----+-------------+-------+------------+------+-------------------------+------+---------+------+------+----------+------------------------------------------------+
| id | select_type | table | partitions | type | possible_keys           | key  | key_len | ref  | rows | filtered | Extra                                          |
+----+-------------+-------+------------+------+-------------------------+------+---------+------+------+----------+------------------------------------------------+
|  1 | SIMPLE      | A     | NULL       | ALL  | PRIMARY,IdAndName_index | NULL | NULL    | NULL |   16 |    90.00 | Using where                                    |
|  1 | SIMPLE      | B     | NULL       | ALL  | PRIMARY,IdAndName_index | NULL | NULL    | NULL |   16 |     6.25 | Range checked for each record (index map: 0x3) |
+----+-------------+-------+------------+------+-------------------------+------+---------+------+------+----------+------------------------------------------------+

SELECT imie FROM osoba WHERE dataUrodzenia < "2000-01-01";
+----+-------------+-------+------------+------+-----------------+------+---------+------+------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys   | key  | key_len | ref  | rows | filtered | Extra       |
+----+-------------+-------+------------+------+-----------------+------+---------+------+------+----------+-------------+
|  1 | SIMPLE      | osoba | NULL       | ALL  | BirthDate_index | NULL | NULL    | NULL |   14 |    85.71 | Using where |
+----+-------------+-------+------------+------+-----------------+------+---------+------+------+----------+-------------+

SELECT nazwa FROM hobbiesAndMultiplicity WHERE mnogosc IN (SELECT MAX(mnogosc) FROM hobbiesAndMultiplicity);
+----+--------------+----------------+------------+--------+-------------------------+---------+---------+----------------+------+----------+---------------------------------+
| id | select_type  | table          | partitions | type   | possible_keys           | key     | key_len | ref            | rows | filtered | Extra                           |
+----+--------------+----------------+------------+--------+-------------------------+---------+---------+----------------+------+----------+---------------------------------+
|  1 | PRIMARY      | <derived3>     | NULL       | ALL    | NULL                    | NULL    | NULL    | NULL           |    9 |   100.00 | Using where                     |
|  3 | DERIVED      | <derived4>     | NULL       | ALL    | NULL                    | NULL    | NULL    | NULL           |    9 |   100.00 | Using temporary; Using filesort |
|  4 | DERIVED      | hobby          | NULL       | index  | NULL                    | PRIMARY | 9       | NULL           |   11 |    33.33 | Using where; Using index        |
|  4 | DERIVED      | nauka          | NULL       | eq_ref | PRIMARY                 | PRIMARY | 4       | Hobby.hobby.id |    1 |   100.00 | NULL                            |
|  5 | UNION        | hobby          | NULL       | index  | NULL                    | PRIMARY | 9       | NULL           |   11 |    33.33 | Using where; Using index        |
|  5 | UNION        | sport          | NULL       | eq_ref | PRIMARY,IdAndName_index | PRIMARY | 4       | Hobby.hobby.id |    1 |   100.00 | NULL                            |
|  6 | UNION        | hobby          | NULL       | index  | NULL                    | PRIMARY | 9       | NULL           |   11 |    33.33 | Using where; Using index        |
|  6 | UNION        | inne           | NULL       | eq_ref | PRIMARY                 | PRIMARY | 4       | Hobby.hobby.id |    1 |   100.00 | NULL                            |
| NULL | UNION RESULT | <union4,5,6>   | NULL       | ALL    | NULL                    | NULL    | NULL    | NULL           | NULL |     NULL | Using temporary                 |
|  2 | SUBQUERY     | <derived8>     | NULL       | ALL    | NULL                    | NULL    | NULL    | NULL           |    9 |   100.00 | NULL                            |
|  8 | DERIVED      | <derived9>     | NULL       | ALL    | NULL                    | NULL    | NULL    | NULL           |    9 |   100.00 | Using temporary; Using filesort |
|  9 | DERIVED      | hobby          | NULL       | index  | NULL                    | PRIMARY | 9       | NULL           |   11 |    33.33 | Using where; Using index        |
|  9 | DERIVED      | nauka          | NULL       | eq_ref | PRIMARY                 | PRIMARY | 4       | Hobby.hobby.id |    1 |   100.00 | NULL                            |
| 10 | UNION        | hobby          | NULL       | index  | NULL                    | PRIMARY | 9       | NULL           |   11 |    33.33 | Using where; Using index        |
| 10 | UNION        | sport          | NULL       | eq_ref | PRIMARY,IdAndName_index | PRIMARY | 4       | Hobby.hobby.id |    1 |   100.00 | NULL                            |
| 11 | UNION        | hobby          | NULL       | index  | NULL                    | PRIMARY | 9       | NULL           |   11 |    33.33 | Using where; Using index        |
| 11 | UNION        | inne           | NULL       | eq_ref | PRIMARY                 | PRIMARY | 4       | Hobby.hobby.id |    1 |   100.00 | NULL                            |
| NULL | UNION RESULT | <union9,10,11> | NULL       | ALL    | NULL                    | NULL    | NULL    | NULL           | NULL |     NULL | Using temporary                 |
+----+--------------+----------------+------------+--------+-------------------------+---------+---------+----------------+------+----------+---------------------------------+

SELECT DISTINCT imie FROM osoba INNER JOIN zwierzak ON osoba.id = zwierzak.ID WHERE osoba.dataUrodzenia = (SELECT MIN(osoba.dataUrodzenia) FROM osoba INNER JOIN zwierzak ON osoba.id = zwierzak.ID);
+----+-------------+----------+------------+--------+--------------------------------+-------------+---------+-------------------+------+----------+------------------------------+
| id | select_type | table    | partitions | type   | possible_keys                  | key         | key_len | ref               | rows | filtered | Extra                        |
+----+-------------+----------+------------+--------+--------------------------------+-------------+---------+-------------------+------+----------+------------------------------+
|  1 | PRIMARY     | osoba    | NULL       | ref    | PRIMARY,Name_index,Birth_index | Birth_index | 3       | const             |    1 |   100.00 | Using where; Using temporary |
|  1 | PRIMARY     | zwierzak | NULL       | ref    | ID                             | ID          | 5       | Hobby.osoba.id    |    1 |   100.00 | Using index                  |
|  2 | SUBQUERY    | zwierzak | NULL       | index  | ID                             | ID          | 5       | NULL              |    5 |   100.00 | Using where; Using index     |
|  2 | SUBQUERY    | osoba    | NULL       | eq_ref | PRIMARY                        | PRIMARY     | 4       | Hobby.zwierzak.ID |    1 |   100.00 | NULL                         |
+----+-------------+----------+------------+--------+--------------------------------+-------------+---------+-------------------+------+----------+------------------------------+



