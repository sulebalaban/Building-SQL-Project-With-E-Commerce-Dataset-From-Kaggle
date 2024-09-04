ALTER TABLE order_details  CHANGE `Order ID` order_id VARCHAR(25);
ALTER TABLE order_details  CHANGE `Sub-Category`  sub_category  VARCHAR(25);
ALTER TABLE order_list  CHANGE  `Order ID` order_id VARCHAR(25);
ALTER TABLE order_list  CHANGE `Order Date` order_date VARCHAR(25);
ALTER TABLE sales_target   CHANGE `Month of Order Date` month_of_order VARCHAR(25);