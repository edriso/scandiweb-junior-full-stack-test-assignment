DROP DATABASE IF EXISTS scandiweb_ecommerce_task;
CREATE DATABASE scandiweb_ecommerce_task;
USE scandiweb_ecommerce_task;

-- CREATING TABLES --
CREATE TABLE categories (
    name VARCHAR(255) PRIMARY KEY
);

CREATE TABLE products (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    inStock BOOLEAN DEFAULT TRUE,
    gallery JSON,
    description TEXT,
    category VARCHAR(255),
    brand VARCHAR(255),
    FOREIGN KEY (category) REFERENCES categories(name) ON DELETE SET NULL
);

CREATE TABLE attributes (
    id VARCHAR(255) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    type VARCHAR(50) NOT NULL, -- For example, 'text', 'swatch', etc.

    CONSTRAINT unique_attribute UNIQUE (name, type)
);

CREATE TABLE product_attributes (
    id VARCHAR(255) PRIMARY KEY,
    product_id VARCHAR(255) NOT NULL,
    attribute_id VARCHAR(255),
    displayValue VARCHAR(255) NOT NULL,
    value VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_id) REFERENCES attributes(id) ON DELETE SET NULL,

    CONSTRAINT unique_product_attribute_value UNIQUE (product_id, attribute_id, value)
);

CREATE TABLE currencies (
    label VARCHAR(50) PRIMARY KEY,
    symbol VARCHAR(10) NOT NULL
);

CREATE TABLE prices (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    amount DECIMAL(10, 2),
    currency VARCHAR(50) NOT NULL,
    product_id VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (currency) REFERENCES currencies(label) ON DELETE CASCADE,

    CONSTRAINT unique_product_price_currency UNIQUE (product_id, currency)
);

CREATE TABLE orders (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    total_amount DECIMAL(10, 2) NOT NULL,
    total_currency VARCHAR(50) NOT NULL,
    status ENUM('pending', 'processing', 'shipped', 'delivered') NOT NULL DEFAULT 'pending',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id BIGINT UNSIGNED NOT NULL,
    product_id VARCHAR(255),
    product_name VARCHAR(255) NOT NULL,
    attribute_values JSON NOT NULL,
    quantity INT UNSIGNED DEFAULT 1,
    paid_amount DECIMAL(10, 2) NOT NULL,
    paid_currency VARCHAR(50) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE SET NULL
);

-- INSERTING DATA --
INSERT INTO categories (name) VALUES
('all'),
('clothes'),
('tech');

