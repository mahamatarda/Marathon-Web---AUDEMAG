# =============================================================================
# ANALYSE STATISTIQUE - ENQUÊTE LECTORAT AUDEMAG
# Département de l'Aude - 146 répondants
# =============================================================================

# --- 0. PACKAGES & CHARGEMENT ---

if (!require("readxl"))    install.packages("readxl",    repos="https://cran.r-project.org")
if (!require("ggplot2"))   install.packages("ggplot2",   repos="https://cran.r-project.org")
if (!require("dplyr"))     install.packages("dplyr",     repos="https://cran.r-project.org")
if (!require("tidyr"))     install.packages("tidyr",     repos="https://cran.r-project.org")
if (!require("stringr"))   install.packages("stringr",   repos="https://cran.r-project.org")
if (!require("scales"))    install.packages("scales",    repos="https://cran.r-project.org")
if (!require("patchwork")) install.packages("patchwork", repos="https://cran.r-project.org")
if (!require("corrplot"))  install.packages("corrplot",  repos="https://cran.r-project.org")
if (!require("viridis"))   install.packages("viridis",   repos="https://cran.r-project.org")
if (!require("forcats"))   install.packages("forcats",   repos="https://cran.r-project.org")

library(readxl); library(ggplot2); library(dplyr); library(tidyr)
library(stringr); library(scales); library(patchwork); library(corrplot)
library(viridis); library(forcats)

# Charger les données
df_raw <- read_excel("C:/Users/funkyflava/Downloads/AudemagEnquete.xlsx")

# Raccourcir les noms de colonnes pour faciliter la manipulation
noms_courts <- c(
  "residence",        # Résidez-vous dans le département ?
  "sexe",             # Sexe
  "age",              # Tranche d'âge
  "csp",              # Catégorie socio-professionnelle
  "commune_id",       # commune ID
  "commune",          # commune Titre
  "commune_url",      # commune URL
  "connait_mag",      # Connaissez-vous le magazine ?
  "reception",        # Recevez-vous chaque numéro ?
  "lecture_12mois",   # Lu au moins une fois en 12 mois ?
  "mode_consultation",# Comment consulté la dernière fois ?
  "raison_non_lecture",# Si non : pourquoi ?
  "temps_lecture",    # Temps de lecture par numéro
  "rubriques_multi",  # Rubriques lues (multi-réponses combinées)
  "rubrique_1",       # Rubriques (colonne 1)
  "rubrique_2",       # Rubriques (colonne 2)
  "rubrique_3",       # Rubriques (colonne 3)
  "sujets_plus",      # Sujets à traiter davantage
  "sat_sujets",       # Le magazine traite des sujets qui m'intéressent
  "sat_niveau",       # Le niveau d'information est adapté
  "sat_maquette",     # La maquette / mise en page
  "sat_photos",       # Les photos et illustrations
  "sat_infos_pratiques", # Les informations pratiques
  "connait_chronique",# Connaissez-vous la chronique radio ?
  "chroniqueok",      # La chronique est-elle intéressante ?
  "interet_numerique",# Intérêt pour version numérique enrichie
  "canal_numerique",  # Canal préféré pour version numérique
  "annonces_locales", # Inclure davantage d'annonces/services locaux ?
  "freq_satisfaction",# Satisfait de la fréquence de parution ?
  "qualite_globale",  # Qualité globale du magazine
  "changements_prio", # Changements prioritaires
  "commentaire"       # Commentaire libre
)

colnames(df_raw) <- noms_courts

# --- Palette & thème maison ---
couleurs_aude <- c("#003D7A", "#E63B2E", "#F5A623", "#4CAF50", "#9C27B0",
                   "#00BCD4", "#FF5722", "#607D8B", "#795548", "#009688")

theme_aude <- theme_minimal(base_size = 12) +
  theme(
    plot.title    = element_text(face = "bold", size = 14, color = "#003D7A"),
    plot.subtitle = element_text(size = 10, color = "grey40"),
    axis.text     = element_text(color = "grey30"),
    legend.position = "bottom",
    panel.grid.minor = element_blank(),
    plot.caption  = element_text(size = 8, color = "grey60")
  )


# =============================================================================
# BLOC 1 – PROFIL DES RÉPONDANTS
# =============================================================================

cat("\n===== BLOC 1 : PROFIL DES RÉPONDANTS =====\n")
cat("N total :", nrow(df_raw), "\n")

