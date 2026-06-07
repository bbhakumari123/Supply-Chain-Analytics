CREATE DATABASE Supplychain_Analysis;
Use Supplychain_Analysis;

# Total Orders KPI
CREATE OR REPLACE VIEW vw_total_orders AS
SELECT CASE WHEN COUNT(Order_ID) >= 1000000000 THEN CONCAT(ROUND(COUNT(Order_ID) / 1000000000.0, 2), ' B')
            WHEN COUNT(Order_ID) >= 1000000 THEN CONCAT(ROUND(COUNT(Order_ID) / 1000000.0, 2), ' M')
            WHEN COUNT(Order_ID) >= 1000 THEN CONCAT(ROUND(COUNT(Order_ID) / 1000.0, 2), ' K')
            ELSE CAST(ROUND(COUNT(Order_ID), 2) AS CHAR)
       END AS Total_Orders
FROM Fact_Orders;

# Total Sales Revenue
CREATE OR REPLACE VIEW vw_total_sales_revenue AS
SELECT CASE WHEN SUM(Revenue) >= 1000000000 THEN CONCAT(ROUND(SUM(Revenue) / 1000000000.0, 2), ' B')
            WHEN SUM(Revenue) >= 1000000 THEN CONCAT(ROUND(SUM(Revenue) / 1000000.0, 2), ' M')
            WHEN SUM(Revenue) >= 1000 THEN CONCAT(ROUND(SUM(Revenue) / 1000.0, 2), ' K')
            ELSE CAST(ROUND(SUM(Revenue), 2) AS CHAR)
       END AS Total_Sales_Revenue
FROM Fact_Orders;

# Average Order Value (AOV)
CREATE OR REPLACE VIEW vw_average_order_value AS
SELECT CASE WHEN SUM(Revenue) / COUNT(DISTINCT Order_ID) >= 1000000 THEN CONCAT(ROUND((SUM(Revenue) / COUNT(DISTINCT Order_ID)) / 1000000, 1), ' M')
            WHEN SUM(Revenue) / COUNT(DISTINCT Order_ID) >= 1000 THEN CONCAT(ROUND((SUM(Revenue) / COUNT(DISTINCT Order_ID)) / 1000, 1), ' K')
            ELSE ROUND(SUM(Revenue) / COUNT(DISTINCT Order_ID), 2)
	   END AS Average_Order_Value
FROM Fact_Orders;

# Sales by Product & Category
CREATE OR REPLACE VIEW vw_sales_by_product_category AS
SELECT p.Product_ID, p.Product_Name, p.Category, p.Sub_Category,
    CASE WHEN SUM(f.Revenue) >= 1000000000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000000000.0,2), ' B')
         WHEN SUM(f.Revenue) >= 1000000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000000.0,2), ' M')
         WHEN SUM(f.Revenue) >= 1000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000.0,2), ' K')
         ELSE CAST(ROUND(SUM(f.Revenue),2) AS CHAR)
    END AS Total_Revenue,
    SUM(f.Order_Quantity) AS Total_Quantity_Sold
FROM Fact_Orders f
JOIN Dim_Product p
ON f.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Product_Name, p.Category, p.Sub_Category;
    
# Orders by Region / Country / City
CREATE OR REPLACE VIEW vw_orders_by_region AS
SELECT c.Customer_Region, c.Customer_Country, c.Customer_City, COUNT(f.Order_ID) AS Total_Orders,
    CASE WHEN SUM(f.Revenue) >= 1000000000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000000000.0,2), ' B')
         WHEN SUM(f.Revenue) >= 1000000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000000.0,2), ' M')
         WHEN SUM(f.Revenue) >= 1000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000.0,2), ' K')
         ELSE CAST(ROUND(SUM(f.Revenue),2) AS CHAR)
    END AS Total_Revenue
FROM Fact_Orders f
JOIN Dim_Customer c
ON f.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Region, c.Customer_Country, c.Customer_City;
    
