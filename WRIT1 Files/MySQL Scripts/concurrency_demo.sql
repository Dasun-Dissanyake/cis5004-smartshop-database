
-- Demonstrate concurrency control with SELECT ... FOR UPDATE

-- Step 1: Set stock to 1 for demo
UPDATE Products SET stock_quantity = 1 WHERE product_id = 1;
SELECT product_id, name, stock_quantity FROM Products WHERE product_id = 1;

-- In Session A:
START TRANSACTION;
SELECT stock_quantity FROM Products WHERE product_id = 1 FOR UPDATE;
-- (do not commit yet)

-- In Session B (run in another tab):
START TRANSACTION;
SELECT stock_quantity FROM Products WHERE product_id = 1 FOR UPDATE;
-- This will wait until Session A commits

-- Back in Session A:
UPDATE Products SET stock_quantity = stock_quantity - 1 WHERE product_id = 1;
INSERT INTO Orders (customer_id, branch_id, order_date, total_amount, status)
VALUES (1, 1, NOW(), 1500.00, 'Completed');
SET @new_order_id = LAST_INSERT_ID();
INSERT INTO OrderItems (order_id, product_id, quantity, unit_price, subtotal)
VALUES (@new_order_id, 1, 1, 1500.00, 1500.00);
COMMIT;

-- Now Session B's SELECT returns (stock now 0)
-- Session B can then:
ROLLBACK;

-- Optional: Reset stock
UPDATE Products SET stock_quantity = 1 WHERE product_id = 1;

-- Set stock to 1 for demo
UPDATE Products SET stock_quantity = 1 WHERE product_id = 1;
-- Verify
SELECT product_id, name, stock_quantity FROM Products WHERE product_id = 1;