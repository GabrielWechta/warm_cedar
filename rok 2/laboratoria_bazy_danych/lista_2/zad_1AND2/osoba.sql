CREATE TABLE IF NOT EXISTS osoba (
	id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
	imie VARCHAR(20) NOT NULL,
	dataUrodzenia DATE NOT NULL,
	plec CHAR(1) NOT NULL);