# Monthly Sales Trend (MTD / Monthly Tracking)
CREATE OR REPLACE VIEW vw_monthly_sales_trend AS
SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS Sales_Month, COUNT(Order_ID) AS Total_Orders,
    CASE WHEN SUM(Revenue) >= 1000000000 THEN CONCAT(ROUND(SUM(Revenue)/1000000000.0,2), ' B')
         WHEN SUM(Revenue) >= 1000000 THEN CONCAT(ROUND(SUM(Revenue)/1000000.0,2), ' M')
         WHEN SUM(Revenue) >= 1000 THEN CONCAT(ROUND(SUM(Revenue)/1000.0,2), ' K')
         ELSE CAST(ROUND(SUM(Revenue),2) AS CHAR)
    END AS Total_Revenue
FROM Fact_Orders
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m');

# Daily Sales Trend
CREATE OR REPLACE VIEW vw_daily_sales_trend AS
SELECT Order_Date, COUNT(Order_ID) AS Daily_Orders,
    CASE WHEN SUM(Revenue) >= 1000000000 THEN CONCAT(ROUND(SUM(Revenue)/1000000000.0,2), ' B')
         WHEN SUM(Revenue) >= 1000000 THEN CONCAT(ROUND(SUM(Revenue)/1000000.0,2), ' M')
         WHEN SUM(Revenue) >= 1000 THEN CONCAT(ROUND(SUM(Revenue)/1000.0,2), ' K')
         ELSE CAST(ROUND(SUM(Revenue),2) AS CHAR)
    END AS Daily_Revenue
FROM Fact_Orders
GROUP BY Order_Date;

# Stock on Hand
CREATE OR REPLACE VIEW vw_stock_on_hand AS
SELECT Product_ID, Warehouse_ID,
    CASE WHEN SUM(Stock_On_Hand) >= 1000000000 THEN CONCAT(ROUND(SUM(Stock_On_Hand)/1000000000.0,2), ' B')
         WHEN SUM(Stock_On_Hand) >= 1000000 THEN CONCAT(ROUND(SUM(Stock_On_Hand)/1000000.0,2), ' M')
         WHEN SUM(Stock_On_Hand) >= 1000 THEN CONCAT(ROUND(SUM(Stock_On_Hand)/1000.0,2), ' K')
         ELSE CAST(ROUND(SUM(Stock_On_Hand),2) AS CHAR)
    END AS Total_Stock_On_Hand
FROM Fact_Inventory
GROUP BY Product_ID, Warehouse_ID;
    
# Inventory Value
CREATE OR REPLACE VIEW vw_inventory_value AS
SELECT i.Product_ID, p.Product_Name, i.Warehouse_ID,
    CASE WHEN SUM(i.Stock_On_Hand * p.Unit_Cost) >= 1000000000 THEN CONCAT(ROUND(SUM(i.Stock_On_Hand * p.Unit_Cost)/1000000000.0,2), ' B')
         WHEN SUM(i.Stock_On_Hand * p.Unit_Cost) >= 1000000 THEN CONCAT(ROUND(SUM(i.Stock_On_Hand * p.Unit_Cost)/1000000.0,2), ' M')
         WHEN SUM(i.Stock_On_Hand * p.Unit_Cost) >= 1000 THEN CONCAT(ROUND(SUM(i.Stock_On_Hand * p.Unit_Cost)/1000.0,2), ' K')
         ELSE CAST(ROUND(SUM(i.Stock_On_Hand * p.Unit_Cost),2) AS CHAR)
    END AS Inventory_Value
FROM Fact_Inventory i
JOIN Dim_Product p
ON i.Product_ID = p.Product_ID
GROUP BY i.Product_ID, p.Product_Name, i.Warehouse_ID;
    
# Inventory Turnover
CREATE OR REPLACE VIEW vw_inventory_turnover AS
SELECT i.Product_ID, p.Product_Name, ROUND(SUM(f.COGS) / NULLIF(AVG(i.Stock_On_Hand * p.Unit_Cost),0),2) AS Inventory_Turnover
FROM Fact_Inventory i
JOIN Dim_Product p
ON i.Product_ID = p.Product_ID
JOIN Fact_Orders f
ON i.Product_ID = f.Product_ID
GROUP BY i.Product_ID, p.Product_Name;
    
