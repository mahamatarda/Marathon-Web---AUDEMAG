# 📰 audeMAG — Analyse du lectorat & Dashboard interactif

> Projet réalisé dans le cadre du **Marathon du Web 2026**  
> Master 1 MIASHS — Université Paul-Valéry Montpellier 3  
> Commanditaire : **Département de l'Aude**

---

## 📋 Sommaire

- [Contexte](#-contexte)
- [Problématique](#-problématique)
- [Données](#-données)
- [Architecture du projet](#-architecture-du-projet)
- [Pipeline NLP (Python)](#-pipeline-nlp-python)
- [Analyse statistique (R)](#-analyse-statistique-r)
- [Dashboard Shiny](#-dashboard-shiny)
- [Résultats clés](#-résultats-clés)
- [Installation & Lancement](#-installation--lancement)
- [Équipe](#-équipe)

---

## 🗺 Contexte

Depuis plus de 10 ans, **audeMAG** est le magazine départemental de l'Aude, diffusé à **178 000 exemplaires par trimestre**.

Dans le cadre d'une refonte éditoriale et visuelle, le Département de l'Aude a lancé une **enquête de lectorat** pour mieux comprendre les attentes de ses lecteurs. Ce projet vise à analyser ces données et à les croiser avec le contenu réel du corpus de magazines afin de produire des **recommandations actionnables**.

---

## ❓ Problématique

> **Le magazine audeMAG répond-il réellement aux attentes de ses lecteurs ?**

```
Questionnaire lecteurs
        ↓
Analyse textuelle (NLP)
        ↓
Extraction des thèmes
        ↓
Corpus 65 magazines
        ↓
Analyse thématique
        ↓
Croisement offre / demande
        ↓
Recommandations
```

---

## 📊 Données

| Source | Description |
|--------|-------------|
| `AUDEMAG_nouvelle_base.xlsx` | 146 répondants, ~30 variables (rubriques, satisfaction, suggestions) |
| Corpus magazines | 65 numéros audeMAG (2016–2026), format `.txt` extrait des PDFs |

---

## 🏗 Architecture du projet

```
audemag/
│
├── python/
│   ├── audeMAG_pipeline_v12.ipynb   # Pipeline NLP complet (Google Colab)
│   └── Script_A_renommage.ipynb     # Renommage temporel des TXT (AUDEMAG-NXX-YYYY-MM)
│
├── R/
│   ├── analyse_audeMAG.R            # Analyse statistique descriptive
│   └── shiny/
│       ├── app.R                    # Point d'entrée
│       ├── global.R                 # Chargement des données
│       ├── ui.R                     # Interface utilisateur
│       └── server.R                 # Logique serveur
│
├── data/
│   ├── enquete/
│   │   └── AUDEMAG_nouvelle_base.xlsx
│   └── magazines/                   # TXT des magazines (non versionnés — voir .gitignore)
│
├── output/
│   ├── TOTAL/                       # CSV et figures agrégés tous magazines
│   │   ├── *.csv
│   │   └── figures/
│   └── AUDEMAG-NXX-YYYY-MM/         # Dossier par magazine
│       ├── nlp/*.csv
│       └── figures/*.png
│
└── README.md
```

---

## 🐍 Pipeline NLP (Python)

Développé sous **Google Colab** avec `spaCy fr_core_news_lg`.

### Entrées

- Un **ZIP de fichiers `.txt`** (un par magazine, nommés `AUDEMAG-NXX-YYYY-MM.txt`)
- Le fichier **`AUDEMAG_nouvelle_base.xlsx`** (réponses à l'enquête)

### Ce que fait le pipeline

| Étape | Description |
|-------|-------------|
| **Mots fréquents** | Lemmes NOUN + VERB uniquement (adjectifs exclus), séparés en deux nuages |
| **Entités nommées** | Personnes, lieux, organisations — normalisées (`l'Aude`, `de l'Aude` → `L'Aude`) |
| **Profils des personnes** | Classification : Politique/Élu, Agriculteur, Pompier, Artiste, Sportif, Associatif |
| **Sentiments** | Analyse lexicale phrase par phrase — score, termes porteurs, noms associés |
| **Indicateurs** | Distances (km), montants (€), dates, pourcentages, superficies |
| **Rubriques** | Classification de chaque page par score de mots-clés (9 rubriques) |
| **Critiques & suggestions** | Détection automatique des phrases critiques ou suggestives |

### Sorties par magazine

```
AUDEMAG-N57-2026-01/
├── nlp/
│   ├── *_mots_frequents.csv
│   ├── *_entites.csv
│   ├── *_profils.csv
│   ├── *_sentiments_pages.csv
│   ├── *_sentiments_phrases.csv
│   ├── *_indicateurs.csv
│   ├── *_rubriques.csv
│   └── *_critiques.csv
└── figures/
    ├── nuage_mots.png
    ├── entites_per/loc/org.png
    ├── profils.png
    ├── sentiments_phrases.png
    ├── rubriques.png
    ├── heatmap_themes.png
    └── indicateurs.png
```

### Sorties globales (`TOTAL/`)

| Fichier | Contenu |
|---------|---------|
| `global_entites.csv` | Toutes les entités — tous magazines |
| `global_sentiments_phrases.csv` | Phrases analysées — tous magazines |
| `global_rubriques.csv` | Classification pages — tous magazines |
| `enquete_sentiments_phrases.csv` | Sentiments des réponses libres |
| `CROISEMENT_rubriques.csv` | 🔑 Offre magazines vs demande lecteurs |
| `CROISEMENT_sujets_libres.csv` | 🔑 Termes voulus vs fréquence dans les mags |
| `CROISEMENT_sentiments.csv` | 🔑 Tonalité enquête vs tonalité magazines |
| `CROISEMENT_couverture_sentiments.csv` | Taux de couverture terme par terme |

### Figures globales (`TOTAL/figures/`)

```
total_nuage_mots.png
total_entites_per/loc/org.png
total_profils.png
total_rubriques.png
total_heatmap_themes.png
total_sentiments.png
evolution_temporelle.png
evolution_sentiments.png
total_barres_empilees_themes.png      ← répartition thématique par magazine
total_clustering_thematique.png       ← KMeans — groupes de magazines similaires
croisement_rubriques.png
croisement_sujets.png
croisement_sentiments.png
croisement_couverture_sentiments.png
enquete_sentiments.png
enquete_changements.png
priorites_refonte.png
nuages_themes/
    nuage_Politique-Institutions.png
    nuage_Environnement-Nature.png
    nuage_Culture-Patrimoine.png
    ...                               ← un nuage par rubrique
```

### Installation (Colab)

```python
# Cellule 1 du notebook
!pip install -q spacy matplotlib wordcloud pandas seaborn openpyxl lxml scikit-learn
!python -m spacy download fr_core_news_lg -q
```

---

## 📈 Analyse statistique (R)

Script `analyse_audeMAG.R` — analyse descriptive complète de l'enquête de lectorat.

### Ce que fait le script

- **Profil des répondants** — sexe, âge, CSP, commune
- **Habitudes de lecture** — réception, fréquence, temps de lecture, mode de consultation
- **Rubriques** — top lues, top 1 préférée, changements souhaités
- **Satisfaction** — scores 1–5 avec boîtes à moustaches, barres 100% empilées, radar
- **Numérique** — intérêt version enrichie, canaux préférés, connaissance radio

### Installation

```r
install.packages(c(
  "readxl", "ggplot2", "dplyr", "tidyr", "stringr",
  "scales", "patchwork", "corrplot", "viridis", "forcats"
))

source("R/analyse_audeMAG.R")
```

> Le fichier `AUDEMAG_nouvelle_base.xlsx` doit être dans le même dossier que le script,  
> ou son chemin doit être renseigné dans la variable `CSV_PATH` en tête de script.

---

## 🖥 Dashboard Shiny

Accessible en ligne : **[https://audemag.shinyapps.io/Dashbord/](https://audemag.shinyapps.io/Dashbord/)**

### Structure

```
shiny/
├── app.R       # Point d'entrée (source ui.R + server.R)
├── global.R    # Chargement et préparation des données
├── ui.R        # Interface — onglets, filtres, mise en page
└── server.R    # Logique réactive — graphiques, tableaux, exports
```

### Sections du dashboard

| Onglet | Contenu |
|--------|---------|
| 📊 Vue d'ensemble | KPI globaux, profil des répondants |
| 📖 Lecture | Habitudes, modes de consultation |
| 📋 Rubriques | Top rubriques, changements voulus |
| ⭐ Satisfaction | Scores par item, radar, distribution |
| 💻 Numérique | Intérêt numérique, canaux, chronique radio |
| 🔍 Croisement | Offre magazines vs attentes lecteurs |
| 💬 Verbatim | Réponses libres, critiques, suggestions |

### Lancement local

```r
# Dans RStudio ou R console
install.packages(c("shiny", "ggplot2", "dplyr", "tidyr",
                   "plotly", "leaflet", "DT", "readxl"))

shiny::runApp("R/shiny/")
```

---

## 🔑 Résultats clés

### Ce que montrent les données

| Dimension | Résultat |
|-----------|----------|
| Qualité globale | **91,5 %** des lecteurs satisfaits ou très satisfaits |
| Photos | Score moyen **4,36 / 5** — point fort unanime |
| Pertinence des sujets | Score **3,92 / 5** — marge de progression |
| Demande n°1 | **77,3 %** veulent plus de contenu local par canton/commune |
| Chronique radio | **87,9 %** des répondants ne la connaissent pas |

### Écart offre / demande

```
Sous-représentés dans le magazine    Sujet prisé par les lecteurs
───────────────────────────────────────────────────────────────
Social / Solidarité                  ████████████████████ fort
Tourisme                             ████████████░░░░░░░░ moyen
Santé / Famille                      ████████░░░░░░░░░░░░ moyen

Sur-représentés dans le magazine     Sujet moins demandé
───────────────────────────────────────────────────────────────
Politique / Institutions             ████████████████████ fort
```

### Sentiments

- **Magazines** : tonalité largement positive (célébration, résilience, engagement)
- **Lecteurs** (réponses libres) : plus critiques — termes *inutile*, *gâchis*, *loin*, *manque* ressortent

---

## ⚙️ Installation & Lancement

### Prérequis

| Outil | Version |
|-------|---------|
| Python | ≥ 3.10 |
| R | ≥ 4.2 |
| Google Colab | (recommandé pour le pipeline NLP) |
| RStudio | (recommandé pour Shiny) |

### Étapes

```bash
# 1. Cloner le dépôt
git clone https://github.com/votre-equipe/audemag-miashs.git
cd audemag-miashs

# 2. Placer vos données
cp /chemin/AUDEMAG_nouvelle_base.xlsx data/enquete/
# → Déposer les TXT des magazines dans data/magazines/

# 3. Pipeline NLP (Colab)
# Ouvrir python/audeMAG_pipeline_v12.ipynb sur Google Colab
# Cellule 1 : installation
# Cellule 2 : upload ZIP des TXT
# Cellule 3 : upload XLSX
# Cellules 4-8 : exécution et téléchargement

# 4. Analyse R
Rscript R/analyse_audeMAG.R

# 5. Dashboard Shiny
Rscript -e "shiny::runApp('R/shiny/')"
```

### `.gitignore` recommandé

```gitignore
# Données sensibles
data/magazines/
data/enquete/*.xlsx

# Sorties volumineuses
output/
*.zip

# Environnements
.Rhistory
.RData
__pycache__/
*.pyc
.ipynb_checkpoints/
```

---

## 👥 Équipe

| Nom | Rôle |
|-----|------|
| **Mahamat Teguene Ardacham** | Coordinateur |
| **Akil Moub** | IA & NLP |
| **Anziza Ahamada Madi** | Data |
| **Moustapha Ndiaye** | Visualisation |

**Commanditaire** : Département de l'Aude — Contact : Jean Brunel  
**Période** : 23–27 mars 2026

---

## 🛠 Technologies

![Python](https://img.shields.io/badge/Python-3.10+-3776AB?style=flat&logo=python&logoColor=white)
![R](https://img.shields.io/badge/R-4.2+-276DC3?style=flat&logo=r&logoColor=white)
![spaCy](https://img.shields.io/badge/spaCy-fr_core_news_lg-09A3D5?style=flat)
![Shiny](https://img.shields.io/badge/Shiny-deployed-1A73E8?style=flat)

| Catégorie | Outils |
|-----------|--------|
| NLP | spaCy, WordCloud, scikit-learn |
| Visualisation Python | matplotlib, seaborn, Plotly |
| Analyse R | ggplot2, dplyr, tidyr, patchwork, corrplot |
| Dashboard | Shiny, Plotly, Leaflet, DT |
| Notebook | Jupyter / Google Colab |
| Web | HTML / CSS |

---

## 📄 Licence

Ce projet a été réalisé dans un cadre académique pour le compte du Département de l'Aude.  
Les données de l'enquête sont la propriété du Département de l'Aude et ne peuvent être redistribuées.

Site : https://audemag.shinyapps.io/Dashbord/
Diapo : https://www.canva.com/design/DAHE9-5xzqo/7sVd0mSEVGaWIbAQErEutA/edit

---

*Marathon du Web 2026 — Master 1 MIASHS, Université Paul-Valéry Montpellier 3*
