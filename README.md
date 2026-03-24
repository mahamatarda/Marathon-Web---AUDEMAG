# 📰 MARATHON DU WEB 2026 — AUDEMAG 📊

*Master 1 MIASHS – Université Paul-Valéry Montpellier 3*  

> 🇫🇷 **Version française ci-dessous / French version above**

------------------------------------------------------------------------

## 👥 Équipe

- **Ardacham Mahamat Teguene** — 📧 [email@example.com](mailto:email@example.com){.email}  
- **Akil Moub** — 📧 [email@example.com](mailto:email@example.com){.email}  
- **Anziza Ahamada Madi** — 📧 [email@example.com](mailto:email@example.com){.email}  
- **Moustapha Ndiaye** — 📧 [taphandiaye570@gmail.com](mailto:taphandiaye570@gmail.com){.email}  

Commanditaire : **Département de l’Aude** — Contact : [Jean Brunel](mailto:jean.brunel@example.com){.email}  
Période : **23–27 mars 2026**

------------------------------------------------------------------------

## 🎯 Objectifs du projet

Dans le cadre du **Marathon du Web 2026**, ce projet vise à analyser l’enquête de lectorat du magazine départemental **audeMAG** afin de produire :  

- Une **analyse statistique complète**  
- Une **analyse textuelle des réponses ouvertes**  
- Une **visualisation interactive des résultats**  
- Des **recommandations éditoriales et visuelles** pour le commanditaire  

### Objectifs principaux :

1. Identifier les rubriques et contenus les plus appréciés  
2. Mettre en évidence les axes d’amélioration  
3. Créer un **dashboard interactif** pour l’aide à la décision  
4. Valoriser les résultats auprès des citoyens  

------------------------------------------------------------------------

## 🛠️ Outils utilisés

- **R** (ggplot2, dplyr, tidyr, corrplot, viridis) → analyses statistiques et visualisations  
- **Python / SpaCy** → NLP, extraction de textes et images  
- **Jupyter Notebook** → exploration et traitement des éditions passées  
- **R Shiny / Plotly / HTML** → dashboard interactif  

------------------------------------------------------------------------

## 📁 Contenu du dépôt

- `README.md` — Présentation du projet  
- `AUDEMAG ancienne base.xls` — Données brutes, version initiale  
- `AUDEMAG nouvelle base.xlsx` — Données consolidées (146 répondants)  
- `analyse_audeMAG.R` — Analyse statistique complète  
- `nlp_audeMAG.R` — Analyse textuelle (NLP)  
- `extraction.ipynb` — Extraction et analyse des 57 éditions  
- `audemag.html` — Dashboard interactif  

------------------------------------------------------------------------

## 📅 Avancement et méthodologie

- **Analyse exploratoire des données**  
- **Recodage et traitement des variables**  
- **Tests statistiques automatiques** (Khi², Fisher, V de Cramér)  
- **Analyse multivariée** (ACM, clustering)  
- **Analyse textuelle NLP** : nuages de mots, fréquence des termes, topic modeling  
- **Création du dashboard interactif** avec filtres, KPI et graphiques Plotly  

### Répartition des tâches

- **Texte et analyse NLP** : Anziza & Mahamat  
- **Visualisation et analyses statistiques** : Moustapha & Akil  
- **Collaboration** : post-traitement, intégration dans dashboard  

------------------------------------------------------------------------

## 📝 Résultats principaux

- Mesure globale de **la satisfaction des lecteurs**  
- Distinction entre **lecteurs réguliers et occasionnels**  
- Intérêt pour la **version numérique**  
- Identification de **profils types de lecteurs**  
- Détection des **thèmes prioritaires et attentes** des lecteurs  

------------------------------------------------------------------------

## 🔮 Perspectives

- Finalisation de l’analyse NLP avancée (SpaCy)  
- Ajout de **visualisations supplémentaires** dans le dashboard  
- Amélioration de l’ergonomie et de la navigation  
- Production de supports de communication : affiche, flyer, vidéo  
- Rédaction des conclusions et recommandations finales  

------------------------------------------------------------------------

## 🚀 Lancer les analyses

### R
```r
install.packages(c("readxl","ggplot2","dplyr","tidyr","stringr",
"scales","patchwork","corrplot","viridis","forcats"))
setwd("chemin/vers/le/dossier")
source("analyse_audeMAG.R")
