CREATE TABLE chef (
	id INTEGER PRIMARY KEY,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	mentor INTEGER,
	FOREIGN KEY (mentor) REFERENCES chef(id)
);
CREATE TABLE restaurant (
	id INTEGER PRIMARY KEY,
	neighborhood VARCHAR(255) NOT NULL,
	cuisine VARCHAR 255 NOT NULL
);

CREATE TABLE cheftenure (
	id INTEGER PRIMARY KEY,
	chef_id INTEGER NOT NULL,
	start_date INTEGER NOT NULL,
	end_date INTEGER,
	head_chief INTEGER NOT NULL,
	FOREIGN KEY (chief_id) REFERENCES chief(id)
);

CREATE TABLE critic (
	id INTEGER PRIMARY KEY,
	screen_name VARCHAR(255) NOT NULL
);

CREATE TABLE restaurantreview (
	id INTEGER PRIMARY KEY,
	text_review TEXT NOT NULL,
	score INTEGER NOT NULL,
	review_date INTEGER NOT NULL
);

INSERT INTO chef (first_name, last_name, mentor)
VALUES ('Bob', 'Smith', NULL)

INSERT INTO restaurant (neighborhood, cuisine)
VALUES ('')

INSERT INTO cheftenure (start_date, end_date, head_chief)
