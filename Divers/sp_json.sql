BEGIN TRAN
 




DECLARE @json NVARCHAR(4000) = 
    '{"Dims": 
     [
      {"Name":"Apple", "Baking": ["Pie","Tart"], "Plant":"Tree"},
      {"Name":"Tomato", "Cooking":["Stew","Sauce"], "Plant":"Vine"},
      {"Name":"Banana","Baking":["Bread"], "Cooking":["Fried"], "Plant":"Arborescent"}
     ]}
'


select json_value(v.value,'$.Name') Name
from openjson(@json,'$.Dims') v 

select concat('[',string_agg( quotename(json_value(v.value,'$.Name'), '"'), ', ')  WITHIN GROUP ( ORDER BY [key] )   ,']')
from openjson(@json,'$.Dims') v



SELECT Object_Schema_Name(module.object_id) + '.'
       + Object_Name(module.object_id) AS "Name",
  Json_Query([References]) AS "References"
  FROM sys.sql_modules AS module
    OUTER APPLY dbo.JsonReferencedObjects(module.object_id)
  WHERE Json_Query("References") IS NOT NULL
FOR JSON AUTO; 

ROLLBACK
 