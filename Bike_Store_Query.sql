--Question 1. Which brand has the most products in the store? Write a query to display all the brands and the quantity of products of each brand.

SELECT brands.brand_id, brands.brand_name, SUM(stocks.quantity) AS total_quantity  
FROM brands 
JOIN products ON brands.brand_id=products.brand_id
JOIN stocks ON products.product_id=stocks.product_id
GROUP BY brands.brand_id
ORDER BY total_quantity DESC

-- Answer : Brand name 'TREK' with brand id '9' has the most products in the store with the quantity of 5519.


-- Question 2 : Which product is the most ordered? Write a query to display the name of the product and quantity.

SELECT products.product_name, SUM(order_items.quantity) AS order_volume
FROM order_items
JOIN products ON order_items.product_id=products.product_id
GROUP BY products.product_name
ORDER BY order_volume DESC
LIMIT 1

-- Answer : The most ordered product is 'Electra Cruiser 1 (24-Inch) - 2016' with order volume of 296.


-- Question 3 : Which product earned the most revenue? Write a query to display the name of the top 5 products that earned the most revenues.

SELECT products.product_name, SUM(order_items.quantity*order_items.list_price)-SUM(order_items.discount) AS net_revenue  
FROM order_items
JOIN products ON order_items.product_id=products.product_id
GROUP BY product_name
ORDER BY net_revenue DESC
LIMIT 5

-- Answer 3 : The product which earned the most revenue is 'Trek Slash 8 27.5 - 2016'.


-- Question 4 : In which product category were the most units sold?

SELECT categories.category_name, SUM(order_items.quantity) AS volume_sold  
FROM categories
JOIN products ON categories.category_id=products.category_id
JOIN order_items ON products.product_id=order_items.product_id
GROUP BY category_name
ORDER BY volume_sold DESC
LIMIT 1

-- Answer 4 : The most units were sold in category 'Cruisers Bicycles'.


-- Question 5 : Calculate the average bike price for each model year.

SELECT model_year, AVG(list_price) FROM products
GROUP BY model_year


-- Question 6 : How many staff are active in all stores?

SELECT COUNT(staff_id) FROM staffs

-- Answer 6 : 10


-- Question 7 : Who is the top manager?

SELECT * FROM staffs WHERE manager_id IS NULL

-- Answer 7 : Fabiola Jackson is the top manager.
-- Explanation : In the coloumn 'manager_id' in table 'staffs' look for the person whose manager id is null since the person is
--               top management and therefore no manager id is assigned to it.


-- Question 8 : Who are the managers in each store? Write a query to show their details.

SELECT * FROM staffs WHERE manager_id=1

-- Answer 8 : Managers of the store are as follows :
--            Mireya Copeland of store no. 1
--            Jannette David of store no.2
--            Kali Vargas of store no.3
-- Explanation : Look for people whose manager id is 1.


-- Question 9 : Write a query to show the list of employees in each store.

SELECT * FROM staffs 


-- Question 10 : Which state has the most customers? Write a query to return the number of customers from each state.

SELECT state, COUNT(customer_id) FROM customers
GROUP BY state 

-- Answer 10 : New York has the most customers.


-- Question 11 : Which customers have made the highest number of orders? Write a query to show customer's names with their numbers of orders.

SELECT customers.first_name, customers.last_name, COUNT(orders.customer_id) AS no_of_orders
FROM orders
JOIN customers ON orders.customer_id=customers.customer_id
GROUP BY customers.first_name, customers.last_name
ORDER BY no_of_orders DESC


-- Question 12 : Which is the latest order by a customer?

SELECT products.product_id, products.product_name, orders.order_date 
FROM orders
JOIN order_items ON orders.order_id=order_items.order_id
JOIN products ON order_items.product_id=products.product_id
ORDER BY order_date DESC
LIMIT 1

-- Answer 12 : Trek Verve+ Lowstep - 2018 is the latest order done on 2018-12-28.


-- Question 13 : Which orders are late-shipped?

SELECT * FROM orders
WHERE shipped_date > required_date


-- Question 14 : Which store has the most late-shipped orders? Write a query to return each store ID, store name, state, and number of late orders.

SELECT stores.store_id, stores.store_name, stores.state, COUNT(orders.store_id) AS late_shipped 
FROM orders
JOIN stores ON orders.store_id=stores.store_id
WHERE shipped_date > required_date
GROUP BY stores.store_id
ORDER BY late_shipped DESC

-- Answer 14 : Baldwin Bikes in New York with store id of 2 has most late-shipped orders.


-- Question 15 : Which store has the highest revenue? Write a query to return each store ID, store name, state, and revenue.

SELECT stores.store_id, stores.store_name, stores.state, SUM(order_items.quantity*order_items.list_price)-SUM(order_items.discount) AS net_revenue
FROM order_items
JOIN orders ON order_items.order_id=orders.order_id
JOIN stores ON orders.store_id=stores.store_id
GROUP BY stores.store_id
ORDER BY net_revenue DESC

-- Answer 15 : Baldwin Bikes in New York with store id of 2 has the highest revenue.