-- Sample complex queries for portfolio demonstration
SELECT ' SAMPLE BUSINESS INTELLIGENCE QUERIES ' AS Info;

-- 1. Top Selling Products
SELECT 
    p.productName,
    b.brandName,
    SUM(oi.quantity) as total_units_sold,
    SUM(oi.subtotal) as total_revenue,
    AVG(r.rating) as avg_rating
FROM Product p
JOIN Brand b ON p.brandId = b.brandId
LEFT JOIN Product_variation pv ON p.productId = pv.productId
LEFT JOIN Product_item pi ON pv.variationId = pi.variationId
LEFT JOIN Order_items oi ON pi.itemId = oi.itemId
LEFT JOIN Reviews r ON p.productId = r.productId
GROUP BY p.productId
ORDER BY total_revenue DESC
LIMIT 10;

-- 2. Customer Lifetime Value
SELECT 
    c.customerId,
    CONCAT(c.firstName, ' ', c.lastName) as customer_name,
    c.email,
    COUNT(DISTINCT o.orderId) as total_orders,
    SUM(o.grandTotal) as lifetime_value,
    AVG(o.grandTotal) as avg_order_value,
    MAX(o.orderDate) as last_order_date,
    DATEDIFF(NOW(), MIN(o.orderDate)) as days_as_customer
FROM Customers c
LEFT JOIN Orders o ON c.customerId = o.customerId
WHERE o.status IN ('delivered', 'shipped')
GROUP BY c.customerId
HAVING lifetime_value > 0
ORDER BY lifetime_value DESC;

-- 3. Inventory Report
SELECT 
    p.productName,
    b.brandName,
    pc.categoryName,
    pv.sku,
    pi.stockQuantity,
    pi.reorderLevel,
    CASE 
        WHEN pi.stockQuantity = 0 THEN 'Out of Stock'
        WHEN pi.stockQuantity <= pi.reorderLevel THEN 'Reorder Needed'
        ELSE 'In Stock'
    END as stock_status,
    (SELECT SUM(quantity) FROM Order_items oi WHERE oi.itemId = pi.itemId) as units_sold
FROM Product_item pi
JOIN Product_variation pv ON pi.variationId = pv.variationId
JOIN Product p ON pv.productId = p.productId
JOIN Brand b ON p.brandId = b.brandId
JOIN Product_category pc ON p.categoryId = pc.categoryId
ORDER BY stockQuantity ASC;