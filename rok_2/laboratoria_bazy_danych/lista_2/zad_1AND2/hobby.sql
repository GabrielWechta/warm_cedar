CREATE TABLE IF NOT EXISTS hobby (
	osoba INT UNSIGNED NOT NULL,
	id INT UNSIGNED NOT NULL,
	typ ENUM ('sport','nauka','inne') NOT NULL,
	PRIMARY KEY (osoba, id, typ));