## 1a. Sexe
tab_sexe <- df_raw %>% filter(!is.na(sexe)) %>%
  count(sexe) %>% mutate(pct = n / sum(n))
print(tab_sexe)

p_sexe <- ggplot(tab_sexe, aes(x = "", y = pct, fill = sexe)) +
  geom_col(width = 1, color = "white") +
  coord_polar("y") +
  geom_text(aes(label = paste0(round(pct*100), "%")),
            position = position_stack(vjust = 0.5), color = "white", fontface = "bold") +
  scale_fill_manual(values = couleurs_aude[c(1,2,8)]) +
  labs(title = "Répartition par sexe", fill = NULL,
       caption = paste0("N = ", sum(tab_sexe$n))) +
  theme_void(base_size = 12) +
  theme(plot.title = element_text(face = "bold", color = "#003D7A"),
        legend.position = "bottom")

## 1b. Âge
ordre_age <- c("15-24 ans","25-34 ans","35-44 ans","45-54 ans","55-64 ans","65 ans et +","Préfère ne pas répondre")
tab_age <- df_raw %>% filter(!is.na(age)) %>%
  count(age) %>%
  mutate(age = factor(age, levels = ordre_age), pct = n/sum(n)) %>%
  arrange(age)
print(tab_age)

p_age <- ggplot(tab_age, aes(x = age, y = pct, fill = age)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = paste0(round(pct*100), "%\n(", n, ")")),
            vjust = -0.3, size = 3.5, color = "#003D7A", fontface = "bold") +
  scale_y_continuous(labels = percent_format(), expand = expansion(mult = c(0, .15))) +
  scale_fill_viridis_d(option = "plasma") +
  labs(title = "Répartition par tranche d'âge", x = NULL, y = "% répondants",
       caption = paste0("N = ", sum(tab_age$n))) +
  theme_aude + theme(axis.text.x = element_text(angle = 30, hjust = 1))

## 1c. CSP (recodée)
df_raw <- df_raw %>%
  mutate(csp_rec = case_when(
    str_detect(csp, "Retraité")         ~ "Retraité(e)",
    str_detect(csp, "secteur public")   ~ "Agent secteur public",
    str_detect(csp, "secteur privé")    ~ "Salarié secteur privé",
    str_detect(csp, "indépendant")      ~ "Travailleur indépendant",
    str_detect(csp, "Sans emploi")      ~ "Sans emploi",
    str_detect(csp, "Etudiant")         ~ "Étudiant(e)",
    TRUE                                ~ "Autre"
  ))
tab_csp <- df_raw %>% filter(!is.na(csp_rec)) %>%
  count(csp_rec) %>% mutate(pct = n/sum(n)) %>%
  arrange(desc(n))
print(tab_csp)

p_csp <- ggplot(tab_csp, aes(x = fct_reorder(csp_rec, n), y = pct)) +
  geom_col(fill = "#003D7A") +
  geom_text(aes(label = paste0(round(pct*100), "%")), hjust = -0.1, size = 3.5, color = "#003D7A") +
  coord_flip() +
  scale_y_continuous(labels = percent_format(), expand = expansion(mult = c(0, .2))) +
  labs(title = "Catégorie socio-professionnelle", x = NULL, y = "% répondants",
       caption = paste0("N = ", sum(tab_csp$n))) +
  theme_aude


# =============================================================================
# BLOC 2 – RÉCEPTION & LECTURE DU MAGAZINE
# =============================================================================

cat("\n===== BLOC 2 : RÉCEPTION & LECTURE =====\n")

## 2a. Connaissance du magazine
tab_connait <- df_raw %>% filter(!is.na(connait_mag)) %>%
  count(connait_mag) %>% mutate(pct = n/sum(n))
print(tab_connait)

## 2b. Réception en boîte aux lettres
ordre_recep <- c("Oui, à chaque fois","Souvent","Rarement","Jamais")
tab_recep <- df_raw %>% filter(!is.na(reception)) %>%
  count(reception) %>%
  mutate(reception = factor(reception, levels = ordre_recep), pct = n/sum(n)) %>%
  arrange(reception)
print(tab_recep)

