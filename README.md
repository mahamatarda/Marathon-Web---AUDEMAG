MARATHON DU WEB 2026 — SUJET E : AUDEMAG
Analyse de l’enquête de lectorat du magazine départemental de l’Aude

================================================================================

## ÉQUIPE

* Ardacham Mahamat Teguene
* Akil Moub
* Anziza Ahamada Madi
* Moustapha Ndiaye

Commanditaire : Département de l’Aude
Contact : Jean Brunel
Formation : M1 MIASHS — Université Paul-Valéry Montpellier 3
Période : 23–27 mars 2026

================================================================================

## CONTEXTE

Depuis plus de 10 ans, audeMAG est le magazine départemental de l’Aude, diffusé
à grande échelle (178 000 exemplaires par trimestre).

Dans le cadre d’une réflexion sur la refonte de sa maquette et de son contenu,
le Département de l’Aude a lancé une enquête de lectorat afin de mieux comprendre
les attentes des habitant·es.

Objectifs du projet :

* Identifier les contenus les plus appréciés
* Mettre en évidence les axes d’amélioration
* Accompagner la refonte éditoriale
* Produire un outil d’aide à la décision

================================================================================

## DONNÉES

* AUDEMAG ancienne base.xls → version initiale
* AUDEMAG nouvelle base.xlsx → base consolidée

Base consolidée :

* 146 répondants
* Environ 20 variables

Le questionnaire couvre :

* Profil des répondants (âge, sexe, CSP, commune)
* Habitudes de lecture
* Rubriques préférées
* Satisfaction (plusieurs dimensions)
* Notoriété et numérique
* Attentes et changements souhaités

================================================================================

## STRUCTURE DU PROJET

data/

* AUDEMAG ancienne base.xls
* AUDEMAG nouvelle base.xlsx

R/

* analyse_audeMAG.R
* nlp_audeMAG.R

python/

* extraction.ipynb

web/

* audemag.html

================================================================================

## ANALYSES RÉALISÉES

A. Analyse statistique (R)

* Analyse descriptive (univariée et bivariée)
* Tests statistiques : Khi², Fisher, V de Cramér
* Analyse multivariée : ACM, clustering
* Création d’indicateurs (score de satisfaction, profils lecteurs)

B. Analyse textuelle (NLP)

* Nettoyage des textes
* Suppression des stopwords
* Tokenisation
* Analyse de fréquence
* Topic modeling (LDA)
* Nuages de mots

C. Extraction des éditions (Python)

* Analyse des 57 numéros d’audeMAG
* Identification des thèmes éditoriaux
* Étude de l’évolution dans le temps
* Comparaison avec les attentes des lecteurs

D. Dashboard interactif (Shiny)

* Interface interactive
* Filtres dynamiques
* Visualisations (Plotly)
* Indicateurs clés
* Exploration des données

================================================================================

## DÉMARCHE MÉTHODOLOGIQUE

Le projet repose sur une approche combinée :

* Analyse statistique
* Traitement du langage naturel (NLP)
* Analyse documentaire
* Data visualisation

Objectif : produire une analyse à la fois rigoureuse, lisible et exploitable
par le commanditaire.

================================================================================

## JOURNAL DE PROJET

Lundi 23 mars

* Analyse exploratoire des données
* Compréhension du questionnaire
* Définition des axes d’analyse
* Répartition des tâches

---

Mardi 24 mars

Objectifs :

* Développer un dashboard interactif
* Structurer le code d’analyse
* Produire des résultats interprétables
* Construire un outil d’aide à la décision

1. Développement du dashboard (R Shiny)

Architecture :

* global.R → données et fonctions
* server.R → logique serveur
* ui.R → interface

Interface :

* Navigation par onglets (vue d’ensemble, analyses)
* Filtres dynamiques (âge, sexe, CSP, etc.)
* KPI visuels
* Graphiques interactifs

Fonctionnalités :

Vue d’ensemble :

* Nombre de répondants
* Satisfaction moyenne
* Lecteurs réguliers
* Intérêt pour le numérique

Analyse univariée :

* Histogrammes
* Diagrammes en barres
* Statistiques descriptives

Analyse bivariée :

* Croisements de variables
* Tests : Khi², Fisher, V de Cramér
* Interprétation des résultats

Analyse multivariée :

* ACM
* Clustering
* Identification de profils de lecteurs

---

2. Développement du code d’analyse

Traitements :

* Import des données
* Nettoyage
* Recodage
* Création de variables

Transformations :

* Score de satisfaction global
* Regroupement des CSP
* Indicateurs (lecteur régulier, intérêt numérique)

Analyses intégrées :

* Statistiques descriptives
* Tests d’association
* Analyse multivariée

---

3. Analyse textuelle

* Nettoyage des réponses ouvertes
* Tokenisation
* Suppression des mots vides

Préparation pour :

* Nuages de mots
* Fréquences
* Topic modeling

---

4. Résultats obtenus

* Niveau global de satisfaction mesuré
* Distinction entre lecteurs réguliers et occasionnels
* Intérêt variable pour le numérique
* Différences selon les profils (âge, CSP, habitudes)

Apports :

* Identification de profils types
* Mise en évidence des relations entre variables
* Identification des thèmes principaux

---

5. Apports de la journée

* Passage d’une analyse exploratoire à un outil opérationnel
* Création d’un dashboard fonctionnel
* Automatisation des analyses
* Structuration du projet

---

6. Difficultés rencontrées

* Nettoyage des données
* Recodage des variables
* Intégration des analyses
* Automatisation des tests statistiques

---

7. Perspectives

* Finalisation de l’analyse NLP
* Amélioration du dashboard
* Ajout de visualisations
* Production de supports (affiche, flyer, vidéo)

================================================================================

## TECHNOLOGIES UTILISÉES

* R (ggplot2, dplyr, tidyr, corrplot, viridis)
* Python (SpaCy)
* Jupyter Notebook
* Shiny
* Plotly
* HTML

================================================================================

## LANCER LES ANALYSES

R :
install.packages(c("readxl","ggplot2","dplyr","tidyr","stringr",
"scales","patchwork","corrplot","viridis","forcats"))

source("analyse_audeMAG.R")

NLP :
source("nlp_audeMAG.R")

Python :
jupyter notebook extraction.ipynb

================================================================================

## LIVRABLES

[OK] Analyse statistique
[OK] Dashboard interactif
[OK] Analyse textuelle
[ ] Analyse des éditions (en cours)
[ ] Supports de communication (en cours)

================================================================================

## CONCLUSION

Le projet permet de transformer une enquête de lectorat en un outil
d’analyse et d’aide à la décision.

Le dashboard développé offre :

* une lecture claire des résultats
* une exploration interactive
* une valorisation concrète des données

================================================================================
