---
title: "Mistral-7B"
date: 2024-03-10
categories:
  - LLM
  - NLP
  - DL
---

[**Mistral-7B**](https://arxiv.org/abs/2310.06825)

- **Thesis**: Mistral-7B shows that it is possible to train high performant LLM w/o
  sacrificing the efficiency in terms of memory usage and computational cost.
  The model outperforms Llama2-13B on all tasks and Llama2-34B in tasks such
  math and code generation
- **Methods**:
  - Model:
    - dim = 4096
    - n_layers = 32
    - head_dim = 128
    - hidden_dim = 14336; dimension of FFN
    - n_heads = 32; n_kv_heads = 8. Because we're using GQA -> 1 head is shared
      between 4 keys/values
    - window_size 4096
    - context_len = 8192
    - vocab_size = 32000
    - Tokenizer is SentencePiece
    - Sliding Window Attention (SWA). On every layer, each hidden state at
      position $i$, it attends to tokens from previous layer from position $i -
      window_{size}$ to $i$. So a token attends to tokens in its local context (window size).
      This means that we theoretically would have attention
      span in the last layer = $n*{layers} x window\_{size}$ due to receptive
      field that is similar to CNNs.
      - This reduces the dot products performed to get the attention scores
        which speeds up training and inference
      - It may affect model's performance since a token may not have direct
        access to attend directly to all tokens in the context size, but if the
        window size is big enough and through the indirect attention of tokens'
        receptive fields -> performance may not suffer
    - Rolling Buffer Cache. Because tokens only attend to up to $window_{size}$
      tokens, we can have fixed cache where tokens at positions $i > window_{size}$
      will be stored at position $i % window_{size}$, which means overwrites past values.
      Therefore, the `KV` cache would be of size $window_size$ instead of $context_len$.
      In other words, we use entries in `KV` cache that are after $i % window_size$
      followed by entries from $0$ index to $i % window_size$ for all $i > window_size$
    - Uses Grouped Multi Query Attention (GMQA) [[llama2]] that reduces memory usage and
      speed up inference speed especially during decoding -> reduces latency and
      increases throughput through larger batch sizes
    - Cache Pre-fill and Chunking: During sequence generation (inference), we
      already know the prompt -> we can pre-fill the `KV` cache with the
      prompt. If the prompt is very large, it would be chunked into
      $window_{size}$ chunks and each chunk will be processed separately where
      the current chunk will attend to the cache from previous chunk and
      itself. The keys and values will come from the `KV` cache and the tokens
      from the current chunk, but the query comes from the tokens in the current
      chunk. This means that the attention mask would be bigger than the `KV`
      cache starting from 2nd chunk where it would be of dimension: size of
      current chunk (for query) x size of (current chunk + previous chunk) for keys.
      Same logic applies to values metric. This allows the current chunk to
      attend to previous chunks. This process stops when we start generation
      where we use typical `KV` cache that appends K&V for each token separately
    - Mistral-7B-Instruct is fine-tuned on instruction dataset from HF. The
      model is comparable with Llama2-13B chat model
- **Contribution**: Open-sourced weights and training code for a very
  performant model that outperforms Llama2-13B on all tasks. This helps in
  democratizing adoption of LLMs and deploy smaller models that don't
  compromise
  on quality

#nlp #llm

