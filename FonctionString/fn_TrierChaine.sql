/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2008 R2 (10.50.1617)
    Source Database Engine Edition : Microsoft SQL Server Enterprise Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/

USE [Axiant_Vs_Sigma]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_TrierAdresse]    Script Date: 2017-09-21 11:05:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[fn_TrierChaine] (@adr VARCHAR(255)) 
RETURNS @rtnTable TABLE  
		(
		 Entre  VARCHAR(255),
		 Sortie VARCHAR(255) 
		)
 
AS 
 
BEGIN  

	DECLARE @inTable TABLE  
		(
		  ID INT,
		  Phrase VARCHAR(255)
		) 
	
	INSERT INTO @inTable(Phrase)
	VALUES (@adr) 
	 
	 
	   
	;
	WITH    base
			  AS ( SELECT   L.[char] ,
							T.ID ,
							T.Phrase
				   FROM     @inTable T
							CROSS APPLY ( SELECT    SUBSTRING(T.Phrase, 1 + Number, 1) [CHAR]
										  FROM      master..spt_values
										  WHERE     Number < DATALENGTH(T.Phrase)
													AND TYPE = 'P'
										) L
				 )
				 
				 
	    INSERT INTO @rtnTable(Entre, sortie )         
		SELECT  DISTINCT
				b1.Phrase ,
				REPLACE(( SELECT    '' + [CHAR]
						  FROM      base b2
						  WHERE     b1.Phrase = b2.Phrase
						  ORDER BY  [CHAR]
							FOR
							  XML PATH('')
						), '&#x20;', ' ') AS columns2
		FROM    base AS b1
 
 
		RETURN;
		
 END