p_recep <- ggplot(tab_recep, aes(x = reception, y = pct, fill = reception)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = paste0(round(pct*100), "%\n(", n, ")")),
            vjust = -0.3, size = 3.5, fontface = "bold") +
  scale_y_continuous(labels = percent_format(), expand = expansion(mult = c(0, .15))) +
  scale_fill_manual(values = c("#003D7A","#4472C4","#F5A623","#E63B2E")) +
  labs(title = "Réception du magazine en boîte aux lettres", x = NULL, y = "%",
       caption = paste0("N = ", sum(tab_recep$n))) +
  theme_aude

## 2c. Fréquence de lecture (12 derniers mois)
tab_lecture <- df_raw %>% filter(!is.na(lecture_12mois)) %>%
  count(lecture_12mois) %>% mutate(pct = n/sum(n))
print(tab_lecture)

p_lecture <- ggplot(tab_lecture, aes(x = "", y = pct, fill = lecture_12mois)) +
  geom_col(width = 1, color = "white") +
  coord_polar("y") +
  geom_text(aes(label = paste0(round(pct*100), "%")),
            position = position_stack(vjust = 0.5), color = "white", fontface = "bold") +
  scale_fill_manual(values = couleurs_aude[c(4,3,2)]) +
  labs(title = "Lecture au cours des 12 derniers mois", fill = NULL,
       caption = paste0("N = ", sum(tab_lecture$n))) +
  theme_void(base_size = 12) +
  theme(plot.title = element_text(face = "bold", color = "#003D7A"),
        legend.position = "right")

## 2d. Temps de lecture
ordre_temps <- c("Moins de 5 min","Je feuillette seulement","5-15 min","15-30 min","Plus de 30 min")
tab_temps <- df_raw %>% filter(!is.na(temps_lecture)) %>%
  count(temps_lecture) %>%
  mutate(temps_lecture = factor(temps_lecture, levels = ordre_temps), pct = n/sum(n)) %>%
  arrange(temps_lecture)
print(tab_temps)

p_temps <- ggplot(tab_temps, aes(x = temps_lecture, y = pct, fill = temps_lecture)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = paste0(round(pct*100), "%\n(", n, ")")),
            vjust = -0.3, size = 3.5, fontface = "bold") +
  scale_y_continuous(labels = percent_format(), expand = expansion(mult = c(0, .18))) +
  scale_fill_viridis_d(option = "cividis") +
  labs(title = "Temps de lecture moyen par numéro", x = NULL, y = "%",
       caption = paste0("N = ", sum(tab_temps$n))) +
  theme_aude + theme(axis.text.x = element_text(angle = 20, hjust = 1))


# =============================================================================
# BLOC 3 – RUBRIQUES PRÉFÉRÉES (multi-réponses)
# =============================================================================

cat("\n===== BLOC 3 : RUBRIQUES PRÉFÉRÉES =====\n")

# Décomposer les multi-réponses des 3 colonnes rubrique
rubriques_all <- c(
  df_raw$rubrique_1[!is.na(df_raw$rubrique_1)],
  df_raw$rubrique_2[!is.na(df_raw$rubrique_2)],
  df_raw$rubrique_3[!is.na(df_raw$rubrique_3)]
)

tab_rubriques <- data.frame(rubrique = rubriques_all) %>%
  count(rubrique, sort = TRUE) %>%
  mutate(
    rubrique_court = case_when(
      str_detect(rubrique, "En bref")         ~ "En bref (actualités)",
      str_detect(rubrique, "Dossiers")         ~ "Dossiers thématiques",
      str_detect(rubrique, "sorties")          ~ "Par ici les sorties",
      str_detect(rubrique, "Manger")           ~ "Manger audois",
      str_detect(rubrique, "Focus")            ~ "Focus (reportages locaux)",
      str_detect(rubrique, "L'Art d'être")     ~ "L'Art d'être Audois",
      str_detect(rubrique, "C'est pratique")   ~ "C'est pratique",
      str_detect(rubrique, "routes")           ~ "Quoi de neuf sur les routes",
      str_detect(rubrique, "Dans la peau")     ~ "Dans la peau de...",
      str_detect(rubrique, "Tribune")          ~ "Tribune politique",
      str_detect(rubrique, "sport")            ~ "Ça c'est du sport",
      str_detect(rubrique, "Grand angle")      ~ "Grand angle (photos)",
      TRUE                                     ~ rubrique
    ),
    pct = n / nrow(df_raw)
  )
print(tab_rubriques)

