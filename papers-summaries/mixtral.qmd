---
title: "Mixtral of Experts"
date: 2024-03-17
categories:
  - LLM
  - NLP
  - DL
---

[Mixtral of Experts](http://arxiv.org/abs/2401.04088)

- **Thesis**: Mixtral-8x7B through its use of Mixture of Experts (MoE) helps
  train and generate text very efficiently and achieve much better performance
  than comparable dense models with the same computational cost. MoE allows to
  train much bigger models than its counter dense models due to the fact that
  each token in each layer will processed by 2 experts (not 8) which reduces
  computational cost.
- **Methods**:
  - Model: Follows [[mistral-7b]] with the following changes:
    - context_len = 32768
    - num_experts = 8
    - top_k_experts = 2
- **Contribution**: Open sourced Mistral-8x7B base and chat models. Also
  provides efficient implementations for sparse MoE on single and multiple GPUs
  such as Efficient Parallelism
- **Improvements**:
  - Takes more VRAM as the full model needs to be loaded into memory to be
    able to use it even though each token is used by 2 experts only
  - More prone to overfitting
  - Hard to fine-tune
- **Notes**:
  - Mixtral 8x7B is sparse Mixture of Experts (SMoE) that is based largely on
    Mistral-7B with the difference that each layer has 8 experts. Each expert
    is a Feed-Forward-Network (FFN). There is a gate (router) layer between
    self-attention layer and FFN layer that selects top 2 experts for each token.
    More specifically, the router network is a linear layer that takes $d_{model}$
    for each token and produce logits for each expert. Top 2 experts based on
    the logits will be chosen for each token to process it and there would
    weighted sum based on the softmax of the top 2 logits to combine the output
    of the 2 experts. Tokens maybe process by different experts in different
    layers.
  - `Experts` can be thought of as each trained on subset of data that they
    become specialized on it
  - Since each token is processed by top 2 experts on every layer, we can have
    very large models w/o affecting latency and throughput of the model because
    each token has access to only fraction of the model's parameters (13B) and
    not the full 47B
  - Trained on multilingual data with context size of 32k
  - Outperforms or matches the performance of Llama2-70B and GPT3.5
    - Hugely outperforms Llama2-70B on tasks that require common-sense
      reasoning and code generation
  - Mixtral 8x7B - Instruct outperforms Gemini 1.5 Pro, Claude 2.1, and GPT3.5
    turbo on human evaluation benchmarks
  - MoE allows us to train larger models w/o for the same fixed computational
    cost. This means we can increase the capacity/complexity of the model while
    keeping the computational budget fixed
  - Experts: each layer has several “experts” that are standalone neural network
    modules or layers with independent sets of parameters.
  - Router: a parametric (and learnable) gating mechanism that selects a (sparse)
    group of experts used to process each input.
  - Achieves similar performance of dense models with same computation much
    faster -> learns much faster

#nlp #llm
