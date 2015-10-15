 
-- Conditionally drop the test table to make reruns easier.
IF OBJECT_ID('tempdb..#TestData','U') IS NOT NULL DROP TABLE #TestData;
CREATE TABLE #TestData (AccountNumber INT, 
                        Value CHAR(3));
                        
                        
-- Build 1000 account numbers with random 3 character data.
;WITH
TENS      (N) AS (SELECT 0 UNION ALL SELECT 0 UNION ALL SELECT 0 UNION ALL 
                  SELECT 0 UNION ALL SELECT 0 UNION ALL SELECT 0 UNION ALL 
                  SELECT 0 UNION ALL SELECT 0 UNION ALL SELECT 0 UNION ALL SELECT 0),
THOUSANDS (N) AS (SELECT 1 FROM TENS t1 CROSS JOIN TENS t2 CROSS JOIN TENS t3),
MILLIONS  (N) AS (SELECT 1 FROM THOUSANDS t1 CROSS JOIN THOUSANDS t2),
TALLY     (N) AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT 0)) FROM MILLIONS)


INSERT INTO #TestData
SELECT TOP (100000) 
       AccountNumber = CASE WHEN (N%1000) = 0 THEN 1000 ELSE N%1000 END,
       Value         = CHAR(CONVERT(INT,RAND(CHECKSUM(NEWID()))*10)+64) +
                       CHAR(CONVERT(INT,RAND(CHECKSUM(NEWID()))*10)+64) +
                       CHAR(CONVERT(INT,RAND(CHECKSUM(NEWID()))*10)+64)
  FROM TALLY;

-- Add a clustered index to the table 
CREATE CLUSTERED INDEX IX_#TestData_Cover ON #TestData (AccountNumber, Value);
 
 
 
 
 WITH CTE AS
(
SELECT DISTINCT 
       AccountNumber
  FROM #TestData
)
SELECT AccountNumber,
       CommaList = STUFF((
                   SELECT ',' + Value
                     FROM #TestData
                    WHERE AccountNumber = CTE.AccountNumber
                    ORDER BY Value
                      FOR XML PATH(''), 
                              TYPE).value('.','varchar(max)'),1,1,'')
  FROM CTE
 ORDER BY AccountNumber;
 
 
 --SELECT COUNT(value) ,AccountNumber
 
 --FROM    #TestData
 --GROUP BY AccountNumber