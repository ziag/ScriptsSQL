BEGIN TRAN

DECLARE @t TABLE (col1 INT)
INSERT INTO @t VALUES
(1),(2),(3),(5),(6),(8),(8),(9),(10),(11),(12),(12),(14),(15),(18),(19),(20);

WITH cte AS
(
	SELECT
		col1,
		DR = col1 - DENSE_RANK() OVER(ORDER BY col1)
	FROM @t
)
SELECT
	Low = MIN(col1),
	High = MAX(col1)
FROM cte
GROUP BY DR

ROLLBACK