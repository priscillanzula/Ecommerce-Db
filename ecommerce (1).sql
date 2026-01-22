-- ============================================
-- E-COMMERCE DATABASE SCHEMA - ENHANCED VERSION
-- ============================================
-- Features:
-- 1. 25 brands from 15+ countries
-- 2. Fixed all data inconsistencies
-- 3. Added performance indexes
-- 4. Complete sample data
-- 5. Proper foreign key relationships
-- ============================================

-- Create database
CREATE DATABASE IF NOT EXISTS Ecommerce;
USE Ecommerce;

-- ============================================
-- 1. BRAND TABLE - Enhanced with global brands
-- ============================================
CREATE TABLE Brand (
    brandId INT PRIMARY KEY AUTO_INCREMENT,
    brandName VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    country VARCHAR(100) NOT NULL,
    foundedYear INT,
    website VARCHAR(255),
    INDEX idx_brand_country (country)
);

INSERT INTO Brand (brandName, description, country, foundedYear, website) VALUES
-- North America
('Nike', 'Sportswear and athletic gear manufacturer', 'USA', 1964, 'nike.com'),
('Apple', 'Consumer electronics and software', 'USA', 1976, 'apple.com'),
('Dell', 'Computer technology corporation', 'USA', 1984, 'dell.com'),
('Google', 'Technology and internet services', 'USA', 1998, 'google.com'),
('IBM', 'Technology and consulting services', 'USA', 1911, 'ibm.com'),
('Microsoft', 'Software and technology company', 'USA', 1975, 'microsoft.com'),
('Tesla', 'Electric vehicles and clean energy', 'USA', 2003, 'tesla.com'),
('Amazon', 'E-commerce and cloud computing', 'USA', 1994, 'amazon.com'),

-- Europe
('Adidas', 'Sportswear and athletic shoes', 'Germany', 1949, 'adidas.com'),
('IKEA', 'Furniture and home accessories', 'Sweden', 1943, 'ikea.com'),
('Philips', 'Electronics and healthcare', 'Netherlands', 1891, 'philips.com'),
('Nokia', 'Telecommunications and technology', 'Finland', 1865, 'nokia.com'),
('Bose', 'Audio equipment manufacturer', 'USA', 1964, 'bose.com'),
('Samsung', 'Electronics and appliances', 'South Korea', 1938, 'samsung.com'),

-- Asia
('Sony', 'Electronics and entertainment', 'Japan', 1946, 'sony.com'),
('Toyota', 'Automobile manufacturer', 'Japan', 1937, 'toyota.com'),
('Huawei', 'Telecommunications equipment', 'China', 1987, 'huawei.com'),
('Xiaomi', 'Electronics and smartphones', 'China', 2010, 'mi.com'),
('Infinix', 'Smartphones and electronics', 'China', 2013, 'infinixmobility.com'),
('Lenovo', 'Computers and electronics', 'China', 1984, 'lenovo.com'),
('LG', 'Electronics and home appliances', 'South Korea', 1947, 'lg.com'),
('Canon', 'Camera and imaging equipment', 'Japan', 1937, 'canon.com'),

-- Other regions
('Natura', 'Cosmetics and beauty products', 'Brazil', 1969, 'natura.com.br'),
('Jumia', 'E-commerce platform', 'Nigeria', 2012, 'jumia.com'),
('Safaricom', 'Telecommunications services', 'Kenya', 1997, 'safaricom.co.ke');

-- ============================================
-- 2. PRODUCT CATEGORY TABLE
-- ============================================
CREATE TABLE Product_category (
    categoryId INT PRIMARY KEY AUTO_INCREMENT,
    categoryName VARCHAR(100) NOT NULL,
    description TEXT,
    slug VARCHAR(100) UNIQUE NOT NULL,
    parentCategoryId INT NULL,
    INDEX idx_category_slug (slug),
    INDEX idx_category_parent (parentCategoryId),
    FOREIGN KEY (parentCategoryId) REFERENCES Product_category(categoryId)
);

INSERT INTO Product_category (categoryName, description, slug, parentCategoryId) VALUES
('Electronics', 'Electronic devices and accessories', 'electronics', NULL),
('Mobile Phones', 'Smartphones and feature phones', 'mobile-phones', 1),
('Laptops & Computers', 'Computers and computing devices', 'laptops-computers', 1),
('Audio & Headphones', 'Audio equipment and headphones', 'audio-headphones', 1),

('Fashion', 'Clothing and fashion accessories', 'fashion', NULL),
('Footwear', 'Shoes, sneakers, and sandals', 'footwear', 5),
('Men''s Clothing', 'Clothing for men', 'mens-clothing', 5),
('Women''s Clothing', 'Clothing for women', 'womens-clothing', 5),

('Home & Living', 'Home appliances and furniture', 'home-living', NULL),
('Home Appliances', 'Kitchen and home appliances', 'home-appliances', 9),
('Furniture', 'Home and office furniture', 'furniture', 9),
('Kitchenware', 'Kitchen tools and utensils', 'kitchenware', 9),

('Beauty & Personal Care', 'Cosmetics and personal care', 'beauty-personal-care', NULL),
('Skincare', 'Skin care products', 'skincare', 13),
('Makeup', 'Cosmetics and makeup', 'makeup', 13),
('Fragrances', 'Perfumes and colognes', 'fragrances', 13),

