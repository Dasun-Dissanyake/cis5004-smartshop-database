-- SmartShop Ltd - Relational Database Schema
-- DBMS: SQLite (Compatible with most SQL environments)

-- 1. Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    address TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Branches Table
CREATE TABLE IF NOT EXISTS Branches (
    branch_id INTEGER PRIMARY KEY AUTOINCREMENT,
    branch_name TEXT NOT NULL,
    location TEXT NOT NULL,
    type TEXT CHECK(type IN ('Physical', 'Online')) NOT NULL
);

-- 3. Products Table
CREATE TABLE IF NOT EXISTS Products (
    product_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    category TEXT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INTEGER DEFAULT 0,
    description TEXT
);

-- 4. Orders Table
CREATE TABLE IF NOT EXISTS Orders (
    order_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_id INTEGER,
    branch_id INTEGER,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) DEFAULT 0.00,
    status TEXT CHECK(status IN ('Pending', 'Completed', 'Shipped', 'Cancelled')) DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);

-- 5. OrderItems Table (Linking Table for Many-to-Many between Orders and Products)
CREATE TABLE IF NOT EXISTS OrderItems (
    item_id INTEGER PRIMARY KEY AUTOINCREMENT,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
