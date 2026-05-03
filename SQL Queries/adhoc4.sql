/* 4.  Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields, 
segment 
product_count_2020 
product_count_2021 
difference */

WITH cte1 AS 
(SELECT p.segment, COUNT(DISTINCT CASE WHEN fiscal_year = 2020 THEN fsm.product_code END) AS products_count_2020,
	   COUNT(DISTINCT CASE WHEN fiscal_year = 2021 THEN fsm.product_code END) AS products_count_2021
FROM fact_sales_monthly fsm JOIN dim_product p USING (product_code)
GROUP BY p.segment)

SELECT segment, products_count_2020, products_count_2021, (products_count_2021 - products_count_2020) AS difference
FROM cte1
ORDER BY difference DESC;