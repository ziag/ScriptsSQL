-- Table to store the data
CREATE TABLE WhatsChanged (
 id INT NOT NULL IDENTITY(1,1),
 event_type sysname,
 object_id int,
 object_name sysname,
 change_date datetime,
 changed_by sysname
 );
GO
-- Make sure there won't be any problems inserting
-- into the logging table.
GRANT INSERT ON WhatsChanged TO public;
GO
CREATE TRIGGER tr_WhatsChanged
ON DATABASE
FOR DDL_PROCEDURE_EVENTS,
    DDL_FUNCTION_EVENTS,
    DDL_VIEW_EVENTS,
    DDL_TRIGGER_EVENTS,
    DDL_TABLE_EVENTS
AS
BEGIN
 INSERT INTO WhatsChanged (event_type, object_id, object_name, change_date, changed_by)
  VALUES (EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]',  'NVARCHAR(255)'),
    EVENTDATA().value('(/EVENT_INSTANCE/ObjectId)[1]',  'INT'),
    EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]',  'NVARCHAR(255)'),
    getdate(),
    ORIGINAL_LOGIN()
    );
END

/*
-- Connection created as test user
CREATE PROCEDURE ChangeTest AS
 PRINT '1';
GO
ALTER PROCEDURE ChangeTest AS
 PRINT '1';
GO
DROP PROCEDURE ChangeTest;
GO

SELECT  *
FROM     WhatsChanged
*/

/*
DROP TRIGGER [tr_WhatsChanged] ON DATABASE
DROP TABLE WhatsChanged
*/