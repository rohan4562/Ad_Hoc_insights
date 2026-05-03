/* 5.  Get the products that have the highest and lowest manufacturing costs. 
The final output should contain these fields, 
product_code 
product 
manufacturing_cost */

SELECT p.product_code, p.product, manufacturing_cost
FROM dim_product p JOIN fact_manufacturing_cost m USING (product_code)
WHERE manufacturing_cost = (SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost)

UNION ALL

SELECT p.product_code, p.product, manufacturing_cost
FROM dim_product p JOIN fact_manufacturing_cost m USING (product_code)
WHERE manufacturing_cost = (SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost)

