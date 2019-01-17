use UDA_iAcces; 

declare @nbrJour int = 15

SELECT  COUNT(*) , CAST( a.DateMAJ as date) as dateMAj
FROM    tblAcces  as a
WHERE  a.DateMAJ > GETDATE() - @nbrJour 
GROUP BY CAST( a.DateMAJ as date) 
ORDER BY CAST( a.DateMAJ as date)  desc

SELECT -- a.DateMAJ,  * 
	  COUNT(*) , CAST( a.DateMAJ as date) as dateMAj
FROM   UDA_iAcces.dbo.tblAcces  as a
WHERE  a.DateMAJ > GETDATE() - @nbrJour 
and  DATEPART  ( hh, a.DateMAJ) between 3 and 4 
GROUP BY CAST( a.DateMAJ as date) 
ORDER BY  CAST( a.DateMAJ as date)  desc

 
SELECT  *
FROM    tblAcces 
WHERE  EstModifie = 1
or NomUtilisateur = '146824'

 /*
SELECT top 5 sj.name,
       sh.run_date,
       sh.step_name,
       STUFF(STUFF(RIGHT(REPLICATE('0', 6) +  CAST(sh.run_time as varchar(6)), 6), 3, 0, ':'), 6, 0, ':') 'run_time',
       STUFF(STUFF(STUFF(RIGHT(REPLICATE('0', 8) + CAST(sh.run_duration as varchar(8)), 8), 3, 0, ':'), 6, 0, ':'), 9, 0, ':') 'run_duration (DD:HH:MM:SS)  '
FROM msdb.dbo.sysjobs sj
JOIN msdb.dbo.sysjobhistory sh
ON sj.job_id = sh.job_id

WHERE name = 'Maj User web sans courriel'
and step_name = 'Maj_tabUserWeb_UserSansCourriel' 

ORDER BY run_date desc, run_time desc 
*/
 

--IF  EXISTS (SELECT * 
--				FROM sys.objects 
--				WHERE OBJECT_ID = OBJECT_ID(N'#tmp_uw') 
--				AND TYPE IN (N'U')
--				)

 
--	 DROP TABLE #tmp_uw;
  
 
 
/*

SELECT -- COUNT( * ) 

*  into #tmp_uw

FROM OPENQUERY(BD_WEB_PROD, 
				'SELECT  user.uid,
						user.name, 		
						user.status,   						
						matricule.field_artiste_matricule_value,   
						prenom.field_artiste_prenom_reel_value,  
						nom.field_artiste_nom_reel_value,  
						user.mail,
						categ.nom  as categ,         
						etat.nom  as etat,         
						statut_type.nom as nom_type,   
						typeInterv.nom as type_Intervenant, 
 
						FROM_UNIXTIME(created) as DateCreation,         
						FROM_UNIXTIME(access) as DateAccess,        
						FROM_UNIXTIME(login) as DateLogin     
         
 
				FROM uda_db.drupal_users as user  

				left join drupal_field_data_field_artiste_matricule as matricule   			 
					on user.name = matricule.field_artiste_matricule_value

				left join drupal_field_data_field_artiste_prenom_reel as prenom   			
					on matricule.entity_id = prenom.entity_id     

				left join drupal_field_data_field_artiste_nom_reel as nom   
					on matricule.entity_id = nom.entity_id     

				left join (Select (name) as nom, entity_id      
							FROM drupal_field_data_field_artiste_statut_categorie as c                 
							inner join drupal_taxonomy_term_data as t      
								on c.field_artiste_statut_categorie_tid = t.tid ) as categ             			
							on matricule.entity_id = categ.entity_id   
 
          
				left join (Select (name) as nom, entity_id      
							FROM drupal_field_data_field_artiste_statut_etat as e     
							inner join drupal_taxonomy_term_data as t      
								on e.field_artiste_statut_etat_tid = t.tid ) as etat             
							on matricule.entity_id = etat.entity_id              
            
				left join (Select (name) as nom, entity_id      
							FROM drupal_field_data_field_artiste_statut_type as typ     
							inner join drupal_taxonomy_term_data as t      
							on typ.field_artiste_statut_type_tid = t.tid ) as statut_type             
							on matricule.entity_id = statut_type.entity_id
  
				left join ( Select (name) as nom, entity_id, field_type_intervenant_id_tid      
								FROM drupal_field_data_field_type_intervenant_id type_interv_id
								inner join drupal_taxonomy_term_data as t    
								on type_interv_id.field_type_intervenant_id_tid = t.tid  
			
							) as typeInterv 
							on user.uid = typeInterv.entity_id
 
			 -- where (user.mail is null 
			--		or user.mail = "") 
			 
			 -- and user.status = 1
			 
			 -- and ( (categ.nom not in ("Permissionnaire")  and etat.nom not in ("Démissionnaire", "Décédé")  ) 
			 --       or 
				--   (typeInterv.nom is not null)
				--  )
						
 		') AS www;

 
 */