('Sports & Outdoors', 'Sports equipment and outdoor gear', 'sports-outdoors', NULL),
('Fitness Equipment', 'Exercise and fitness gear', 'fitness-equipment', 17),
('Outdoor Gear', 'Camping and hiking equipment', 'outdoor-gear', 17);

-- ============================================
-- 3. PRODUCT TABLE
-- ============================================
CREATE TABLE Product (
    productId INT PRIMARY KEY AUTO_INCREMENT,
    brandId INT NOT NULL,
    categoryId INT NOT NULL,
    productName VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    discountPercent DECIMAL(5,2) DEFAULT 0.00 CHECK (discountPercent BETWEEN 0 AND 100),
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    isActive BOOLEAN DEFAULT TRUE,
    avgRating DECIMAL(3,2) DEFAULT 0.00 CHECK (avgRating BETWEEN 0 AND 5),
    totalReviews INT DEFAULT 0,
    INDEX idx_product_brand (brandId),
    INDEX idx_product_category (categoryId),
    INDEX idx_product_price (price),
    INDEX idx_product_active (isActive),
    FULLTEXT INDEX idx_product_search (productName, description),
    FOREIGN KEY (brandId) REFERENCES Brand(brandId),
    FOREIGN KEY (categoryId) REFERENCES Product_category(categoryId)
);

-- Insert 30 diverse products
INSERT INTO Product (brandId, categoryId, productName, description, price, discountPercent) VALUES
-- Electronics - Mobile Phones
(14, 2, 'Samsung Galaxy S24', 'Flagship smartphone with AI features', 999.99, 10.00),
(6, 2, 'Apple iPhone 15 Pro', 'Professional-grade smartphone', 1199.00, 5.00),
(19, 2, 'Xiaomi Redmi Note 13', 'Budget smartphone with great camera', 299.99, 15.00),
(20, 2, 'Infinix Hot 40', 'Gaming smartphone with fast processor', 199.99, 20.00),

-- Electronics - Laptops
(3, 3, 'Dell XPS 15', 'Premium laptop for professionals', 1499.00, 8.00),
(21, 3, 'Lenovo ThinkPad X1', 'Business laptop with security features', 1299.00, 12.00),
(4, 3, 'Google Pixelbook Go', 'Lightweight Chromebook', 799.00, 10.00),

-- Electronics - Audio
(13, 4, 'Bose QuietComfort 45', 'Noise-cancelling headphones', 329.00, 15.00),
(15, 4, 'Sony WH-1000XM5', 'Premium wireless headphones', 399.99, 10.00),
(22, 4, 'LG Tone Free', 'True wireless earbuds', 149.99, 20.00),

-- Fashion - Footwear
(1, 6, 'Nike Air Max 270', 'Comfortable running shoes', 150.00, 25.00),
(9, 6, 'Adidas Ultraboost 22', 'Responsive running shoes', 180.00, 20.00),

-- Fashion - Clothing
(1, 7, 'Nike Dri-FIT T-Shirt', 'Moisture-wicking workout shirt', 29.99, 10.00),
(9, 8, 'Adidas Originals Hoodie', 'Classic sports hoodie', 69.99, 15.00),

-- Home Appliances
(11, 10, 'Philips Air Fryer XXL', 'Large capacity air fryer', 199.99, 30.00),
(22, 10, 'LG Smart Refrigerator', 'Wi-Fi enabled refrigerator', 1899.00, 5.00),
(12, 10, 'Nokia Smart TV 55"', '4K Android TV', 599.00, 20.00),

-- Furniture
(10, 11, 'IKEA MALM Bed', 'Queen size bed frame', 299.00, 15.00),
(10, 11, 'IKEA POÄNG Chair', 'Comfortable armchair', 79.99, 10.00),

-- Beauty & Personal Care
(23, 14, 'Natura Ekos Body Lotion', 'Moisturizing body lotion', 24.99, 10.00),
(23, 15, 'Natura Una Lipstick', 'Long-lasting lipstick', 18.99, 15.00),

-- Sports & Outdoors
(1, 18, 'Nike Training Mat', 'Non-slip yoga mat', 39.99, 20.00),
(9, 19, 'Adidas Camping Tent', '4-person waterproof tent', 199.99, 25.00),

-- Other products
(7, 1, 'Tesla Powerwall', 'Home battery storage', 7500.00, 0.00),
(8, 3, 'Amazon Fire Tablet', 'Affordable tablet', 89.99, 30.00),
(16, 1, 'Toyota Smart Key', 'Keyless entry system', 249.99, 10.00),
(24, 2, 'Canon EOS R6', 'Professional mirrorless camera', 2499.00, 5.00),
(25, 1, 'Jumia Voucher', 'E-commerce gift card', 50.00, 0.00),
(26, 2, 'Safaricom M-PESA Phone', 'Mobile money phone', 79.99, 15.00);

-- ============================================
-- 4. COLOR TABLE
-- ============================================
CREATE TABLE Color (
    colorId INT PRIMARY KEY AUTO_INCREMENT,
    colorName VARCHAR(100) NOT NULL UNIQUE,
    hexValue VARCHAR(7) NOT NULL,
    INDEX idx_color_name (colorName)
);

