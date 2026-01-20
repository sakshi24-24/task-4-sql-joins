-- Task 4: SQL Intermediate – Joins
-- Dataset: Chinook SQLite Database

--------------------------------------------------
-- STEP 1: INNER JOIN
-- Orders with customer details
--------------------------------------------------
SELECT 
    i.InvoiceId,
    i.InvoiceDate,
    c.FirstName || ' ' || c.LastName AS CustomerName,
    c.Country,
    i.Total
FROM Invoice i
INNER JOIN Customer c
ON i.CustomerId = c.CustomerId;

--------------------------------------------------
-- STEP 2: LEFT JOIN
-- Customers who never placed any orders
--------------------------------------------------
SELECT 
    c.CustomerId,
    c.FirstName,
    c.LastName,
    c.Country
FROM Customer c
LEFT JOIN Invoice i
ON c.CustomerId = i.CustomerId
WHERE i.InvoiceId IS NULL;

--------------------------------------------------
-- STEP 3: Revenue per Product (Track)
-- Identifying high-performing SKUs
--------------------------------------------------
SELECT 
    t.Name AS TrackName,
    SUM(il.UnitPrice * il.Quantity) AS TotalRevenue
FROM InvoiceLine il
INNER JOIN Track t
ON il.TrackId = t.TrackId
GROUP BY t.TrackId
ORDER BY TotalRevenue DESC;

--------------------------------------------------
-- STEP 4: Category-wise Revenue (Genre)
--------------------------------------------------
SELECT 
    g.Name AS Genre,
    SUM(il.UnitPrice * il.Quantity) AS GenreRevenue
FROM InvoiceLine il
INNER JOIN Track t ON il.TrackId = t.TrackId
INNER JOIN Genre g ON t.GenreId = g.GenreId
GROUP BY g.GenreId
ORDER BY GenreRevenue DESC;

--------------------------------------------------
-- STEP 5: Business Question
-- Sales in USA
--------------------------------------------------
SELECT 
    i.InvoiceId,
    i.InvoiceDate,
    c.Country,
    i.Total
FROM Invoice i
INNER JOIN Customer c
ON i.CustomerId = c.CustomerId
WHERE c.Country = 'USA';
