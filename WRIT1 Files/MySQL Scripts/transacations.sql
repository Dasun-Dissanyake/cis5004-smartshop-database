-- Start transaction
START TRANSACTION;

-- Insert order (order_id will be auto-generated)
INSERT INTO orders (customer_id, branch_id, order_date, total_amount, status)
VALUES (1, 1, NOW(), 0.00, 'Pending');

-- Get the new order_id (for MySQL)
SET @new_order_id = LAST_INSERT_ID();

-- Insert order items (for product_id 1 and 2)
INSERT INTO orderitems (order_id, product_id, quantity, unit_price, subtotal)
VALUES 
    (@new_order_id, 1, 1, 1500.00, 1500.00),
    (@new_order_id, 2, 2, 25.00, 50.00);   -- two wireless mice

-- Update stock
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 1;
UPDATE products SET stock_quantity = stock_quantity - 2 WHERE product_id = 2;

-- Update order total
UPDATE orders SET total_amount = 1550.00 WHERE order_id = @new_order_id;

-- If everything is OK, commit
COMMIT;




START TRANSACTION;

INSERT INTO orders (customer_id, branch_id, order_date, status)
VALUES (2, 3, NOW(), 'Pending');

SET @new_order_id = LAST_INSERT_ID();

INSERT INTO orderitems (order_id, product_id, quantity, unit_price, subtotal)
VALUES (@new_order_id, 999, 1, 100.00, 100.00);
ROLLBACK;


-- After running, check if order exists:
SELECT * FROM orders WHERE order_id = @new_order_id; -- Should be empty if rollback happened.



 -- Demonstrating Concurrency with Row Locking
START TRANSACTION;
SELECT stock_quantity FROM products WHERE product_id = 1 FOR UPDATE;
-- Now check if enough stock (e.g., stock is 20)
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 1;
COMMIT;

-- Session 2 (run simultaneously in another query tab)
START TRANSACTION;
SELECT stock_quantity FROM products WHERE product_id = 1 FOR UPDATE;
-- This will wait until Session 1 commits or times out.
-- Once Session 1 commits, Session 2 gets the updated stock value.
UPDATE products SET stock_quantity = stock_quantity - 1 WHERE product_id = 1;
COMMIT;


