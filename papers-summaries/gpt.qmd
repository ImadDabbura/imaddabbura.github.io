---
title: "GPT: Improving Language Understanding by Generative Pre-Training"
date: 2021-01-16
categories:
  - LLM
  - NLP
  - DL
---

**[GPT: Improving Language Understanding by Generative Pre-Training](https://cdn.openai.com/research-covers/language-unsupervised/language_understanding_paper.pdf)**

- **Thesis**: With abundance of unlabeled text and the huge cost of acquiring/labeling text data, we can use semi-supervised learning that utilizes the abundance of unlabeled text along with language modeling objective to train a model that learns general linguistic knowledge. This would lead to learning general representations that can be used with minimal changes to perform downstream tasks discriminatively.
- **Methods**:
  - Model:
    - Decoder transformer with 12 transformer blocks
    - Token and positional embeddings
    - 768 embedding dimension
    - 512 context window size
    - BPE tokenizer with 40,000 merges
    - Dropout = 0.1 for all residual, embedding, and attention
    - Batch size = 64
  - Two stage training.
    - Generative Pre-training that uses language modeling objective with unlabeled text. This means we try to predict the next word given the previous k-tokens where k is the context window
    - Discriminative fine-tuning pre-trained model on downstream tasks using labeled data so the model can adapt to new task. Depending on the downstream tasks, we may need to transform the input so we can utilize the pre-trained model w/o any changes. All tasks would have pre-trained model followed by linear layer and softmax
      - Only classification doesn't require any changes to input.
      - We use the representation of the predicted word to be the input of the linear layer
      - Inputs for all tasks have `<s>` and `<e>` tokens that are initialized randomly
      -
- **Contribution**: Introduce two training phases (generative pre-training and discriminative fine-tuning) using decoder-only transformer architecture that would learn general linguistic knowledge with no changes to the pre-trained model when tuning on downstream tasks
- **Takeaways**: Training large language models on large unlabeled datasets is a major step forward to acquire deeper and general linguistic knowledge that can be utilized by downstream tasks with shorter fine-tuning. Also, transferring more transformer layers improve performance for all tasks which suggest that each layer helps learn more language skills
- **Importance**: We can use the same model for any NLP tasks with no changes to the architecture and utilize general language knowledge model acquired during pre-training. The changes may only be needed for input/output layer
- **Improvements**: The current solution doesn't work well on short sequences.

#nlp #llm

