🧠 Marathon du Web 2026 – Projet AUDEMAG 📰
Master 1 MIASHS – Université Paul-Valéry Montpellier 3
🇫🇷 Projet réalisé dans le cadre du Marathon du Web — analyse de l’enquête de lectorat du magazine départemental de l’Aude
👥 Équipe
Ardacham Mahamat Teguene
Akil Moub
Anziza Ahamada Madi
Moustapha Ndiaye
Commanditaire : Département de l’Aude
Contact : Jean Brunel
🎯 Objectifs du projet
Ce projet s’inscrit dans le cadre du Marathon du Web 2026.
Il consiste à analyser une enquête de lectorat du magazine audeMAG afin d’en tirer des résultats exploitables.
Objectifs principaux :
Analyser les profils et habitudes des lecteurs
Mesurer le niveau de satisfaction du magazine
Identifier les attentes et axes d’amélioration
Mettre en place un outil d’aide à la décision (dashboard)
📊 Données
Deux bases ont été utilisées :
AUDEMAG ancienne base.xls → version initiale
AUDEMAG nouvelle base.xlsx → base consolidée
Contenu :
146 répondants
Environ 20 variables
Les données portent sur :
le profil des répondants (âge, sexe, CSP, commune)
les habitudes de lecture
les rubriques préférées
la satisfaction
l’intérêt pour le numérique
les commentaires et suggestions
🛠️ Outils utilisés
R (analyse statistique, visualisation)
Python (analyse textuelle – NLP)
R Shiny (dashboard interactif)
Plotly (visualisations interactives)
Jupyter Notebook
📁 Contenu du dépôt
README.md — présentation du projet
analyse_audeMAG.R — analyse statistique complète
nlp_audeMAG.R — analyse textuelle (NLP)
extraction.ipynb — extraction et analyse des éditions
audemag.html — dashboard interactif
📊 Travaux réalisés
🔹 Analyse statistique
Analyse descriptive (univariée, bivariée)
Tests statistiques (Khi², Fisher, V de Cramér)
Analyse multivariée (ACM, clustering)
🔹 Analyse textuelle (NLP)
Nettoyage des textes
Tokenisation et suppression des stopwords
Analyse de fréquence et nuages de mots
Identification des thèmes principaux
Classification des retours critiques et suggestions
🔹 Analyse des éditions
Étude de 57 numéros du magazine
Identification des thèmes éditoriaux
Croisement avec les attentes exprimées dans le sondage
🔹 Dashboard interactif
Développé sous R Shiny
Navigation par onglets : Vue d’ensemble, Analyse univariée, Analyse bivariée, Analyse multivariée
Filtres dynamiques (âge, sexe, CSP, habitudes de lecture, intérêt numérique)
KPI et visualisations interactives (Plotly)
Charte graphique cohérente avec le département de l’Aude
📅 Avancement
Lundi 23 mars
Analyse exploratoire
Compréhension du questionnaire
Répartition des tâches entre membres de l’équipe
Mardi 24 mars
Développement du dashboard
Structuration et finalisation du code audemag_analyse_complete
Mise en place des analyses statistiques et bivariées
Début de l’analyse textuelle (NLP)
Passage d’une analyse exploratoire à un outil interactif fonctionnel
⚠️ Difficultés rencontrées
Nettoyage et structuration des données (valeurs manquantes, formats différents)
Recodage et transformation des variables
Mise en place automatique des tests statistiques
Intégration de toutes les analyses dans un dashboard unique
🔮 Perspectives
Finalisation de l’analyse textuelle (NLP avancé avec SpaCy)
Ajout de visualisations supplémentaires
Amélioration de l’ergonomie et de l’expérience utilisateur du dashboard
Production de supports de restitution : affiche, flyer, vidéo
Rédaction des conclusions finales et recommandations
🚀 Conclusion
Le projet permet de transformer l’enquête de lectorat en un outil décisionnel complet.
Le travail réalisé fournit :
Une lecture claire et synthétique des résultats
L’identification des points forts et axes d’amélioration du magazine
Un dashboard interactif exploitable par le commanditaire pour guider ses décisions
