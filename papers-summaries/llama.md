---
title: "LLaMA: Open and Efficient Foundation Language Models"
date: 2023-09-07
categories:
  - LLM
  - NLP
  - DL
---

**[LLaMA: Open and Efficient Foundation Language Models](https://arxiv.org/abs/2302.13971)**

- **Thesis**: It is possible to train LLMs that are competitive with much bigger closed models such as GPT3 on publicly available datasets w/o the need to have proprietary data. Also, inference budget is more important than compute budget, so instead of training very large LMs to achieve high performance, we train smaller models extensively on much bigger datasets. As a result, the tradeoff is between performance and inference.
- **Methods**:
  - Models: 7B, 13B, 33B, 65B
  - Data:
    - Only publicly available data that is compatible with open source
    - Trained on 1 trillion tokens for 7B and 13B models and 1.4 trillion tokens for 33B and 65B models
  - Tokenizer: BPE algorithm using implementation from Sentence-Piece
  - Model:
    - Transformer architecture (decoder)
    - Context length is 2k
    - Batch size is 4M
    - Number of heads goes from 32 for 7B model to 64 for 65B model
    - Hidden dimension goes from 4096 for 7B model to 8192 for 65B model
    - Number of layers goes from 32 for 7B model to 80 for 65B model
    - Use RMSNorm which proves to be much more efficient than LayerNorm and is more stable - RMSNorm paper shows that we only need re-scaling invariance to achieve decoupling of layer's neuron from weight and input (avoid internal covariate shift) and we don't need re-centering invariance. Therefore, we don't need to calculate the mean
      $$
      \begin{align}
      \begin{split} & \bar{a}_i = \frac{a_i}{\text{RMS}(\mathbf{a})} g_i, \quad \text{where}~~ \text{RMS}(\mathbf{a}) = \sqrt{\frac{1}{n} \sum_{i=1}^{n} a_i^2}. \end{split}\nonumber
      \end{align}
      $$
          - Also RMSNorm is cheaper to compute because we don't to calculate the mean
    - Pre-layer normalization -> normalize the input of multihead attention block and MLP instead of the output. Also, normalize the out of the last transformer block before feeding it into output linear layer (classifier)
    - Use SwiGLU instead of ReLU for non-linearity. It was shown that it leads to better performance in LLMs, but no intuition why :)
    - Replace absolute positional embedding with rotary embeddings (RoPE), which is a hybrid of absolute and relative positional embeddings.
      - Relative positional encodings deals with two tokens at a time and it is involved when we calculate the attention (not only when we get the embeddings in the case of absolute positional embedding): since the attention mechanism captures the “intensity” of how much two words are related two each other, relative positional encodings tells the attention mechanism the distance between the two words involved in it. So, given two tokens, we create a vector that represents their distance.
      - RoPE gets applied after query and key have been multiplied by the weight matrix $W$. This means after $x@W_q$ and $x@W_k$.
      - RoPE is only applied to keys and query NOT values because they determine the attention scores and we want the attention scores to be weighted by how far tokens are from each other. In other words, as tokens get far from each other, they should pay less attention to each other. Therefore, it gets applied to query/key in every transformer block
      - There is nothing to learn in RoPE
    - Recompute some activations during backward when needed and not store them during the forward pass to reduce memory peak consumption during training
    - Don't store weights or calculate query/key scores that will be masked in causal attention -> scores for future tokens (the ones to the right from each token)
- **Contribution**:
  - Released 4 variants of the model to open-source community that allows for further improvement and experimentation.
    - They achieve best possible performance for various inference budgets. The 13B model beats GPT3 on most benchmarks even though it is 10x smaller. The largest model (65B) is competitive with the largest models such as Chinchilla or PaLM-540B
  - Started a trend towards focusing on inference budget not only compute budget. Inference budget is very important because it affects the feasibility serving the model at scale.
  - Illustrated that smaller models trained extensively on larger and high quality datasets can beat larger proprietary models. Some [studies](https://arxiv.org/abs/2203.15556) showed we can optimize the model size/dataset size for a given compute budget. For example, 10B model is recommended to be trained on 200B tokens.
- **Takeaways**: High quality large dataset and longer training is all you need to create a decently sized models that are very competitive.
- **Improvements**: Llama models are base LM and not much effort have been spent on making such models helpful by following user's instructions. I am guessing this would be corrected with the next version.

#nlp #llm
