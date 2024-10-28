\c nc_flix

SELECT title
FROM movies
WHERE release_date >= '2000-01-01';

SELECT customer_name, date_of_birth
FROM customers
ORDER BY date_of_birth ASC
LIMIT 1;

SELECT customer_name, date_of_birth
FROM customers
WHERE customer_name LIKE 'D%'
ORDER BY date_of_birth DESC;

SELECT ROUND(AVG(rating),2) AS average_rating
FROM movies
WHERE release_date BETWEEN '1980-01-01' AND '1989-12-31';

SELECT "location",
        SUM(COALESCE(loyalty_points,0)) AS total_points,
        ROUND(AVG(COALESCE(loyalty_points,0)),2) AS average_points
FROM customers
GROUP BY "location";

-- SELECT *
-- FROM movies;

-- UPDATE cost
-- SET cost = ROUND(cost*0.95,2)
-- FROM movies;

UPDATE movies
SET cost = ROUND(cost*0.95,2)
RETURNING *;

-- SELECT *
-- FROM movies;

