CREATE TABLE chefs (
	id INTEGER PRIMARY KEY,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255) NOT NULL,
	mentor_id INTEGER,
	FOREIGN KEY (mentor_id) REFERENCES chef(id)
);

CREATE TABLE restaurants (
	id INTEGER PRIMARY KEY,
	neighborhood VARCHAR(255) NOT NULL,
	cuisine VARCHAR(255) NOT NULL
);

CREATE TABLE cheftenures (
	id INTEGER PRIMARY KEY,
	chef_id INTEGER NOT NULL,
	restaurant_id INTEGER NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE,
	head_chief INTEGER NOT NULL,
	FOREIGN KEY (restaurant_id) REFERENCES restaurant(id),
	FOREIGN KEY (chef_id) REFERENCES chef(id)
);

CREATE TABLE critics (
	id INTEGER PRIMARY KEY,
	screen_name VARCHAR(255) NOT NULL
);

CREATE TABLE restaurantreviews (
	id INTEGER PRIMARY KEY,
	restaurant_id INTEGER NOT NULL,
	critic_id INTEGER NOT NULL,
	text_review TEXT NOT NULL,
	score INTEGER NOT NULL,
	review_date DATE NOT NULL,
	FOREIGN KEY (restaurant_id) REFERENCES restaurant(id)
	FOREIGN KEY (critic_id) REFERENCES critic(id)
);