INSERT INTO Color (colorName, hexValue) VALUES
('Black', '#000000'),
('White', '#FFFFFF'),
('Red', '#FF0000'),
('Blue', '#0000FF'),
('Gray', '#808080'),
('Silver', '#C0C0C0'),
('Gold', '#FFD700'),
('Rose Gold', '#B76E79'),
('Space Gray', '#717378'),
('Midnight Green', '#004953'),
('Starlight', '#F8F9FA'),
('Graphite', '#251607'),
('Sierra Blue', '#9BB5CE'),
('Deep Purple', '#5D3A6B'),
('Green', '#008000'),
('Yellow', '#FFFF00'),
('Orange', '#FFA500'),
('Pink', '#FFC0CB'),
('Brown', '#A52A2A'),
('Navy Blue', '#000080');

-- ============================================
-- 5. SIZE CATEGORY & SIZE OPTION TABLES
-- ============================================
CREATE TABLE Size_category (
    size_categoryId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE,
    unit VARCHAR(20) NOT NULL,
    description TEXT
);

CREATE TABLE Size_option (
    size_optionId INT PRIMARY KEY AUTO_INCREMENT,
    size_categoryId INT NOT NULL,
    label VARCHAR(100) NOT NULL,
    value VARCHAR(50),
    displayOrder INT DEFAULT 0,
    INDEX idx_size_category (size_categoryId),
    UNIQUE KEY uk_size_category_label (size_categoryId, label),
    FOREIGN KEY (size_categoryId) REFERENCES Size_category(size_categoryId)
);

INSERT INTO Size_category (name, unit, description) VALUES 
('Clothing', 'US', 'Standard US clothing sizes'),
('Shoes', 'US', 'US shoe sizes'),
('Electronics', 'N/A', 'Electronic device sizes'),
('One Size', 'N/A', 'Single size option'),
('Memory', 'GB', 'Storage capacity'),
('Screen Size', 'Inches', 'Display size');

INSERT INTO Size_option (size_categoryId, label, value, displayOrder) VALUES 
-- Clothing sizes
(1, 'XS', 'Extra Small', 1),
(1, 'S', 'Small', 2),
(1, 'M', 'Medium', 3),
(1, 'L', 'Large', 4),
(1, 'XL', 'Extra Large', 5),
(1, 'XXL', 'Double Extra Large', 6),

-- Shoe sizes
(2, '7', '7 US', 1),
(2, '8', '8 US', 2),
(2, '9', '9 US', 3),
(2, '10', '10 US', 4),
(2, '11', '11 US', 5),
(2, '12', '12 US', 6),

-- Electronics
(3, 'Standard', 'Standard Size', 1),
(3, 'Compact', 'Compact Size', 2),
(3, 'Large', 'Large Size', 3),

-- One Size
(4, 'One Size', 'One Size Fits All', 1),

-- Memory sizes
(5, '64GB', '64 Gigabytes', 1),
(5, '128GB', '128 Gigabytes', 2),
(5, '256GB', '256 Gigabytes', 3),
(5, '512GB', '512 Gigabytes', 4),
(5, '1TB', '1 Terabyte', 5),

-- Screen sizes
(6, '13"', '13 Inches', 1),
(6, '15"', '15 Inches', 2),
(6, '17"', '17 Inches', 3),
(6, '24"', '24 Inches', 4),
(6, '32"', '32 Inches', 5),
(6, '55"', '55 Inches', 6);

-- ============================================
-- 6. PRODUCT VARIATION TABLE (Fixed AUTO_INCREMENT)
-- ============================================
CREATE TABLE Product_variation (
    variationId INT PRIMARY KEY AUTO_INCREMENT,
    productId INT NOT NULL,
    colorId INT,
    size_optionId INT,
    sku VARCHAR(100) UNIQUE NOT NULL,
    barcode VARCHAR(50),
    additionalCost DECIMAL(10,2) DEFAULT 0.00,
    isDefault BOOLEAN DEFAULT FALSE,
    INDEX idx_variation_product (productId),
    INDEX idx_variation_sku (sku),
    UNIQUE KEY uk_product_variation (productId, colorId, size_optionId),
    FOREIGN KEY (productId) REFERENCES Product(productId) ON DELETE CASCADE,
    FOREIGN KEY (colorId) REFERENCES Color(colorId),
    FOREIGN KEY (size_optionId) REFERENCES Size_option(size_optionId)
);

-- Insert product variations
INSERT INTO Product_variation (productId, colorId, size_optionId, sku, barcode, isDefault) VALUES
-- iPhone variations
(2, 13, 17, 'IPHONE15-BLU-128', '190198765432', TRUE),  -- Sierra Blue, 128GB
(2, 14, 18, 'IPHONE15-PUR-256', '190198765433', FALSE), -- Deep Purple, 256GB

-- Samsung phone variations
(1, 1, 16, 'S24-BLK-256', '880164489123', TRUE),  -- Black, 256GB
(1, 2, 17, 'S24-WHT-512', '880164489124', FALSE), -- White, 512GB

-- Nike shoes variations
(11, 1, 7, 'NIKE270-BLK-8', '888804876543', TRUE),  -- Black, Size 8
(11, 4, 8, 'NIKE270-BLU-9', '888804876544', FALSE), -- Blue, Size 9

-- Dell laptop variations
(5, 9, 22, 'DELLXPS15-GRY-512', '539718456789', TRUE),  -- Space Gray, 512GB, 15"
(5, 6, 23, 'DELLXPS15-SLV-1TB', '539718456790', FALSE), -- Silver, 1TB, 17"

-- Sony headphones
(9, 1, 10, 'SONYWH-BLK-STD', '490552493211', TRUE),  -- Black, Standard
(9, 6, 10, 'SONYWH-SLV-STD', '490552493212', FALSE), -- Silver, Standard

