/*Find the top 10 profitable states & cities so that the company can expand its business.
 Determine the number of products sold and the number of customers
 in these top 10 profitable states & cities.*/
 
 
 SELECT State,City, 
   COUNT(DISTINCT CustomerName) AS num_of_customers,
   Sum(Profit) AS total_profit,
   Sum(Quantity) AS  total_quantity 
FROM combined_orders
GROUP BY State,City 
ORDER BY total_profit DESC
LIMIT 10; 
 

