-- ============================================
-- E-commerce Customer Retention & Funnel Analysis
-- ============================================

-- 🔹 1. Total Users
SELECT COUNT(DISTINCT CustomerID) AS total_users
FROM ecommerce;


-- 🔹 2. First-Time Buyers
SELECT COUNT(DISTINCT CustomerID) AS first_time_users
FROM ecommerce;


-- 🔹 3. Repeat Users
SELECT COUNT(*) AS repeat_users
FROM (
    SELECT CustomerID
    FROM ecommerce
    GROUP BY CustomerID
    HAVING COUNT(DISTINCT InvoiceNo) > 1
) t;


-- 🔹 4. Retention Rate
SELECT 
    COUNT(DISTINCT CASE WHEN order_count > 1 THEN CustomerID END) 
    / COUNT(DISTINCT CustomerID) AS retention_rate
FROM (
    SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS order_count
    FROM ecommerce
    GROUP BY CustomerID
) t;


-- 🔹 5. One-Time Users (Drop-off)
SELECT COUNT(*) AS one_time_users
FROM (
    SELECT CustomerID
    FROM ecommerce
    GROUP BY CustomerID
    HAVING COUNT(DISTINCT InvoiceNo) = 1
) t;


-- 🔹 6. Time to Second Purchase
SELECT 
    AVG(DATEDIFF(second_order, first_order)) AS avg_days_to_repeat
FROM (
    SELECT 
        CustomerID,
        MIN(InvoiceDate) AS first_order,
        MAX(InvoiceDate) AS second_order
    FROM ecommerce
    GROUP BY CustomerID
    HAVING COUNT(DISTINCT InvoiceNo) > 1
) t;


-- 🔹 7. Customer Segmentation (RFM - simplified)
SELECT 
    CASE 
        WHEN total_spent < 100 THEN 'Low Value'
        WHEN total_spent BETWEEN 100 AND 500 THEN 'Medium Value'
        ELSE 'High Value'
    END AS segment,
    COUNT(*) AS users
FROM (
    SELECT CustomerID, SUM(Quantity * UnitPrice) AS total_spent
    FROM ecommerce
    GROUP BY CustomerID
) t
GROUP BY segment;


-- 🔹 8. Funnel Summary
SELECT 
    COUNT(DISTINCT CustomerID) AS total_users,
    COUNT(DISTINCT CASE WHEN order_count > 1 THEN CustomerID END) AS retained_users,
    COUNT(DISTINCT CASE WHEN order_count = 1 THEN CustomerID END) AS dropped_users
FROM (
    SELECT CustomerID, COUNT(DISTINCT InvoiceNo) AS order_count
    FROM ecommerce
    GROUP BY CustomerID
) t;


-- 🔹 9. Cohort Analysis (User Acquisition)
SELECT 
    DATE_FORMAT(first_purchase, '%Y-%m') AS cohort_month,
    COUNT(DISTINCT CustomerID) AS users
FROM (
    SELECT 
        CustomerID,
        MIN(InvoiceDate) AS first_purchase
    FROM ecommerce
    GROUP BY CustomerID
) t
GROUP BY cohort_month
ORDER BY cohort_month;


-- 🔹 10. Revenue by Cohort
SELECT 
    DATE_FORMAT(first_purchase, '%Y-%m') AS cohort_month,
    SUM(total_spent) AS revenue
FROM (
    SELECT 
        CustomerID,
        MIN(InvoiceDate) AS first_purchase,
        SUM(Quantity * UnitPrice) AS total_spent
    FROM ecommerce
    GROUP BY CustomerID
) t
GROUP BY cohort_month
ORDER BY cohort_month;


-- 🔹 11. Repeat Customer Revenue Contribution
SELECT 
    SUM(Quantity * UnitPrice) AS repeat_revenue
FROM ecommerce
WHERE CustomerID IN (
    SELECT CustomerID
    FROM ecommerce
    GROUP BY CustomerID
    HAVING COUNT(DISTINCT InvoiceNo) > 1
);