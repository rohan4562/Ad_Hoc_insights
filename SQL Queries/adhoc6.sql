/* 6.  Generate a report which contains the top 5 customers who received an 
average high  pre_invoice_discount_pct  for the  fiscal  year 2021  and in the 
Indian  market. The final output contains these fields, 
customer_code 
customer 
average_discount_percentage */

SELECT 
    c.customer_code,
    c.customer,
    pid.pre_invoice_discount_pct AS average_discount_precentage
FROM
    dim_customer c
        JOIN
    fact_pre_invoice_deductions pid USING (customer_code)
WHERE
    pid.fiscal_year = 2021
        AND c.market = 'India'
ORDER BY average_discount_precentage DESC
LIMIT 5;