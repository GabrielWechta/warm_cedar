CREATE TABLE IF NOT EXISTS sport (
	id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
	nazwa VARCHAR(20) NOT NULL,
	typ ENUM ('indywidualny','druzynowy','mieszany') NOT NULL DEFAULT 'druzynowy',
	lokacja VARCHAR(20));
