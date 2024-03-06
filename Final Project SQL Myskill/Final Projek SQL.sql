-- Question 1
SELECT 
	month(order_date) as month,
	sum(after_discount) as Total_2021_after_discount 
from final_project.order_detail
WHERE 
	order_date BETWEEN '2021-01-01' and '2021-12-31'
    and is_valid=1
GROUP by month 
order by sum(after_discount) DESC

# Question 2

Select DISTINCT sku_detail.category,
  sum(after_discount) as Total_2022_after_discount
from order_detail 
LEFT join sku_detail 
on order_detail.sku_id = sku_detail.id
where 
	order_date BETWEEN '2022-01-01' and '2022-12-31'
    and is_valid=1
GROUP by  sku_detail.category
ORDER by sum(after_discount) DESC

# Question 3

WITH sales_revenue AS 
(SELECT 
	sd.category,
	sum(CASE WHEN EXTRACT(YEAR from order_date) = 2021 then after_discount END) as revenue_2021,
 	sum(CASE WHEN EXTRACT(YEAR from order_date) = 2022 then after_discount END) as revenue_2022
FROM order_detail od
LEFT JOIN sku_detail sd
ON od.sku_id = sd.id
WHERE 
 	EXTRACT(YEAR from order_date) in (2021,2022)
 	and is_valid = 1
GROUP BY sd.category
ORDER by 2,3 DESC)
SELECT
	*,
	(revenue_2022 - revenue_2021) as revenue_diff
from sales_revenue
ORDER by revenue_diff DESC

# Question 4

SELECT 
    pd.payment_method,
    count(DISTINCT(od.id)) as nou_order
from order_detail od
left join payment_detail pd
ON od.payment_id = pd.id
where 
	order_date BETWEEN '2022-01-01' AND '2022-12-31'
    and is_valid = 1
GROUP by payment_method
ORDER by nou_order DESC
LIMIT 5

# Question 5

SELECT 
	CASE 
    WHEN LOWER(sku_name) LIKE '%samsung%' THEN 'Samsung'
    WHEN LOWER(sku_name) LIKE '%macbook%' 
    or LOWER(sku_name) LIKE '%iphone%' 
    or LOWER(sku_name) LIKE '%apple%' then 'Apple'
    WHEN LOWER(sku_name) LIKE '%sony%' THEN 'Sony'
    WHEN LOWER(sku_name) LIKE '%huawei%' THEN 'Huawei'
    WHEN LOWER(sku_name) LIKE '%lenovo%' THEN 'Lenovo'
    end as brand,
    sum(after_discount) as total_revenue
from order_detail od
left join sku_detail sd
on od.sku_id = sd.id
WHERE 
	is_valid = 1 and (LOWER(sku_name) LIKE '%samsung%'
    or LOWER(sku_name) LIKE '%macbook%' or LOWER(sku_name) LIKE '%iphone%'
    or LOWER(sku_name) LIKE '%apple%' or LOWER(sku_name) LIKE '%sony%'
    or LOWER(sku_name) LIKE '%huawei%' or LOWER(sku_name) LIKE '%lenovo%')
GROUP by brand
ORDER by total_revenue DESC




