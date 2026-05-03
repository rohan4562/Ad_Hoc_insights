/* 10.  Get the Top 3 products in each division that have a high 
total_sold_quantity in the fiscal_year 2021? The final output contains these 
fields, 
division 
product_code  
product 
total_sold_quantity 
rank_order */

WITH cte AS (SELECT p.division, fsm.product_code, CONCAT(p.product ,' [', p.variant, ']') AS product, 
		SUM(fsm.sold_quantity) AS total_sold_quantity, 
		dense_rank() OVER(PARTITION BY p.division ORDER BY SUM(fsm.sold_quantity) DESC) AS rank_order
FROM fact_sales_monthly fsm JOIN dim_product p ON fsm.product_code = p.product_code
WHERE fsm.fiscal_year = 2021
GROUP BY p.division, fsm.product_code)

SELECT *
FROM cte 
WHERE rank_order <= 3