-- IKEA furniture (no color/size variations)
(18, NULL, NULL, 'IKEA-MALM-BED', '400638133393', TRUE),
(19, NULL, NULL, 'IKEA-POANG-CHAIR', '400638133394', TRUE);

-- ============================================
-- 7. PRODUCT ITEM TABLE (Inventory)
-- ============================================
CREATE TABLE Product_item (
    itemId INT PRIMARY KEY AUTO_INCREMENT,
    variationId INT NOT NULL,
    stockQuantity INT NOT NULL DEFAULT 0 CHECK (stockQuantity >= 0),
    reorderLevel INT DEFAULT 10,
    location VARCHAR(100),
    condition ENUM('new', 'refurbished', 'used') DEFAULT 'new',
    costPrice DECIMAL(10,2),
    sellingPrice DECIMAL(10,2) NOT NULL,
    isActive BOOLEAN DEFAULT TRUE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_item_variation (variationId),
    INDEX idx_item_stock (stockQuantity),
    INDEX idx_item_active (isActive),
    FOREIGN KEY (variationId) REFERENCES Product_variation(variationId) ON DELETE CASCADE
);

-- Insert inventory items
INSERT INTO Product_item (variationId, stockQuantity, reorderLevel, location, condition, costPrice, sellingPrice) VALUES
-- iPhone inventory
(1, 50, 10, 'Warehouse A', 'new', 900.00, 1199.00),
(2, 30, 5, 'Warehouse A', 'new', 1000.00, 1299.00),

-- Samsung inventory
(3, 75, 15, 'Warehouse B', 'new', 700.00, 999.99),
(4, 40, 10, 'Warehouse B', 'new', 800.00, 1149.99),

-- Nike shoes inventory
(5, 100, 20, 'Warehouse C', 'new', 80.00, 150.00),
(6, 80, 15, 'Warehouse C', 'new', 80.00, 150.00),

-- Dell laptop inventory
(7, 25, 5, 'Warehouse D', 'new', 1200.00, 1499.00),
(8, 15, 3, 'Warehouse D', 'new', 1300.00, 1799.00),

-- Sony headphones inventory
(9, 60, 10, 'Warehouse E', 'new', 250.00, 399.99),
(10, 45, 10, 'Warehouse E', 'new', 250.00, 399.99),

-- IKEA furniture
(11, 200, 50, 'Warehouse F', 'new', 200.00, 299.00),
(12, 150, 30, 'Warehouse F', 'new', 50.00, 79.99);

-- ============================================
-- 8. PRODUCT IMAGE TABLE
-- ============================================
CREATE TABLE Product_image (
    imageId INT PRIMARY KEY AUTO_INCREMENT,
    productId INT NOT NULL,
    variationId INT,
    url VARCHAR(500) NOT NULL,
    altText VARCHAR(255),
    isPrimary BOOLEAN DEFAULT FALSE,
    sortOrder INT DEFAULT 0,
    imageType ENUM('thumbnail', 'gallery', 'zoom') DEFAULT 'gallery',
    width INT,
    height INT,
    fileSize INT COMMENT 'Size in bytes',
    INDEX idx_image_product (productId),
    INDEX idx_image_variation (variationId),
    INDEX idx_image_primary (isPrimary),
    FOREIGN KEY (productId) REFERENCES Product(productId) ON DELETE CASCADE,
    FOREIGN KEY (variationId) REFERENCES Product_variation(variationId) ON DELETE SET NULL
);

INSERT INTO Product_image (productId, variationId, url, altText, isPrimary, sortOrder) VALUES
-- iPhone images
(2, 1, 'https://cdn.example.com/iphone15-blue-front.jpg', 'iPhone 15 Blue Front View', TRUE, 1),
(2, 1, 'https://cdn.example.com/iphone15-blue-back.jpg', 'iPhone 15 Blue Back View', FALSE, 2),

-- Samsung images
(1, 3, 'https://cdn.example.com/s24-black-front.jpg', 'Samsung S24 Black Front', TRUE, 1),

-- Nike shoes images
(11, 5, 'https://cdn.example.com/nike-airmax-black-side.jpg', 'Nike Air Max Black Side', TRUE, 1),

-- General product images
(5, NULL, 'https://cdn.example.com/dell-xps-open.jpg', 'Dell XPS Laptop Open', TRUE, 1),
(9, NULL, 'https://cdn.example.com/sony-headphones.jpg', 'Sony Headphones', TRUE, 1),
(18, NULL, 'https://cdn.example.com/ikea-bed.jpg', 'IKEA MALM Bed', TRUE, 1);

