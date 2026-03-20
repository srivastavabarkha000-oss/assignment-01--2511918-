

# Install required libraries

from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import matplotlib.pyplot as plt
import numpy as np

# Load a pre-trained embedding model
model = SentenceTransformer('all-MiniLM-L6-v2')

# Define sample sentences
sentences = [
    "Cricket is played across 20 countries in the world.",
    "In Cricket, a batsman aims to score runs while the bowler tries to dismiss them.",
    "Cricket is played on a pitch of 22 yards.",
     "Cooking requires a balance of ingredients, timing, and technique.",
     " Baking, grilling, and frying are common cooking methods used worldwide.",
     "Cooking is also a type of art, and makes space for hobby.",
      "Cybersecurity focuses on protecting systems and data from digital attacks.",
     "Strong passwords and two-factor authentication improve online safety.",
     "Regular software updates help prevent vulnerabilities from being exploited."
]

# Generate vector embeddings
vectors = model.encode(sentences)

print(f"Embedding shape: {vectors.shape}")

# Compute cosine similarity matrix
similarity_matrix = cosine_similarity(vectors)

# Plot heatmap
plt.figure(figsize=(10, 8))
plt.imshow(similarity_matrix)
plt.colorbar()

# Add labels
plt.xticks(ticks=range(len(sentences)), labels=[f"S{i}" for i in range(len(sentences))], rotation=45)
plt.yticks(ticks=range(len(sentences)), labels=[f"S{i}" for i in range(len(sentences))])

plt.title("Cosine Similarity Heatmap (10x10)")
plt.tight_layout()
plt.show()


# New query sentence
query = "The bowler took three wickets in one over"

# Encode the query
query_vector = model.encode([query])

# Compute similarity with existing sentence vectors
query_similarities = cosine_similarity(query_vector, vectors)[0]

# Get top 2 most similar sentences
top_indices = np.argsort(query_similarities)[-2:][::-1]

print(f"\nQuery: {query}\n")

print("Top 2 most similar sentences:")
for idx in top_indices:
    print(f"- {sentences[idx]} (Score: {query_similarities[idx]:.4f})")