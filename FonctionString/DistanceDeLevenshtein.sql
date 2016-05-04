CREATE FUNCTION [dbo].[DistanceDeLevenshtein](@gauche  VARCHAR(100),
											 @droite VARCHAR(100))
returns INT
AS

/*
SELECT [dbo].[DistanceDeLevenshtein]('a','b')
SELECT [dbo].[DistanceDeLevenshtein]('a','a')
*/
  BEGIN
      DECLARE @difference    INT,
              @lenDroite      INT,
              @lenGauche       INT,
              @gaucheIndex     INT,
              @droiteIndex    INT,
              @gauche_char     CHAR(1),
              @droite_char    CHAR(1),
              @compareLength INT

      SET @lenGauche = LEN(@gauche)
      SET @lenDroite = LEN(@droite)
      SET @difference = 0

      IF @lenGauche = 0
        BEGIN
            SET @difference = @lenDroite

            GOTO done
        END

      IF @lenDroite = 0
        BEGIN
            SET @difference = @lenGauche

            GOTO done
        END

      GOTO comparison

      COMPARISON:

      IF ( @lenGauche >= @lenDroite )
        SET @compareLength = @lenGauche
      ELSE
        SET @compareLength = @lenDroite

      SET @droiteIndex = 1
      SET @gaucheIndex = 1

      WHILE @gaucheIndex <= @compareLength
        BEGIN
            SET @gauche_char = substring(@gauche, @gaucheIndex, 1)
            SET @droite_char = substring(@droite, @droiteIndex, 1)

            IF @gauche_char <> @droite_char
              BEGIN  
                  IF( @gauche_char = substring(@droite, @droiteIndex + 1, 1) )
                    SET @droiteIndex = @droiteIndex + 1
  
                  ELSE IF( substring(@gauche, @gaucheIndex + 1, 1) = @droite_char )
                    SET @gaucheIndex = @gaucheIndex + 1

                  SET @difference = @difference + 1
              END

            SET @gaucheIndex = @gaucheIndex + 1
            SET @droiteIndex = @droiteIndex + 1
        END

      GOTO done

      DONE:

      RETURN @difference
  END 
GO

