-- SmartShop Ltd - Sample Data

-- Insert Branches
INSERT INTO Branches (branch_name, location, type) VALUES 
('Main Street Branch', 'Colombo 03', 'Physical'),
('Coastal Branch', 'Galle', 'Physical'),
('SmartShop Online', 'Cloud', 'Online');

-- Insert Customers
INSERT INTO Customers (first_name, last_name, email, phone, address) VALUES 
('John', 'Doe', 'john.doe@email.com', '0771234567', '123 Park Ave, Colombo'),
('Jane', 'Smith', 'jane.s@email.com', '0777654321', '45 Beach Rd, Galle'),
('Aruna', 'Perera', 'aruna.p@email.com', '0711112222', '10 Hill St, Kandy');

-- Insert Products
INSERT INTO Products (name, category, price, stock_quantity, description) VALUES 
('Laptop Pro 15', 'Electronics', 1500.00, 20, 'High performance laptop for professionals'),
('Wireless Mouse', 'Electronics', 25.00, 100, 'Ergonomic wireless mouse'),
('Coffee Maker', 'Appliances', 80.00, 15, 'Automatic drip coffee maker'),
('Running Shoes', 'Apparel', 60.00, 50, 'Lightweight breathable running shoes'),
('Smart Watch', 'Electronics', 200.00, 30, 'Fitness tracker and smartwatch');

-- Insert Sample Orders
INSERT INTO Orders (customer_id, branch_id, total_amount, status) VALUES 
(1, 1, 1525.00, 'Completed'),
(2, 3, 60.00, 'Shipped'),
(3, 2, 280.00, 'Pending');

-- Insert Order Items
-- Order 1: Laptop + Mouse
INSERT INTO OrderItems (order_id, product_id, quantity, unit_price, subtotal) VALUES 
(1, 1, 1, 1500.00, 1500.00),
(1, 2, 1, 25.00, 25.00);

-- Order 2: Running Shoes
INSERT INTO OrderItems (order_id, product_id, quantity, unit_price, subtotal) VALUES 
(2, 4, 1, 60.00, 60.00);

-- Order 3: Coffee Maker + Smart Watch
INSERT INTO OrderItems (order_id, product_id, quantity, unit_price, subtotal) VALUES 
(3, 3, 1, 80.00, 80.00),
(3, 5, 1, 200.00, 200.00);
