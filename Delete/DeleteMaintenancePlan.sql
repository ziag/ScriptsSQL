declare @id uniqueidentifier
set @id = (SELECT ID FROM MSDB..SYSMAINTPLAN_PLANS where name = 'MaintenancePlan')

SELECT ID FROM MSDB..SYSMAINTPLAN_PLANS where name = 'MaintenancePlan'

select @id 


 

 

 
DELETE FROM SYSMAINTPLAN_LOG WHERE PLAN_ID=  @id

 
DELETE FROM SYSMAINTPLAN_SUBPLANS WHERE PLAN_ID =  @id

 
DELETE FROM SYSMAINTPLAN_PLANS WHERE ID =  @id