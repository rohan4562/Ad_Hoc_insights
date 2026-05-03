/* 9.  Which channel helped to bring more gross sales in the fiscal year 2021 
and the percentage of contribution?  The final output  contains these fields, 
channel 
gross_sales_mln 
percentage  */

WITH cte AS (SELECT c.channel, fsm.sold_quantity*g.gross_price AS gross_sales
FROM fact_sales_monthly fsm JOIN dim_customer c ON fsm.customer_code = c.customer_code JOIN fact_gross_price g ON fsm.product_code = g.product_code
	AND fsm.fiscal_year = g.fiscal_year
WHERE fsm.fiscal_year = 2021)

SELECT channel, CONCAT(ROUND(SUM(gross_sales/1000000),2), 'M') AS gross_sales_mln, 
		CONCAT(ROUND((SUM(gross_sales))*100/(SELECT SUM(gross_sales) FROM cte),2), '%') AS percentage
FROM cte
GROUP BY channel
ORDER BY percentage DESC
