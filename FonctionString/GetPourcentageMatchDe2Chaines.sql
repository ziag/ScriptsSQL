CREATE FUNCTION [dbo].[GetPourcentageMatchDe2Chaines]
(
     @string1 NVARCHAR(100)
    ,@string2 NVARCHAR(100)
)
RETURNS INT
AS
BEGIN

/*
SELECT [dbo].[GetPourcentageMatchDe2Chaines]('abcde','abcdd')
*/

    DECLARE @nombreLevenShtein INT

    DECLARE @LenString1 INT = LEN(@string1)
    DECLARE @LenString2 INT = LEN(@string2)
    
    DECLARE @maxLenNombre INT = CASE 
									WHEN @LenString1 > @LenString2 
										THEN @LenString1 
									ELSE @LenString2 
								END

    SELECT @nombreLevenShtein = [dbo].[DistanceDeLevenshtein] (@string1, @string2)

    DECLARE @pourcentageDeMauvaisCaracteres INT = @nombreLevenShtein * 100 / @maxLenNombre

    DECLARE @pourcentageDeBonCaracteres INT = 100 - @pourcentageDeMauvaisCaracteres
 
 
    RETURN @pourcentageDeBonCaracteres

END


GO

