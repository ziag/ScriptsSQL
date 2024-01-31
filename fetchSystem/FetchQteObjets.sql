/*
Ce script utilise la table système sys.objects pour compter le nombre d’objets dans une base de données. 
Les types d’objets pris en compte sont les tables (U), les vues (V), les procédures stockées (P), 
les fonctions scalaires (FN), les fonctions en ligne (IF), et les fonctions de table (TF) 1.
*/

SELECT  

		CASE type	
			WHEN 'U'  THEN 'Tables'
			WHEN 'V'  THEN 'Vues'
			WHEN 'P'  THEN 'Procédures stockées'
			WHEN 'FN' THEN 'Fonctions'  --'Fonctions Scalaires'
			WHEN 'IF' THEN 'Fonctions'  --'Fonctions en ligne'
			WHEN 'TF' THEN 'Fonctions'  --'Fonctions de table'
			
		END TypeObjet,

		COUNT(*) AS 'Nombre d''objets'

FROM sys.objects
WHERE type IN ('U', 'V', 'P', 'FN', 'IF', 'TF')

GROUP BY CASE type	
			WHEN 'U'  THEN 'Tables'
			WHEN 'V'  THEN 'Vues'
			WHEN 'P'  THEN 'Procédures stockées'
			WHEN 'FN' THEN 'Fonctions'  --'Fonctions Scalaires'
			WHEN 'IF' THEN 'Fonctions'  --'Fonctions en ligne'
			WHEN 'TF' THEN 'Fonctions'  --'Fonctions de table'
			
		END  
