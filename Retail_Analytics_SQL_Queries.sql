-- ====================================================================
-- RETAIL BUSINESS PERFORMANCE ANALYTICS SUITE
-- Business Intelligence & Executive Reporting Queries
-- Author: Ajay Saini
-- Dataset: 9,994 Retail Transaction Records
-- ====================================================================

-- 1. Executive Summary KPIs: Total Sales, Total Profit & Profit Margin
SELECT 
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    COUNT(DISTINCT Customer_ID) AS Total_Customers,
    ROUND(SUM(Sales), 2) AS Total_Revenue,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Overall_Profit_Margin_Pct,
    ROUND(AVG(Discount) * 100, 2) AS Avg_Discount_Pct
FROM Retail_Transactions;


-- 2. Regional Performance & Contribution Breakdown
SELECT 
    Region,
    COUNT(DISTINCT Order_ID) AS Orders_Count,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Regional_Margin_Pct,
    ROUND((SUM(Sales) / (SELECT SUM(Sales) FROM Retail_Transactions)) * 100, 2) AS Sales_Contribution_Pct
FROM Retail_Transactions
GROUP BY Region
ORDER BY Total_Sales DESC;


-- 3. Category & Sub-Category Profitability Analysis
SELECT 
    Category,
    Sub_Category,
    COUNT(Row_ID) AS Total_Items_Sold,
    ROUND(SUM(Sales), 2) AS SubCategory_Sales,
    ROUND(SUM(Profit), 2) AS SubCategory_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Margin_Pct,
    ROUND(AVG(Discount) * 100, 2) AS Avg_Discount_Given
FROM Retail_Transactions
GROUP BY Category, Sub_Category
ORDER BY Category, SubCategory_Profit DESC;


-- 4. Deep-Dive: Impact of Discounting on Margin Erosion (Profit Leakage)
SELECT 
    CASE 
        WHEN Discount = 0.0 THEN '0% (No Discount)'
        WHEN Discount BETWEEN 0.01 AND 0.20 THEN '1% - 20% (Low)'
        WHEN Discount BETWEEN 0.21 AND 0.40 THEN '21% - 40% (Moderate)'
        ELSE 'Above 40% (Aggressive Discount)'
    END AS Discount_Bracket,
    COUNT(Row_ID) AS Transaction_Volume,
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Realized_Margin_Pct
FROM Retail_Transactions
GROUP BY 
    CASE 
        WHEN Discount = 0.0 THEN '0% (No Discount)'
        WHEN Discount BETWEEN 0.01 AND 0.20 THEN '1% - 20% (Low)'
        WHEN Discount BETWEEN 0.21 AND 0.40 THEN '21% - 40% (Moderate)'
        ELSE 'Above 40% (Aggressive Discount)'
    END
ORDER BY Total_Sales DESC;


-- 5. Customer Segment Performance Matrix
SELECT 
    Segment,
    COUNT(DISTINCT Customer_ID) AS Active_Customers,
    COUNT(DISTINCT Order_ID) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Segment_Revenue,
    ROUND(SUM(Profit), 2) AS Segment_Profit,
    ROUND(SUM(Sales) / COUNT(DISTINCT Order_ID), 2) AS Avg_Order_Value (AOV),
    ROUND((SUM(Profit) / SUM(Sales)) * 100, 2) AS Margin_Pct
FROM Retail_Transactions
GROUP BY Segment
ORDER BY Segment_Revenue DESC;


-- 6. Year-Over-Year (YoY) Sales & Growth Trend (Window Functions)
WITH MonthlySales AS (
    SELECT 
        STRFTIME('%Y-%m', Order_Date) AS YearMonth,
        ROUND(SUM(Sales), 2) AS Monthly_Revenue,
        ROUND(SUM(Profit), 2) AS Monthly_Profit
    FROM Retail_Transactions
    GROUP BY STRFTIME('%Y-%m', Order_Date)
)
SELECT 
    YearMonth,
    Monthly_Revenue,
    LAG(Monthly_Revenue, 1) OVER (ORDER BY YearMonth) AS Prev_Month_Revenue,
    ROUND(((Monthly_Revenue - LAG(Monthly_Revenue, 1) OVER (ORDER BY YearMonth)) / 
           LAG(Monthly_Revenue, 1) OVER (ORDER BY YearMonth)) * 100, 2) AS MoM_Growth_Pct,
    Monthly_Profit
FROM MonthlySales;