INSERT INTO products (id, name, inStock, gallery, description, category, brand) VALUES
('huarache-x-stussy-le', 'Nike Air Huarache Le', true, '["https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_2_720x.jpg?v=1612816087","https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_1_720x.jpg?v=1612816087","https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_3_720x.jpg?v=1612816087","https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_5_720x.jpg?v=1612816087","https://cdn.shopify.com/s/files/1/0087/6193/3920/products/DD1381200_DEOA_4_720x.jpg?v=1612816087"]', '<p>Great sneakers for everyday use!</p>', 'clothes', 'Nike x Stussy'),
('jacket-canada-goosee', 'Jacket', true, '["https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016105/product-image/2409L_61.jpg","https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016107/product-image/2409L_61_a.jpg","https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016108/product-image/2409L_61_b.jpg","https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016109/product-image/2409L_61_c.jpg","https://images.canadagoose.com/image/upload/w_480,c_scale,f_auto,q_auto:best/v1576016110/product-image/2409L_61_d.jpg","https://images.canadagoose.com/image/upload/w_1333,c_scale,f_auto,q_auto:best/v1634058169/product-image/2409L_61_o.png","https://images.canadagoose.com/image/upload/w_1333,c_scale,f_auto,q_auto:best/v1634058159/product-image/2409L_61_p.png"]', '<p>Awesome winter jacket</p>', 'clothes', 'Canada Goose'),
('ps-5', 'PlayStation 5', true, '["https://images-na.ssl-images-amazon.com/images/I/510VSJ9mWDL._SL1262_.jpg","https://images-na.ssl-images-amazon.com/images/I/610%2B69ZsKCL._SL1500_.jpg","https://images-na.ssl-images-amazon.com/images/I/51iPoFwQT3L._SL1230_.jpg","https://images-na.ssl-images-amazon.com/images/I/61qbqFcvoNL._SL1500_.jpg","https://images-na.ssl-images-amazon.com/images/I/51HCjA3rqYL._SL1230_.jpg"]', '<p>A good gaming console. Plays games of PS4! Enjoy if you can buy it mwahahahaha</p>', 'tech', 'Sony'),
('xbox-series-s', 'Xbox Series S 512GB', false, '["https://images-na.ssl-images-amazon.com/images/I/71vPCX0bS-L._SL1500_.jpg","https://images-na.ssl-images-amazon.com/images/I/71q7JTbRTpL._SL1500_.jpg","https://images-na.ssl-images-amazon.com/images/I/71iQ4HGHtsL._SL1500_.jpg","https://images-na.ssl-images-amazon.com/images/I/61IYrCrBzxL._SL1500_.jpg","https://images-na.ssl-images-amazon.com/images/I/61RnXmpAmIL._SL1500_.jpg"]', ' <div> <ul> <li><span>Hardware-beschleunigtes Raytracing macht dein Spiel noch realistischer</span></li> <li><span>Spiele Games mit bis zu 120 Bilder pro Sekunde</span></li> <li><span>Minimiere Ladezeiten mit einer speziell entwickelten 512GB NVMe SSD und wechsle mit Quick Resume nahtlos zwischen mehreren Spielen.</span></li> <li><span>Xbox Smart Delivery stellt sicher, dass du die beste Version deines Spiels spielst, egal, auf welcher Konsole du spielst</span></li> <li><span>Spiele deine Xbox One-Spiele auf deiner Xbox Series S weiter. Deine Fortschritte, Erfolge und Freundesliste werden automatisch auf das neue System übertragen.</span></li> <li><span>Erwecke deine Spiele und Filme mit innovativem 3D Raumklang zum Leben</span></li> <li><span>Der brandneue Xbox Wireless Controller zeichnet sich durch höchste Präzision, eine neue Share-Taste und verbesserte Ergonomie aus</span></li> <li><span>Ultra-niedrige Latenz verbessert die Reaktionszeit von Controller zum Fernseher</span></li> <li><span>Verwende dein Xbox One-Gaming-Zubehör -einschließlich Controller, Headsets und mehr</span></li> <li><span>Erweitere deinen Speicher mit der Seagate 1 TB-Erweiterungskarte für Xbox Series X (separat erhältlich) und streame 4K-Videos von Disney+, Netflix, Amazon, Microsoft Movies &amp; TV und mehr</span></li> </ul> </div>', 'tech', 'Microsoft'),
('apple-imac-2021', 'iMac 2021', true, '["https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/imac-24-blue-selection-hero-202104?wid=904&hei=840&fmt=jpeg&qlt=80&.v=1617492405000"]', 'The new iMac!', 'tech', 'Apple'),
('apple-iphone-12-pro', 'iPhone 12 Pro', true, '["https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-12-pro-family-hero?wid=940&amp;hei=1112&amp;fmt=jpeg&amp;qlt=80&amp;.v=1604021663000"]', 'This is iPhone 12. Nothing else to say.', 'tech', 'Apple'),
('apple-airpods-pro', 'AirPods Pro', false, '["https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/MWP22?wid=572&hei=572&fmt=jpeg&qlt=95&.v=1591634795000"]', ' <h3>Magic like you’ve never heard</h3> <p>AirPods Pro have been designed to deliver Active Noise Cancellation for immersive sound, Transparency mode so you can hear your surroundings, and a customizable fit for all-day comfort. Just like AirPods, AirPods Pro connect magically to your iPhone or Apple Watch. And they’re ready to use right out of the case. <h3>Active Noise Cancellation</h3> <p>Incredibly light noise-cancelling headphones, AirPods Pro block out your environment so you can focus on what you’re listening to. AirPods Pro use two microphones, an outward-facing microphone and an inward-facing microphone, to create superior noise cancellation. By continuously adapting to the geometry of your ear and the fit of the ear tips, Active Noise Cancellation silences the world to keep you fully tuned in to your music, podcasts, and calls. <h3>Transparency mode</h3> <p>Switch to Transparency mode and AirPods Pro let the outside sound in, allowing you to hear and connect to your surroundings. Outward- and inward-facing microphones enable AirPods Pro to undo the sound-isolating effect of the silicone tips so things sound and feel natural, like when you’re talking to people around you.</p> <h3>All-new design</h3> <p>AirPods Pro offer a more customizable fit with three sizes of flexible silicone tips to choose from. With an internal taper, they conform to the shape of your ear, securing your AirPods Pro in place and creating an exceptional seal for superior noise cancellation.</p> <h3>Amazing audio quality</h3> <p>A custom-built high-excursion, low-distortion driver delivers powerful bass. A superefficient high dynamic range amplifier produces pure, incredibly clear sound while also extending battery life. And Adaptive EQ automatically tunes music to suit the shape of your ear for a rich, consistent listening experience.</p> <h3>Even more magical</h3> <p>The Apple-designed H1 chip delivers incredibly low audio latency. A force sensor on the stem makes it easy to control music and calls and switch between Active Noise Cancellation and Transparency mode. Announce Messages with Siri gives you the option to have Siri read your messages through your AirPods. And with Audio Sharing, you and a friend can share the same audio stream on two sets of AirPods — so you can play a game, watch a movie, or listen to a song together.</p> ', 'tech', 'Apple'),
('apple-airtag', 'AirTag', true, '["https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/airtag-double-select-202104?wid=445&hei=370&fmt=jpeg&qlt=95&.v=1617761672000"]', ' <h1>Lose your knack for losing things.</h1> <p>AirTag is an easy way to keep track of your stuff. Attach one to your keys, slip another one in your backpack. And just like that, they’re on your radar in the Find My app. AirTag has your back.</p> ', 'tech', 'Apple');

