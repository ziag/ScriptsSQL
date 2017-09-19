BEGIN TRAN

SELECT send_request_date
     , send_request_user
     , subject FROM msdb.dbo.sysmail_sentitems
WHERE sent_date >= DATEADD(dd,-7,getdate());

ROLLBACK