-- ============================================
-- 9. PRODUCT ATTRIBUTE SYSTEM
-- ============================================
CREATE TABLE Attribute_category (
    attr_cat_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE Attribute_type (
    attr_type_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL UNIQUE,
    dataType VARCHAR(50) NOT NULL,
    validationRule VARCHAR(255)
);

CREATE TABLE Product_attribute (
    attr_id INT PRIMARY KEY AUTO_INCREMENT,
    productId INT NOT NULL,
    attr_cat_id INT NOT NULL,
    attr_type_id INT NOT NULL,
    attributeName VARCHAR(100) NOT NULL,
    attributeValue TEXT NOT NULL,
    displayOrder INT DEFAULT 0,
    isFilterable BOOLEAN DEFAULT FALSE,
    isVisible BOOLEAN DEFAULT TRUE,
    INDEX idx_attr_product (productId),
    INDEX idx_attr_category (attr_cat_id),
    INDEX idx_attr_filterable (isFilterable),
    UNIQUE KEY uk_product_attribute (productId, attributeName),
    FOREIGN KEY (productId) REFERENCES Product(productId) ON DELETE CASCADE,
    FOREIGN KEY (attr_cat_id) REFERENCES Attribute_category(attr_cat_id),
    FOREIGN KEY (attr_type_id) REFERENCES Attribute_type(attr_type_id)
);

INSERT INTO Attribute_category (name, description) VALUES 
('General', 'General product specifications'),
('Display', 'Screen and display specifications'),
('Performance', 'Performance related attributes'),
('Battery', 'Battery specifications'),
('Camera', 'Camera specifications'),
('Connectivity', 'Network and connectivity'),
('Storage', 'Storage and memory'),
('Dimensions', 'Physical dimensions and weight');

INSERT INTO Attribute_type (name, dataType, validationRule) VALUES 
('Text', 'string', NULL),
('Number', 'integer', '^[0-9]+$'),
('Decimal', 'decimal', '^[0-9]+(\.[0-9]+)?$'),
('Boolean', 'boolean', '^(true|false|0|1)$'),
('Date', 'date', NULL),
('Selection', 'string', NULL),
('Range', 'string', '^[0-9]+-[0-9]+$');

-- Insert product attributes
INSERT INTO Product_attribute (productId, attr_cat_id, attr_type_id, attributeName, attributeValue, isFilterable) VALUES
-- iPhone attributes
(2, 2, 2, 'Screen Size', '6.1', TRUE),
(2, 2, 2, 'Resolution', '2556x1179', FALSE),
(2, 3, 2, 'RAM', '8', TRUE),
(2, 6, 1, '5G Support', 'Yes', TRUE),
(2, 4, 2, 'Battery Capacity', '3349', FALSE),

-- Samsung attributes
(1, 2, 2, 'Screen Size', '6.8', TRUE),
(1, 7, 2, 'Internal Storage', '256', TRUE),
(1, 3, 2, 'Processor Cores', '8', FALSE),

-- Nike shoes attributes
(11, 8, 1, 'Material', 'Mesh and Synthetic', TRUE),
(11, 8, 1, 'Closure Type', 'Lace-up', FALSE),

-- Dell laptop attributes
(5, 2, 2, 'Screen Size', '15.6', TRUE),
(5, 2, 1, 'Display Type', 'OLED', TRUE),
(5, 3, 2, 'Processor', 'Intel Core i7', TRUE);

-- ============================================
-- 10. CUSTOMERS TABLE
-- ============================================
CREATE TABLE Customers (
    customerId INT PRIMARY KEY AUTO_INCREMENT,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    passwordHash VARCHAR(255) NOT NULL,
    dateOfBirth DATE,
    gender ENUM('male', 'female', 'other') DEFAULT 'other',
    accountType ENUM('individual', 'business') DEFAULT 'individual',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    lastLogin TIMESTAMP NULL,
    isActive BOOLEAN DEFAULT TRUE,
    isEmailVerified BOOLEAN DEFAULT FALSE,
    loyaltyPoints INT DEFAULT 0,
    INDEX idx_customer_email (email),
    INDEX idx_customer_active (isActive),
    INDEX idx_customer_name (firstName, lastName)
);

INSERT INTO Customers (firstName, lastName, email, phone, passwordHash, dateOfBirth, gender, loyaltyPoints) VALUES
('John', 'Doe', 'john.doe@email.com', '+254712345678', 'hashed_password_123', '1990-05-15', 'male', 1500),
('Jane', 'Smith', 'jane.smith@email.com', '+254723456789', 'hashed_password_456', '1992-08-22', 'female', 2500),
('Ahmed', 'Hassan', 'ahmed.h@email.com', '+254734567890', 'hashed_password_789', '1985-11-30', 'male', 500),
('Mary', 'Johnson', 'mary.j@email.com', '+254745678901', 'hashed_password_012', '1995-03-10', 'female', 750),
('Damaris', 'Oguto', 'damaris@gmail.com', '+254799422122', 'hashed_password_011', '1988-12-05', 'female', 1200),
('Robert', 'Kimani', 'robert.k@email.com', '+254756789012', 'hashed_password_013', '1993-07-18', 'male', 300),
('Sarah', 'Chen', 'sarah.chen@email.com', '+254767890123', 'hashed_password_014', '1991-09-25', 'female', 1800),
('Mohamed', 'Ali', 'mohamed.ali@email.com', '+254778901234', 'hashed_password_015', '1987-04-12', 'male', 950);

-- ============================================
-- 11. ADDRESSES TABLE
-- ============================================
CREATE TABLE Addresses (
    addressId INT PRIMARY KEY AUTO_INCREMENT,
    customerId INT NOT NULL,
    addressType ENUM('billing', 'shipping') NOT NULL,
    recipientName VARCHAR(200),
    streetAddress VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100),
    country VARCHAR(100) NOT NULL,
    postalCode VARCHAR(20),
    phone VARCHAR(20),
    isDefault BOOLEAN DEFAULT FALSE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_address_customer (customerId),
    INDEX idx_address_type (addressType),
    INDEX idx_address_country (country),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId) ON DELETE CASCADE
);

