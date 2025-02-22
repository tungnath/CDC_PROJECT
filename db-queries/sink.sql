CREATE DATABASE payment_db;

use payment_db;

CREATE TABLE payment_db.orderdb_customer_sink (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payment_db.orderdb_order_sink (
    id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES orderdb_customer_sink(id) ON DELETE CASCADE
);

select * from payment_db.orderdb_customer_sink;
select * from payment_db.orderdb_order_sink;
