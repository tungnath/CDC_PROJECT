CREATE DATABASE order_db;

use order_db;

CREATE TABLE order_db.customer (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_db.`order` (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE
);

INSERT INTO order_db.customer (name, email, phone) VALUES
('Alice Johnson', 'alice@example.com', '9876543210'),
('Bob Smith', 'bob@example.com', '9876543211'),
('Charlie Brown', 'charlie@example.com', '9876543212');


INSERT INTO order_db.`order` (customer_id, total_amount) VALUES
(1, 150.75),
(2, 299.99),
(1, 89.50),  
(3, 120.00);
