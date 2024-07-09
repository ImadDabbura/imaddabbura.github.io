---
title: "Chinchilla: Training Compute-Optimal Large Language Models"
date: 2024-02-15
categories:
  - LLM
  - NLP
  - DL
---

**[Chinchilla: Training Compute-Optimal Large Language Models](https://arxiv.org/abs/2203.15556)**

- **Thesis**: Most LLMs are significantly undertrained because they mostly
  increase model size without increasing the number of training tokens. Based on
  the empirical analysis, for a $10x$ increase in compute budget, we should
  increase the model size and the number of training tokens almost **EQUALLY**.
- **Methods**:
  - _Approach 1_:
    - For fixed family of models that range from 70M to 10B in size, each
      model is trained on 4 different number of training tokens.
    - Learning rate is decayed by $10x$ over number of training tokens.
    - Each model would have 4 runs. Plot loss vs FLOPS for each model and
      smooth the loss curve. Therefore, we end up with a curve for each model
      that would give us a mapping from FLOPS to training loss.
    - For each FLOP, we determine the lowest loss achieved by each model (which
      run achieves the best loss for each model)
  - _Approach 2_:
    - For 9 fixed compute budget, train every model size 9 times on varying
      training tokens s.t. the FLOP counts is ~ predetermined compute budget.
    - So we end up with 9 different curves, one for each compute budget
    - The curves are U shaped and tell us which model (and consequently
      training tokens) yield the lowest loss.
    - After fitting power-laws between FLOPs and loss-optimal model size and
      number of training tokens, we can estimate the model size and training
      tokens for any compute budget
  - _Approach 3_:
    - Fit parametric loss function on the results of all experiments from
      approach 1 & 2 as a parametric function of model size and number of
      training tokens
  - The three approaches yielded very similar results in the scaling of
    parameter counts and number of training tokens. As compute budget increases,
    model size and number of training tokens should increase almost equally
  - **Chinchilla Model**:
    - Number of parameters is 70B, which was determined using the scaling
      function(s) from above with the same compute budget that **Gopher** LLM
      used. Therefore, it is $4x$ smaller than **Gopher**
    - Number of training tokens is 1.4T
    - Number of layers = 80
    - Number of heads = 64
    - Batch size = 1.5M -> 3M
    - Dimension of model is 8192
    - Dimension of head is 128
- **Contribution**:
  - Empirically estimated function(s) to figure out the optimal
    model size and number of training tokens for any compute budget.
  - **Chinchilla** model that is very similar to **Gopher** model that is $4x$
    smaller and outperforms **Gopher** model on almost all tasks.
- **Takeaways**: To get the optimal performance for a given compute budget,
  increase the number of training tokens by the same rate of increasing the model
  size for any additional compute budget.
- **Improvements**:
  - The paper assumes that the relationship between loss and model size and
    number of training tokens follows a power-law. That is may not be true for
    all scales. This may suggest that the author may have overestimated the
    model size for a given compute budget.
  - Among all the runs, there is only 2 large-scale models (**Gopher** and
    **Chinchilla**) and almost no intermediate-scale models
  - All models in all runs have been trained in less than 1 epoch of data.
    Could we have different trends if we train for many epochs?
- **Questions**:
  - Dive deeper into approach 1 as not clear what is the role of decaying
    learning rate has to do with scaling laws
- **Notes**:
  - **Chinchilla** is LLM that uses the same compute budget as **Gopher** but
    with $4x$ less parameters (`70B` instead of `280B`) and trained on $4x$
    more tokens (`1.4T` instead of `400B`). _Gopher_ was significantly
    undertrained. _Chinchilla_ outperforms _Gopher_ on almost all downstream
    task and the inference cost is much smaller (since the model is $4x$
    smaller) which makes it more feasible to use by downstream tasks.
  - The paper is trying to compute the optimal model size and the number of
    training tokens (training dataset size) for a given compute budget. This
    is traditional optimization problem where we're trying to find the minimum
    number of model's parameters (`N`) and number of training tokens (`D`) such
    that the compute budget $FLOPS(N, D) = C$.
    - The authors trained 400 models that range in size between 70M to 16B
      trained on 5B to over 400B tokens.
  - [[scaling-laws-for-nlp]] predicted that for $10x$ increase in compute
    budget, the model size should increase by $5.5x$ while training dataset
    size should increase by $1.8x$.
  - Dense transformer models are models like GPT/BERT family of models while
    sparse transformer models are models like Mistral and Mixtral that are base
    on mixture of experts
  - Large and high quality training data plays a critical role in training LLMs
  - [[scaling-laws-for-nlp]] overestimate the effect of model size on loss
    because the authors kept the learning rate schedule and training tokens
    fixed for all runs. Therefore, they arrived at the conclusion that model should be
    scaled much faster than the size of the training data. In this paper, the
    authors changed learning rate schedule to match training tokens and changed
    training tokens.
