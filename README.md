# MARATHON DU WEB 2026 - AUDEMAG

Master 1 MIASHS - Université Paul-Valéry Montpellier 3  

Analyse de l’enquête de lectorat du magazine départemental audeMAG  
Objectif : transformer des données en outil d’aide à la décision publique

------------------------------------------------------------------------

## Équipe

- Ardacham Mahamat Teguene 
- Akil Moub — 
- Anziza Ahamada Madi — 
- Moustapha Ndiaye — 

Commanditaire : Département de l’Aude  
Contact : Jean Brunel —  
Période : 23–27 mars 2026  

------------------------------------------------------------------------

## Contexte

Depuis plus de 10 ans, audeMAG est le magazine départemental de l’Aude, diffusé à grande échelle (178 000 exemplaires par trimestre).

Dans le cadre d’une refonte éditoriale et visuelle, le Département de l’Aude a lancé une enquête de lectorat afin de mieux comprendre :
- les attentes des lecteurs  
- leur niveau de satisfaction  
- les usages du magazine  

Ce projet vise à analyser ces données et à les croiser avec le contenu réel des magazines.

------------------------------------------------------------------------

## Problématique

Le magazine audeMAG répond-il réellement aux attentes des lecteurs ?

------------------------------------------------------------------------

## Données

Enquête lectorat :
- 146 répondants  
- environ 20 variables  

Corpus :
- 65 numéros du magazine audeMAG  

------------------------------------------------------------------------

## Approche globale

Questionnaire lecteurs  
↓  
Analyse textuelle (NLP)  
↓  
Extraction des thèmes  
↓  
Corpus magazines  
↓  
Analyse thématique  
↓  
Croisement offre / demande  
↓  
Recommandations  

------------------------------------------------------------------------

## PARTIE 1 - ANALYSE TEXTUELLE ET CORPUS

### Méthodologie NLP

Traitement des données :
- nettoyage des textes  
- tokenisation  
- suppression des mots vides  

Choix méthodologiques :
- conservation des noms communs et des verbes  
- suppression des adjectifs (peu informatifs)  

Harmonisation :
- regroupement des entités similaires (ex : Aude, l’Aude, de l’Aude)  

Cela permet d’éviter les doublons et d’améliorer la qualité des résultats.

------------------------------------------------------------------------

### Analyse des magazines

- ajout des dates dans les fichiers (format AUDEMAG-numero-date)  
- analyse chronologique des contenus  
- visualisation via heatmap  

Résultats :
- forte présence de contenu institutionnel  
- présence secondaire de l’environnement et de la culture  
- faible présence du sport, de l’économie et du tourisme  

Limite :
- la catégorie "institutionnel" regroupe plusieurs types de contenus  
- interprétation à nuancer  

------------------------------------------------------------------------

### Attentes des lecteurs

Les lecteurs demandent :
- plus de contenu local  
- plus d’informations pratiques  
- des contenus plus pédagogiques  

Ils montrent moins d’intérêt pour le contenu institutionnel.

------------------------------------------------------------------------

### Analyse croisée

Résultat principal :

- Magazine : contenu institutionnel  
- Lecteurs : contenu local et concret  

Conclusion :
le magazine répond partiellement aux attentes.

------------------------------------------------------------------------

### Analyse des sentiments

Comparaison entre :
- les textes des magazines  
- les réponses ouvertes  

Résultats :
- magazine : très positif  
- lecteurs : plus critiques  

Limites :
- analyse basée sur les mots  
- contexte parfois non pris en compte  

------------------------------------------------------------------------

### Recommandations

- renforcer le contenu local  
- ajouter des informations pratiques  
- proposer des formats courts  
- améliorer la pédagogie  
- réduire le contenu institutionnel  
- améliorer la lisibilité  

------------------------------------------------------------------------

## PARTIE 2 - DASHBOARD INTERACTIF

Accès à l’application :
https://audemag.shinyapps.io/Dashbord/

------------------------------------------------------------------------

### Architecture

- global.R : données  
- ui.R : interface  
- server.R : logique  
- app.R : lancement  

------------------------------------------------------------------------

### Améliorations réalisées

Nettoyage :
- suppression des graphiques inutiles  
- conservation des plus pertinents  

Titres :
- noms simplifiés  
- meilleure compréhension  

Filtres :
- simplification  
- adaptation aux données  

Explications :
- ajout de textes sous les graphiques  

Organisation :
- section configuration  
- section visualisation  
- section aide  

Corrections :
- bugs Shiny  
- erreurs regex  
- problèmes de chargement  

------------------------------------------------------------------------

### Résultat

Application :
- plus claire  
- plus lisible  
- plus professionnelle  

Utilisable par :
- décideurs  
- utilisateurs non techniques  

------------------------------------------------------------------------

## Conclusion

Le projet montre que :
- le magazine est cohérent mais trop institutionnel  
- les lecteurs veulent du contenu local et concret  
- il existe un écart entre l’offre et la demande  

Ce travail constitue une base solide pour améliorer le magazine.

------------------------------------------------------------------------

## Perspectives

- amélioration du dashboard  
- déploiement web  
- génération de rapports  
- amélioration de l’interface  

------------------------------------------------------------------------

## Technologies utilisées

- R (ggplot2, dplyr, tidyr, corrplot)  
- Python (SpaCy)  
- Jupyter Notebook  
- Shiny  
- Plotly  
- Leaflet  
- HTML / CSS  

------------------------------------------------------------------------

## Lancer le projet

R :
```r
install.packages(c("readxl","ggplot2","dplyr","tidyr","stringr",
"scales","patchwork","corrplot","viridis","forcats"))

source("analyse_audeMAG.R")