INSERT INTO attributes (id, name, type) VALUES
('size', 'size', 'text'),
('color', 'color', 'swatch'),
('capacity', 'capacity', 'text'),
('With USB 3 ports', 'With USB 3 ports', 'text'),
('Touch ID in keyboard', 'Touch ID in keyboard', 'text');

INSERT INTO product_attributes (id, product_id, attribute_id, displayValue, value) VALUES
('huarache-x-stussy-le-size-40', 'huarache-x-stussy-le', 'size', '40', '40'),
('huarache-x-stussy-le-size-41', 'huarache-x-stussy-le', 'size', '41', '41'),
('huarache-x-stussy-le-size-42', 'huarache-x-stussy-le', 'size', '42', '42'),
('huarache-x-stussy-le-size-43', 'huarache-x-stussy-le', 'size', '43', '43'),
('jacket-canada-goosee-size-Small', 'jacket-canada-goosee', 'size', 'Small', 'S'),
('jacket-canada-goosee-size-Medium', 'jacket-canada-goosee', 'size', 'Medium', 'M'),
('jacket-canada-goosee-size-Large', 'jacket-canada-goosee', 'size', 'Large', 'L'),
('jacket-canada-goosee-size-Extra Large', 'jacket-canada-goosee', 'size', 'Extra Large', 'XL'),
('ps-5-color-Green', 'ps-5', 'color', 'Green', '#44FF03'),
('ps-5-color-Cyan', 'ps-5', 'color', 'Cyan', '#03FFF7'),
('ps-5-color-Blue', 'ps-5', 'color', 'Blue', '#030BFF'),
('ps-5-color-Black', 'ps-5', 'color', 'Black', '#000000'),
('ps-5-color-White', 'ps-5', 'color', 'White', '#FFFFFF'),
('ps-5-capacity-512G', 'ps-5', 'capacity', '512G', '512G'),
('ps-5-capacity-1T', 'ps-5', 'capacity', '1T', '1T'),
('xbox-series-s-color-Green', 'xbox-series-s', 'color', 'Green', '#44FF03'),
('xbox-series-s-color-Cyan', 'xbox-series-s', 'color', 'Cyan', '#03FFF7'),
('xbox-series-s-color-Blue', 'xbox-series-s', 'color', 'Blue', '#030BFF'),
('xbox-series-s-color-Black', 'xbox-series-s', 'color', 'Black', '#000000'),
('xbox-series-s-color-White', 'xbox-series-s', 'color', 'White', '#FFFFFF'),
('xbox-series-s-capacity-512G', 'xbox-series-s', 'capacity', '512G', '512G'),
('xbox-series-s-capacity-1T', 'xbox-series-s', 'capacity', '1T', '1T'),
('apple-imac-2021-capacity-256GB', 'apple-imac-2021', 'capacity', '256GB', '256GB'),
('apple-imac-2021-capacity-512GB', 'apple-imac-2021', 'capacity', '512GB', '512GB'),
('apple-imac-2021-With USB 3 ports-Yes', 'apple-imac-2021', 'With USB 3 ports', 'Yes', 'Yes'),
('apple-imac-2021-With USB 3 ports-No', 'apple-imac-2021', 'With USB 3 ports', 'No', 'No'),
('apple-imac-2021-Touch ID in keyboard-Yes', 'apple-imac-2021', 'Touch ID in keyboard', 'Yes', 'Yes'),
('apple-imac-2021-Touch ID in keyboard-No', 'apple-imac-2021', 'Touch ID in keyboard', 'No', 'No'),
('apple-iphone-12-pro-capacity-512G', 'apple-iphone-12-pro', 'capacity', '512G', '512G'),
('apple-iphone-12-pro-capacity-1T', 'apple-iphone-12-pro', 'capacity', '1T', '1T'),
('apple-iphone-12-pro-color-Green', 'apple-iphone-12-pro', 'color', 'Green', '#44FF03'),
('apple-iphone-12-pro-color-Cyan', 'apple-iphone-12-pro', 'color', 'Cyan', '#03FFF7'),
('apple-iphone-12-pro-color-Blue', 'apple-iphone-12-pro', 'color', 'Blue', '#030BFF'),
('apple-iphone-12-pro-color-Black', 'apple-iphone-12-pro', 'color', 'Black', '#000000'),
('apple-iphone-12-pro-color-White', 'apple-iphone-12-pro', 'color', 'White', '#FFFFFF');