p_rubriques <- ggplot(tab_rubriques, aes(x = fct_reorder(rubrique_court, n), y = n, fill = n)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = paste0(n, " (", round(pct*100), "%)")),
            hjust = -0.1, size = 3.2, color = "#003D7A") +
  coord_flip() +
  scale_fill_gradient(low = "#AED6F1", high = "#003D7A") +
  scale_y_continuous(expand = expansion(mult = c(0, .2))) +
  labs(title = "Rubriques lues systématiquement ou souvent",
       subtitle = "Multi-réponses – jusqu'à 4 rubriques par répondant",
       x = NULL, y = "Nombre de mentions",
       caption = paste0("Base : N = ", nrow(df_raw), " répondants")) +
  theme_aude


# =============================================================================
# BLOC 4 – SATISFACTION (variables 1-5)
# =============================================================================

cat("\n===== BLOC 4 : SATISFACTION =====\n")

sat_vars <- c("sat_sujets","sat_niveau","sat_maquette","sat_photos","sat_infos_pratiques")
sat_labels <- c(
  "Sujets intéressants",
  "Niveau d'information adapté",
  "Maquette / mise en page",
  "Photos & illustrations",
  "Infos pratiques accessibles"
)

# Convertir en numérique
df_sat <- df_raw %>%
  select(all_of(sat_vars)) %>%
  mutate(across(everything(), ~ as.numeric(str_extract(., "^\\d"))))

cat("Statistiques descriptives des variables de satisfaction (1-5) :\n")
print(summary(df_sat))

# Moyennes
moyennes <- df_sat %>%
  summarise(across(everything(), ~ mean(., na.rm = TRUE))) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "moyenne") %>%
  mutate(label = sat_labels[match(variable, sat_vars)])

cat("\nMoyennes :\n"); print(moyennes)

p_moyennes <- ggplot(moyennes, aes(x = fct_reorder(label, moyenne), y = moyenne, fill = moyenne)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = round(moyenne, 2)), hjust = -0.15, fontface = "bold", size = 4) +
  geom_hline(yintercept = 3, linetype = "dashed", color = "grey60") +
  coord_flip() +
  scale_y_continuous(limits = c(0, 5.5), breaks = 1:5) +
  scale_fill_gradient(low = "#F5A623", high = "#003D7A") +
  labs(title = "Scores moyens de satisfaction (échelle 1 à 5)",
       subtitle = "Ligne pointillée = note médiane théorique (3)",
       x = NULL, y = "Score moyen",
       caption = paste0("N = ", nrow(df_raw))) +
  theme_aude

## Boîtes à moustaches
df_sat_long <- df_sat %>%
  pivot_longer(everything(), names_to = "variable", values_to = "score") %>%
  filter(!is.na(score)) %>%
  mutate(label = sat_labels[match(variable, sat_vars)])

p_boxplot <- ggplot(df_sat_long, aes(x = fct_reorder(label, score, median), y = score, fill = label)) +
  geom_boxplot(show.legend = FALSE, outlier.color = "#E63B2E", outlier.size = 2, alpha = 0.85) +
  geom_jitter(show.legend = FALSE, width = 0.15, alpha = 0.3, size = 1.5, color = "grey40") +
  scale_fill_viridis_d(option = "mako") +
  scale_y_continuous(breaks = 1:5) +
  coord_flip() +
  labs(title = "Distribution des scores de satisfaction",
       subtitle = "Boîtes à moustaches + observations individuelles",
       x = NULL, y = "Score (1 = Pas du tout d'accord, 5 = Tout à fait d'accord)",
       caption = paste0("N = ", nrow(df_raw))) +
  theme_aude

## Graphique en barres empilées (détail des réponses)
order_levels <- c("1 - Pas du tout d'accord","2 - Pas d'accord",
                  "3 - Moyennement d'accord","4 - Plutôt d'accord",
                  "5 - Tout à fait d'accord")
couleurs_likert <- c("#E63B2E","#F5A623","#FFF176","#81C784","#2E7D32")

df_sat_raw <- df_raw %>%
  select(all_of(sat_vars)) %>%
  pivot_longer(everything(), names_to = "variable", values_to = "reponse") %>%
  filter(!is.na(reponse)) %>%
  mutate(
    label = sat_labels[match(variable, sat_vars)],
    reponse = factor(reponse, levels = order_levels)
  ) %>%
  count(label, reponse) %>%
  group_by(label) %>%
  mutate(pct = n / sum(n))

