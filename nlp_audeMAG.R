# =============================================================================
# ANALYSE TEXTUELLE NLP – QUESTIONS OUVERTES – ENQUÊTE LECTORAT AUDEMAG
# Département de l'Aude
# =============================================================================

# --- 0. PACKAGES ---

pkgs <- c("readxl","dplyr","tidyr","stringr","ggplot2","scales","forcats",
          "tidytext","wordcloud2","RColorBrewer","SnowballC","igraph",
          "ggraph","widyr","patchwork","textdata","viridis","htmlwidgets")

for (p in pkgs) {
  if (!require(p, character.only = TRUE, quietly = TRUE))
    install.packages(p, repos = "https://cran.r-project.org")
  library(p, character.only = TRUE)
}

# --- 1. CHARGEMENT & SÉLECTION DES COLONNES OUVERTES ---

df_raw <- read_excel("C:/Users/funkyflava/Downloads/AudemagEnquete.xlsx")

noms_courts <- c(
  "residence","sexe","age","csp","commune_id","commune","commune_url",
  "connait_mag","reception","lecture_12mois","mode_consultation",
  "raison_non_lecture","temps_lecture","rubriques_multi",
  "rubrique_1","rubrique_2","rubrique_3",
  "sujets_plus",           # Q.OUVERTE 1
  "sat_sujets","sat_niveau","sat_maquette","sat_photos","sat_infos_pratiques",
  "connait_chronique","chroniqueok","interet_numerique","canal_numerique",
  "annonces_locales","freq_satisfaction","qualite_globale",
  "changements_prio",      # Q.OUVERTE 2 (semi-ouverte)
  "commentaire"            # Q.OUVERTE 3
)
colnames(df_raw) <- noms_courts

# Extraire les 3 corpus
corpus_sujets     <- df_raw %>% filter(!is.na(sujets_plus),
                                        !str_detect(str_to_lower(sujets_plus), "^non$|^rien$")) %>%
  select(id = 1, texte = sujets_plus) %>%
  mutate(id = row_number(), source = "Sujets souhaités")

corpus_commentaires <- df_raw %>% filter(!is.na(commentaire)) %>%
  select(texte = commentaire) %>%
  mutate(id = row_number(), source = "Commentaires libres")

corpus_all <- bind_rows(corpus_sujets, corpus_commentaires)

cat("Corpus sujets :", nrow(corpus_sujets), "réponses\n")
cat("Corpus commentaires :", nrow(corpus_commentaires), "réponses\n")

# --- 2. STOPWORDS FRANÇAIS ENRICHIS ---

# Stopwords de base (tidytext ne couvre pas le français nativement)
sw_fr <- data.frame(word = c(
  "le","la","les","un","une","des","du","de","d","l","en","et","ou","à","au","aux",
  "ce","cet","cette","ces","je","tu","il","elle","nous","vous","ils","elles",
  "mon","ton","son","ma","ta","sa","mes","tes","ses","notre","votre","leur","leurs",
  "que","qui","quoi","dont","où","car","mais","donc","or","ni","si","ne","pas",
  "plus","moins","très","bien","aussi","même","tout","tous","toute","toutes",
  "on","se","y","en","sur","sous","avec","sans","pour","par","lors","dans","entre",
  "être","avoir","faire","aller","voir","vouloir","pouvoir","savoir","falloir",
  "est","sont","était","serait","soit","été","fait","faire","peut","ont","a",
  "m","qu","s","n","c","j","t","peu","trop","assez","vraiment","plutôt","comme",
  "ça","cela","ceci","ici","là","plus","notamment","afin","ainsi","lorsque",
  "depuis","pendant","après","avant","toujours","jamais","souvent","parfois",
  "numéro","magazine","audemag","département","aude","audois","audoise",
  "bonjour","merci","cordialement","bien","bonne","bon","bons","bonnes"
), stringsep = " ")
sw_fr <- tibble(word = sw_fr$word)