# Days of Inventory on Hand (DOH)
CREATE OR REPLACE VIEW vw_days_inventory_on_hand AS
SELECT i.Product_ID, p.Product_Name,
    ROUND((AVG(i.Stock_On_Hand * p.Unit_Cost)/ NULLIF(SUM(f.COGS),0)) * 365) AS Days_Inventory_On_Hand
FROM Fact_Inventory i
JOIN Dim_Product p ON i.Product_ID = p.Product_ID
JOIN Fact_Orders f ON i.Product_ID = f.Product_ID
GROUP BY i.Product_ID, p.Product_Name;

# Reorder Status
CREATE OR REPLACE VIEW vw_reorder_status AS
SELECT Product_ID, Warehouse_ID, Stock_On_Hand, Reorder_Level,
    CASE WHEN Stock_On_Hand < Reorder_Level THEN 'REORDER REQUIRED'
         ELSE 'STOCK SUFFICIENT'
    END AS Reorder_Status
FROM Fact_Inventory;

# On-Time Delivery %
CREATE OR REPLACE VIEW vw_on_time_delivery AS
SELECT CONCAT(ROUND((SUM(CASE WHEN Actual_Delivery_Date <= Promised_Delivery_Date THEN 1 ELSE 0 END) * 100.0) / COUNT(*),2), "%") AS On_Time_Delivery_Pct
FROM Fact_Orders;

# Average Delivery Lead Time
CREATE OR REPLACE VIEW vw_avg_delivery_lead_time AS
SELECT ROUND(AVG(DATEDIFF(Actual_Delivery_Date, Order_Date)),2) AS Avg_Lead_Time_Days FROM Fact_Orders;

# Average Delay Days
CREATE OR REPLACE VIEW vw_average_delay_days AS
SELECT ROUND(AVG(Delay_Days),2) AS Average_Delay_Days FROM Fact_Orders WHERE Delay_Days > 0;

# Orders by Ship Mode
CREATE OR REPLACE VIEW vw_orders_by_ship_mode AS
SELECT Ship_Mode, COUNT(Order_ID) AS Total_Orders,
    CASE WHEN SUM(Revenue) >= 1000000000 THEN CONCAT(ROUND(SUM(Revenue)/1000000000.0,2), ' B')
         WHEN SUM(Revenue) >= 1000000 THEN CONCAT(ROUND(SUM(Revenue)/1000000.0,2), ' M')
         WHEN SUM(Revenue) >= 1000 THEN CONCAT(ROUND(SUM(Revenue)/1000.0,2), ' K')
         ELSE CAST(ROUND(SUM(Revenue),2) AS CHAR)
    END AS Revenue
FROM Fact_Orders
GROUP BY Ship_Mode;

# Freight Cost per Order
CREATE OR REPLACE VIEW vw_freight_cost_per_order AS
SELECT ROUND(AVG(Shipping_Cost),2) AS Avg_Freight_Cost_Per_Order
FROM Fact_Orders;

# Order Cycle Time
CREATE OR REPLACE VIEW vw_order_cycle_time AS
SELECT ROUND(AVG(DATEDIFF(Actual_Delivery_Date, Order_Date)),2) AS Avg_Order_Cycle_Time_Days
FROM Fact_Orders;

# Fill Rate %
CREATE OR REPLACE VIEW vw_fill_rate AS
SELECT CONCAT(ROUND((SUM(Shipped_Quantity) * 100.0)/ NULLIF(SUM(Order_Quantity),0),2), "%") AS Fill_Rate_Pct
FROM Fact_Orders;

# Backorder Rate
CREATE OR REPLACE VIEW vw_backorder_rate AS
SELECT ROUND((SUM(CASE WHEN Shipped_Quantity < Order_Quantity THEN 1 ELSE 0 END) * 100.0) / COUNT(*),2) AS Backorder_Rate_Pct
FROM Fact_Orders;

# Perfect Order Rate
CREATE OR REPLACE VIEW vw_perfect_order_rate AS
SELECT ROUND((SUM(CASE WHEN Actual_Delivery_Date <= Promised_Delivery_Date AND Shipped_Quantity = Order_Quantity THEN 1 ELSE 0 END) * 100.0) / COUNT(*),2) AS Perfect_Order_Rate_Pct
FROM Fact_Orders;

