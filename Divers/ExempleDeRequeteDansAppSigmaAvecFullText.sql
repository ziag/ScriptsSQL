BEGIN TRAN

SELECT DISTINCT intervenant.IntervenantID AS ID, intervenant.Nom, intervenant.Prenom, 
                intervenant.NumMatricule AS Matricule, intervenant.Actif, intervenant.DateNaissance, categorieDesc.Categorie AS Categorie, 
                etatDesc.Etat AS Etat, typeDesc.DescriptionType AS TypeMembre, adrPostalePrincipaleDesc.AdresseConcatenee AS Adresse, 
                courrielPrincipal.Adresse AS Courriel, intervenant.NAS AS Nas, adrPrincipale.Confidentielle AS AdresseConfidentielle  FROM tblIntervenants intervenant

                LEFT JOIN  
                ( 
                     tblAdresses adrPrincipale 
                     JOIN tblAdressesPostales adrPostalePrincipale ON adrPrincipale.AdresseID = adrPostalePrincipale.AdressePostaleID AND adrPrincipale.IsPrincipale = 1
                     AND ISNULL(adrPrincipale.DateDebut, GETDATE()) <= GETDATE()
                        AND ISNULL(CAST(adrPrincipale.DateFin AS DATE), CAST(GETDATE() AS DATE)) >= CAST(GETDATE() AS DATE)
                     JOIN tblAdressesPostalesDesc adrPostalePrincipaleDesc ON adrPostalePrincipale.AdressePostaleID = adrPostalePrincipaleDesc.AdressePostaleID AND adrPostalePrincipaleDesc.LangueID = 1) ON adrPrincipale.IntervenantID = intervenant.IntervenantID  LEFT JOIN 
                ( 
                     tblAdresses adrCourrielPrincipale 
                     JOIN tblCourriels courrielPrincipal ON adrCourrielPrincipale.AdresseID = courrielPrincipal.CourrielID AND adrCourrielPrincipale.IsPrincipale = 1 
                ) ON adrCourrielPrincipale.IntervenantID = intervenant.IntervenantID 
                LEFT JOIN tblArtistes artiste ON intervenant.IntervenantID = artiste.ArtisteID 
                
                LEFT JOIN tblRepresentations representation ON intervenant.IntervenantID = representation.IntervenantID 
                LEFT JOIN tblCombinaisonsCategorieEtatType combinaisonCategorieEtatType ON representation.CombinaisonCategorieEtatTypeID = combinaisonCategorieEtatType.CombinaisonCategorieEtatTypeID 
                LEFT JOIN tblEtats etat ON combinaisonCategorieEtatType.EtatID = etat.EtatID 
                LEFT JOIN tblEtatsDesc etatDesc ON etat.EtatID = etatDesc.EtatID AND etatDesc.LangueID = 1 LEFT JOIN tblCategories categorie ON combinaisonCategorieEtatType.CategorieID = categorie.CategorieID 
                LEFT JOIN tblCategoriesDesc categorieDesc ON categorie.CategorieID = categorieDesc.CategorieID AND categorieDesc.LangueID = 1 LEFT JOIN tblTypes type ON combinaisonCategorieEtatType.TypeID = type.TypeID 
                LEFT JOIN tblTypesDesc typeDesc ON type.TypeID = typeDesc.TypeID AND typeDesc.LangueID = 1  
				LEFT JOIN tblAdresses fttAdresse ON fttAdresse.IntervenantID = intervenant.IntervenantID

                --       LEFT JOIN CONTAINSTABLE(tblIntervenants, (NAS_6, NumMatricule), @ft_search) fti ON intervenant.intervenantid = fti.[Key]
                 --      LEFT JOIN CONTAINSTABLE(tblIntervenantsAliasDesc, AliasConcatene, @ft_search) fta ON intervenant.intervenantid = fta.[Key]
                  --     LEFT JOIN CONTAINSTABLE(tblIntervenantsDesc, (NomPrenom, PrenomNom), @ft_search) ftid ON intervenant.intervenantid = ftid.[Key] 
				  
     WHERE 1 = 1  
	 -- AND (fti.[Key] IS NOT NULL OR ftid.[Key] IS NOT NULL OR fta.[Key] IS NOT NULL)  
	 AND  artiste.ArtisteID IS NOT NULL 

     AND (representation.RepresentationID is null OR representation.RepresentationIntervenantID = 1)  AND intervenant.Actif = 1  ORDER BY intervenant.Nom, intervenant.Prenom 

ROLLBACK