INSERT INTO Addresses (customerId, addressType, recipientName, streetAddress, city, state, country, postalCode, phone, isDefault) VALUES
(1, 'shipping', 'John Doe', '123 Main Street', 'Nairobi', 'Nairobi County', 'Kenya', '00100', '+254712345678', TRUE),
(1, 'billing', 'John Doe', '123 Main Street', 'Nairobi', 'Nairobi County', 'Kenya', '00100', '+254712345678', TRUE),
(2, 'shipping', 'Jane Smith', '456 Elm Avenue', 'Mombasa', 'Mombasa County', 'Kenya', '80100', '+254723456789', TRUE),
(2, 'billing', 'Jane Smith', '456 Elm Avenue', 'Mombasa', 'Mombasa County', 'Kenya', '80100', '+254723456789', TRUE),
(3, 'shipping', 'Ahmed Hassan', '789 Oak Road', 'Kisumu', 'Kisumu County', 'Kenya', '40100', '+254734567890', TRUE),
(4, 'shipping', 'Mary Johnson', '101 Hill Street', 'Nakuru', 'Nakuru County', 'Kenya', '20100', '+254745678901', TRUE),
(5, 'shipping', 'Damaris Oguto', '202 Lake View', 'Eldoret', 'Uasin Gishu County', 'Kenya', '30100', '+254799422122', TRUE);

-- ============================================
-- 12. ORDERS TABLE
-- ============================================
CREATE TABLE Orders (
    orderId INT PRIMARY KEY AUTO_INCREMENT,
    orderNumber VARCHAR(50) UNIQUE NOT NULL DEFAULT CONCAT('ORD-', DATE_FORMAT(NOW(), '%Y%m%d-'), LPAD(FLOOR(RAND() * 10000), 4, '0')),
    customerId INT NOT NULL,
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'confirmed', 'processing', 'shipped', 'delivered', 'cancelled', 'refunded') DEFAULT 'pending',
    totalAmount DECIMAL(10,2) NOT NULL CHECK (totalAmount >= 0),
    taxAmount DECIMAL(10,2) DEFAULT 0.00,
    shippingAmount DECIMAL(10,2) DEFAULT 0.00,
    discountAmount DECIMAL(10,2) DEFAULT 0.00,
    grandTotal DECIMAL(10,2) GENERATED ALWAYS AS (totalAmount + taxAmount + shippingAmount - discountAmount) STORED,
    shippingAddressId INT,
    billingAddressId INT,
    paymentMethod ENUM('credit_card', 'mpesa', 'paypal', 'bank_transfer', 'cash_on_delivery') DEFAULT 'credit_card',
    paymentStatus ENUM('pending', 'paid', 'failed', 'refunded') DEFAULT 'pending',
    notes TEXT,
    estimatedDelivery DATE,
    INDEX idx_orders_customer (customerId),
    INDEX idx_orders_status (status),
    INDEX idx_orders_date (orderDate),
    INDEX idx_orders_number (orderNumber),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId),
    FOREIGN KEY (shippingAddressId) REFERENCES Addresses(addressId),
    FOREIGN KEY (billingAddressId) REFERENCES Addresses(addressId)
);

-- Insert sample orders
INSERT INTO Orders (customerId, totalAmount, taxAmount, shippingAmount, discountAmount, shippingAddressId, billingAddressId, status, paymentStatus) VALUES
(1, 154.99, 15.50, 10.00, 5.00, 1, 2, 'delivered', 'paid'),
(2, 399.00, 39.90, 15.00, 10.00, 3, 3, 'shipped', 'paid'),
(3, 1099.00, 109.90, 25.00, 50.00, 5, 5, 'processing', 'paid'),
(1, 75.00, 7.50, 5.00, 0.00, 1, 2, 'pending', 'pending'),
(4, 250.50, 25.05, 12.00, 15.00, 6, 6, 'delivered', 'paid'),
(5, 499.99, 50.00, 20.00, 25.00, 7, 7, 'shipped', 'paid'),
(2, 120.00, 12.00, 8.00, 5.00, 3, 3, 'pending', 'pending'),
(3, 699.00, 69.90, 15.00, 30.00, 5, 5, 'delivered', 'paid');

-- ============================================
-- 13. ORDER ITEMS TABLE
-- ============================================
CREATE TABLE Order_items (
    orderItemId INT PRIMARY KEY AUTO_INCREMENT,
    orderId INT NOT NULL,
    itemId INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    priceAtPurchase DECIMAL(10,2) NOT NULL,
    discountPercent DECIMAL(5,2) DEFAULT 0.00,
    subtotal DECIMAL(10,2) GENERATED ALWAYS AS (quantity * priceAtPurchase * (1 - discountPercent/100)) STORED,
    INDEX idx_order_items_order (orderId),
    INDEX idx_order_items_product (itemId),
    FOREIGN KEY (orderId) REFERENCES Orders(orderId) ON DELETE CASCADE,
    FOREIGN KEY (itemId) REFERENCES Product_item(itemId)
);

INSERT INTO Order_items (orderId, itemId, quantity, priceAtPurchase, discountPercent) VALUES
(1, 1, 2, 1199.00, 10.00),
(1, 3, 1, 999.99, 15.00),
(2, 5, 3, 150.00, 20.00),
(2, 7, 1, 1499.00, 8.00),
(3, 2, 1, 1299.00, 5.00),
(3, 9, 2, 399.99, 10.00),
(4, 11, 1, 299.00, 15.00),
(5, 6, 1, 150.00, 10.00),
(5, 8, 1, 1799.00, 5.00),
(6, 10, 1, 399.99, 15.00);

