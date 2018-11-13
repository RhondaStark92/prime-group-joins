-- Get all customers and their addresses.
SELECT * from customers
JOIN addresses ON customers.id = addresses.customer_id
ORDER BY customers.id

-- Get all orders and their line items (orders, quantity and product).
SELECT orders.id, line_items.quantity, products.description from orders
JOIN line_items ON orders.id = line_items.order_id
JOIN products ON line_items.product_id = products.id
order by orders.id


-- Which warehouses have cheetos?
SELECT warehouse.warehouse from warehouse
JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
JOIN products ON warehouse_product.product_id = products.id
WHERE products.description LIKE 'cheetos'

-- Which warehouses have diet pepsi?
SELECT warehouse.warehouse from warehouse
JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
JOIN products ON warehouse_product.product_id = products.id
WHERE products.description LIKE 'diet pepsi'

-- Get the number of orders for each customer. 
-- NOTE: It is OK if those without orders are not included in results.
SELECT addresses.customer_id, customers.first_name, customers.last_name, count(addresses.customer_id) FROM orders
JOIN addresses ON orders.address_id = addresses.id
JOIN customers on customers.id = addresses.customer_id
GROUP BY addresses.customer_id, customers.first_name, customers.last_name

-- How many customers do we have?
SELECT COUNT(*) FROM customers

-- How many products do we carry?
SELECT COUNT(*) FROM products

-- What is the total available on-hand quantity of diet pepsi?
SELECT SUM(warehouse_product.on_hand) FROM warehouse
JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
JOIN products ON warehouse_product.product_id = products.id
WHERE products.description LIKE 'diet pepsi'
GROUP BY warehouse_product.product_id

-- STRETCH GOALS
-- How much was the total cost for each order?
SELECT SUM(products.unit_price * line_items.quantity) as order_total, orders.id 
from orders
JOIN line_items ON orders.id = line_items.order_id
JOIN products ON line_items.product_id = products.id
group by orders.id 

-- How much has each customer spent in total?
SELECT SUM(products.unit_price * line_items.quantity) as order_total, customers.id 
FROM orders
JOIN line_items ON orders.id = line_items.order_id
JOIN products ON line_items.product_id = products.id
JOIN addresses ON orders.address_id = addresses.id
JOIN customers on customers.id = addresses.customer_id
GROUP BY customers.id

-- How much has each customer spent in total? Customers who have 
-- spent $0 should still show up in the table. It should say 0, 
-- not NULL (research coalesce).

