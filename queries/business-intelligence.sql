

-- 1. Top 10 Selling Products
SELECT p.productName, b.brandName, SUM(oi.quantity) AS units_sold,
       SUM(oi.subtotal) AS revenue, AVG(r.rating) AS avg_rating
FROM Product p
JOIN Brand b ON p.brandId = b.brandId
LEFT JOIN Product_variation pv ON p.productId = pv.productId
LEFT JOIN Product_item pi ON pv.variationId = pi.variationId
LEFT JOIN Order_items oi ON pi.itemId = oi.itemId
LEFT JOIN Reviews r ON p.productId = r.productId
GROUP BY p.productId
ORDER BY revenue DESC
LIMIT 10;

-- 2. Customer Segmentation by Lifetime Value
SELECT c.customerId, CONCAT(c.firstName, ' ', c.lastName) AS customer_name,
       SUM(o.grandTotal) AS lifetime_value,
       CASE 
           WHEN SUM(o.grandTotal) > 1000 THEN 'VIP'
           WHEN SUM(o.grandTotal) > 500 THEN 'Loyal'
           ELSE 'Regular' 
       END AS segment
FROM Customers c
LEFT JOIN Orders o ON c.customerId = o.customerId
WHERE o.status IN ('delivered', 'shipped')
GROUP BY c.customerId
HAVING lifetime_value > 0;

-- 3. Revenue per Category
SELECT pc.categoryName, SUM(oi.subtotal) AS revenue
FROM Product_category pc
JOIN Product p ON pc.categoryId = p.categoryId
JOIN Product_variation pv ON p.productId = pv.productId
JOIN Product_item pi ON pv.variationId = pi.variationId
JOIN Order_items oi ON pi.itemId = oi.itemId
GROUP BY pc.categoryId
ORDER BY revenue DESC;

-- 4. Top 5 Customers by Orders
SELECT c.customerId, CONCAT(c.firstName, ' ', c.lastName) AS customer_name,
       COUNT(o.orderId) AS total_orders
FROM Customers c
JOIN Orders o ON c.customerId = o.customerId
GROUP BY c.customerId
ORDER BY total_orders DESC
LIMIT 5;
