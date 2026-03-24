# 📰 MARATHON DU WEB 2026 — AUDEMAG 📊

*Master 1 MIASHS – Université Paul-Valéry Montpellier 3*  

> 🇫🇷 Projet réalisé dans le cadre du Marathon du Web 2026 — Analyse de l’enquête de lectorat du magazine départemental audeMAG

------------------------------------------------------------------------

## 👥 Équipe

- **Ardacham Mahamat Teguene** — 📧 [email@example.com](mailto:email@example.com){.email}  
- **Akil Moub** — 📧 [email@example.com](mailto:email@example.com){.email}  
- **Anziza Ahamada Madi** — 📧 [email@example.com](mailto:email@example.com){.email}  
- **Moustapha Ndiaye** — 📧 [taphandiaye570@gmail.com](mailto:taphandiaye570@gmail.com){.email}  

**Commanditaire :** Département de l’Aude  
**Contact :** Jean Brunel — 📧 [jean.brunel@example.com](mailto:jean.brunel@example.com){.email}  
**Période :** 23–27 mars 2026  

------------------------------------------------------------------------

## 🎯 Contexte

Depuis plus de 10 ans, **audeMAG** est le magazine départemental de l’Aude, diffusé à grande échelle auprès des habitants (**178 000 exemplaires par trimestre** depuis 2025).

Dans le cadre d’une réflexion sur la **refonte éditoriale et visuelle** du magazine, le Département de l’Aude a lancé une **enquête de lectorat** visant à mieux comprendre les attentes, les usages et le niveau de satisfaction des lecteurs.

Ce projet s’inscrit dans une logique de **valorisation des données publiques** et d’**aide à la décision**.

------------------------------------------------------------------------

## 🎯 Objectifs du projet

- Identifier les contenus les plus appréciés  
- Mettre en évidence les axes d’amélioration prioritaires  
- Analyser les attentes exprimées par les lecteurs  
- Développer un **outil interactif d’exploration des données**  
- Proposer des **recommandations pour la refonte du magazine**  

------------------------------------------------------------------------

## 📂 Données

Deux bases ont été exploitées :

- `AUDEMAG ancienne base.xls` → version initiale  
- `AUDEMAG nouvelle base.xlsx` → base consolidée  

**Caractéristiques :**
- 146 répondants  
- Environ 20 variables  

### Variables étudiées

- Profil : âge, sexe, CSP, commune  
- Habitudes de lecture  
- Rubriques préférées  
- Satisfaction (plusieurs dimensions)  
- Notoriété (chronique radio)  
- Intérêt pour le numérique  
- Attentes et suggestions  

------------------------------------------------------------------------

## 🗂️ Structure du dépôt

- `README.md` — Présentation du projet  
- `AUDEMAG nouvelle base.xlsx` — Données consolidées  
- `analyse_audeMAG.R` — Analyse statistique  
- `nlp_audeMAG.R` — Analyse textuelle  
- `extraction.ipynb` — Analyse des éditions  
- `audemag.html` — Dashboard interactif  

------------------------------------------------------------------------

## 📊 Analyses réalisées

### 🔹 Analyse statistique (R)

- Analyse descriptive (univariée et bivariée)  
- Tests statistiques :
  - Khi²  
  - Test de Fisher  
  - V de Cramér  
- Analyse multivariée :
  - ACM  
  - Clustering  
- Création d’indicateurs :
  - Score de satisfaction  
  - Profils de lecteurs  

---

### 🔹 Analyse textuelle (NLP)

- Nettoyage et préparation des textes  
- Tokenisation  
- Suppression des stopwords  
- Analyse de fréquence  
- Topic modeling (LDA)  
- Nuages de mots  

---

### 🔹 Analyse des éditions (Python)

- Extraction des contenus des **57 numéros d’audeMAG**  
- Identification des thèmes éditoriaux  
- Analyse de leur évolution  
- Comparaison avec les attentes des lecteurs  

---

### 🔹 Dashboard interactif (Shiny)

- Interface structurée en onglets :
  - Vue d’ensemble  
  - Analyse univariée  
  - Analyse bivariée  
  - Analyse multivariée  

- Fonctionnalités :
  - Filtres dynamiques  
  - KPI (indicateurs clés)  
  - Graphiques interactifs (Plotly)  
  - Interprétation automatique des résultats  

➡️ Objectif : proposer un **outil d’aide à la décision clair et interactif**

------------------------------------------------------------------------

## 🧠 Démarche méthodologique

Le projet repose sur une approche pluridisciplinaire combinant :

- 📊 Analyse statistique  
- 🧠 Traitement automatique du langage (NLP)  
- 🗂️ Analyse documentaire  
- 🌐 Visualisation interactive  

### Principes méthodologiques

- Nettoyage et harmonisation des données  
- Recodage et création d’indicateurs  
- Automatisation des analyses  
- Validation critique des résultats  
- Restitution claire et interprétable  

------------------------------------------------------------------------

## 👥 Organisation de l’équipe

- **Analyse textuelle & contenu** : Anziza, Mahamat  
- **Analyse statistique & visualisation** : Moustapha, Akil  

**Fonctionnement :**
- Travail en parallèle  
- Réunions régulières  
- Mise en commun et harmonisation  

------------------------------------------------------------------------

## 📈 Résultats principaux

- Mesure du **niveau global de satisfaction**  
- Identification de **profils de lecteurs**  
- Distinction entre lecteurs réguliers et occasionnels  
- Mise en évidence de l’**intérêt pour le numérique**  
- Identification des **thèmes attendus et critiques récurrentes**  

------------------------------------------------------------------------

## ⚠️ Difficultés rencontrées

- Nettoyage des données (valeurs manquantes, formats)  
- Recodage des variables  
- Intégration des différentes analyses  
- Automatisation des tests statistiques  
- Traitement des données textuelles  

------------------------------------------------------------------------

## 🔮 Perspectives

- Finalisation de l’analyse NLP avancée (SpaCy)  
- Amélioration du dashboard (ergonomie, design)  
- Ajout de visualisations  
- Production de supports de communication :
  - affiche  
  - flyer  
  - vidéo  
- Rédaction des recommandations finales  

------------------------------------------------------------------------

## 🛠️ Technologies utilisées

- **R** → ggplot2, dplyr, tidyr, corrplot, viridis  
- **Python** → SpaCy  
- **Jupyter Notebook**  
- **R Shiny**  
- **Plotly**  
- **HTML / CSS**  

------------------------------------------------------------------------

## 🚀 Lancer les analyses

### R

```r
install.packages(c("readxl","ggplot2","dplyr","tidyr","stringr",
"scales","patchwork","corrplot","viridis","forcats"))

setwd("chemin/vers/le/projet")
source("analyse_audeMAG.R")
