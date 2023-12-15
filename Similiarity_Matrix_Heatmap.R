library(tidyverse)
library(viridis)
library(ComplexHeatmap)

x <- read.csv("protein_similarity_matrix.tsv",sep="\t", row.names = 1)

view_results <- read.csv("diamond_database/results.tsv",sep="\t")

# get first line again
view_results <- view_results[, 1:3]

colnames(view_results) <- c("protein1", "protein2", "value")

view_results <- view_results[view_results$value <100.0,]



barplot(view_results$value)

similarity_matrix <- view_results %>%
  pivot_wider(names_from = protein2, values_from = value) %>%
  column_to_rownames(var = "protein1")

common <- intersect(row.names(similarity_matrix), colnames(similarity_matrix))

similarity_matrix <- similarity_matrix[common,common]



similarity_df <- as.data.frame(similarity_matrix)
my_palette <- viridis(100)

heatmap_plot <- Heatmap(
  t(similarity_df),
  col = my_palette,
  name = "Similarity",
  show_row_names = TRUE,
  show_column_names = TRUE,
  clustering_distance_rows = "euclidean",
  clustering_distance_columns = "euclidean"
)
png("heatmap_plot.png")
draw(heatmap_plot)
dev.off()


# Save the plot
ggsave("heatmap_plot.png", heatmap_plot)

# my_palette <- viridis(100)
# 
# # Plot heatmap
# heatmap(
#   as.matrix(similarity_matrix),
#   col = my_palette,
#   main = "Protein Similarity Matrix",
#   xlab = "Protein 2",
#   ylab = "Protein 1"
# )