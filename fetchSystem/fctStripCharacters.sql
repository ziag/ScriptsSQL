 
-- =============================================
-- Author:		Michel Thiffault
-- Create date: 2011/02/15
-- Description:	Enlève tous les caractères qui ne 
--				matche pas l'expression @MatchExpression.
-- =============================================
ALTER FUNCTION [dbo].[fctStripCharacters] 
(     
	@String NVARCHAR(MAX),      
	@MatchExpression VARCHAR(255) 
) 
RETURNS NVARCHAR(MAX) AS 
BEGIN     
	SET @MatchExpression =  '%['+@MatchExpression+']%'      
	WHILE PATINDEX(@MatchExpression, @String) > 0         
		SET @String = STUFF(@String, PATINDEX(@MatchExpression, @String), 1, '')      
	RETURN @String  
END 
