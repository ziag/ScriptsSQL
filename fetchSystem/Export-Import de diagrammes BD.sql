-- ===========================================================================================================
-- Auteur original:	   		http://www.dotnetspider.com/resources/21180-Copy-or-move-database-digram-from-for.aspx		
-- Adaptation:				Christian Melançon
-- Date de création:		2011-05-25
-- Description:				Ce script permet d'exporter un diagramme de base de données d'une base de données
--							à une autre.
--
-- Paramètres:				@DiagramID: ID du diagramme à exporter.
--							#DB_SOURCE#: Nom de la base de données source.
--							#DB_TARGET#: Nom de la base de données de destination.
--
-- Notes:					Les tables du diagramme à exporter doivent exister dans la base de données de 
--							destination.
-- ===========================================================================================================

--------------------------------------------------------------------------------------------------------------
-- Étape 1: identifier le ID du diagramme à exporter (colonne diagram_id)
--------------------------------------------------------------------------------------------------------------
SELECT * FROM UDA_Axiant.dbo.sysdiagrams


--------------------------------------------------------------------------------------------------------------
-- Étape 2: exporter le diagramme en spécifiant son ID dans la base de données source.
--------------------------------------------------------------------------------------------------------------
DECLARE @DiagramID AS INT
SET @DiagramID = 1

--INSERT INTO UDA_Axiant.dbo.sysdiagrams
SELECT diagram.name, diagram.principal_id, diagram.version, diagram.definition
FROM UDA_Axiant.dbo.sysdiagrams diagram
WHERE diagram.diagram_id = @DiagramID