# Supplier Performance Score
CREATE OR REPLACE VIEW vw_supplier_performance AS
SELECT s.Supplier_ID, s.Supplier_Name, s.Supplier_Tier, s.Reliability_Score,
    COUNT(f.Order_ID) AS Total_Orders,
    ROUND(AVG(f.Delay_Days),2) AS Avg_Delay_Days,
    CASE WHEN SUM(f.Revenue) >= 1000000000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000000000.0,2), ' B')
         WHEN SUM(f.Revenue) >= 1000000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000000.0,2), ' M')
         WHEN SUM(f.Revenue) >= 1000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000.0,2), ' K')
         ELSE CAST(ROUND(SUM(f.Revenue),2) AS CHAR)
    END AS Total_Business_Value
FROM Fact_Orders f
JOIN Dim_Supplier s
ON f.Supplier_ID = s.Supplier_ID
GROUP By s.Supplier_ID, s.Supplier_Name, s.Supplier_Tier, s.Reliability_Score;
    
# Supplier On-Time Delivery %
CREATE OR REPLACE VIEW vw_supplier_otd AS
SELECT s.Supplier_ID, s.Supplier_Name,
    CONCAT(ROUND((SUM(CASE WHEN f.Actual_Delivery_Date <= f.Promised_Delivery_Date THEN 1 ELSE 0 END) * 100.0) / COUNT(*),2), "%") AS Supplier_OTD_Pct
FROM Fact_Orders f
JOIN Dim_Supplier s
ON f.Supplier_ID = s.Supplier_ID
GROUP BY s.Supplier_ID, s.Supplier_Name;

# Spend by Supplier
CREATE OR REPLACE VIEW vw_spend_by_supplier AS
SELECT s.Supplier_ID, s.Supplier_Name,
    CASE WHEN SUM(f.COGS) >= 1000000000 THEN CONCAT(ROUND(SUM(f.COGS)/1000000000.0,2), ' B')
         WHEN SUM(f.COGS) >= 1000000 THEN CONCAT(ROUND(SUM(f.COGS)/1000000.0,2), ' M')
         WHEN SUM(f.COGS) >= 1000 THEN CONCAT(ROUND(SUM(f.COGS)/1000.0,2), ' K')
         ELSE CAST(ROUND(SUM(f.COGS),2) AS CHAR)
    END AS Total_Spend
FROM Fact_Orders f
JOIN Dim_Supplier s
ON f.Supplier_ID = s.Supplier_ID
GROUP BY s.Supplier_ID, s.Supplier_Name;

# Warehouse Utilization
CREATE OR REPLACE VIEW vw_warehouse_utilization AS
SELECT w.Warehouse_ID, w.Warehouse_City, w.Capacity_Units,
    SUM(i.Stock_On_Hand) AS Current_Stock,
    ROUND((SUM(i.Stock_On_Hand) * 100.0)/ NULLIF(w.Capacity_Units,0),2) AS Utilization_Pct
FROM Fact_Inventory i
JOIN Dim_Warehouse w
ON i.Warehouse_ID = w.Warehouse_ID
GROUP BY w.Warehouse_ID, w.Warehouse_City, w.Capacity_Units;
    
# Top 5 Products by Revenue
CREATE OR REPLACE VIEW vw_top_5_products AS
SELECT p.Product_ID, p.Product_Name,
    CASE WHEN SUM(f.Revenue) >= 1000000000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000000000.0,2), ' B')
         WHEN SUM(f.Revenue) >= 1000000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000000.0,2), ' M')
         WHEN SUM(f.Revenue) >= 1000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000.0,2), ' K')
         ELSE CAST(ROUND(SUM(f.Revenue),2) AS CHAR)
    END AS Total_Revenue
FROM Fact_Orders f
JOIN Dim_Product p
ON f.Product_ID = p.Product_ID
GROUP BY p.Product_ID, p.Product_Name
ORDER BY SUM(f.Revenue) DESC
LIMIT 5;

