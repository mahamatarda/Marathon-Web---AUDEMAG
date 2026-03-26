# 📰 MARATHON DU WEB 2026 — AUDEMAG 📊

*Master 1 MIASHS – Université Paul-Valéry Montpellier 3*  

> Analyse de l’enquête de lectorat du magazine départemental audeMAG  
> Objectif : transformer des données en **outil d’aide à la décision publique**

------------------------------------------------------------------------

## 👥 Équipe

- **Ardacham Mahamat Teguene** — 📧 [mardacham@gmail.com](mailto:mardacham@gmail.com)  
- **Akil Moub** — 📧 [akilmhb@gmail.com](mailto:akilmhb@example.com)  
- **Anziza Ahamada Madi** — 📧 [anziza.ahamada1@gmail.com](mailto:anziza.ahamada1@gmail.com)  
- **Moustapha Ndiaye** — 📧 [taphandiaye570@gmail.com](mailto:taphandiaye570@gmail.com)  

**Commanditaire :** Département de l’Aude  
**Contact :** Jean Brunel — 📧 [jean.brunel@example.com](mailto:jean.brunel@example.com)  
**Période :** 23–27 mars 2026  

------------------------------------------------------------------------

## 🎯 Contexte

Depuis plus de 10 ans, **audeMAG** est le magazine départemental de l’Aude, diffusé à grande échelle (**178 000 exemplaires par trimestre**).

Dans le cadre d’une refonte éditoriale et visuelle, le Département de l’Aude a lancé une **enquête de lectorat** afin de mieux comprendre :
- les attentes des lecteurs  
- leur niveau de satisfaction  
- les usages du magazine  

👉 Ce projet vise à **analyser ces données et les croiser avec le contenu réel du magazine**.

------------------------------------------------------------------------

## 🎯 Problématique

**Le magazine audeMAG répond-il réellement aux attentes des lecteurs ?**

------------------------------------------------------------------------

## 📂 Données

- Enquête lectorat :
  - 146 répondants  
  - ~20 variables  

- Corpus :
  - 65 numéros du magazine audeMAG  

------------------------------------------------------------------------

## 🧠 Approche globale

Pipeline d’analyse :

------------------------------------------------------------------------

# 📊 PARTIE 1 — ANALYSE TEXTUELLE (NLP)

## ⚙️ Pipeline NLP

### 1. Nettoyage des textes
- Passage en minuscules  
- Suppression de la ponctuation  
- Suppression des stopwords  
- Tokenisation  

---

### 2. Extraction des thèmes
- Identification des mots importants  
- Regroupement en thématiques  

---

### 3. Transformation en scores

Exemple :
- Magazine → environnement = 0.6  
- Questionnaire → 40 % veulent plus d’environnement  

👉 Permet de comparer **offre vs attentes**

---

### 4. Croisement

Comparaison entre :
- Ce que proposent les magazines  
- Ce que demandent les lecteurs  

➡️ Objectif : identifier les écarts  

---

## 🛠️ Technologies NLP

- Python  
- SpaCy (`fr_core_news_lg`)  
- Pandas  
- Matplotlib  
- Seaborn  
- WordCloud  

---

## 📈 Résultats — Analyse des magazines

### 🔥 Constats principaux

- Forte dominance du contenu **institutionnel / politique**  
- Présence secondaire de l’environnement et de la culture  
- Faible représentation :
  - sport  
  - économie  
  - tourisme  

👉 Ligne éditoriale peu diversifiée  

---

## 📊 Attentes des lecteurs

Les lecteurs expriment un besoin de :
- contenu **local**  
- informations **pratiques**  
- sujets **concrets du quotidien**  

👉 Moins d’intérêt pour le contenu institutionnel  

---

## ⚖️ Croisement (résultat clé)

👉 **Décalage important identifié :**

- Magazine → institutionnel  
- Lecteurs → local et pratique  

➡️ Réponse partielle aux attentes  

---

## 😊 Analyse des sentiments

- Magazine : **82 % positif**  
- Lecteurs : **78 % positif + critiques plus présentes**  

👉 Le magazine est plus optimiste que les retours lecteurs  

---

## 💡 Recommandations

- Renforcer le contenu local  
- Ajouter des rubriques pratiques  
- Proposer des formats courts  
- Valoriser les initiatives locales  
- Réduire le contenu institutionnel  
- Améliorer la lisibilité (visuels, infographies)  

------------------------------------------------------------------------

# 🌐 PARTIE 2 — DASHBOARD INTERACTIF (R SHINY)

## 🏗️ Architecture

- `global.R` → données  
- `ui.R` → interface  
- `server.R` → logique  
- `app.R` → lancement  

---

## 🎨 Fonctionnalités

### 🔹 Vue d’ensemble
- Nombre de répondants  
- Satisfaction moyenne  
- Taux de lecteurs réguliers  
- Intérêt pour le numérique  

---

### 🔹 Analyse univariée
- Histogrammes  
- Diagrammes en barres  
- Statistiques descriptives  

---

### 🔹 Analyse bivariée
- Tests :
  - Khi²  
  - Fisher  
  - V de Cramér  

- Visualisations adaptées automatiquement  

---

### 🔹 Analyse multivariée
- ACM  
- Clustering (HCPC, PAM, Ward)  

👉 Identification de profils de lecteurs  

---

## 🗺️ Carte interactive (Leaflet)

- Visualisation géographique des répondants  
- Taille des points = nombre de réponses  
- Couleur = satisfaction  
- Utilisation de données GeoJSON  

---

## 🧠 Analyse textuelle intégrée

- Nuage de mots  
- Fréquences  
- Bigrammes  
- Cooccurrences  
- Filtres dynamiques  

---

## 🎨 Design

- Respect de la charte graphique  
- Interface moderne et lisible  
- Expérience utilisateur fluide  

---

## ⚠️ Problèmes rencontrés

- Bugs Shiny ([object Object])  
- Nettoyage des données  
- Regex et traitement texte  
- Intégration des analyses  

👉 Tous corrigés ou en cours de stabilisation  

------------------------------------------------------------------------

# 🚀 Résultat final

👉 Un **dashboard interactif complet et opérationnel**

Permet :
- d’explorer les données  
- de comprendre les résultats  
- d’aider à la prise de décision  

------------------------------------------------------------------------

# 📈 Conclusion

Le projet met en évidence :

- Une ligne éditoriale cohérente mais trop institutionnelle  
- Des attentes orientées vers du contenu concret et local  
- Un écart significatif entre offre et attentes  

👉 Ce travail constitue une base solide pour la refonte du magazine audeMAG  

------------------------------------------------------------------------

# 🔮 Perspectives

- Déploiement web du dashboard  
- Génération automatique de rapports  
- Storytelling interactif  
- Amélioration UX/UI  

------------------------------------------------------------------------

# 🛠️ Technologies utilisées

- R (ggplot2, dplyr, tidyr, corrplot, viridis)  
- Python (SpaCy)  
- Jupyter Notebook  
- R Shiny  
- Plotly  
- Leaflet  
- HTML / CSS  

------------------------------------------------------------------------

# 🚀 Lancer le projet

### R

```r
install.packages(c("readxl","ggplot2","dplyr","tidyr","stringr",
"scales","patchwork","corrplot","viridis","forcats"))

setwd("chemin/vers/le/projet")
source("analyse_audeMAG.R")
