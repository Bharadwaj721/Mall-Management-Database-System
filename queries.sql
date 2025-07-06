-- =============================================
-- SQL Queries with Comments
-- =============================================

-- 1. Retrieve movie theatre details along with associated tenant officer and mall information
SELECT 
    MT.*, 
    TOF.*, 
    M.* 
FROM MOVIE_THEATRES MT
JOIN TENANT_OFFICERS TOF ON MT.TENANT_ID = TOF.ID
JOIN MALL M ON MT.MALL_CODE = M.CODE;

-- 2. Get all store names and their categories for a specific mall (e.g., M106)
SELECT 
    S.STORE_NAME, 
    SC.CATEGORIES 
FROM STORES S
JOIN STORE_CATEGORIES SC ON S.CATEGORY_ID = SC.ID
WHERE S.MALL_CODE = 'M106';

-- 3. List all mall managers along with the code of the mall they manage
SELECT 
    MM.NAME, 
    MM.MANAGER_ID, 
    M.CODE 
FROM MALL_MANAGERS MM
JOIN MALL M ON MM.MALL_CODE = M.CODE;

-- 4. Count the number of stores managed by each mall manager
SELECT 
    MM.NAME, 
    COUNT(S.STORE_ID) AS STORE_COUNT 
FROM MALL_MANAGERS MM
LEFT JOIN MALL M ON MM.MALL_CODE = M.CODE
LEFT JOIN STORES S ON M.CODE = S.MALL_CODE
GROUP BY MM.NAME;

-- 5. Find names of tenant officers who are involved in both food corners and movie theatres
SELECT 
    TOF.NAME 
FROM TENANT_OFFICERS TOF
JOIN FOOD_CORNERS FC ON TOF.ID = FC.TENANT_ID
JOIN MOVIE_THEATRES MT ON TOF.ID = MT.TENANT_ID;