BEGIN TRANSACTION;

USE UDA_Axiant; 


--SELECT  *

--INTO Tbl_Artistes_de_cirque_Pour_Sophie 

--FROM OPENQUERY(BD_WEB_PROD, 
--	       'select 				   
--				   matricule.field_artiste_matricule_value as matricule,   
--				   user.status as estActif,				   
--				   nom.field_artiste_nom_reel_value as nom,  
--				   prenom.field_artiste_prenom_reel_value as prenom,  
--				   m.familleMetier,
--				   m.nomMetier
               
--			FROM uda_db.drupal_users as user  

 
--			INNER join drupal_field_data_field_artiste_matricule as matricule   
--				on user.name = matricule.field_artiste_matricule_value

--			INNER join drupal_field_data_field_artiste_prenom_reel as prenom      
--				on matricule.entity_id = prenom.entity_id     

--			INNER join drupal_field_data_field_artiste_nom_reel as nom   
--				on matricule.entity_id = nom.entity_id     

--			INNER join drupal_field_data_field_artiste_fonctions as fn
--				on matricule.entity_id = fn.entity_id
   
--			INNER join ( SELECT metier.tid, metier.name as nomMetier, term_data.name as familleMetier
--						FROM uda_db.drupal_taxonomy_term_data as term_data
--						inner join uda_db.drupal_taxonomy_term_hierarchy as term_hierachy
--							on term_data.tid = term_hierachy.parent
--							and term_data.name = ''Artiste de cirque''
				
--						inner join uda_db.drupal_taxonomy_term_data as metier
--							on term_hierachy.tid = metier.tid
			 
--						 order by term_data.tid) as m
--							on  m.tid =  fn.field_artiste_fonctions_tid
                
--			where m.tid is not null  

--		 ') 

--ORDER BY Nom, prenom, nomMetier;


SELECT  -- Distinct(matricule ) , estActif, nom, prenom
		clown.*
		--,estActif 
FROM    UDA_Axiant.dbo.Tbl_Artistes_de_cirque_Pour_Sophie AS clown

LEFT JOIN UDA_Membership.dbo.tblIntervenants as i 
	on clown.matricule COLLATE database_default  = i.NumMatricule 
	and i.EstArtiste = 1 

WHERE clown.estActif <> i.Actif; 



ROLLBACK;