--SELECT  iA.NomUtilisateur,
--		iA.CategorieID 
--		,courriel.* 
--		,case 
--			when  wwwUser.categ <> '' --  is null 
--				then  right(wwwUser.name, 6) 
--			else wwwUser.name  
--		end as [name]
		
--		,wwwUser.field_artiste_matricule_value	
--		,wwwUser.field_artiste_prenom_reel_value	
--		,wwwUser.field_artiste_nom_reel_value
--		,iA.DateMAJGlobale 
--		,iA.DateMAJ 
 
--FROM    #tmp_uw AS wwwUser

--LEFT JOIN UDA_iAcces.dbo.tblAcces AS iA   
--	ON wwwUser.[name] COLLATE database_default = ia.NomUtilisateur 
--	AND (iA.Courriel IS NOT NULL AND  iA.Courriel <> '' )								

--LEFT JOIN (SELECT  i.NumMatricule, i.Nom, i.Prenom , c.Adresse , i.EstArtiste 
--			FROM    UDA_Membership.dbo.tblIntervenants as i 
--			INNER JOIN UDA_Membership.dbo.tblAdresses as a
--				on i.IntervenantID = a.IntervenantID 
--			INNER JOIN UDA_Membership.dbo.tblCourriels as c 
--				on a.AdresseID = c.CourrielID 
			 

--			) as courriel 
--			on case 
--			when  wwwUser.categ <> '' --  is null 
--				then  right(wwwUser.name, 6) 
--			else wwwUser.name  
--			end  COLLATE database_default = courriel.NumMatricule 


-- WHERE courriel.Adresse is not null 


/*
SELECT  *
FROM    #tmp_uw AS wwwUser

-- WHERE wwwUser.mail = 'mariosamson67@hotmail.com'

-- wwwUser.field_artiste_matricule_value = '678333'



SELECT  *
FROM    UDA_iAcces.dbo.tblAcces as a
WHERE a.DateMAJ > GETDATE() - 4

ORDER BY a.DateMAJ desc

--a.EstModifie  = 1 
-- a.Matricule = '678333'
*/
/*

IF  EXISTS (SELECT * 
				FROM sys.objects 
				WHERE OBJECT_ID = OBJECT_ID(N'#uda_sync_acces ') 
				AND TYPE IN (N'U')
				)
 
DROP TABLE #uda_sync_acces ;

*/


/*

SELECT -- COUNT( * ) 
		*  
		
into #uda_sync_acces

FROM OPENQUERY(BD_WEB_PROD, 
				'select MAX(date_completed) as date_completed, acces_id  
				from   #uda_sync_acces 
				GROUP BY acces_id '
				) 
*/
/*
SELECT  *
FROM    #uda_sync_acces
where date_completed > '2018-11-01'


SELECT   a.DateMAJ , uda_sync_acces.date_completed, a.*
FROM    UDA_iAcces.dbo.tblAcces as a

INNER JOIN  (select MAX(date_completed) as date_completed, acces_id  
			 from   #uda_sync_acces 
			 GROUP BY acces_id  
			 ) AS uda_sync_acces
	on a.AccesID = uda_sync_acces.acces_ID
	and a.DateMAJ > uda_sync_acces.date_completed
	
WHERE a.DateMAJ > '2018-01-11' 




SELECT  a.EstModifie,*
FROM    UDA_iAcces.dbo.tblAcces as a
WHERE a.Matricule = '128645'
or a.EstModifie = 1



SELECT -- COUNT( * ) 
		*  
		
-- into #uda_sync_acces

FROM OPENQUERY(BD_WEB_PROD, 
				'select * from 
				  drupal_uda_sync_acces 
				where date_Completed is null 
				order by date_received desc'
				) 
				-- 'select MAX(date_completed) as date_completed, acces_id  


*/