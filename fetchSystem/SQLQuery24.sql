BEGIN TRAN

SELECT  a.DateMAJ , a.DateMAJGlobale , a.EstModifie, * 
FROM    UDA_iAcces.dbo.tblAcces as a

CROSS APPLY Axiant_Vs_Sigma.dbo.fn_categEtatTypeByMat (a.Matricule) as cet 

WHERE  a.DateMAJGlobale > '2018-01-14T08:51:34.467'

and a.CategorieID = 5 

-- and a.EstModifie = 1 

ORDER BY a.DateMAJ desc,  a.NomUtilisateur


ROLLBACK