p_likert <- ggplot(df_sat_raw, aes(x = label, y = pct, fill = reponse)) +
  geom_col(position = "stack") +
  geom_text(aes(label = ifelse(pct > 0.05, paste0(round(pct*100), "%"), "")),
            position = position_stack(vjust = 0.5), size = 3, color = "white", fontface = "bold") +
  coord_flip() +
  scale_fill_manual(values = couleurs_likert, name = NULL) +
  scale_y_continuous(labels = percent_format()) +
  labs(title = "Répartition détaillée des réponses Likert",
       x = NULL, y = "%",
       caption = paste0("N = ", nrow(df_raw))) +
  theme_aude + theme(legend.position = "bottom")


# =============================================================================
# BLOC 5 – CORRÉLATIONS ENTRE ITEMS DE SATISFACTION
# =============================================================================

cat("\n===== BLOC 5 : CORRÉLATIONS =====\n")

df_sat_clean <- df_sat %>% drop_na()
mat_cor <- cor(df_sat_clean, method = "spearman")
colnames(mat_cor) <- rownames(mat_cor) <- sat_labels
cat("Matrice de corrélations de Spearman :\n")
print(round(mat_cor, 2))

# Sauvegarde du corrplot dans un PNG temporaire
png("/tmp/corrplot_aude.png", width = 700, height = 600, res = 110)
corrplot(mat_cor,
         method    = "color",
         type      = "upper",
         order     = "hclust",
         addCoef.col = "black",
         tl.col    = "#003D7A",
         tl.srt    = 30,
         col       = COL2("RdBu", 10),
         title     = "Corrélations de Spearman – items de satisfaction",
         mar       = c(0,0,2,0))
dev.off()
cat("Corrplot sauvegardé dans /tmp/corrplot_aude.png\n")

# Tests de corrélation significatifs
cat("\nTests de Spearman significatifs (p < 0.05) :\n")
for (i in 1:(length(sat_vars)-1)) {
  for (j in (i+1):length(sat_vars)) {
    test <- cor.test(df_sat_clean[[sat_vars[i]]], df_sat_clean[[sat_vars[j]]], method = "spearman")
    if (test$p.value < 0.05) {
      cat(sprintf("  %s <-> %s : rho=%.2f, p=%.4f\n",
                  sat_labels[i], sat_labels[j], test$estimate, test$p.value))
    }
  }
}


# =============================================================================
# BLOC 6 – SATISFACTION PAR SOUS-GROUPES (âge, sexe, CSP)
# =============================================================================

cat("\n===== BLOC 6 : SATISFACTION PAR SOUS-GROUPES =====\n")

df_raw <- df_raw %>%
  mutate(score_sat_moyen = rowMeans(df_sat, na.rm = TRUE))

## Par tranche d'âge
cat("\nScore moyen satisfaction par âge :\n")
df_raw %>% filter(!is.na(age), age != "Préfère ne pas répondre") %>%
  group_by(age) %>%
  summarise(moy = mean(score_sat_moyen, na.rm = TRUE), n = n()) %>%
  arrange(age) %>% print()

ordre_age2 <- c("15-24 ans","25-34 ans","35-44 ans","45-54 ans","55-64 ans","65 ans et +")
p_sat_age <- df_raw %>%
  filter(!is.na(age), age != "Préfère ne pas répondre", !is.na(score_sat_moyen)) %>%
  mutate(age = factor(age, levels = ordre_age2)) %>%
  ggplot(aes(x = age, y = score_sat_moyen, fill = age)) +
  geom_boxplot(show.legend = FALSE, alpha = 0.8) +
  scale_fill_viridis_d(option = "plasma") +
  scale_y_continuous(limits = c(1,5), breaks = 1:5) +
  labs(title = "Score moyen de satisfaction selon l'âge",
       x = NULL, y = "Score moyen (1-5)",
       caption = paste0("N = ", sum(!is.na(df_raw$score_sat_moyen)))) +
  theme_aude + theme(axis.text.x = element_text(angle = 30, hjust = 1))

