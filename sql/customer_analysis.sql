SELECT COUNT(*) FROM customer;
SELECT * FROM customer LIMIT 10;
-- Analyze and categorize customers based on demographics, spending habits, and satisfaction levels.
SELECT gender,COUNT(*) FROM customer GROUP BY gender;
SELECT gender,SUM(total_spend) FROM customer GROUP BY gender;
SELECT city,COUNT(*) FROM customer GROUP BY city;
SELECT city,SUM(total_spend) FROM customer GROUP BY city;
SELECT satisfaction_level,COUNT(*) FROM customer GROUP BY satisfaction_level;
SELECT satisfaction_level,SUM(total_spend) FROM customer GROUP BY satisfaction_level;

-- Gender with Age
SELECT gender,age,COUNT(*) FROM customer GROUP BY gender,age;

-- Gender With Membershiptype
SELECT gender,membership_type,COUNT(*) FROM customer GROUP BY gender,membership_type ORDER BY gender;

-- Gender with City
SELECT gender,city,COUNT(*) FROM customer GROUP BY gender,city ORDER BY gender;

-- City with Membershiptype
SELECT membership_type,city,COUNT(*) FROM customer GROUP BY membership_type,city ORDER BY membership_type;

-- Membership Type and Total Spend
SELECT membership_type, SUM(total_spend) FROM customer GROUP BY membership_type;

-- Satistaction Level and average spend
SELECT satisfaction_level, AVG(total_spend) FROM customer GROUP BY satisfaction_level;

-- Items Purschased with Satisfaction Level
SELECT satisfaction_level, AVG(items_purchased) FROM customer GROUP BY satisfaction_level;

-- Items Purschased with Gender
SELECT gender, SUM(items_purchased) FROM customer GROUP BY gender;

-- Discount Applied
SELECT discount_applied, COUNT(*) FROM customer GROUP BY discount_applied;

-- Discount Applied with Gender
SELECT gender,discount_applied, COUNT(*) FROM customer GROUP BY gender,discount_applied ORDER BY gender;

-- Average Rating with Satisfaction Level
SELECT satisfaction_level,AVG(average_rating) FROM customer GROUP BY satisfaction_level;

-- Customer Segmentation by Spending
SELECT
    COUNT(*),
    CASE
        WHEN total_spend >= 1000 THEN 'High Spender'
        WHEN total_spend >= 600 THEN 'Medium Spender'
        ELSE 'Low Spender'
    END AS spending_segment
FROM customer
GROUP BY spending_segment;

-- Customer Recency Analysis
SELECT
    CASE
        WHEN days_since_last_purchase <= 15 THEN 'Recent'
        WHEN days_since_last_purchase <= 30 THEN 'Moderate'
        ELSE 'Inactive'
    END AS customer_status,
    COUNT(*) AS total_customers,
    ROUND(AVG(total_spend)::numeric, 2) AS avg_spend
FROM customer
GROUP BY customer_status
ORDER BY total_customers DESC;

-- Satisfaction Analysis
SELECT
    satisfaction_level,
    COUNT(*) AS total_customers,
    ROUND(AVG(average_rating)::numeric, 2) AS avg_rating,
    ROUND(AVG(total_spend)::numeric, 2) AS avg_spend,
    ROUND(AVG(items_purchased)::numeric, 2) AS avg_items
FROM customer
GROUP BY satisfaction_level
ORDER BY avg_rating DESC;

-- Discount Analysis
SELECT
    discount_applied,
    COUNT(*) AS total_customers,
    ROUND(AVG(total_spend)::numeric, 2) AS avg_spend,
    ROUND(AVG(items_purchased)::numeric, 2) AS avg_items,
    ROUND(AVG(average_rating)::numeric, 2) AS avg_rating
FROM customer
GROUP BY discount_applied;

-- City Performance
SELECT
    city,
    COUNT(*) AS total_customers,
    ROUND(SUM(total_spend)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_spend)::numeric, 2) AS avg_spend
FROM customer
GROUP BY city
ORDER BY total_revenue DESC;