# Top Customers by Revenue
CREATE OR REPLACE VIEW vw_top_customers AS
SELECT c.Customer_ID, c.Customer_Segment, c.Customer_Country,
    CASE WHEN SUM(f.Revenue) >= 1000000000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000000000.0,2), ' B')
         WHEN SUM(f.Revenue) >= 1000000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000000.0,2), ' M')
         WHEN SUM(f.Revenue) >= 1000 THEN CONCAT(ROUND(SUM(f.Revenue)/1000.0,2), ' K')
         ELSE CAST(ROUND(SUM(f.Revenue),2) AS CHAR)
    END AS Total_Revenue
FROM Fact_Orders f
JOIN Dim_Customer c
ON f.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Segment, c.Customer_Country;

# Sales Growth %
CREATE OR REPLACE VIEW vw_sales_growth AS
WITH monthly_sales AS (
    SELECT DATE_FORMAT(Order_Date, '%Y-%m') AS Sales_Month, SUM(Revenue) AS Monthly_Revenue
    FROM Fact_Orders
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)
SELECT Sales_Month,
    CONCAT(ROUND(Monthly_Revenue / 1000000, 2), ' M') AS Monthly_Revenue,
    CONCAT(ROUND(COALESCE(LAG(Monthly_Revenue) OVER (ORDER BY Sales_Month),0) / 1000000,2),' M') AS Prev_Month_Revenue,
    CONCAT(ROUND(COALESCE(((Monthly_Revenue -LAG(Monthly_Revenue) OVER (ORDER BY Sales_Month))/ NULLIF(LAG(Monthly_Revenue) OVER (ORDER BY Sales_Month), 0)) * 100, 0), 2), '%') AS Sales_Growth_PCT
FROM monthly_sales;

# Cost-to-Serve per Customer
CREATE OR REPLACE VIEW vw_cost_to_serve_customer AS
SELECT c.Customer_ID, c.Customer_Segment,
    CASE WHEN SUM(f.Shipping_Cost + f.COGS) >= 1000000000 THEN CONCAT(ROUND(SUM(f.Shipping_Cost + f.COGS)/1000000000.0,2), ' B')
        WHEN SUM(f.Shipping_Cost + f.COGS) >= 1000000 THEN CONCAT(ROUND(SUM(f.Shipping_Cost + f.COGS)/1000000.0,2), ' M')
        WHEN SUM(f.Shipping_Cost + f.COGS) >= 1000 THEN CONCAT(ROUND(SUM(f.Shipping_Cost + f.COGS)/1000.0,2), ' K')
        ELSE CAST(ROUND(SUM(f.Shipping_Cost + f.COGS),2) AS CHAR)
    END AS Total_Cost_To_Serve,
    COUNT(f.Order_ID) AS Total_Orders,
    ROUND(SUM(f.Shipping_Cost + f.COGS)/ COUNT(f.Order_ID),2) AS Cost_Per_Order
FROM Fact_Orders f
JOIN Dim_Customer c
ON f.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Segment;
    
#Final Execution
SELECT * FROM vw_total_orders;
SELECT * FROM vw_total_sales_revenue;
SELECT * FROM vw_average_order_value;
SELECT * FROM vw_sales_by_product_category;
SELECT * FROM vw_orders_by_region;
SELECT * FROM vw_monthly_sales_trend;
SELECT * FROM vw_daily_sales_trend;
SELECT * FROM vw_stock_on_hand;
SELECT * FROM vw_inventory_value;
SELECT * FROM vw_inventory_turnover;
SELECT * FROM vw_days_inventory_on_hand;
SELECT * FROM vw_reorder_status;
SELECT * FROM vw_on_time_delivery;
SELECT * FROM vw_avg_delivery_lead_time;
SELECT * FROM vw_average_delay_days;
SELECT * FROM vw_orders_by_ship_mode;
SELECT * FROM vw_freight_cost_per_order;
SELECT * FROM vw_order_cycle_time;
SELECT * FROM vw_fill_rate;
SELECT * FROM vw_backorder_rate;
SELECT * FROM vw_perfect_order_rate;
SELECT * FROM vw_supplier_performance;
SELECT * FROM vw_supplier_otd;
SELECT * FROM vw_spend_by_supplier;
SELECT * FROM vw_warehouse_utilization;
SELECT * FROM vw_top_5_products;
SELECT * FROM vw_top_customers;
SELECT * FROM vw_sales_growth;
SELECT * FROM vw_cost_to_serve_customer;
    