# --- 3. TOKENISATION & NETTOYAGE ---

tokenize_corpus <- function(df, corpus_name) {
  df %>%
    mutate(texte = str_to_lower(texte),
           texte = str_replace_all(texte, "[''`]", " "),
           texte = str_replace_all(texte, "[^a-zàâäéèêëîïôöùûüç ]", " "),
           texte = str_squish(texte)) %>%
    unnest_tokens(word, texte) %>%
    filter(nchar(word) > 2) %>%
    anti_join(sw_fr, by = "word") %>%
    mutate(source = corpus_name)
}

tokens_sujets  <- tokenize_corpus(corpus_sujets,       "Sujets souhaités")
tokens_comments <- tokenize_corpus(corpus_commentaires, "Commentaires libres")
tokens_all      <- bind_rows(tokens_sujets, tokens_comments)

cat("Tokens après nettoyage – Sujets :",      nrow(tokens_sujets),  "\n")
cat("Tokens après nettoyage – Commentaires :", nrow(tokens_comments), "\n")

# --- 4. FRÉQUENCES DE MOTS ---

cat("\n===== TOP MOTS =====\n")

freq_sujets <- tokens_sujets %>% count(word, sort = TRUE)
freq_comments <- tokens_comments %>% count(word, sort = TRUE)
freq_all      <- tokens_all %>% count(word, sort = TRUE)

print(head(freq_sujets, 20))
print(head(freq_comments, 20))

theme_aude <- theme_minimal(base_size = 12) +
  theme(
    plot.title    = element_text(face = "bold", size = 13, color = "#003D7A"),
    plot.subtitle = element_text(size = 10, color = "grey40"),
    axis.text     = element_text(color = "grey30"),
    panel.grid.minor = element_blank(),
    plot.caption  = element_text(size = 8, color = "grey60")
  )

## Barplot top 20 mots – sujets souhaités
p_freq_sujets <- freq_sujets %>% slice_head(n = 20) %>%
  ggplot(aes(x = fct_reorder(word, n), y = n, fill = n)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = n), hjust = -0.2, size = 3.5, color = "#003D7A", fontface = "bold") +
  coord_flip() +
  scale_fill_gradient(low = "#AED6F1", high = "#003D7A") +
  scale_y_continuous(expand = expansion(mult = c(0, .2))) +
  labs(title = "Top 20 mots – Sujets souhaités",
       subtitle = paste0("N = ", nrow(corpus_sujets), " réponses"),
       x = NULL, y = "Fréquence") +
  theme_aude

## Barplot top 20 mots – commentaires libres
p_freq_comments <- freq_comments %>% slice_head(n = 20) %>%
  ggplot(aes(x = fct_reorder(word, n), y = n, fill = n)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = n), hjust = -0.2, size = 3.5, color = "#E63B2E", fontface = "bold") +
  coord_flip() +
  scale_fill_gradient(low = "#FADBD8", high = "#E63B2E") +
  scale_y_continuous(expand = expansion(mult = c(0, .2))) +
  labs(title = "Top 20 mots – Commentaires libres",
       subtitle = paste0("N = ", nrow(corpus_commentaires), " réponses"),
       x = NULL, y = "Fréquence") +
  theme_aude

## Comparaison côte à côte
p_freq_compare <- p_freq_sujets + p_freq_comments +
  plot_annotation(title = "Analyse de fréquence des mots – Questions ouvertes",
                  theme = theme(plot.title = element_text(face = "bold", color = "#003D7A")))


# --- 5. TF-IDF (discrimination entre les deux corpus) ---

cat("\n===== TF-IDF =====\n")

tfidf_data <- tokens_all %>%
  count(source, word) %>%
  bind_tf_idf(word, source, n) %>%
  arrange(desc(tf_idf))

print(tfidf_data %>% group_by(source) %>% slice_head(n = 10))

