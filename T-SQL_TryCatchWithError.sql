BEGIN TRAN
   SELECT  9 / 0; -- Divide by Zero

BEGIN TRY
    SELECT  9 / 0; -- Divide by Zero
END TRY
BEGIN CATCH
    SELECT  ERROR_LINE() AS 'Line' ,
            ERROR_MESSAGE() AS 'Message' ,
            ERROR_NUMBER() AS 'Number' ,
            ERROR_SEVERITY() AS 'Severity' ,
            ERROR_STATE() AS 'State';
END CATCH;

ROLLBACK