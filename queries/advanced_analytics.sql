

-- 1. Customer Lifetime Value with Ranking
SELECT c.customerId, CONCAT(c.firstName, ' ', c.lastName) AS customer_name,
       SUM(o.grandTotal) AS lifetime_value,
       RANK() OVER (ORDER BY SUM(o.grandTotal) DESC) AS rank
FROM Customers c
LEFT JOIN Orders o ON c.customerId = o.customerId
WHERE o.status IN ('delivered', 'shipped')
GROUP BY c.customerId
HAVING lifetime_value > 0;

-- 2. Monthly Sales Trends
SELECT DATE_FORMAT(o.orderDate, '%Y-%m') AS month, 
       SUM(o.grandTotal) AS monthly_revenue,
       COUNT(o.orderId) AS orders_count
FROM Orders o
WHERE o.status IN ('delivered', 'shipped')
GROUP BY month
ORDER BY month;

-- 3. Inventory Reorder Analysis
SELECT p.productName, b.brandName, pi.stockQuantity, pi.reorderLevel,
       CASE
           WHEN pi.stockQuantity <= pi.reorderLevel THEN 'Reorder Needed'
           ELSE 'Stock Sufficient'
       END AS status
FROM Product_item pi
JOIN Product_variation pv ON pi.variationId = pv.variationId
JOIN Product p ON pv.productId = p.productId
JOIN Brand b ON p.brandId = b.brandId
ORDER BY pi.stockQuantity ASC;

-- 4. Sales Forecasting (Simple Moving Average)
SELECT DATE_FORMAT(o.orderDate, '%Y-%m') AS month,
       SUM(o.grandTotal) AS revenue,
       AVG(SUM(o.grandTotal)) OVER (ORDER BY DATE_FORMAT(o.orderDate, '%Y-%m') ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM Orders o
WHERE o.status IN ('delivered', 'shipped')
GROUP BY month
ORDER BY month;
