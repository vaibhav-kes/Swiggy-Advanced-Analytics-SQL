SELECT * 
FROM swiggy.restaurants;

USE swiggy;

-- Retrieve the entire dataset to understand the table structure and available columns
SELECT * FROM restaurants;


-- Apply a global rank based on cost; restaurants with the same cost will share a rank
SELECT *, RANK() OVER(ORDER BY cost DESC) FROM restaurants;


-- Use rating_count as a proxy for 'visits' and rank the restaurants globally
SELECT *, RANK() OVER(ORDER BY rating_count DESC) FROM restaurants;


-- PARTITION BY city creates separate ranking 'buckets' for each individual city
SELECT *, RANK() OVER(PARTITION BY city ORDER BY cost DESC) FROM restaurants;


-- Unlike RANK, DENSE_RANK ensures no numbers are skipped if there are ties in price
SELECT *, DENSE_RANK() OVER(PARTITION BY city ORDER BY cost DESC) FROM restaurants;


-- ROW_NUMBER assigns a unique, sequential integer to every row within each city bucket
SELECT *, ROW_NUMBER() OVER(PARTITION BY city ORDER BY cost DESC) FROM restaurants;


-- This comparison shows the difference in how each function handles duplicate prices within a cuisine
SELECT *,
   RANK() OVER(PARTITION BY cuisine ORDER BY cost DESC),
   DENSE_RANK() OVER(PARTITION BY cuisine ORDER BY cost DESC),
   ROW_NUMBER() OVER(PARTITION BY cuisine ORDER BY cost DESC)
   FROM restaurants;
   
   
-- Step 1: Create a temporary result set (CTE) that calculates the ranks
WITH RankedRestaurants AS (
    SELECT *, 
           ROW_NUMBER() OVER(
               PARTITION BY city 
               ORDER BY (cost * rating_count) DESC
           ) AS revenue_rank
    FROM restaurants
)
-- Step 2: Select from that result set where the rank is within the top 5
SELECT * FROM RankedRestaurants
WHERE revenue_rank <= 5;


-- Step 1: Create a temporary result named 'CuisineRanking'
WITH CuisineRanking AS (
    SELECT *, 
           ROW_NUMBER() OVER(
               PARTITION BY cuisine 
               ORDER BY (cost * rating_count) DESC
           ) AS top_rank
    FROM restaurants
)
-- Step 2: Select from that result and filter for the top 5
SELECT * FROM CuisineRanking
WHERE top_rank <= 5;


-- Step 1: Identify the top 5 earners in each cuisine category
WITH TopFivePerCuisine AS (
    SELECT 
        cuisine, 
        (cost * rating_count) AS individual_revenue,
        ROW_NUMBER() OVER(
            PARTITION BY cuisine 
            ORDER BY (cost * rating_count) DESC
        ) AS rank_within_cuisine
    FROM restaurants
)
-- Step 2: Sum the revenue for those top performers and find the top 5 cuisines
SELECT 
    cuisine, 
    SUM(individual_revenue) AS total_revenue 
FROM TopFivePerCuisine 
WHERE rank_within_cuisine <= 5
GROUP BY cuisine
ORDER BY total_revenue DESC
LIMIT 5;


-- Step 1: Create a temporary list of ranked restaurants per city
WITH CityPerformance AS (
    SELECT 
        city, 
        (cost * rating_count) AS est_revenue,
        ROW_NUMBER() OVER(
            PARTITION BY city 
            ORDER BY (cost * rating_count) DESC
        ) AS restaurant_rank
    FROM restaurants
)
-- Step 2: Sum the revenue of the top 5 restaurants for each city
SELECT 
    city, 
    SUM(est_revenue) AS hub_revenue
FROM CityPerformance
WHERE restaurant_rank <= 5
GROUP BY city
ORDER BY hub_revenue DESC
LIMIT 5;


-- Calculates the total earnings for the elite 1% of the establishment list
SELECT SUM(cost * rating_count) FROM (
    SELECT *, ROW_NUMBER() OVER(ORDER BY cost * rating_count DESC) AS revanue_rank
    FROM restaurants
    ) t WHERE revanue_rank <= (SELECT COUNT(*) / 100 FROM restaurants);
    
    
    -- Sums revenue for the top 20% to see if they follow the 80/20 rule of business
SELECT SUM(cost * rating_count) FROM (
    SELECT *, ROW_NUMBER() OVER(ORDER BY cost * rating_count DESC) AS revenue_rank
    FROM restaurants
    ) t WHERE revenue_rank <= ((SELECT COUNT(*) FROM restaurants) / 100) * 20;
    
    
    -- Uses CTEs (WITH clause) to compare top 20% revenue against the grand total
WITH q1 AS (
    SELECT SUM(cost * rating_count) AS top_revenue FROM (
    SELECT *, ROW_NUMBER() OVER(ORDER BY cost * rating_count DESC) AS revenue_rank
    FROM restaurants
    ) t WHERE revenue_rank <= ((SELECT COUNT(*) FROM restaurants) / 100) * 20
    ), q2 AS (
    SELECT SUM(cost * rating_count) AS total_revenue FROM restaurants
    )
    SELECT ROUND((top_revenue / total_revenue) * 100) AS revenue_percentage FROM q1, q2;


