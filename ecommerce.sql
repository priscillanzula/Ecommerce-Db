CREATE DATABASE Ecommerce;
USE Ecommerce;

-- create brand
CREATE TABLE Brand(
    brandId INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    brandName VARCHAR(100) NOT NULL,
    description TEXT,
    country VARCHAR(100) NOT NULL
);

INSERT INTO brand (brandName, description, country) VALUES
('Nike', 'deals with sportswear and athletic gear.', 'United States of America'),
('Infinix', 'Global electronics brand.', 'China'),
('Dell', 'a global technology company known for designing, developing, and manufacturing a wide range of products.', 'Italy'),
('Google', 'multinational corporation and technology company focusing on online advertising, search engine technology, cloud computing.', 'China'),
('IBM', 'built on innovation and a commitment to solving business problems through technology.', 'American'),
('Apple', 'Innovative technology company famous for iPhones, iPads, and Macs.', 'Indonesia');


CREATE TABLE Product_category(
categoryId INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
categoryName VARCHAR(100) NOT NULL,
description TEXT,
slug VARCHAR(100) UNIQUE
);

INSERT INTO Product_category (categoryName, description, slug) VALUES
('Electronics', 'Devices like smartphones, laptops, and accessories', 'electronics'),
('Footwear', 'Shoes, sandals, boots, and other types of footwear', 'footwear'),
('Home Appliances', 'Devices for household use such as refrigerators, microwaves', 'home-appliances'),
('Beauty & Personal Care', 'Products like skincare, makeup, and grooming tools', 'beauty-personal-care');

CREATE TABLE  Product(
    productId INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    brandId INT NOT NULL,
    categoryId INT NOT NULL,
    productName VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (brandId) REFERENCES brand(brandId),
    FOREIGN KEY (categoryId) REFERENCES product_category(categoryId)
);
INSERT INTO product (productName, brandId, categoryId, price) VALUES 
('Nike Revolution 6', 1, 2, 75.00),
('Infinix Smart 7 HD', 2, 1, 120.00),
('Dell Inspiron 15', 3, 1, 950.00),
('Google Nest Hub', 4, 3, 129.00),
('IBM Smart Fridge', 5, 3, 599.99),
('Apple iPhone 15', 6, 1, 1099.00),
('Nike Flip Flops', 1, 2, 35.00),
('Google Pixel Watch', 4, 1, 399.00);


CREATE TABLE Product_image(
    imageId INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    productId INT NOT NULL,
    Url VARCHAR(255) NOT NULL,
    altText VARCHAR(255),
    FOREIGN KEY (productId) REFERENCES Product(productId)
);


INSERT INTO Product_image (productId, url, altText) VALUES
(1, 'https://example.com/images/nike-rev6-1.jpg', 'Nike Revolution 6 - Side View'),
(1, 'https://example.com/images/nike-rev6-2.jpg', 'Nike Revolution 6 - Top View'),
(2, 'https://example.com/images/infinix-smart7hd.jpg', 'Infinix Smart 7 HD - Front'),
(3, 'https://example.com/images/dell-inspiron15.jpg', 'Dell Inspiron 15 - Open'),
(4, 'https://example.com/images/google-nesthub.jpg', 'Google Nest Hub - Front'),
(5, 'https://example.com/images/ibm-fridge.jpg', 'IBM Smart Fridge - Closed'),
(6, 'https://example.com/images/iphone15.jpg', 'Apple iPhone 15   - Midnight'),
(7, 'https://example.com/images/nike-flipflops.jpg', 'Nike Flip Flops - Blue'),
(8, 'https://example.com/images/pixel-watch.jpg', 'Google Pixel Watch - Silver');

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

INSERT INTO Product_attribute (productId, attr_type_id, attr_cat_id, value)
VALUES (1, 2, 1, 'Red'),
(1, 1, 1, 'Cotton'),
(2, 3, 1, 'Large'),
(2, 6, 2, 'Waterproof'),
 (3, 4, 3, '1.5 kg'),
 (3, 5, 1, 'Generic');




CREATE TABLE Color(
    colorId INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    colorName VARCHAR(100) NOT NULL,
    hexValue VARCHAR(100)
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

CREATE TABLE Size_category(
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

CREATE TABLE Size_option(
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

CREATE TABLE Product_attribute (
    attr_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    productId INT NOT NULL,
    attr_type_id INT NOT NULL,
    attr_cat_id INT,
    value VARCHAR(255),
    FOREIGN KEY (productId) REFERENCES Product(productId),
    FOREIGN KEY (attr_type_id) REFERENCES Attribute_type(attr_type_id),
    FOREIGN KEY (attr_cat_id) REFERENCES Attribute_category(attr_cat_id)
);
INSERT INTO Product_attribute (productId, attr_type_id, attr_cat_id, value)
VALUES (1, 2, 1, 'Red'),
(1, 1, 1, 'Cotton'),
(2, 3, 1, 'Large'),
(2, 6, 2, 'Waterproof'),
 (3, 4, 3, '1.5 kg'),
 (3, 5, 1, 'Generic');


CREATE TABLE Product_item(
    itemId INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    productId INT,
    colorId INT,
    size_optionId INT,
    price DECIMAL(10,2) NOT NULL,
    stock_Qty INT NOT NULL,
    sku VARCHAR(100) NOT NULL,
    FOREIGN KEY (productId) REFERENCES Product(productId),
    FOREIGN KEY (colorId) REFERENCES Color(colorId),
    FOREIGN KEY (size_optionId) REFERENCES Size_option(size_optionId)
);

INSERT INTO Product_item (itemId, productId, colorId, size_optionId, price, stock_Qty, sku) VALUES
(1, 2, 1, 1, 29.99, 100, 'TBL-BLU-S'),
(2, 3, 1, 2, 29.99, 85, 'TBL-BLU-M'),
(3, 1, 1, 3, 29.99, 75, 'TBL-BLU-L'),
(4, 4, 2, 1, 29.99, 50, 'TBL-RED-S'),
(5, 5, 2, 2, 29.99, 65, 'TBL-RED-M'),
(7, 6, 4, 6, 49.99, 30, 'JNS-DNM-6');



CREATE TABLE Product_variation(
    variationId INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
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

CREATE TABLE Attribute_category(
    attr_cat_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
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





