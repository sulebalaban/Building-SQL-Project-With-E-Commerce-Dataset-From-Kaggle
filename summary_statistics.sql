/*Find the number of orders,customers,cities and state*/
SELECT COUNT(DISTINCT order_id ) AS num_of_orders,
	   COUNT(DISTINCT CustomerName ) AS num_of_customers,
       COUNT(DISTINCT City ) AS  num_of_cities,
       COUNT(DISTINCT State ) AS num_of_states
FROM combined_orders;       
