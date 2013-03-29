INSERT INTO chefs (first_name, last_name, mentor_id)
VALUES ('Bob', 'Smith', NULL), ('Delish', 'Cook', 1),
       ('Jimmy', 'Jim', 1), ('Oompa', 'Loompa', 2);

INSERT INTO restaurants (neighborhood, cuisine)
VALUES ('yumville', 'yummy cuisine'), ('yuckville', 'yucky cuisine');

INSERT INTO cheftenures (chef_id, start_date, end_date, head_chief)
VALUES (1, '1999-12-20', NULL, 1),
			 (1, '2001-02-25', '2001-08-13', 0),
			 (2, '2002-01-02', NULL, 1);

INSERT INTO critics (screen_name)
VALUES ('hateful critic'), ('nice critic'), ('boring critic');

INSERT INTO restaurantreviews (restaurant_id, critic_id, text_review, score, review_date)
VALUES (1, 1, 'horrible food', 1, '2012-05-05'),
			 (2, 1, 'terrible food', 1, '2013-03-02'),
			 (2, 2, 'amazing', 20, '2013-02-04'),
			 (1, 3, 'ok.', 10, '2013-03-15');