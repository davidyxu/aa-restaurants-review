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