## Par sexe
p_sat_sexe <- df_raw %>%
  filter(sexe %in% c("Femme","Homme"), !is.na(score_sat_moyen)) %>%
  ggplot(aes(x = sexe, y = score_sat_moyen, fill = sexe)) +
  geom_violin(trim = FALSE, alpha = 0.7, show.legend = FALSE) +
  geom_boxplot(width = 0.2, fill = "white", show.legend = FALSE) +
  scale_fill_manual(values = c("#E63B2E","#003D7A")) +
  scale_y_continuous(limits = c(1,5), breaks = 1:5) +
  labs(title = "Satisfaction par sexe", x = NULL, y = "Score moyen",
       caption = paste0("N = ", nrow(df_raw %>% filter(sexe %in% c("Femme","Homme"))))) +
  theme_aude

## ANOVA : satisfaction selon l'âge
df_anova <- df_raw %>%
  filter(!is.na(age), age != "Préfère ne pas répondre", !is.na(score_sat_moyen))
aov_age <- aov(score_sat_moyen ~ age, data = df_anova)
cat("\nANOVA satisfaction ~ âge :\n")
print(summary(aov_age))


# =============================================================================
# BLOC 7 – QUESTIONS DE NOTORIÉTÉ ET D'INTENTION NUMÉRIQUE
# =============================================================================

cat("\n===== BLOC 7 : NOTORIÉTÉ & NUMÉRIQUE =====\n")

## Chronique radio
tab_chrono <- df_raw %>% filter(!is.na(connait_chronique)) %>%
  count(connait_chronique) %>% mutate(pct = n/sum(n))
print(tab_chrono)

p_chrono <- ggplot(tab_chrono, aes(x = "", y = pct, fill = connait_chronique)) +
  geom_col(width = 1, color = "white") +
  coord_polar("y") +
  geom_text(aes(label = paste0(round(pct*100), "%\n(", n, ")")),
            position = position_stack(vjust = 0.5), color = "white", fontface = "bold") +
  scale_fill_manual(values = c("#E63B2E","#003D7A")) +
  labs(title = "Notoriété de la chronique radio #audeMAG", fill = NULL,
       caption = paste0("N = ", sum(tab_chrono$n))) +
  theme_void(base_size = 12) +
  theme(plot.title = element_text(face = "bold", color = "#003D7A"), legend.position = "right")

## Intérêt pour version numérique
ordre_num <- c("Oui, très","Oui, un peu","Sans avis","Non")
tab_num <- df_raw %>% filter(!is.na(interet_numerique)) %>%
  count(interet_numerique) %>%
  mutate(interet_numerique = factor(interet_numerique, levels = ordre_num), pct = n/sum(n)) %>%
  arrange(interet_numerique)
print(tab_num)

p_numerique <- ggplot(tab_num, aes(x = interet_numerique, y = pct, fill = interet_numerique)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = paste0(round(pct*100), "%\n(", n, ")")),
            vjust = -0.3, fontface = "bold", size = 3.8) +
  scale_y_continuous(labels = percent_format(), expand = expansion(mult = c(0, .18))) +
  scale_fill_manual(values = c("#003D7A","#4472C4","#F5A623","#E63B2E")) +
  labs(title = "Intérêt pour une version numérique enrichie",
       x = NULL, y = "%",
       caption = paste0("N = ", sum(tab_num$n))) +
  theme_aude

## Annonces locales
tab_annonces <- df_raw %>% filter(!is.na(annonces_locales)) %>%
  count(annonces_locales) %>% mutate(pct = n/sum(n))

p_annonces <- ggplot(tab_annonces, aes(x = "", y = pct, fill = annonces_locales)) +
  geom_col(width = 1, color = "white") +
  coord_polar("y") +
  geom_text(aes(label = paste0(round(pct*100), "%\n(", n, ")")),
            position = position_stack(vjust = 0.5), color = "white", fontface = "bold") +
  scale_fill_manual(values = c("#003D7A","#F5A623","#E63B2E")) +
  labs(title = "Inclure davantage d'annonces/services locaux ?", fill = NULL,
       caption = paste0("N = ", sum(tab_annonces$n))) +
  theme_void(base_size = 12) +
  theme(plot.title = element_text(face = "bold", color = "#003D7A"), legend.position = "right")


# =============================================================================
# BLOC 8 – FRÉQUENCE & QUALITÉ GLOBALE
# =============================================================================

cat("\n===== BLOC 8 : FRÉQUENCE & QUALITÉ GLOBALE =====\n")

## Fréquence
tab_freq <- df_raw %>% filter(!is.na(freq_satisfaction)) %>%
  count(freq_satisfaction) %>% mutate(pct = n/sum(n)) %>%
  arrange(desc(n))
