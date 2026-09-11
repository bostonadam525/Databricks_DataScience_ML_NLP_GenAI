-- SELECT DISTINCT Equipment, Sex
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- LIMIT 10

-- SELECT *
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- WHERE Age < 30
-- LIMIT 10

-- -- Filter on 1 value
-- SELECT *
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- WHERE Equipment <> 'Raw'

-- Filter on multiple values and operators (e.g. in, and, or)
-- SELECT * 
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- WHERE Equipment in ('Raw','Single-ply') or Division = 'Master 51+'

-- -- ORDER BY clause
-- SELECT * 
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- WHERE Equipment in ('Raw','Single-ply') or Division = 'Master 51+'
-- ORDER BY Name DESC 

-- -- LIMIT simple example
-- SELECT Name
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- WHERE Equipment = 'Raw'
-- ORDER BY Age DESC
-- LIMIT 5;

-- -- SUBQUERIES in WHERE statement
-- -- Gets oldest person 
-- SELECT Name, Age
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- WHERE Equipment = 'Raw'
-- AND Name <> 

--   (SELECT Name
--   FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
--   WHERE Equipment = 'Raw'
--   ORDER BY Age DESC
--   LIMIT 1)
-- ORDER BY Age DESC
-- LIMIT 1

-- -- SUBQUERY in TABLE -- DISTINCT name from this table query below
-- SELECT DISTINCT Name FROM
--   (SELECT Name
--   FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
--   WHERE Equipment = 'Raw'
--   ORDER BY Age DESC
--   LIMIT 1)


-- Aggregation Functions
-- 1. Sum (INT only), COUNT(INT or categorical), AVG (numerical), MAX (range), MIN (range)
-- SELECT SUM(TotalKg) AS TotalKg, COUNT(Name) AS CountName, AVG(TotalKg) AS AvgTotalKg, MAX(TotalKg) AS MaxTotalKg, MIN(TotalKg) AS MinTotalKg
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- WHERE Equipment = 'Raw' AND Age < 15

-- -- 2. COUNT IF function
-- SELECT COUNTIF(age < 14 AND Equipment = 'Raw')
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`

-- -- 3. GROUP BY and ALIAS
-- SELECT Name, Equipment, SUM(TotalKg) AS TotalKgSum
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- WHERE Equipment = 'Raw' AND Age < 15
-- GROUP BY Name, Equipment

------------------------------------------------------------------------------------------------
-- LIKE and Wildcards
-- % is case sensitive
SELECT Name
FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
WHERE Name LIKE '%y'

-- -- _ is another method
-- SELECT Name
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- WHERE Name like '__y%'

-----------------------------------------------------------------------------------
-- HAVING clause
-- filter out only rows where sum of totalkg is more than 500 -- cant use WHERE clause because SQL
-- has not allowed it you cant use AGG funcs in WHERE clause
-- SELECT Name, SUM(TotalKg) AS TotalKg_Sum
-- from `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- GROUP BY Name
-- HAVING TotalKg_Sum > 500
-- ORDER BY TotalKg_Sum DESC

------------------------------------------------------------------------------
-- UNION and UNION DISTINCT to append multiple tables VERTICALLY
-- using two separate tables: OPW-MALE, OPW-FEMALE
-- There are 3 rules for writing UNION statements
-- 1. Num of cols in all SELECT statements should be the same
-- 2. Order of cols should be the same
-- -- 3. Data types of cols should be the same
-- SELECT Name, Age
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting-OPW-FEMALE`
-- WHERE Equipment = 'Raw'

-- UNION ALL 

-- SELECT Name, Age
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting-OPW-MALE`
-- WHERE Equipment = `Single-Ply`

-- -- To remove duplicates you can use UNION DISTINCT
-- -- notice below both queries use the SAME table
-- SELECT Name, Age
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- WHERE Equipment = 'Raw

-- UNION DISTINCT

-- SELECT Name, Age
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`
-- WHERE Equipment = 'Single-Ply'

---------------------------------------------------------------------------------------------------------------
-- Using JOINS to merge data from multiple tables
-- 4 main types of joins:
-- 1. LEFT join -- all left and only matching from right
-- 2. Right join -- all right and only matching from left
-- 3. INNER join -- only matching rows from both tables
-- 4. FULL (outer) join -- all values from left and right tables


-- Example: Create a table using MEETS and OPENPOWERLIFTING datasets
-- with columns: Name, Equipment, Division, and Federation
-- WHERE MEETID = 20, 62 or 100
-- -- LEFT join -- can also rewrite query belo with RIGHT join just reverses tables
-- SELECT pw.Name, pw.Equipment, pw.Division 
-- FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting` AS pw -- table alias
-- LEFT JOIN `gen-lang-client-0009707049.powerlifting.meets` AS mt 
-- ON pw.MeetID = mt.MeetID -- join on unique MeetID
-- WHERE pw.MeetID IN (20, 62, 100)

----------------------------------------------------------------------------------------------------------------- CASE statements -- creates new columns and similar to if, else statements
-- GOAL: create a new column using these conditions:
--- Age < 12 then 'very young', age between 12 and 15 then 'young', age between 16 and 35 then 'adult', age > 35 then 'old'
SELECT Name, Age,
CASE
  when Age < 12 then 'Very Young'
  when Age between 12 and 15 then 'Young'
  when Age between 16 and 35 then 'Adult'
  else 'Old
END AS Age_Category -- name of new column
FROM `gen-lang-client-0009707049.powerlifting.openpowerlifting`



