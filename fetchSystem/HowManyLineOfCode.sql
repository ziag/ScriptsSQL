
SELECT DB_NAME(DB_ID()) [DB_Name],
       type,
       COUNT(*) AS Object_Count,
       SUM(LinesOfCode) AS LinesOfCode
FROM
(
    SELECT type,
           LEN(definition) - LEN(REPLACE(definition, CHAR(10), '')) AS LinesOfCode,
           OBJECT_NAME(object_id) AS NameOfObject
    FROM sys.all_sql_modules a
        JOIN sysobjects  AS s
            ON a.object_id = s.id
    -- AND xtype IN('TR', 'P', 'FN', 'IF', 'TF', 'V')
    WHERE OBJECTPROPERTY(object_id, 'IsMSShipped') = 0
) SubQuery
GROUP BY type;



/*
Dans SQL Server, la colonne `xtype` de la table système `sysobjects` (ou `sys.sysobjects` pour les versions plus récentes) indique le type d'objet dans la base de données. Voici les principaux types de `xtype` que vous pouvez rencontrer[1](https://learn.microsoft.com/en-us/sql/relational-databases/system-compatibility-views/sys-sysobjects-transact-sql?view=sql-server-ver16)[2](https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-objects-transact-sql?view=sql-server-ver16) :

- **AF** : Fonction d'agrégat (CLR)
- **C** : Contrainte CHECK
- **D** : Défaut ou contrainte DEFAULT
- **F** : Contrainte de clé étrangère
- **FN** : Fonction scalaire
- **FS** : Fonction scalaire d'assembly (CLR)
- **FT** : Fonction table d'assembly (CLR)
- **IF** : Fonction table en ligne
- **IT** : Table interne
- **P** : Procédure stockée
- **PC** : Procédure stockée d'assembly (CLR)
- **PK** : Contrainte de clé primaire
- **RF** : Procédure stockée de filtre de réplication
- **S** : Table système
- **SN** : Synonyme
- **SO** : Séquence
- **SQ** : File d'attente de service
- **TA** : Déclencheur DML d'assembly (CLR)
- **TF** : Fonction table
- **TR** : Déclencheur DML SQL
- **TT** : Type de table
- **U** : Table utilisateur
- **UQ** : Contrainte UNIQUE
- **V** : Vue
- **X** : Procédure stockée étendue

Ces types permettent de catégoriser les différents objets créés dans une base de données SQL Server[1](https://learn.microsoft.com/en-us/sql/relational-databases/system-compatibility-views/sys-sysobjects-transact-sql?view=sql-server-ver16)[2](https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-objects-transact-sql?view=sql-server-ver16).

Avez-vous besoin d'informations supplémentaires sur un type spécifique ou sur la manière d'utiliser ces informations dans vos requêtes SQL ?
[1](https://learn.microsoft.com/en-us/sql/relational-databases/system-compatibility-views/sys-sysobjects-transact-sql?view=sql-server-ver16): [sys.sysobjects (Transact-SQL) - SQL Server | Microsoft Learn](https://learn.microsoft.com/en-us/sql/relational-databases/system-compatibility-views/sys-sysobjects-transact-sql?view=sql-server-ver16)
[2](https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-objects-transact-sql?view=sql-server-ver16): [sys.objects (Transact-SQL) - SQL Server | Microsoft Learn](https://learn.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-objects-transact-sql?view=sql-server-ver16)
*/
