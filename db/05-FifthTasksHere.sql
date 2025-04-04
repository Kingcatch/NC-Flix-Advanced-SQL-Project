\c nc_flix

\echo '\n1. Design a way of storing information on rentals. A rental should track the following information:\nrental_id\nstock_id\nrental_start\nrental_end\ncustomer_id\n'

CREATE TABLE rentals (
    rental_id SERIAL PRIMARY KEY,
    stock_id INT,
    rental_start DATE,
    rental_end DATE,
    customer_id INT
);

INSERT INTO rentals (stock_id,rental_start,rental_end,customer_id)
VALUES (1, now()::date, now()::date + 14, 1);

INSERT INTO rentals (stock_id,rental_start,rental_end,customer_id)
VALUES (2, now()::date -1, now()::date + 13, 2);

INSERT INTO rentals (stock_id,rental_start,rental_end,customer_id)
VALUES (36, now()::date -7, now()::date + 7, 3);

SELECT * FROM rentals;

\echo '\n2. Finally, we have a customer in one of our stores! They wish to rent a film but have some requirements:\n\nThe film must be age-appropriate (classification of U).\nThe film must be available in Birmingham.\nThe film must not have been rented more than 5 times already.\nInstead of creating a list of only the films that match this criteria, create an output that marks yes or no in a column that represents the requirement.\n'

SELECT 
    movies.title, 
    stores.city, 
    CASE
        WHEN movies.classification = 'U' 
        AND stores.city = 'Birmingham' 
        AND (SELECT COUNT(rental_id) FROM rentals WHERE rentals.stock_id = stock.stock_id) < 6
        THEN 'Yes'
        ELSE 'No'
    END AS suitable
FROM movies
LEFT JOIN stock ON movies.movie_id = stock.movie_id
LEFT JOIN rentals ON stock.stock_id = rentals.stock_id
LEFT JOIN stores ON stock.store_id = stores.store_id;