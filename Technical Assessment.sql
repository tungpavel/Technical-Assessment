-- Task 1
SELECT EmployeeID, FirstName, LastName, Division
  FROM [BB C - Test].[dbo].[Employee$]
Where Division like 'unknown' OR Division is null

-- Task 2
SELECT [BB C - Test].[dbo].[Location$].LocationID,
[BB C - Test].[dbo].Location$.Building,
[BB C - Test].[dbo].[Location$].City,
count([BB C - Test].[dbo].[Employee$].EmployeeID) as Number_of_employees
FROM [BB C - Test].[dbo].[Location$]
  left JOIN [BB C - Test].[dbo].[Employee$]
on [BB C - Test].[dbo].[Location$].LocationID = [BB C - Test].[dbo].[Employee$].LocationID
Where [BB C - Test].[dbo].[Location$].CountryID = 826 AND isActive = 1
group by [BB C - Test].[dbo].[Location$].LocationID,
		[BB C - Test].[dbo].Location$.Building,
		[BB C - Test].[dbo].[Location$].City
order by count([BB C - Test].[dbo].[Employee$].EmployeeID) DESC, [BB C - Test].[dbo].Location$.LocationID Asc

-- Task 3
SELECT count([Location$].Building) as "Number of same name buildings",
[BB C - Test].[dbo].[Location$].building
FROM [BB C - Test].[dbo].[Location$] 
WHERE [BB C - Test].[dbo].[Location$].CountryID != 826
group by [BB C - Test].[dbo].[Location$].building
HAVING count([Location$].Building) > 1

--Task 4
SELECT [BB C - Test].[dbo].[Employee$].EmployeeID,
[BB C - Test].[dbo].[Asset$].AssetID,
[BB C - Test].[dbo].[Asset$].Manufacturer,
[BB C - Test].[dbo].[Asset$].Model
FROM [BB C - Test].[dbo].[Asset$]
JOIN [BB C - Test].[dbo].[Employee$]
ON [BB C - Test].[dbo].[Employee$].LocationID = [BB C - Test].[dbo].[Asset$].LocationID
WHERE [BB C - Test].[dbo].[Asset$].Manufacturer like '%apple%'
AND [BB C - Test].[dbo].[Asset$].Manufacturer not like 'pineapple'

--Task 5
SELECT [ProductSKU],
	  DATEPART(Year,[TransactionDate]) as Years,
      DATEPART(Month,[TransactionDate]) as Months,
	  [TransactionType],
	  count([TransactionAmount]) as Total,
	  MIN([TransactionAmount]) as Minimum,
	  AVG([TransactionAmount]) as Average,
	  Max([TransactionAmount]) as Maximum
FROM [BB C - Test].[dbo].[AssetBilling$]
group by [ProductSKU],DATEPART(Month,[TransactionDate]), DATEPART(Year,[TransactionDate]),TransactionType


-- Task 6
SELECT EmployeeID, AssetType
FROM [BB C - Test].[dbo].[Employee$] 
JOIN [BB C - Test].[dbo].[Asset$]
	ON [BB C - Test].[dbo].[Employee$].LocationID = [BB C - Test].[dbo].[Asset$].LocationID
WHERE [BB C - Test].[dbo].[Asset$].AssetID like '[a-z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
	AND AssetID is not NULL
order by (case when AssetType = 'Laptop' then 1 else 2 end),
	(case when LifecycleStatus = 'Deployed' then 2 else 3 end),
	WhenInstalled Desc