INSERT INTO currencies (label, symbol) VALUES
('USD', '$'),
('EUR', '€');

INSERT INTO prices (amount, currency, product_id) VALUES
(144.69, 'USD', 'huarache-x-stussy-le'),
(518.47, 'USD', 'jacket-canada-goosee'),
(844.02, 'USD', 'ps-5'),
(333.99, 'USD', 'xbox-series-s'),
(1600, 'USD', 'apple-imac-2021'),
(1000.76, 'USD', 'apple-iphone-12-pro'),
(300, 'USD', 'apple-airpods-pro'),
(120.57, 'USD', 'apple-airtag');

INSERT INTO orders (total_amount, total_currency) VALUES (2000.00, 'USD');

SET @order_id = LAST_INSERT_ID();

INSERT INTO order_items (order_id, product_id, product_name, attribute_values, quantity, paid_amount, paid_currency)
VALUES 
(@order_id, 'huarache-x-stussy-le', 'Nike Air Huarache Le', '{"size": "42", "color": "Black"}', 2, 289.38, 'USD'),
(@order_id, 'ps-5', 'PlayStation 5', '{"color": "Black", "capacity": "512G"}', 1, 844.027, 'USD'),
(@order_id, 'apple-imac-2021', 'iMac 2021', '{"capacity": "512GB", "With USB 3 ports": "Yes", "Touch ID in keyboard": "No"}', 1, 1600.00, 'USD');

-- TESTING
SELECT * FROM products;
