-- SmartShop Ltd - Key Analytical Queries

-- 1. Top-Selling Products (by total quantity sold)
SELECT 
    p.name AS Product,
    p.category,
    SUM(oi.quantity) AS TotalSold,
    SUM(oi.subtotal) AS TotalRevenue
FROM OrderItems oi
JOIN Products p ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY TotalSold DESC;

-- 2. Monthly Sales by Branch
-- Note: strftime is SQLite specific for date formatting
SELECT 
    b.branch_name AS Branch,
    strftime('%Y-%m', o.order_date) AS Month,
    SUM(o.total_amount) AS MonthlyRevenue,
    COUNT(o.order_id) AS TransactionCount
FROM Orders o
JOIN Branches b ON o.branch_id = b.branch_id
GROUP BY b.branch_name, Month
ORDER BY Month DESC, MonthlyRevenue DESC;

-- 3. Customer Purchase History (Total spent per customer)
SELECT 
    c.first_name || ' ' || c.last_name AS Customer,
    COUNT(o.order_id) AS NumberOfOrders,
    SUM(o.total_amount) AS TotalSpent
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY TotalSpent DESC;

-- 4. Low Stock Alert (Products with less than 25 in stock)
SELECT 
    name, 
    stock_quantity, 
    category
FROM Products
WHERE stock_quantity < 25
ORDER BY stock_quantity ASC;
