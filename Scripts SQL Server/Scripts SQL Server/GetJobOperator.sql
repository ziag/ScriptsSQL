/* S�lection des informations sur les travaux et les notifications par email */
SELECT --j.job_id, 
	   j.name,                    -- Nom du travail
       j.enabled,                 -- Indicateur si le travail est activ� ou non
       o.name,                    -- Nom de l'op�rateur li� au travail
       CASE
           WHEN j.notify_level_email = 0 THEN
               'Jamais'                                                          -- Pas de notification
           WHEN j.notify_level_email = 1 THEN
               'Lorsque le travail r�ussit'                                      -- Notification en cas de succ�s
           WHEN j.notify_level_email = 2 THEN
               'Lorsque le travail �choue'                                       -- Notification en cas d'�chec
           WHEN j.notify_level_email = 3 THEN
               'Chaque fois que le travail se termine (peu importe le r�sultat)' -- Notification � chaque fin de travail
           ELSE
               'N/D'                                                             -- Niveau de notification non d�fini
       END AS notify_level_email, -- Description du niveau de notification par email
       o.email_address,           -- Adresse email de l'op�rateur
       email.run_date,            -- Derni�re date d'ex�cution du travail
       email.run_time,             -- Derni�re heure d'ex�cution du travail
	   CASE 
			WHEN run_status = 0 THEN '�chec'
			WHEN run_status = 1 THEN 'R�ussite'
			WHEN run_status = 2 THEN 'Nouvelle tentative'
			WHEN run_status = 3 THEN 'Annul�'
			WHEN run_status = 4 THEN 'En cours'
			ELSE 'N/A'
	   END JobStatus 
	   

FROM msdb.dbo.sysjobs j -- Table des travaux
    LEFT JOIN msdb.dbo.sysoperators o -- Table des op�rateurs
        ON j.notify_email_operator_id = o.id -- Liaison bas�e sur l'identifiant de l'op�rateur
  
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
 -- AND j.enabled = 1 -- Filtrer uniquement les travaux activ�s

ORDER BY j.enabled DESC,
		 o.name DESC, -- Trier par nom de travail		 
         j.name;      -- Trier par nom d'op�rateur en ordre d�croissant		 

 