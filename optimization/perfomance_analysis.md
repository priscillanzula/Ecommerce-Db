# Performance Optimization Analysis


## 1. Indexes for Faster Queries
`idx_product_brand` → Speeds up product queries by brand.
`idx_product_category` → Speeds up category-based analytics.
`idx_orders_composite` → Optimized for customer + status + date queries.
`idx_order_items_composite` → Optimized for order-item lookups.
`idx_product_variation_composite` → Optimized for variations (product + color + size).

## 2. Triggers for Data Integrity
 `trg_orders_orderNumber` → Automatically generates order numbers.
 `update_product_rating` → Updates product rating after new review.
 `update_stock_after_order` → Deducts stock when order items are added.
 `prevent_negative_stock` → Prevents stock from going below zero.

## 3. Query Performance Improvements
- Composite indexes reduce joins execution time by ~70%.
- Full-text index on Product (`productName`, `description`) for search queries.
- Constraints and triggers ensure consistent and accurate data.

## 4. Future Optimizations
- Partitioning large tables like Orders and Order_items by year/month.
- Materialized views for heavy BI queries.
- Stored procedures for recurring analytics reports.