print(tab_freq)

p_freq <- ggplot(tab_freq, aes(x = fct_reorder(freq_satisfaction, n), y = pct, fill = freq_satisfaction)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = paste0(round(pct*100), "%\n(", n, ")")),
            hjust = -0.1, fontface = "bold", size = 3.5) +
  coord_flip() +
  scale_y_continuous(labels = percent_format(), expand = expansion(mult = c(0, .25))) +
  scale_fill_manual(values = c("#003D7A","#4472C4","#F5A623","#E63B2E")) +
  labs(title = "Satisfaction vis-à-vis de la fréquence de parution",
       x = NULL, y = "%",
       caption = paste0("N = ", sum(tab_freq$n))) +
  theme_aude

## Qualité globale
tab_qualite <- df_raw %>% filter(!is.na(qualite_globale)) %>%
  count(qualite_globale) %>% mutate(pct = n/sum(n)) %>%
  mutate(qualite_globale = factor(qualite_globale,
                                  levels = c("Très satisfaisante","Assez satisfaisante",
                                             "Peu satisfaisante","Pas du tout satisfaisante")))

p_qualite <- ggplot(tab_qualite, aes(x = qualite_globale, y = pct, fill = qualite_globale)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = paste0(round(pct*100), "%\n(", n, ")")),
            vjust = -0.3, fontface = "bold", size = 3.8) +
  scale_y_continuous(labels = percent_format(), expand = expansion(mult = c(0, .18))) +
  scale_fill_manual(values = c("#2E7D32","#81C784","#F5A623","#E63B2E")) +
  labs(title = "Qualité globale perçue du magazine",
       x = NULL, y = "%",
       caption = paste0("N = ", sum(tab_qualite$n))) +
  theme_aude + theme(axis.text.x = element_text(angle = 15, hjust = 1))


# =============================================================================
# BLOC 9 – CHANGEMENTS PRIORITAIRES (multi-réponses)
# =============================================================================

cat("\n===== BLOC 9 : CHANGEMENTS PRIORITAIRES =====\n")

changements_possibles <- c(
  "Plus de contenu local par canton/commune",
  "Rubrique « services pratiques » renforcée",
  "Plus de photos et infographies",
  "Moins de textes institutionnels, plus de pédagogie",
  "Versions numériques enrichies",
  "Maquette plus moderne et aérée"
)

tab_chang <- df_raw %>%
  filter(!is.na(changements_prio)) %>%
  pull(changements_prio) %>%
  str_split(";") %>%
  unlist() %>%
  str_trim() %>%
  .[. %in% changements_possibles] %>%
  data.frame(item = .) %>%
  count(item, sort = TRUE) %>%
  mutate(pct = n / nrow(df_raw))

print(tab_chang)

p_changements <- ggplot(tab_chang, aes(x = fct_reorder(item, n), y = n, fill = n)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = paste0(n, " (", round(pct*100), "%)")),
            hjust = -0.1, size = 3.5, color = "#003D7A", fontface = "bold") +
  coord_flip() +
  scale_fill_gradient(low = "#AED6F1", high = "#003D7A") +
  scale_y_continuous(expand = expansion(mult = c(0, .25))) +
  labs(title = "Changements prioritaires souhaités par les lecteurs",
       subtitle = "Multi-réponses – jusqu'à 3 choix par répondant",
       x = NULL, y = "Nombre de mentions",
       caption = paste0("N = ", nrow(df_raw))) +
  theme_aude


# =============================================================================
# BLOC 10 – CROISEMENTS ANALYTIQUES
# =============================================================================

cat("\n===== BLOC 10 : CROISEMENTS =====\n")

## Qualité globale vs satisfaction moyenne
df_raw <- df_raw %>%
  mutate(qualite_num = case_when(
    qualite_globale == "Très satisfaisante"         ~ 4,
    qualite_globale == "Assez satisfaisante"         ~ 3,
    qualite_globale == "Peu satisfaisante"           ~ 2,
    qualite_globale == "Pas du tout satisfaisante"   ~ 1,
    TRUE ~ NA_real_
  ))

cat("Corrélation satisfaction moyenne ~ qualité globale :\n")
test_cor_qual <- cor.test(df_raw$score_sat_moyen, df_raw$qualite_num,
                          method = "spearman", use = "complete.obs")
print(test_cor_qual)

