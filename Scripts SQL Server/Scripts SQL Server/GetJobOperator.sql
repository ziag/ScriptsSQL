/* Sélection des informations sur les travaux et les notifications par email */
SELECT --j.job_id, 
	   j.name,                    -- Nom du travail
       j.enabled,                 -- Indicateur si le travail est activé ou non
       o.name,                    -- Nom de l'opérateur lié au travail
       CASE
           WHEN j.notify_level_email = 0 THEN
               'Jamais'                                                          -- Pas de notification
           WHEN j.notify_level_email = 1 THEN
               'Lorsque le travail réussit'                                      -- Notification en cas de succès
           WHEN j.notify_level_email = 2 THEN
               'Lorsque le travail échoue'                                       -- Notification en cas d'échec
           WHEN j.notify_level_email = 3 THEN
               'Chaque fois que le travail se termine (peu importe le résultat)' -- Notification à chaque fin de travail
           ELSE
               'N/D'                                                             -- Niveau de notification non défini
       END AS notify_level_email, -- Description du niveau de notification par email
       o.email_address,           -- Adresse email de l'opérateur
       email.run_date,            -- Dernière date d'exécution du travail
       email.run_time,             -- Dernière heure d'exécution du travail
	   CASE 
			WHEN run_status = 0 THEN 'Échec'
			WHEN run_status = 1 THEN 'Réussite'
			WHEN run_status = 2 THEN 'Nouvelle tentative'
			WHEN run_status = 3 THEN 'Annulé'
			WHEN run_status = 4 THEN 'En cours'
			ELSE 'N/A'
	   END JobStatus 
	   

FROM msdb.dbo.sysjobs j -- Table des travaux
    LEFT JOIN msdb.dbo.sysoperators o -- Table des opérateurs
        ON j.notify_email_operator_id = o.id -- Liaison basée sur l'identifiant de l'opérateur
  
   LEFT JOIN (SELECT sjh.instance_id, sjh.run_date, sjh.run_time, sjh.job_id, sjh.run_status
				FROM msdb.dbo.sysjobhistory AS sjh-- Table de l'historique des travaux
				INNER JOIN (SELECT MAX(instance_id) AS instance_id,
							job_id 
							FROM msdb.dbo.sysjobhistory -- Table de l'historique des travaux
							GROUP BY job_id  -- Groupement par identifiant de travail) 
							)AS lastTime
				ON lastTime.instance_id = sjh.instance_id
				) AS email
				ON	email.job_id = j.job_id

       
	
WHERE 1 = 1
 -- AND j.enabled = 1 -- Filtrer uniquement les travaux activés

ORDER BY j.enabled DESC,
		 o.name DESC, -- Trier par nom de travail		 
         j.name;      -- Trier par nom d'opérateur en ordre décroissant		 

 