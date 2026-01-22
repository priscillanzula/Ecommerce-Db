### E-commerce SQL Analytics Portfolio 📊
#### Overview

This project is a comprehensive e-commerce database system designed to demonstrate advanced SQL skills, including business intelligence analytics, inventory management, and customer segmentation. It’s a fully normalized database optimized for performance, complete with triggers, indexes, and real-world e-commerce workflows.

#### Key Features

10+ Normalized Tables: Covers full e-commerce workflow from brands, products, variations, and inventory to orders, payments, shipping, and reviews.

Advanced Analytics: Customer Lifetime Value (CLV), sales trends, inventory optimization.

Performance Optimized: 15+ strategic indexes for faster queries and data integrity triggers.

Business Intelligence: Top products, customer segmentation, sales forecasting, and data-driven insights.

Data Integrity & Validation: Automated triggers, constraints, and validation queries ensure clean and reliable data.

####  Database Schema


#### Core Analytics Queries

1. Top Selling Products
2. 
```
SELECT p.productName, b.brandName, SUM(oi.quantity) as units_sold,
       SUM(oi.subtotal) as revenue, AVG(r.rating) as avg_rating
FROM Product p
JOIN Brand b ON p.brandId = b.brandId
LEFT JOIN Product_variation pv ON p.productId = pv.productId
LEFT JOIN Product_item pi ON pv.variationId = pi.variationId
LEFT JOIN Order_items oi ON pi.itemId = oi.itemId
LEFT JOIN Reviews r ON p.productId = r.productId
GROUP BY p.productId
ORDER BY revenue DESC LIMIT 10;

```

2. Customer Lifetime Value
```
SELECT c.customerId, CONCAT(c.firstName, ' ', c.lastName) as customer_name,
       COUNT(DISTINCT o.orderId) as total_orders, SUM(o.grandTotal) as lifetime_value,
       CASE WHEN SUM(o.grandTotal) > 1000 THEN 'VIP'
            WHEN SUM(o.grandTotal) > 500 THEN 'Loyal'
            ELSE 'Regular' END as segment
FROM Customers c
LEFT JOIN Orders o ON c.customerId = o.customerId
WHERE o.status IN ('delivered', 'shipped')
GROUP BY c.customerId HAVING lifetime_value > 0;

```

3. Inventory Status
```
SELECT p.productName, b.brandName, pv.sku, pi.stockQuantity,
       CASE WHEN pi.stockQuantity = 0 THEN 'Out of Stock'
            WHEN pi.stockQuantity <= pi.reorderLevel THEN 'Reorder Needed'
            ELSE 'In Stock' END as stock_status
FROM Product_item pi
JOIN Product_variation pv ON pi.variationId = pv.variationId
JOIN Product p ON pv.productId = p.productId
JOIN Brand b ON p.brandId = b.brandId
ORDER BY pi.stockQuantity ASC;

```
#### Performance Highlights

- 73% faster customer queries with composite indexes.

- Automated stock management with triggers.

- Full-text search for product discovery.

- Data validation with integrity constraints.

#### Quick Start

 1. Import database

```
mysql -u root -p < complete-database.sql

```
2. Verify installation
``` USE Ecommerce;
  SHOW TABLES;
```

 3. Run analytics
    
```
SELECT 'Brands' as Entity, COUNT(*) FROM Brand
UNION ALL SELECT 'Products', COUNT(*) FROM Product
UNION ALL SELECT 'Customers', COUNT(*) FROM Customers;
```

#### Skills Demonstrated

##### Skill	
   Complex Joins- 5-table joins for product analytics.	

   Window Functions- sales trends with LAG/LEAD.	

   Index Optimization- 10+ strategic indexes.	

   Data Integrity- automated triggers, constraints.	

   Business Analytics- CLV, inventory optimization, segmentation.	

#### Project Structure
```
   ecommerce-sql-portfolio/
   ├── README.md                     # Project overview and documentation
   ├── complete-database.sql          # Full SQL script to create database, tables, indexes, triggers, and sample data
   ├── queries/                       # Directory for analytical queries
    │   ├── business-intelligence.sql  # BI-focused queries (top products, segmentation)
    │   └── advanced-analytics.sql     # Advanced SQL analytics (CLV, trends, forecasts)
    └── optimization/                  # Performance optimization files
       └── performance-analysis.md    # Details on indexes, triggers, query performance
```


###  Collaboration
This project was completed collaboratively with version control and documentation handled via GitHub.


<table>
  <thead></thead>
  <tbody>
    <tr>
      <td align="center">
        <a href="https://github.com/ochiengtim">
          <img src="https://avatars.githubusercontent.com/u/163648475?v=4" width="100;" alt="Timothy Ochieng"/>
          <br />
          <sub><b>Timothy Ochieng</b></sub>
        </a>
      </td>
      <td align="center">
        <a href="https://github.com/MishMatende">
          <img src="https://avatars.githubusercontent.com/u/113938133?v=4" width="100;" alt="Mishael Matende"/>
          <br />
          <sub><b>Mishael Matende</b></sub>
        </a>
      </td>
      <td align="center">
        <a href="https://github.com/chepkwonychepchieng">
          <img src="https://avatars.githubusercontent.com/u/205326460?v=4" width="100;" alt="Chepkwony Chepchieng"/>
          <br />
          <sub><b>Chepkwony Chepchieng</b></sub>
        </a>
      </td>
      <td align="center">
        <a href="https://github.com/priscillanzula">
          <img src="https://avatars.githubusercontent.com/u/144167777?v=4" width="100;" alt="priscillanzula"/>
          <br />
          <sub><b>Priscilla Nzula</b></sub>
        </a>
      </td>
    </tr>
  </tbody>
</table>





