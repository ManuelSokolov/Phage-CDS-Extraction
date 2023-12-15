import pandas as pd
import networkx as nx
import markov_clustering as mcl
import seaborn as sns
import matplotlib.pyplot as plt
from scipy.cluster.hierarchy import linkage, dendrogram

# df = pd.read_csv('diamond_database/results.tsv', sep='\t', header=None, dtype={10: str})

# # Keep only the first three columns
# df = df.iloc[:, :3]

# # Assign column names
# df.columns = ['protein1', 'protein2', 'value']

# #df = df[df['value'] != 100]  # Drop rows where 'value' is 100

# # Create a matrix using pivot
# matrix = df.pivot(index='protein1', columns='protein2', values='value')

# # Save the matrix as a TSV file
# matrix.to_csv('protein_similarity_matrix.tsv', sep='\t')

matrix = pd.read_csv('diamond_database/results.tsv', sep='\t', header=0, index_col=0)

sns.heatmap(matrix, cmap='viridis', annot=True, fmt="d", cbar_kws={'label': 'Similarity'})
plt.title('Protein Similarity Matrix')
plt.xlabel('Protein 2')
plt.ylabel('Protein 1')
plt.show()
plt.savefig("Protein_correlation.png")


# Get the data type of the "value" column
value_column_type = df['value'].dtype
print(f'The data type of the "value" column is: {value_column_type}')

exit(0)

# Get clusters
clusters = mcl.get_clusters(result)

# Create a graph from the clusters
G = nx.Graph()
for cluster_id, proteins in enumerate(clusters):
    for protein in proteins:
        G.add_node(protein, cluster=cluster_id)

# Plot the graph
pos = nx.spring_layout(G)  # You can use other layout algorithms
nx.draw(G, pos, with_labels=True, font_size=6)
plt.show()

# Plot dendrogram
linkage_matrix = linkage(df.values, method='average')  # Adjust method as needed
dendrogram(linkage_matrix, labels=df.index, leaf_font_size=6)
plt.show()

