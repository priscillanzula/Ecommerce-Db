
-- E-COMMERCE DATABASE SCHEMA

CREATE DATABASE IF NOT EXISTS Ecommerce;
USE Ecommerce;

-- Brand
CREATE TABLE Brand (
    brandId INT PRIMARY KEY AUTO_INCREMENT,
    brandName VARCHAR(100) NOT NULL,
    description TEXT,
    country VARCHAR(100) NOT NULL
);

INSERT INTO Brand (brandName, description, country) VALUES
('Nike', 'Deals with sportswear and athletic gear.', 'United States'),
('Infinix', 'Global electronics brand.', 'China'),
('Dell', 'Technology company making computers and accessories.', 'Italy'),
('Google', 'Tech company focusing on search, cloud, devices.', 'China'),
('IBM', 'Solving business problems with innovation.', 'USA'),
('Apple', 'Known for iPhones, iPads, Macs.', 'Indonesia');

-- Product Category
CREATE TABLE Product_category (
    categoryId INT PRIMARY KEY AUTO_INCREMENT,
    categoryName VARCHAR(100) NOT NULL,
    description TEXT,
    slug VARCHAR(100) UNIQUE
);

INSERT INTO Product_category (categoryName, description, slug) VALUES
('Electronics', 'Smartphones, laptops, accessories', 'electronics'),
('Footwear', 'Shoes, sandals, sneakers', 'footwear'),
('Home Appliances', 'Microwaves, fridges, kitchen devices', 'home-appliances'),
('Beauty & Personal Care', 'Skincare, makeup, grooming tools', 'beauty-personal-care');

-- Product
CREATE TABLE Product (
    productId INT PRIMARY KEY AUTO_INCREMENT,
    brandId INT NOT NULL,
    categoryId INT NOT NULL,
    productName VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (brandId) REFERENCES Brand(brandId),
    FOREIGN KEY (categoryId) REFERENCES Product_category(categoryId)
);

INSERT INTO Product (productName, brandId, categoryId, price) VALUES 
('Nike Revolution 6', 1, 2, 75.00),
('Infinix Smart 7 HD', 2, 1, 120.00),
('Dell Inspiron 15', 3, 1, 950.00),
('Google Nest Hub', 4, 3, 129.00),
('IBM Smart Fridge', 5, 3, 599.99),
('Apple iPhone 15', 6, 1, 1099.00),
('Nike Flip Flops', 1, 2, 35.00),
('Google Pixel Watch', 4, 1, 399.00);

-- Product Image
CREATE TABLE Product_image (
    imageId INT PRIMARY KEY AUTO_INCREMENT,
    productId INT NOT NULL,
    url VARCHAR(255) NOT NULL,
    altText VARCHAR(255),
    isPrimary BOOLEAN DEFAULT FALSE,
    sortOrder INT DEFAULT 0,
    FOREIGN KEY (productId) REFERENCES Product(productId)
);

INSERT INTO Product_image (productId, url, altText) VALUES
(1, 'https://example.com/images/nike-rev6-1.jpg', 'Side View'),
(1, 'https://example.com/images/nike-rev6-2.jpg', 'Top View'),
(2, 'https://example.com/images/infinix-smart7hd.jpg', 'Front'),
(3, 'https://example.com/images/dell-inspiron15.jpg', 'Open View'),
(4, 'https://example.com/images/google-nesthub.jpg', 'Nest Hub Front'),
(5, 'https://example.com/images/ibm-fridge.jpg', 'Fridge Closed'),
(6, 'https://example.com/images/iphone15.jpg', 'iPhone 15 Midnight'),
(7, 'https://example.com/images/nike-flipflops.jpg', 'Blue Flip Flops'),
(8, 'https://example.com/images/pixel-watch.jpg', 'Pixel Watch Silver');

-- Color
CREATE TABLE Color (
    colorId INT PRIMARY KEY AUTO_INCREMENT,
    colorName VARCHAR(100) NOT NULL,
    hexValue VARCHAR(7)
);

INSERT INTO Color (colorName, hexValue) VALUES
('Black', '#000000'),
('White', '#FFFFFF'),
('Red', '#FF0000'),
('Blue', '#0000FF'),
('Gray', '#808080'),
('Silver', '#C0C0C0'),
('Green', '#008000'),
('Midnight', '#121212');

