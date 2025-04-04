\c nc_flix

\echo '1. Create an output to display the information on our customers. It should include:\n name\nlocation\nloyalty membership status\n'

SELECT customer_name, location, 
       CASE 
           WHEN loyalty_points = 0 THEN 'doesnt even go here'
           WHEN loyalty_points < 10 THEN 'bronze status'
           WHEN loyalty_points BETWEEN 10 AND 100 THEN 'silver status'
           WHEN loyalty_points > 100 THEN 'gold status'
           ELSE 'doesnt even go here'
       END AS loyalty_status
FROM customers;

\echo '2. We want more information on our customers:\nname\nage\nlocation\nloyalty points\nWe would also like to order them by location, and then within their location groups, order by number of loyalty points, high to low.\n'

SELECT 
    customer_name AS name, 
    ((now()::date - date_of_birth)/365) AS age, 
    location, 
    COALESCE(loyalty_points, 0) AS loyalty_points, 
    CASE 
        WHEN COALESCE(loyalty_points, 0) = 0 THEN 'doesnt even go here'
        WHEN COALESCE(loyalty_points, 0) < 10 THEN 'bronze status'
        WHEN COALESCE(loyalty_points, 0) BETWEEN 10 AND 100 THEN 'silver status'
        WHEN COALESCE(loyalty_points, 0) > 100 THEN 'gold status'
        ELSE 'doesnt even go here'
    END AS loyalty_status
FROM customers
ORDER BY location, loyalty_points DESC;