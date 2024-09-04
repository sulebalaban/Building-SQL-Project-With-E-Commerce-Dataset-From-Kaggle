-- top 5 new customers
SELECT CustomerName, State, City, SUM(Amount) AS sales
FROM combined_orders
WHERE CustomerName NOT IN (
       SELECT DISTINCT CustomerName
       FROM combined_orders
       WHERE YEAR(STR_TO_DATE(order_date, '%d-%m-%y')) = 2018
     )
GROUP BY CustomerName, State, City
ORDER BY sales DESC
LIMIT 5