DROP PROCEDURE IF EXISTS magic;

DELIMITER $$
CREATE PROCEDURE magic(IN job VARCHAR(30))
BEGIN
	DECLARE job_id INT UNSIGNED;
	DECLARE average, my_max, my_min DECIMAL(30,10);
	DECLARE epsilon DECIMAL(30,10) DEFAULT 0.03;
	DECLARE magic_average DECIMAL(30,10) DEFAULT -1.0;

	SET job_id = (SELECT id FROM zawody WHERE nazwa = job); 
	SET average = (SELECT AVG(zarobki) FROM praca WHERE id_zawody = job_id);
	SET my_max = (SELECT pensja_max FROM zawody WHERE nazwa = job);
	SET my_min = (SELECT pensja_min FROM zawody WHERE nazwa = job);
	
	WHILE magic_average NOT BETWEEN my_min AND my_max
	DO
		SET epsilon = rand() * 0.06 - 0.03 + 1.0;
		SET magic_average = average * epsilon;
	END WHILE;

	SELECT average, my_min, my_max, magic_average;
END; $$

DELIMITER ;
