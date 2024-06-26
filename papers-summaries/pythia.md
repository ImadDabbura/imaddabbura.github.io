---
title: "Pythia: A Suite for Analyzing Large Language Models Across Training and Scaling"
date: 2023-12-09
categories:
  - LLM
  - NLP
  - DL
---

**[Pythia: A Suite for Analyzing Large Language Models Across Training and Scaling](https://arxiv.org/abs/2304.01373)**

- **Thesis**: Provide open-sources models of different sizes and checkpoints
  as well as training code to study how LLMs capabilities evolve during training
  such as biases and correlation of term frequencies task accuracy.
- **Methods**:
  - Models:
    - 8 models from 70M to 12B parameters with almost identical training
      setup
    - Checkpoint of each model is saved after ~2B tokens
  - BPE tokenizer
  - Datasets:
    - The Pile (300B tokens)
    - Near de-duplicated version of the Pile (207B tokens)
- **Contribution**: Released and make available the following:
  - 154 checkpoints for each model
  - Training/model code
  - 8 model sizes that range from 70M to 12B
  - Each model is trained twice:
    - One on the Pile dataset (300B tokens)
    - One on the near de-duplicated version of the Pile (207B tokens)
- **Importance**: Open sourced models, checkpoints, and training code to help
  researchers further study the learning dynamics of LLMs as training progress.
- **Takeaways**:
  - Models trained on near de-duplicated data didn't outperform models trained
    on the full dataset
  - Changing corpus statistics 7% and 21% before end of training by replacing
    masculine pronouns with feminine pronouns led to reduce bias w/o hardly
    affecting the model's perplexity. This may be due to the fact that LLM
    captures tokens' correlations and distributions and such a change makes the
    model more robust. The effect is bigger for larger models as they tend to
    be more biased
  - Placing sequences in the beginning of segments didn't show any evidence of
    memorization
  - Term frequencies related to a task affect the few-shot accuracy for the
    models. The more frequent the term the more accurate the model
    - Small models don't show better performance with more term frequencies,
      which means this is an emergent ability for large models

#nlp #llm
