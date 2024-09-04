-- Create combined_orders view
CREATE VIEW combined_orders AS 
SELECT d.order_id, d.Amount, d.Profit, d.Quantity, d.Category, d.sub_category,
       l.order_date, l.State, l.CustomerName, l.City
FROM order_details AS d
JOIN order_list AS l
ON d.order_id = l.order_id;

-- Create customer_grouping view with corrected CASE logic
CREATE VIEW customer_grouping AS
SELECT CustomerName,
      CASE
    WHEN R >= 4 AND F >= 4 AND ((F+M)/2) >= 5 THEN 'Champions'
    WHEN R >= 4 AND F >= 3 AND ((F+M)/2) >= 4 THEN 'Loyal Customers'
    WHEN R >= 3 AND F >= 3 AND ((F+M)/2) >= 4 THEN 'Potential Loyalist'
    WHEN R >= 4 AND F >= 1 AND ((F+M)/2) >= 3 THEN 'New Customers'
    WHEN R >= 3 AND F >= 1 AND ((F+M)/2) >= 3 THEN 'Promising'
    WHEN R >= 2 AND F >= 1 AND ((F+M)/2) >= 3 THEN 'Customers Needing Attention'
    WHEN R >= 2 AND F >= 2 AND ((F+M)/2) >= 3 THEN 'About to Sleep'
    WHEN R >= 3 AND F = 1 AND ((F+M)/2) <= 2 THEN 'At Risk'
    WHEN R >= 2 AND F = 1 AND ((F+M)/2) <= 2 THEN 'Cant Lose Them'
    WHEN R >= 1 AND F >= 2 AND ((F+M)/2) <= 2 THEN 'Hibernating'
    WHEN R >= 1 AND F >= 1 AND ((F+M)/2) <= 2 THEN 'Lost'
END AS customer_segment

FROM (
    SELECT CustomerName,
           MAX(STR_TO_DATE(order_date, '%d-%m-%y')) AS lates_order_date,
           DATEDIFF(STR_TO_DATE('31-03-2019', '%d-%m-%y'), MAX(STR_TO_DATE(order_date, '%d-%m-%y'))) AS recency,
           COUNT(DISTINCT order_id) AS frequency,
           SUM(amount) AS monetary,
           NTILE(5) OVER (ORDER BY DATEDIFF(STR_TO_DATE('31-03-2019', '%d-%m-%y'), MAX(STR_TO_DATE(order_date, '%d-%m-%y'))) DESC) AS R,
           NTILE(5) OVER (ORDER BY COUNT(DISTINCT order_id) ASC) AS F,
           NTILE(5) OVER (ORDER BY SUM(amount) ASC) AS M
    FROM combined_orders
    GROUP BY CustomerName
) AS rfm_table;

-- Final result query with corrected GROUP BY and ORDER BY
SELECT customer_segment,
       COUNT(DISTINCT CustomerName) AS num_of_customers,
       ROUND(COUNT(DISTINCT CustomerName) * 100.0 / (SELECT COUNT(*) FROM customer_grouping), 2) AS pct_of_customers
FROM customer_grouping
GROUP BY customer_segment
ORDER BY pct_of_customers DESC;
