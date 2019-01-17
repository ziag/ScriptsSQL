CREATE TRIGGER db_trg_ObjectChanges
ON DATABASE
FOR ALTER_PROCEDURE, DROP_PROCEDURE,
 ALTER_INDEX, DROP_INDEX,
 ALTER_TABLE, DROP_TABLE, ALTER_TRIGGER, DROP_TRIGGER,
 ALTER_VIEW, DROP_VIEW, ALTER_SCHEMA, DROP_SCHEMA,
 ALTER_ROLE, DROP_ROLE, ALTER_USER, DROP_USER
AS
SET NOCOUNT ON
INSERT dbo.ChangeAttempt
(EventData, DBUser)
VALUES (EVENTDATA(), USER)
GO