-- Size Category
CREATE TABLE Size_category (
    size_categoryId INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    unit VARCHAR(20) NOT NULL
);

INSERT INTO Size_category (size_categoryId, name, unit) VALUES 
(1, 'Small', 'cm'),
(2, 'Medium', 'cm'),
(3, 'Large', 'cm'),
(4, 'Extra Small', 'inch'),
(5, 'Extra Large', 'inch'),
(7, 'Adult', 'cm');

-- Size Option
CREATE TABLE Size_option (
    size_optionId INT PRIMARY KEY,
    size_categoryId INT,
    label VARCHAR(100) NOT NULL,
    FOREIGN KEY (size_categoryId) REFERENCES Size_category(size_categoryId)
);

INSERT INTO Size_option (size_optionId, size_categoryId, label) VALUES 
(1, 1, 'S'),
(2, 2, 'M'),
(3, 3, 'L'),
(4, 4, 'XS'),
(5, 5, 'XL'),
(6, 5, 'XXL'),
(13, 3, 'One Size');

-- Product Variation
CREATE TABLE Product_variation (
    variationId INT PRIMARY KEY AUTO_INCREMENT,
    productId INT,
    colorId INT,
    size_optionId INT,
    FOREIGN KEY (productId) REFERENCES Product(productId),
    FOREIGN KEY (colorId) REFERENCES Color(colorId),
    FOREIGN KEY (size_optionId) REFERENCES Size_option(size_optionId)
);

INSERT INTO Product_variation (variationId, productId, colorId, size_optionId) VALUES 
(1, 1, 1, 1),
(2, 1, 1, 2),
(3, 1, 1, 3),
(4, 1, 2, 1),
(5, 1, 2, 2);

-- Product Item
CREATE TABLE Product_item (
    itemId INT PRIMARY KEY AUTO_INCREMENT,
    variationId INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_Qty INT NOT NULL,
    sku VARCHAR(100) UNIQUE NOT NULL,
    FOREIGN KEY (variationId) REFERENCES Product_variation(variationId)
);

INSERT INTO Product_item (variationId, price, stock_Qty, sku) VALUES
(1, 29.99, 100, 'TBL-BLU-S'),
(2, 29.99, 85, 'TBL-BLU-M'),
(3, 29.99, 75, 'TBL-BLU-L'),
(4, 29.99, 50, 'TBL-RED-S'),
(5, 29.99, 65, 'TBL-RED-M');

-- Attribute Category
CREATE TABLE Attribute_category (
    attr_cat_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

INSERT INTO Attribute_category (attr_cat_id, name) VALUES 
(1, 'Material'),
(2, 'Pattern'),
(3, 'Style'),
(4, 'Sleeve Length'),
(5, 'Neckline'),
(6, 'Fit'),
(7, 'Season'),
(8, 'Fabric Weight'),
(9, 'Occasion');

-- Attribute Type
CREATE TABLE Attribute_type (
    attr_type_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    dataType VARCHAR(100) NOT NULL
);

INSERT INTO Attribute_type (attr_type_id, name, dataType) VALUES 
(1, 'Text', 'string'),
(2, 'Number', 'integer'),
(3, 'Decimal', 'decimal'),
(4, 'Boolean', 'boolean'),
(5, 'Date', 'date'),
(6, 'Selection', 'string');

-- Product Attribute
CREATE TABLE Product_attribute (
    attr_id INT PRIMARY KEY AUTO_INCREMENT,
    productId INT NOT NULL,
    attr_type_id INT NOT NULL,
    attr_cat_id INT,
    value VARCHAR(255),
    FOREIGN KEY (productId) REFERENCES Product(productId),
    FOREIGN KEY (attr_type_id) REFERENCES Attribute_type(attr_type_id),
    FOREIGN KEY (attr_cat_id) REFERENCES Attribute_category(attr_cat_id)
);

INSERT INTO Product_attribute (productId, attr_type_id, attr_cat_id, value) VALUES
(1, 2, 1, 'Red'),
(1, 1, 1, 'Cotton'),
(2, 3, 1, 'Large'),
(2, 6, 2, 'Waterproof'),
(3, 4, 3, '1.5 kg'),
(3, 5, 1, 'Generic');

