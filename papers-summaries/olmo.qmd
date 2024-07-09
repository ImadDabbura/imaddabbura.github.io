---
title: "OLMo: Accelerating the Science of Language Models"
date: 2024-04-09
categories:
  - LLM
  - NLP
  - DL
---

**[OLMo: Accelerating the Science of Language Models](http://arxiv.org/abs/2402.00838)**

- **Thesis**: Following the same mission as [[pythia]], this paper open sourced
  every aspect of the model's training and inference code. This includes
  training and inference codes as well as training data and model weights and
  checkpoints. OLMo model has similar performance to models such as Llama and
  much more performant than [[pythia]] models.
- **Methods**:
  - Models:
    - 4 variants of 7B models and 1 model of 1B parameters
    - Rotary positional embedding
    - SwiGLUE
    - BPE tokenizer with 50280 vocabulary size
  - Dataset: Dolmo
  - All models train on ~2T tokens
- **Contribution**: Released all the details of the framework such as training
  and inference code, data pipeline to reproduce training data, checkpoints,
  model weights, evaluation framework

#nlp #llm
