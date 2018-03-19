IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Magic8Ball]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[Magic8Ball]
GO

USE [tempdb]  
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Ceci est un test.

-- Author:		Carlton B Ramsey
-- Create date: 05/20/2015
-- Description:	T-SQL Magic 8 Ball.  For when you need to consult the oracle.
-- =============================================
CREATE PROCEDURE [dbo].[Magic8Ball] 
(
	@Question nvarchar(max)
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @Answer nvarchar(100)
	DECLARE @Magic8BallAnswers TABLE
	(
	Answer_ID	int
	,Answer_Type	nvarchar(25)	
	,Answer_Text	nvarchar(100)
	)

	INSERT INTO @Magic8BallAnswers
	VALUES (1,'Positive','It is certain')
	,(2,'Positive','It is decidedly so')
	,(3,'Positive','Without a doubt')
	,(4,'Positive','Yes definitely')
	,(5,'Positive','You may rely on it')
	,(6,'Positive','As I see it, yes')
	,(7,'Positive','Most likely')
	,(8,'Positive','Outlook good')
	,(9,'Positive','Yes')
	,(10,'Positive','Signs point to yes')
	,(11,'Neutral','Reply hazy try again')
	,(12,'Neutral','Ask again later')
	,(13,'Neutral','Better not tell you now')
	,(14,'Neutral','Cannot predict now')
	,(15,'Neutral','Concentrate and ask again')
	,(16,'Negative','Don''t count on it')
	,(17,'Negative','My reply is no')
	,(18,'Negative','My sources say no')
	,(19,'Negative','Outlook not so good')
	,(20,'Negative','Very doubtful')

	SELECT TOP 1 @Answer = Answer_Text FROM @Magic8BallAnswers ORDER BY ABS(CHECKSUM(NEWID()) % 100)
	PRINT @Answer
END

GO

DECLARE

@Question nvarchar(max)

SET @Question = 'Should I upgrade to the next version of SQL?'

EXECUTE [dbo].[Magic8Ball] @Question

GO