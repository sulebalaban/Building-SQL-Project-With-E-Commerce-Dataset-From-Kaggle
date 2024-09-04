/* display the details (in terms of “order_date”, “order_id”, “State”, and “CustomerName”) for the first order in each state.
 Order the result by “order_id”.*/
 
 SELECT order_date,order_id,State,CustomerName
 FROM (SELECT*, ROW_NUMBER () OVER (PARTITION BY State ORDER BY State ,order_id)
       AS RowNumberPerState 
 FROM combined_orders) firstorder
 WHERE RowNumberPerState=1
 ORDER BY order_id;