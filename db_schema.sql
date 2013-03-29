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
	cuisine VARCHAR(255) NOT NULL
);

CREATE TABLE cheftenure (
	id INTEGER PRIMARY KEY,
	chef_id INTEGER NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE,
	head_chief INTEGER NOT NULL,
	FOREIGN KEY (chef_id) REFERENCES chef(id)
);

CREATE TABLE critic (
	id INTEGER PRIMARY KEY,
	screen_name VARCHAR(255) NOT NULL
);

CREATE TABLE restaurantreview (
	id INTEGER PRIMARY KEY,
	restaurant_id INTEGER NOT NULL,
	critic_id INTEGER NOT NULL,
	text_review TEXT NOT NULL,
	score INTEGER NOT NULL,
	review_date DATE NOT NULL,
	FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
	FOREIGN KEY (critic_id) REFERENCES critic(id)
);

INSERT INTO chef (first_name, last_name, mentor)
VALUES ('Bob', 'Smith', NULL), ('Delish', 'Cook', 1);

INSERT INTO restaurant (neighborhood, cuisine)
VALUES ('yumville', 'yummy cuisine'), ('yuckville', 'yucky cuisine');

INSERT INTO cheftenure (chef_id, start_date, end_date, head_chief)
VALUES (1, '1999-12-20', NULL, 1),
			 (1, '2001-02-25', '2001-08-13', 0),
			 (2, '2002-01-02', NULL, 1);

INSERT INTO critic (screen_name)
VALUES ('hateful critic'), ('nice critic'), ('boring critic');

INSERT INTO restaurantreview (restaurant_id, critic_id, text_review, score, review_date)
VALUES (1, 1, 'horrible food', 1, '2012-05-05'),
			 (2, 1, 'terrible food', 1, '2013-03-02'),
			 (2, 2, 'amazing', 20, '2013-02-04'),
			 (1, 3, 'ok.', 10, '2013-03-15');