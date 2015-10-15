BEGIN TRAN

select object_name(object_id) ,OBJECT_DEFINITION(object_id) from sys.objects where OBJECT_DEFINITION(object_id) like '%sigart%' and type='P'

ROLLBACK