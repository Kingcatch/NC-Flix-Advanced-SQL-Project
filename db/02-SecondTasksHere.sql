\c nc_flix

-- Query the database to find the number of films in stock for each genre.

SELECT genre_name, COUNT(stock.movie_id) AS movies_in_stock FROM genres g
JOIN movies_genres mg ON g.genre_id = mg.genre_id
JOIN movies ON movies.movie_id = mg.movie_id
JOIN stock ON stock.movie_id = movies.movie_id
GROUP BY genre_name;

-- Query the database to find the average rating for films in stock in Newcastle.

SELECT ROUND(AVG(m.rating), 2) AS average_rating
FROM movies m
JOIN stock ON m.movie_id = stock.movie_id 
JOIN stores ON stock.store_id = stores.store_id
WHERE stores.city = 'Newcastle';

-- Query the database to retrieve all the films released in the 90s that have a rating greater than the total average.

SELECT title, release_date, rating FROM movies m
WHERE release_date BETWEEN '1990-01-01' AND '1999-12-31' AND rating > (SELECT ROUND(AVG(m.rating), 2) AS average_rating
FROM movies m);

-- Query the database to find the total number of copies that are in stock for the top-rated film from a pool of the five most recently released films.


SELECT title, rating FROM movies
WHERE release_date IN (SELECT release_date FROM movies
ORDER BY release_date
DESC LIMIT 5)
ORDER BY rating
DESC LIMIT 1; -- Still need to add the total number of copies for the highest rated movie

-- Query the database to find a list of all the locations in which customers live that don't contain a store.


SELECT DISTINCT location FROM customers
WHERE location NOT IN (SELECT city FROM stores);

-- Query the database to find a list of all the locations we have influence over (locations of stores and/or customers). There should be no repeated data.

SELECT DISTINCT location FROM 
(SELECT location FROM customers
UNION
SELECT city from stores) AS area_of_influence;

-- From a list of our stores which have customers living in the same location, calculate which store has the largest catalogue of stock. What is the most abundant genre in that store?


-- SELECT COUNT(movies.title) FROM (
--     SELECT DISTINCT location FROM customers
--     WHERE location IN (SELECT city FROM stores)
--     );
-- ORDER BY store.stock_id
-- DESC LIMIT 1;

WITH biggest_catalogue AS (
    SELECT stock.store_id, COUNT(stock.stock_id) AS total_stock
    FROM stock
    JOIN stores ON stock.store_id = stores.store_id
    WHERE stores.city IN (
        SELECT DISTINCT location  FROM customers
    )
    GROUP BY stock.store_id
    ORDER BY total_stock 
    DESC LIMIT 1
),
all_stores AS (
    SELECT DISTINCT location FROM 
    (SELECT location FROM customers
    UNION SELECT city from stores) 
)

-- SELECT * FROM biggest_catalogue;


SELECT genre_name, COUNT(stock.movie_id) AS movies_in_stock FROM genres g
JOIN movies_genres mg ON g.genre_id = mg.genre_id
JOIN movies ON movies.movie_id = mg.movie_id
JOIN stock ON stock.movie_id = movies.movie_id
JOIN biggest_catalogue ON stock.store_id = biggest_catalogue.store_id
GROUP BY genre_name
ORDER BY movies_in_stock
DESC LIMIT 1;





    