p_tfidf <- tfidf_data %>%
  group_by(source) %>%
  slice_max(tf_idf, n = 15) %>%
  ungroup() %>%
  ggplot(aes(x = fct_reorder(word, tf_idf), y = tf_idf, fill = source)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  facet_wrap(~ source, scales = "free") +
  scale_fill_manual(values = c("#003D7A","#E63B2E")) +
  labs(title = "Mots les plus distinctifs par corpus (TF-IDF)",
       subtitle = "Les mots avec TF-IDF élevé sont caractéristiques de chaque corpus",
       x = NULL, y = "TF-IDF") +
  theme_aude


# --- 6. NUAGES DE MOTS (wordcloud2 – HTML interactif) ---

cat("\n===== NUAGES DE MOTS =====\n")

wc_sujets <- freq_sujets %>% filter(n >= 1) %>%
  rename(freq = n) %>% slice_head(n = 80)

wc_comments <- freq_comments %>% filter(n >= 1) %>%
  rename(freq = n) %>% slice_head(n = 80)

wc1 <- wordcloud2(wc_sujets,
                  color = rep(c("#003D7A","#4472C4","#F5A623","#E63B2E"), length.out = nrow(wc_sujets)),
                  backgroundColor = "white",
                  size = 0.6,
                  fontFamily = "Arial")

wc2 <- wordcloud2(wc_comments,
                  color = rep(c("#E63B2E","#003D7A","#F5A623","#4CAF50"), length.out = nrow(wc_comments)),
                  backgroundColor = "white",
                  size = 0.6,
                  fontFamily = "Arial")

saveWidget(wc1, "nlp_wordcloud_sujets.html",     selfcontained = TRUE)
saveWidget(wc2, "nlp_wordcloud_commentaires.html", selfcontained = TRUE)
cat("Nuages de mots interactifs sauvegardés en HTML.\n")


# --- 7. BIGRAMMES (associations de mots) ---

cat("\n===== BIGRAMMES =====\n")

bigrammes_sujets <- corpus_sujets %>%
  mutate(texte = str_to_lower(texte),
         texte = str_replace_all(texte, "[''`]", " "),
         texte = str_replace_all(texte, "[^a-zàâäéèêëîïôöùûüç ]", " ")) %>%
  unnest_tokens(bigram, texte, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  separate(bigram, into = c("word1","word2"), sep = " ") %>%
  filter(!word1 %in% sw_fr$word, !word2 %in% sw_fr$word,
         nchar(word1) > 2, nchar(word2) > 2) %>%
  count(word1, word2, sort = TRUE)

bigrammes_comments <- corpus_commentaires %>%
  mutate(texte = str_to_lower(texte),
         texte = str_replace_all(texte, "[''`]", " "),
         texte = str_replace_all(texte, "[^a-zàâäéèêëîïôöùûüç ]", " ")) %>%
  unnest_tokens(bigram, texte, token = "ngrams", n = 2) %>%
  filter(!is.na(bigram)) %>%
  separate(bigram, into = c("word1","word2"), sep = " ") %>%
  filter(!word1 %in% sw_fr$word, !word2 %in% sw_fr$word,
         nchar(word1) > 2, nchar(word2) > 2) %>%
  count(word1, word2, sort = TRUE)

cat("Top bigrammes – Sujets :\n");   print(head(bigrammes_sujets, 15))
cat("Top bigrammes – Commentaires :\n"); print(head(bigrammes_comments, 15))

## Barplot bigrammes
bigram_label_plot <- function(df, titre, couleur) {
  df %>%
    mutate(bigram = paste(word1, word2)) %>%
    slice_head(n = 15) %>%
    ggplot(aes(x = fct_reorder(bigram, n), y = n)) +
    geom_col(fill = couleur) +
    geom_text(aes(label = n), hjust = -0.2, size = 3.5, color = couleur, fontface = "bold") +
    coord_flip() +
    scale_y_continuous(expand = expansion(mult = c(0, .25))) +
    labs(title = titre, x = NULL, y = "Fréquence") +
    theme_aude
}

p_bigram_sujets   <- bigram_label_plot(bigrammes_sujets,   "Top bigrammes – Sujets souhaités",   "#003D7A")
p_bigram_comments <- bigram_label_plot(bigrammes_comments, "Top bigrammes – Commentaires libres", "#E63B2E")

p_bigrammes <- p_bigram_sujets + p_bigram_comments +
  plot_annotation(title = "Associations de mots (bigrammes) – Questions ouvertes",
                  theme = theme(plot.title = element_text(face = "bold", color = "#003D7A")))


# --- 8. RÉSEAU DE CO-OCCURRENCES ---

cat("\n===== RÉSEAU DE CO-OCCURRENCES =====\n")

# Co-occurrences dans les commentaires (paires de mots dans le même document)
cooc <- tokens_all %>%
  group_by(source) %>%
  pairwise_count(word, id, sort = TRUE) %>%
  filter(n >= 2)

cat("Paires de mots co-occurrentes (n>=2) :", nrow(cooc), "\n")
print(head(cooc, 15))

# Graphe avec les paires les plus fréquentes
graph_cooc <- cooc %>%
  filter(n >= 2) %>%
  slice_head(n = 60) %>%
  graph_from_data_frame()

set.seed(42)
p_reseau <- ggraph(graph_cooc, layout = "fr") +
  geom_edge_link(aes(edge_alpha = n, edge_width = n), color = "#4472C4", show.legend = FALSE) +
  geom_node_point(color = "#003D7A", size = 4, alpha = 0.8) +
  geom_node_text(aes(label = name), repel = TRUE, size = 3.5,
                 color = "#003D7A", fontface = "bold") +
  scale_edge_width(range = c(0.5, 3)) +
  labs(title = "Réseau de co-occurrences de mots",
       subtitle = "Épaisseur des liens = fréquence de co-occurrence (seuil : n ≥ 2)",
       caption = paste0("N = ", nrow(corpus_all), " réponses combinées")) +
  theme_void(base_size = 12) +
  theme(plot.title = element_text(face = "bold", color = "#003D7A"),
        plot.subtitle = element_text(color = "grey40"))


# --- 9. ANALYSE DE SENTIMENT (dictionnaire AFINN adapté FR) ---

cat("\n===== ANALYSE DE SENTIMENT =====\n")

# Dictionnaire de polarité manuel français – vecteurs séparés pour éviter tout décalage
mots_positifs <- c(
  "agréable","intéressant","intéressante","intéressants","intéressantes",
  "varié","variés","enrichissant","enrichissante","utile","utiles",
  "qualité","excellent","excellente","bonne","bien","super","bravo",
  "apprécions","apprécier","plaît","plaisir","merci","félicitations",
  "lisible","claire","clair","satisfait","satisfaite",
  "pratique","pratiques","proche","découverte",
  "recommande","pertinent","pertinents","pertinente",
  "diversifié","diversifiés","complet","complète"
)

mots_negatifs <- c(
  "inutile","gâchis","scandaleux","ennui","ennuyeux","décevant",
  "mauvais","mauvaise","nul","nulle","problème","dommage",
  "insuffisant","insuffisante","manque","absent","absente",
  "répétitif","institutionnel","institutionnels","aucun",
  "inintéressant","inintéressants","loin","éloigné","éloignée",
  "argent","coût","dépense","gaspillage","absence","ignoré"
)

sentiments_fr <- tibble(
  word      = c(mots_positifs,                         mots_negatifs),
  sentiment = c(rep("positif", length(mots_positifs)), rep("négatif", length(mots_negatifs))),
  score     = c(rep(1,         length(mots_positifs)), rep(-1,        length(mots_negatifs)))
)
cat("Dictionnaire sentiment :", length(mots_positifs), "mots positifs,",
    length(mots_negatifs), "mots négatifs\n")

## Score de sentiment par réponse
score_par_reponse <- tokens_all %>%
  inner_join(sentiments_fr, by = "word") %>%
  group_by(source, id) %>%
  summarise(score_total = sum(score), .groups = "drop")

cat("\nDistribution des scores de sentiment :\n")
score_par_reponse %>% group_by(source) %>%
  summarise(moy = mean(score_total), med = median(score_total),
            pos = sum(score_total > 0), neg = sum(score_total < 0), n = n()) %>%
  print()

p_sentiment_dist <- ggplot(score_par_reponse, aes(x = score_total, fill = source)) +
  geom_histogram(binwidth = 1, color = "white", alpha = 0.85) +
  facet_wrap(~ source, ncol = 1, scales = "free_y") +
  scale_fill_manual(values = c("#003D7A","#E63B2E")) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "grey50") +
  labs(title = "Distribution des scores de sentiment par réponse",
       subtitle = "Score > 0 = tonalité positive | Score < 0 = tonalité négative",
       x = "Score de sentiment", y = "Nombre de réponses",
       caption = "Dictionnaire de polarité FR personnalisé") +
  theme_aude + theme(legend.position = "none")

## Mots positifs vs négatifs les plus fréquents
sentiment_freq <- tokens_all %>%
  inner_join(sentiments_fr, by = "word") %>%
  count(word, sentiment, sort = TRUE) %>%
  group_by(sentiment) %>%
  slice_head(n = 15) %>%
  ungroup()

p_sentiment_mots <- ggplot(sentiment_freq,
                            aes(x = fct_reorder(word, n), y = ifelse(sentiment == "positif", n, -n),
                                fill = sentiment)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = abs(n),
                hjust = ifelse(sentiment == "positif", -0.2, 1.2)),
            size = 3.5, fontface = "bold",
            color = ifelse(sentiment_freq$sentiment == "positif", "#2E7D32", "#C62828")) +
  coord_flip() +
  scale_fill_manual(values = c("positif" = "#2E7D32", "négatif" = "#E63B2E")) +
  scale_y_continuous(labels = function(x) abs(x),
                     expand = expansion(mult = c(.2, .2))) +
  geom_vline(xintercept = 0, color = "grey50") +
  labs(title = "Mots les plus fréquents par polarité",
       subtitle = "Vert = positif (→ droite) | Rouge = négatif (→ gauche)",
       x = NULL, y = "Fréquence",
       caption = paste0("N = ", nrow(corpus_all), " réponses")) +
  theme_aude


