================================================================================
MARATHON DU WEB 2026 — SUJET E : AUDEMAG
Un journal au service des habitant·es
Analyse de l'enquête de lectorat du magazine départemental de l'Aude
================================================================================
ÉQUIPE
------
- Ardacham Mahamat Teguene
- Akil Moub
- Anziza Ahamada Madi
- Moustapha Ndiaye
Commanditaire : Département de l'Aude — Contact : Jean Brunel
Formation : M1 MIASHS, Université Paul-Valéry Montpellier 3
Période : 23–27 mars 2026
CONTEXTE
--------
Depuis 10 ans, audeMAG est le magazine départemental de l'Aude, distribué
dans toutes les boîtes aux lettres du département (178 000 exemplaires par
trimestre depuis janvier 2025).
Dans le cadre d'une réflexion sur la refonte de sa maquette et de son
contenu, le Département de l'Aude a lancé une enquête de satisfaction
auprès de ses lecteurs.
Objectifs du projet :
- Identifier les éléments appréciés du magazine
- Mettre en évidence les points d'amélioration prioritaires
- Accompagner la refonte éditoriale et visuelle
- Valoriser les résultats auprès des citoyens
DONNÉES
-------
- AUDEMAG ancienne base.xls → Première version de l'enquête de lectorat
- AUDEMAG nouvelle base.xlsx → Version consolidée (146 répondants, ~20 questions)
Le questionnaire couvre : profil des répondants (âge, sexe, CSP, commune),
habitudes de lecture, rubriques préférées, satisfaction sur 5 dimensions,
notoriété de la chronique radio, intérêt pour le numérique, changements
prioritaires souhaités.
STRUCTURE DU DÉPÔT
------------------
AUDEMAG ancienne base.xls Données brutes - version initiale
AUDEMAG nouvelle base.xlsx Données consolidées
analyse_audeMAG.R Analyse statistique complète (R)
nlp_audeMAG.R Analyse textuelle NLP (R)
Code python extraction.ipynb Extraction textes/images des 57 éditions
audemag.html Application web interactive (dashboard)
ANALYSES RÉALISÉES
------------------
A. Analyse statistique descriptive — analyse_audeMAG.R
Script R structuré en 10 blocs :
1. Profil des répondants (sexe, âge, CSP)
2. Réception & lecture (fréquence, temps, modes de consultation)
3. Rubriques préférées (analyse multi-réponses)
4. Satisfaction (scores moyens, boxplots, Likert empilés)
5. Corrélations (matrice de Spearman)
6. Satisfaction par sous-groupes (âge, sexe, CSP — ANOVA)
7. Notoriété & numérique (chronique radio, intérêt version numérique)
8. Fréquence & qualité globale
9. Changements prioritaires (analyse multi-réponses)
10. Croisements analytiques (qualité globale vs satisfaction)
→ Génère 20 graphiques (fig01 à fig20) aux couleurs du département
B. Analyse textuelle NLP — nlp_audeMAG.R
Traitement des questions ouvertes :
- Q13 : Sujets souhaités
- Q28 : Commentaires libres et canaux préférés
Approches : nuage de mots, LDA (topic modeling), fréquence des termes clés
C. Extraction des éditions passées — Code python extraction.ipynb
Extraction et analyse des textes et images des 57 numéros d'audeMAG :
- Identifier les thèmes éditoriaux récurrents
- Mesurer l'évolution thématique dans le temps
- Mettre en parallèle contenus du magazine et attentes de l'enquête
D. Application web interactive — audemag.html
Dashboard en HTML permettant l'exploration interactive des résultats,
pour faciliter l'aide à la décision sur la refonte du magazine.
TECHNOLOGIES UTILISÉES
----------------------
R (ggplot2, dplyr, tidyr, corrplot, viridis) → Analyses & visualisations
Python / SpaCy → NLP, extraction textes/images
Jupyter Notebook → Exploration des éditions
HTML → Dashboard interactif
LANCER LES ANALYSES
-------------------
Prérequis R :
install.packages(c("readxl","ggplot2","dplyr","tidyr","stringr",
"scales","patchwork","corrplot","viridis","forcats"))
Analyse statistique :
setwd("chemin/vers/le/dossier")
source("analyse_audeMAG.R")
→ 20 graphiques générés dans le répertoire courant
Analyse NLP :
source("nlp_audeMAG.R")
Extraction Python :
jupyter notebook "Code python extraction.ipynb"
LIVRABLES
---------
[OK] Analyse descriptive complète (univariée, bivariée)
[OK] Visualisations de satisfaction (Likert, boxplots, moyennes)
[OK] Analyse textuelle des questions ouvertes (NLP)
[__] Extraction et analyse thématique des 57 éditions (en cours)
[__] Application web interactive (en cours)
[--] Texte de valorisation pour le site web du Département (en cours)
[--] Publication LinkedIn (en cours)
PLANNING
--------
Lundi 23/03 RDV commanditaire, analyse exploratoire, cahier des charges
Mardi 24/03 Analyses statistiques, coaching visualisation
Mercredi 25/03 Analyses NLP, développement dashboard
Jeudi 26/03 Finalisation — rendu avant minuit
Vendredi 27/03 Présentation, soutenance, remise des prix
LIENS
-----
Enquête lectorat : https://www.aude.fr/enquete-lectorat-audemag
Site audeMAG : https://www.aude.fr/audemag-le-magazine-de-laude-des-
audoises-et-des-audois
================================================================================
