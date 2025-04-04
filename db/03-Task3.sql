\c nc_flix

\echo '1. Query the database to find the store with the highest total number of copies of sequels. Lets assume a film is a sequel if the title contains something like II or VI.\n'

SELECT * FROM movies
WHERE title ~ '\m(II|III|IV|V|VI|VII|VIII|IX|X)\M';

\echo '2. This is likely not a good way to identify sequels going forward. Alter the movies table to track this information better and then update the previous query to make use of this new structure.'


ALTER TABLE IF EXISTS movies
ADD COLUMN sequel_number INT;

UPDATE movies
SET sequel_number = CASE
    WHEN title LIKE '% II%' OR title LIKE '% II:%' THEN 2
    WHEN title LIKE '% III%' OR title LIKE '% III:%' THEN 3
    WHEN title LIKE '% IV%' OR title LIKE '% IV:%' THEN 4
    WHEN title LIKE '% V%' OR title LIKE '% V:%' THEN 5
    WHEN title LIKE '% VI%' OR title LIKE '% VI:%' THEN 6
    WHEN title LIKE '% VII%' OR title LIKE '% VII:%' THEN 7
    WHEN title LIKE '% VIII%' OR title LIKE '% VIII:%' THEN 8
    WHEN title LIKE '% IX%' OR title LIKE '% IX:%' THEN 9
    WHEN title LIKE '% X%' OR title LIKE '% X:%' THEN 10
    ELSE NULL
END;


\echo 'Updated query for store with highest total number of copies of sequels.\n'

SELECT stores.store_id, city, COUNT(stock_id) AS sequels_stocked FROM movies
JOIN stock ON movies.movie_id = stock.movie_id
JOIN stores ON stock.store_id = stores.store_id
WHERE sequel_number > 1
GROUP BY stores.store_id, city
ORDER BY sequels_stocked DESC;