# --- 10. SYNTHÈSE : THÈMES PRINCIPAUX ---

cat("\n===== THÈMES PRINCIPAUX =====\n")

# Thématisation manuelle guidée par les fréquences
themes_mots <- tibble(
  word = c(
    # Contenu local
    "local","locales","localité","commune","communes","village","villages","canton",
    "proximité","territoire","territorial","quartier","petits","rurales","rural",
    # Environnement / écologie
    "environnement","écologie","écologique","écologiques","transition","résilience",
    "alimentaire","nature","biodiversité","ens","espaces","naturels",
    # Patrimoine / culture
    "patrimoine","culture","culturel","culturels","histoire","historique","occitan",
    "occitane","lengadòc","traditions","patrimoine","musée","fêtes",
    # Services pratiques
    "services","pratique","démarches","contacts","informations","annonces","emploi",
    "marchés","associations","aide","aides","social",
    # Gastronomie / terroir
    "terroir","recettes","produits","gastronomie","viticole","vignoble","vins","local",
    "agriculture","agricole","paysans","producteurs",
    # Numérique / modernité
    "numérique","digital","vidéos","podcasts","internet","réseaux","ligne","application",
    # Critique institutionnel
    "institutionnel","institutionnels","politique","propagande","argent","coût",
    "public","contribuable","dépense","gâchis","inutile"
  ),
  theme = c(
    rep("Contenu local & proximité", 15),
    rep("Environnement & écologie",  12),
    rep("Patrimoine & culture",      14),
    rep("Services pratiques",        12),
    rep("Gastronomie & terroir",     10),
    rep("Numérique & modernité",      8),
    rep("Critique institutionnelle", 11)
  )
)