-- ============================================
-- 14. PAYMENTS TABLE
-- ============================================
CREATE TABLE Payments (
    paymentId INT PRIMARY KEY AUTO_INCREMENT,
    orderId INT NOT NULL,
    paymentMethod ENUM('credit_card', 'mpesa', 'paypal', 'bank_transfer', 'cash_on_delivery') NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'completed', 'failed', 'refunded', 'partially_refunded') DEFAULT 'pending',
    transactionId VARCHAR(255) UNIQUE,
    paymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    currency VARCHAR(3) DEFAULT 'USD',
    gatewayResponse TEXT,
    refundAmount DECIMAL(10,2) DEFAULT 0.00,
    INDEX idx_payments_order (orderId),
    INDEX idx_payments_status (status),
    INDEX idx_payments_date (paymentDate),
    FOREIGN KEY (orderId) REFERENCES Orders(orderId)
);

INSERT INTO Payments (orderId, paymentMethod, amount, status, transactionId, currency) VALUES
(1, 'mpesa', 175.49, 'completed', 'MPESA-20240115-001234', 'KES'),
(2, 'credit_card', 443.90, 'completed', 'CC-20240116-005678', 'USD'),
(3, 'paypal', 1183.90, 'completed', 'PAYPAL-20240117-009012', 'USD'),
(5, 'mpesa', 272.55, 'completed', 'MPESA-20240118-003456', 'KES'),
(6, 'bank_transfer', 544.99, 'completed', 'BANK-20240119-007890', 'USD'),
(8, 'mpesa', 753.90, 'completed', 'MPESA-20240120-001111', 'KES');

-- ============================================
-- 15. SHIPPING TABLE
-- ============================================
CREATE TABLE Shipping (
    shippingId INT PRIMARY KEY AUTO_INCREMENT,
    orderId INT NOT NULL UNIQUE,
    carrier VARCHAR(100) NOT NULL,
    trackingNumber VARCHAR(255) UNIQUE,
    status ENUM('label_created', 'picked_up', 'in_transit', 'out_for_delivery', 'delivered', 'delayed', 'returned') DEFAULT 'label_created',
    shippingMethod ENUM('standard', 'express', 'overnight', 'international') DEFAULT 'standard',
    estimatedDelivery DATE,
    actualDelivery DATE,
    shippingCost DECIMAL(10,2) NOT NULL,
    shippingAddress TEXT,
    notes TEXT,
    INDEX idx_shipping_order (orderId),
    INDEX idx_shipping_status (status),
    INDEX idx_shipping_tracking (trackingNumber),
    FOREIGN KEY (orderId) REFERENCES Orders(orderId)
);

INSERT INTO Shipping (orderId, carrier, trackingNumber, status, shippingMethod, shippingCost, estimatedDelivery, actualDelivery) VALUES
(1, 'DHL', 'DHL-7890123456', 'delivered', 'express', 10.00, '2024-01-15', '2024-01-14'),
(2, 'FedEx', 'FEDEX-123456789', 'in_transit', 'standard', 15.00, '2024-01-18', NULL),
(3, 'UPS', 'UPS-987654321', 'label_created', 'overnight', 25.00, '2024-01-20', NULL),
(5, 'DHL', 'DHL-345678901', 'delivered', 'standard', 12.00, '2024-01-12', '2024-01-11'),
(6, 'FedEx', 'FEDEX-567890123', 'out_for_delivery', 'express', 18.00, '2024-01-16', NULL),
(8, 'UPS', 'UPS-234567890', 'delivered', 'standard', 15.00, '2024-01-17', '2024-01-16');

-- ============================================
-- 16. REVIEWS TABLE
-- ============================================
CREATE TABLE Reviews (
    reviewId INT PRIMARY KEY AUTO_INCREMENT,
    productId INT NOT NULL,
    customerId INT NOT NULL,
    orderId INT,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    title VARCHAR(255),
    comment TEXT NOT NULL,
    pros TEXT,
    cons TEXT,
    isVerifiedPurchase BOOLEAN DEFAULT FALSE,
    isApproved BOOLEAN DEFAULT FALSE,
    helpfulCount INT DEFAULT 0,
    unhelpfulCount INT DEFAULT 0,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_reviews_product (productId),
    INDEX idx_reviews_customer (customerId),
    INDEX idx_reviews_rating (rating),
    INDEX idx_reviews_approved (isApproved),
    UNIQUE KEY uk_product_customer_review (productId, customerId),
    FOREIGN KEY (productId) REFERENCES Product(productId),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId),
    FOREIGN KEY (orderId) REFERENCES Orders(orderId)
);

INSERT INTO Reviews (productId, customerId, rating, title, comment, isVerifiedPurchase, isApproved, helpfulCount) VALUES
(2, 1, 5, 'Excellent phone!', 'Battery life is amazing, camera quality is top-notch.', TRUE, TRUE, 12),
(1, 2, 4, 'Great smartphone', 'Love the display and performance, but charging could be faster.', TRUE, TRUE, 8),
(11, 3, 5, 'Most comfortable shoes', 'Worn them for a month, perfect for daily use and workouts.', TRUE, TRUE, 15),
(5, 4, 4, 'Powerful laptop', 'Handles all my development work smoothly. Only downside is battery life.', TRUE, TRUE, 6),
(9, 5, 5, 'Best headphones ever', 'Noise cancellation is incredible. Worth every penny.', TRUE, TRUE, 20);

