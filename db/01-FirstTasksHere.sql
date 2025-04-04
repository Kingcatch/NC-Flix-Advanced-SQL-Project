\c nc_flix

\echo 'Query the database to retrieve all of the movie titles that were released in the 21st century.\n'

SELECT title
FROM movies
WHERE release_date >= '2000-01-01';

\echo 'Query the database to find the oldest customer.\n'

SELECT customer_name, date_of_birth
FROM customers
ORDER BY date_of_birth ASC
LIMIT 1;

\echo 'Query the database to find the customers whose name begins with the letter D. Organise the results by age, youngest to oldest.\n'

SELECT customer_name, date_of_birth
FROM customers
WHERE customer_name LIKE 'D%'
ORDER BY date_of_birth DESC;

\echo 'Query the database to find the average rating of the movies released in the 1980s.\n'

SELECT ROUND(AVG(rating),2) AS average_rating
FROM movies
WHERE release_date BETWEEN '1980-01-01' AND '1989-12-31';

\echo 'Query the database to list the locations of our customers, as well as the total and average number of loyalty points for all customers. You can assume that if the loyalty points row is empty, they are a new customer so they should have the value set to zero.\n'

SELECT "location",
        SUM(COALESCE(loyalty_points,0)) AS total_points,
        ROUND(AVG(COALESCE(loyalty_points,0)),2) AS average_points
FROM customers
GROUP BY "location";

\echo 'The rise in living costs is affecting rentals. Drop the cost of all rentals by 5% and display the updated table. As this is a monetary value, make sure it is rounded to 2 decimal places.\n'

UPDATE movies
SET cost = ROUND(cost*0.95,2)
RETURNING *;