theme_freq <- tokens_all %>%
  inner_join(themes_mots, by = "word") %>%
  count(theme, sort = TRUE) %>%
  mutate(pct = n / nrow(corpus_all))

cat("Fréquence des thèmes :\n")
print(theme_freq)

p_themes <- ggplot(theme_freq, aes(x = fct_reorder(theme, n), y = n, fill = theme)) +
  geom_col(show.legend = FALSE) +
  geom_text(aes(label = paste0(n, " mentions\n(", round(pct*100), "% des réponses)")),
            hjust = -0.05, size = 3.5, color = "#003D7A", fontface = "bold") +
  coord_flip() +
  scale_fill_viridis_d(option = "plasma") +
  scale_y_continuous(expand = expansion(mult = c(0, .4))) +
  labs(title = "Thèmes principaux détectés dans les réponses ouvertes",
       subtitle = "Classification thématique par dictionnaire de mots-clés",
       x = NULL, y = "Nombre de mentions",
       caption = paste0("N = ", nrow(corpus_all), " réponses combinées")) +
  theme_aude


# --- 11. LONGUEUR DES RÉPONSES ---

cat("\n===== LONGUEUR DES RÉPONSES =====\n")

longueur <- corpus_all %>%
  mutate(nb_mots = str_count(texte, "\\S+"),
         nb_chars = nchar(texte))