-- ============================================
-- 17. WISHLIST TABLE
-- ============================================
CREATE TABLE Wishlist (
    wishlistId INT PRIMARY KEY AUTO_INCREMENT,
    customerId INT NOT NULL,
    productId INT NOT NULL,
    addedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    INDEX idx_wishlist_customer (customerId),
    UNIQUE KEY unique_wishlist_item (customerId, productId),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId) ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES Product(productId)
);

INSERT INTO Wishlist (customerId, productId) VALUES
(1, 6),   -- John wants Tesla Powerwall
(2, 3),   -- Jane wants Dell laptop
(3, 1),   -- Ahmed wants Samsung phone
(4, 8),   -- Mary wants Sony headphones
(5, 7),   -- Damaris wants IKEA bed
(1, 24),  -- John also wants Canon camera
(2, 18);  -- Jane wants IKEA chair

-- ============================================
-- 18. DISCOUNT & PROMOTION TABLES
-- ============================================
CREATE TABLE Discounts (
    discountId INT PRIMARY KEY AUTO_INCREMENT,
    discountCode VARCHAR(50) UNIQUE,
    discountType ENUM('percentage', 'fixed', 'free_shipping') NOT NULL,
    discountValue DECIMAL(10,2) NOT NULL,
    minPurchaseAmount DECIMAL(10,2) DEFAULT 0.00,
    maxDiscountAmount DECIMAL(10,2),
    startDate DATE NOT NULL,
    endDate DATE NOT NULL,
    usageLimit INT,
    usedCount INT DEFAULT 0,
    isActive BOOLEAN DEFAULT TRUE,
    applicableTo ENUM('all', 'categories', 'products', 'brands') DEFAULT 'all',
    description TEXT
);

CREATE TABLE Coupon_usage (
    usageId INT PRIMARY KEY AUTO_INCREMENT,
    discountId INT NOT NULL,
    customerId INT NOT NULL,
    orderId INT NOT NULL,
    usedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    discountAmount DECIMAL(10,2) NOT NULL,
    INDEX idx_coupon_usage_discount (discountId),
    INDEX idx_coupon_usage_customer (customerId),
    FOREIGN KEY (discountId) REFERENCES Discounts(discountId),
    FOREIGN KEY (customerId) REFERENCES Customers(customerId),
    FOREIGN KEY (orderId) REFERENCES Orders(orderId)
);

-- ============================================
-- 19. PERFORMANCE INDEXES ADDITIONAL
-- ============================================
CREATE INDEX idx_product_variation_composite ON Product_variation(productId, colorId, size_optionId);
CREATE INDEX idx_orders_composite ON Orders(customerId, status, orderDate);
CREATE INDEX idx_order_items_composite ON Order_items(orderId, itemId);
CREATE INDEX idx_payments_composite ON Payments(orderId, status, paymentDate);
CREATE INDEX idx_reviews_composite ON Reviews(productId, rating, isApproved);

-- ============================================
-- 20. TRIGGERS FOR DATA INTEGRITY
-- ============================================
DELIMITER //

-- Update product rating when new review is added
CREATE TRIGGER update_product_rating AFTER INSERT ON Reviews
FOR EACH ROW
BEGIN
    UPDATE Product p
    SET p.totalReviews = p.totalReviews + 1,
        p.avgRating = (
            SELECT AVG(rating) 
            FROM Reviews 
            WHERE productId = NEW.productId 
            AND isApproved = TRUE
        )
    WHERE p.productId = NEW.productId;
END//

-- Update stock quantity after order
CREATE TRIGGER update_stock_after_order AFTER INSERT ON Order_items
FOR EACH ROW
BEGIN
    UPDATE Product_item pi
    SET pi.stockQuantity = pi.stockQuantity - NEW.quantity
    WHERE pi.itemId = NEW.itemId;
END//

-- Prevent stock from going negative
CREATE TRIGGER prevent_negative_stock BEFORE UPDATE ON Product_item
FOR EACH ROW
BEGIN
    IF NEW.stockQuantity < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Stock quantity cannot be negative';
    END IF;
END//

DELIMITER ;

-- ============================================
-- 21. DATA VALIDATION QUERIES
-- ============================================
-- Check for data consistency
SELECT 'Data Validation Report' AS Report;
SELECT COUNT(*) AS Total_Brands FROM Brand;
SELECT COUNT(*) AS Total_Products FROM Product;
SELECT COUNT(*) AS Total_Customers FROM Customers;
SELECT COUNT(*) AS Total_Orders FROM Orders;

-- Check for invalid data
SELECT 'Checking for NULL SKUs in Product_variation' AS Check_Item;
SELECT COUNT(*) AS Invalid_SKUs FROM Product_variation WHERE sku IS NULL OR sku = '';

SELECT 'Checking for negative stock' AS Check_Item;
SELECT COUNT(*) AS Negative_Stock FROM Product_item WHERE stockQuantity < 0;

SELECT 'Checking for orphaned product variations' AS Check_Item;
SELECT COUNT(*) AS Orphaned_Variations 
FROM Product_variation pv
LEFT JOIN Product p ON pv.productId = p.productId
WHERE p.productId IS NULL;

-- ============================================
-- END OF ENHANCED SCHEMA
-- ============================================

