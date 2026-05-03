/* 7.  Get the complete report of the Gross sales amount for the customer  “Atliq 
Exclusive”  for each month.This analysis helps to  get an idea of low and 
high-performing months and take strategic decisions. 
The final report contains these columns: 
Month 
Year 
Gross sales Amount */

WITH cte AS (SELECT 
				fsm.*,
				g.gross_price,
				fsm.sold_quantity * gross_price AS gross_sales
		    FROM
				fact_sales_monthly fsm
					JOIN
				fact_gross_price g ON fsm.product_code = g.product_code
					AND fsm.fiscal_year = g.fiscal_year) 

SELECT cte.date, cte.fiscal_year, ROUND(SUM(cte.gross_sales),2) AS gross_sales
FROM cte JOIN dim_customer c USING (customer_code)
WHERE c.customer = 'Atliq Exclusive'
GROUP BY cte.date, cte.fiscal_year
ORDER BY cte.date