cat("Statistiques longueur par corpus :\n")
longueur %>% group_by(source) %>%
  summarise(moy_mots = mean(nb_mots), med_mots = median(nb_mots),
            moy_chars = mean(nb_chars), max_mots = max(nb_mots)) %>%
  print()

p_longueur <- ggplot(longueur, aes(x = nb_mots, fill = source)) +
  geom_histogram(binwidth = 5, color = "white", alpha = 0.85) +
  facet_wrap(~ source, ncol = 1, scales = "free_y") +
  scale_fill_manual(values = c("#003D7A","#E63B2E")) +
  labs(title = "Distribution de la longueur des réponses ouvertes",
       x = "Nombre de mots", y = "Nombre de réponses") +
  theme_aude + theme(legend.position = "none")


# =============================================================================
# SAUVEGARDE DES FIGURES
# =============================================================================

cat("\n===== SAUVEGARDE DES FIGURES NLP =====\n")

save_plot <- function(plot, filename, w = 11, h = 6) {
  ggsave(filename, plot = plot, width = w, height = h, dpi = 150, bg = "white")
  cat("Sauvegardé :", filename, "\n")
}

save_plot(p_freq_compare,    "nlp_fig01_frequences.png",       14, 7)
save_plot(p_tfidf,           "nlp_fig02_tfidf.png",            12, 6)
save_plot(p_bigrammes,       "nlp_fig03_bigrammes.png",        13, 6)
save_plot(p_reseau,          "nlp_fig04_reseau_cooccurrences.png", 11, 9)
save_plot(p_sentiment_dist,  "nlp_fig05_sentiment_distribution.png", 9, 7)
save_plot(p_sentiment_mots,  "nlp_fig06_sentiment_mots.png",   10, 7)
save_plot(p_themes,          "nlp_fig07_themes.png",           12, 6)
save_plot(p_longueur,        "nlp_fig08_longueur_reponses.png", 9, 7)

cat("\n=== ANALYSE NLP TERMINÉE ===\n")
cat("8 figures PNG + 2 nuages de mots HTML interactifs générés.\n")
cat("Fichiers : nlp_fig01 à nlp_fig08 + nlp_wordcloud_*.html\n")