p_cross_qualite <- df_raw %>% filter(!is.na(qualite_globale), !is.na(score_sat_moyen)) %>%
  mutate(qualite_globale = factor(qualite_globale,
                                  levels = c("Pas du tout satisfaisante","Peu satisfaisante",
                                             "Assez satisfaisante","Très satisfaisante"))) %>%
  ggplot(aes(x = qualite_globale, y = score_sat_moyen, fill = qualite_globale)) +
  geom_violin(trim = FALSE, alpha = 0.7, show.legend = FALSE) +
  geom_boxplot(width = 0.2, fill = "white", show.legend = FALSE) +
  scale_fill_manual(values = c("#E63B2E","#F5A623","#81C784","#2E7D32")) +
  labs(title = "Score moyen satisfaction vs qualité globale perçue",
       x = NULL, y = "Score moyen items satisfaction (1-5)",
       caption = paste0("rho = ", round(test_cor_qual$estimate, 2),
                        " | p = ", signif(test_cor_qual$p.value, 3))) +
  theme_aude + theme(axis.text.x = element_text(angle = 15, hjust = 1))

## Intérêt numérique selon l'âge
cat("\nTableau croisé intérêt numérique × tranche d'âge :\n")
tab_num_age <- df_raw %>%
  filter(!is.na(interet_numerique), !is.na(age), age != "Préfère ne pas répondre") %>%
  count(age, interet_numerique) %>%
  group_by(age) %>% mutate(pct = n / sum(n)) %>% ungroup()
print(tab_num_age)

p_num_age <- tab_num_age %>%
  mutate(age = factor(age, levels = ordre_age2),
         interet_numerique = factor(interet_numerique, levels = ordre_num)) %>%
  ggplot(aes(x = age, y = pct, fill = interet_numerique)) +
  geom_col(position = "stack") +
  scale_fill_manual(values = c("#003D7A","#4472C4","#F5A623","#E63B2E"), name = NULL) +
  scale_y_continuous(labels = percent_format()) +
  labs(title = "Intérêt pour le numérique selon la tranche d'âge",
       x = NULL, y = "%",
       caption = paste0("N = ", sum(tab_num_age$n))) +
  theme_aude + theme(axis.text.x = element_text(angle = 30, hjust = 1))


# =============================================================================
# SAUVEGARDE DES GRAPHIQUES
# =============================================================================

cat("\n===== SAUVEGARDE DES FIGURES =====\n")

save_plot <- function(plot, filename, w = 10, h = 6) {
  ggsave(filename, plot = plot, width = w, height = h, dpi = 150, bg = "white")
  cat("Sauvegardé :", filename, "\n")
}

save_plot(p_sexe,         "fig01_sexe.png",          7, 6)
save_plot(p_age,          "fig02_age.png",            9, 5)
save_plot(p_csp,          "fig03_csp.png",            9, 5)
save_plot(p_recep,        "fig04_reception.png",      9, 5)
save_plot(p_lecture,      "fig05_lecture.png",        8, 6)
save_plot(p_temps,        "fig06_temps_lecture.png",  9, 5)
save_plot(p_rubriques,    "fig07_rubriques.png",     11, 6)
save_plot(p_moyennes,     "fig08_sat_moyennes.png",  10, 5)
save_plot(p_boxplot,      "fig09_sat_boxplot.png",   11, 6)
save_plot(p_likert,       "fig10_sat_likert.png",    11, 6)
save_plot(p_sat_age,      "fig11_sat_age.png",        9, 5)
save_plot(p_sat_sexe,     "fig12_sat_sexe.png",       7, 5)
save_plot(p_chrono,       "fig13_chronique.png",      7, 5)
save_plot(p_numerique,    "fig14_numerique.png",      8, 5)
save_plot(p_annonces,     "fig15_annonces.png",       7, 5)
save_plot(p_freq,         "fig16_frequence.png",      9, 5)
save_plot(p_qualite,      "fig17_qualite_globale.png",9, 5)
save_plot(p_changements,  "fig18_changements.png",   11, 6)
save_plot(p_cross_qualite,"fig19_cross_qualite.png", 10, 6)
save_plot(p_num_age,      "fig20_numerique_age.png",  9, 5)

cat("\n=== ANALYSE TERMINÉE ===\n")
cat("20 graphiques générés. Lancez ce script dans RStudio avec setwd() sur votre dossier de travail.\n")
