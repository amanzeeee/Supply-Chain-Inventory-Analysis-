-- I'm using these queries.

use supply_chain;


select * from inventory;



-- Q1. Total Products
SELECT COUNT(*) AS Total_Products
FROM products;


-- Q2. Total Suppliers
SELECT COUNT(*) AS Total_Suppliers
FROM suppliers;




-- Q3. Total Warehouses
SELECT COUNT(*) AS Total_Warehouses
FROM warehouses;



-- Q4. Total Inventory Units
SELECT SUM(CurrentStock) AS Total_Inventory
FROM inventory;

-- Q5. Low Stock Products
SELECT *
FROM inventory
WHERE CurrentStock < ReorderLevel;



-- Q6. Overstock Products
SELECT *
FROM inventory
WHERE CurrentStock > MaxStock;

-- Q7. Total Inventory 
 Value
SELECT
SUM(i.CurrentStock * p.UnitCost) AS Inventory_Value
FROM inventory i
JOIN products p
ON i.ProductID = p.ProductID;



-- Q8. Total Orders
SELECT COUNT(*) AS Total_Orders
FROM orders;


-- Q9. Total Revenue
SELECT SUM(Revenue) AS Total_Revenue
FROM sales;


-- Q10. Average Delivery Delay
SELECT AVG(DelayDays) AS Avg_Delay
FROM deliveries;






-- Q11. Top 10 Selling Products
SELECT
    ProductID,
    SUM(UnitsSold) AS Total_Units_Sold
FROM sales
GROUP BY ProductID
ORDER BY Total_Units_Sold DESC
LIMIT 10;




-- Q12. Revenue by Product
SELECT
    ProductID,
    SUM(Revenue) AS Total_Revenue
FROM sales
GROUP BY ProductID
ORDER BY Total_Revenue DESC;



-- Q13. Revenue by Warehouse
SELECT
    WarehouseID,
    SUM(Revenue) AS Total_Revenue
FROM sales
GROUP BY WarehouseID
ORDER BY Total_Revenue DESC;





-- Q14. Orders by Warehouse
SELECT
    WarehouseID,
    COUNT(OrderID) AS Total_Orders
FROM orders
GROUP BY WarehouseID
ORDER BY Total_Orders DESC;





-- Q15. Average Delay by Supplier
SELECT
    SupplierID,
    AVG(DelayDays) AS Avg_Delay
FROM deliveries
GROUP BY SupplierID
ORDER BY Avg_Delay DESC;






-- Q16. Late Deliveries Count by Supplier
SELECT
    SupplierID,
    COUNT(*) AS Late_Deliveries
FROM deliveries
WHERE DelayDays > 0
GROUP BY SupplierID
ORDER BY Late_Deliveries DESC;





-- Q17. Inventory Value by Warehouse
SELECT
    i.WarehouseID,
    SUM(i.CurrentStock * p.UnitCost) AS Inventory_Value
FROM inventory i
JOIN products p
ON i.ProductID = p.ProductID
GROUP BY i.WarehouseID
ORDER BY Inventory_Value DESC;





-- Q18. Category-wise Inventory Value
SELECT
    p.Category,
    SUM(i.CurrentStock * p.UnitCost) AS Inventory_Value
FROM inventory i
JOIN products p
ON i.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY Inventory_Value DESC;




-- Q19. Monthly Revenue Trend
SELECT
    MONTH(Date) AS Month_No,
    SUM(Revenue) AS Total_Revenue
FROM sales
GROUP BY MONTH(Date)
ORDER BY Month_No;




-- Q20. Monthly Orders Trend
SELECT
    MONTH(Date) AS Month_No,
    COUNT(OrderID) AS Total_Orders
FROM orders
GROUP BY MONTH(Date)
ORDER BY Month_No;





-- Q21. Top 5 Products by Revenue (Ranking)
SELECT
    ProductID,
    SUM(Revenue) AS Total_Revenue,
    RANK() OVER(ORDER BY SUM(Revenue) DESC) AS Revenue_Rank
FROM sales
GROUP BY ProductID;




-- Q22. Running Total Revenue
SELECT
    Date,
    SUM(Revenue) AS Daily_Revenue,
    SUM(SUM(Revenue)) OVER(ORDER BY Date) AS Running_Revenue
FROM sales
GROUP BY Date;




-- Q23. Monthly Revenue Growth
SELECT
    MONTH(Date) AS Month_No,
    SUM(Revenue) AS Revenue,
    LAG(SUM(Revenue)) OVER(ORDER BY MONTH(Date)) AS Previous_Month
FROM sales
GROUP BY MONTH(Date);




-- Q24. Warehouse Revenue Ranking
SELECT
    WarehouseID,
    SUM(Revenue) AS Revenue,
    DENSE_RANK() OVER(ORDER BY SUM(Revenue) DESC) AS Warehouse_Rank
FROM sales
GROUP BY WarehouseID;





-- Q25. Top 10 Most Ordered Products
SELECT
    ProductID,
    COUNT(OrderID) AS Orders_Count
FROM orders
GROUP BY ProductID
ORDER BY Orders_Count DESC
LIMIT 10;






-- Q26. Fast Moving Products
SELECT
    ProductID,
    SUM(UnitsSold) AS Units_Sold
FROM sales
GROUP BY ProductID
ORDER BY Units_Sold DESC
LIMIT 10;





-- Q27. Slow Moving Products
SELECT
    ProductID,
    SUM(UnitsSold) AS Units_Sold
FROM sales
GROUP BY ProductID
ORDER BY Units_Sold ASC
LIMIT 10;





-- Q28. Supplier Performance
SELECT
    SupplierID,
    AVG(DelayDays) AS Avg_Delay,
    COUNT(*) AS Total_Deliveries
FROM deliveries
GROUP BY SupplierID
ORDER BY Avg_Delay;





-- Q29. Inventory Status
SELECT
    WarehouseID,
    ProductID,
    CurrentStock,
    CASE
        WHEN CurrentStock < ReorderLevel THEN 'Low Stock'
        WHEN CurrentStock > MaxStock THEN 'Over Stock'
        ELSE 'Normal'
    END AS Stock_Status
FROM inventory;





-- Q30. Highest Inventory Value Products
SELECT
    p.ProductID,
    p.Product,
    SUM(i.CurrentStock * p.UnitCost) AS Inventory_Value
FROM inventory i
JOIN products p
ON i.ProductID = p.ProductID
GROUP BY p.ProductID, p.Product
ORDER BY Inventory_Value DESC
LIMIT 10;