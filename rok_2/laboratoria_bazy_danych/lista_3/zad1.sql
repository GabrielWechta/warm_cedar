SHOW INDEX FROM hobby;

+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| hobby |          0 | PRIMARY  |            1 | osoba       | A         |          10 |     NULL | NULL   |      | BTREE      |         |               |
| hobby |          0 | PRIMARY  |            2 | id          | A         |          11 |     NULL | NULL   |      | BTREE      |         |               |
| hobby |          0 | PRIMARY  |            3 | typ         | A         |          11 |     NULL | NULL   |      | BTREE      |         |               |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+

#wszytskie indexy to primary keys.

SHOW INDEX FROM inne;

+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| Table | Non_unique | Key_name | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+
| inne  |          0 | PRIMARY  |            1 | id          | A         |          10 |     NULL | NULL   |      | BTREE      |         |               |
+-------+------------+----------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+

SHOW INDEX FROM nazwaHobby; #View
# Empty set ponieważ jest to tylko view, nieindeksowany.

|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

CREATE INDEX Name_index USING BTREE ON osoba (imie);
CREATE INDEX BirthDate_index USING BTREE ON osoba (dataUrodzenia);
CREATE INDEX IdAndName_index USING HASH ON sport (id, nazwa);
CREATE INDEX NameAndId_index USING BTREE ON inne (nazwa, id);
CREATE INDEX NameAndId2_index USING HASH ON inne (nazwa, id);
CREATE INDEX PersonAndIdAndType_index USING HASH ON hobby (osoba,id,typ);
