---
title: "Llama 2: Open Foundation and Fine-Tuned Chat Models"
date: 2023-10-05
categories:
  - LLM
  - NLP
  - DL
---

**[Llama 2: Open Foundation and Fine-Tuned Chat Models](http://arxiv.org/abs/2307.09288)**

- **Thesis**: With clever algorithmic tweaking and focus on helpfulness/safety
  the new chat models are great for dialogue use cases.
- **Methods**:
  - Models:
    - Base LLMs: 7B, 13B, 34B, 70B
    - Chat LLMs: 7B, 13B, 34B, 70B
    - Use `KV` cache during inference. The task of LLM is **next token prediction**. At each step we're only interested in the prediction of the last token but we still need to give the previous tokens (context) that were already computed from before. So at step 10, we would've already computed the attention scores for token1 9 times and token2 8 times. Also, we're not interested in the attention scores for future tokens for causal inference since the attention score matrix is lower triangular. To summarize:
      - Can we cache the dot-products of tokens from previous steps?
      - Can we not compute attention scores for successor tokens?
      - Can we not compute prediction for previous tokens since we already have them?
    - `KV` achieves this by appending the key and query vectors at each time step and compute hidden vector for the current word. So at time step 10, we would have 10 tokens' vectors in `K` and `V` caches and we would compute dot-product of only token 10 and all previous tokens to get attention score vector which is then applied to vector cache that will yield hidden vector that will be fed to classifier head to predict next token
    - Without `KV` cache, memory wasn't the bottleneck; however, `KV` memory access becomes the bottleneck.
      - To remedy this issue, multi-query attention is used where only query has multi-heads but keys and values don't have multiple heads -> Different query heads would share the same keys and values. The drawback of this approach is slight degradation in performance.
      - As a middle ground solution between multi-head query (as in vanilla transformer) and multi-query attention, _Group Multi-Query_ attention is introduced where we would have multiple query heads in which query heads in the same group share the same keys and values
  - Data:
    - Only publicly available data that is compatible with open source
    - Increased size from [[llama]] by $40\%$
      - Trained on 2 trillion tokens for all models
  - Chat models:
    - ~28k high quality instructions dataset for SFT + public available datasets -> ~100k dataset size
    - Reward model:
      - Human annotators are presented with an instruction and two sample responses from different variants of the model (with maybe different temperature) to pick which one they prefer and why according to safety and helpfulness guidelines.
        - Also, they would assign label for the difference between the chosen response and the other response as follows:
          - _significantly better, better, slightly better, or negligibly better/unsure_
          - Each category would have fixed value so that reward model would learn to assign large gaps between responses of different preferences
  - Tokenizer: BPE algorithm using implementation from Sentence-Piece
  - Model:
    - Similar architecture to [[llama]]
    - Doubled the context length to 4k
    - Used group-query attention for 34B and 70B models
    - Reward model:
      - Trained progressively as new batch of data is available.
      - The model is the same as pre-trained chat model
      - Classification head was replaced with linear layer to generate a score for the response. Given a prompt and model response, model scores the response
      - Binary ranking loss is used to
        $$\mathcal{L}_{ranking} = -log(\sigma(r_\theta(x,y_{c}) - r_\theta(x,y_{r}) - m(r)))$$where $r_\theta(x, y)$ is the scalar score output for prompt $x$ and completion $y$ with model weights $\theta$. $y_{c}$ is the preferred response that annotators choose and $y_{r}$ is the rejected counterpart, and the margin $m(r)$ is a discrete function of the preference rating
    - Two reward models were trained: Helpfulness reward model and safety reward model. The reason for two models instead of 1 is that some response can be helpful and not safe and vice versa.
  - Chat model is further fine-tuned using RLHF
    - Through PPO
    - Rejection sampling: The largest model (70B) is used to score k samples for each prompt. Create dataset that has the prompt and the response with the highest score to further fine-tune the smaller models
  - GhostAttention method is proposed so chat model(s) adhere to the role it is given in the beginning in all responses in multi-turn conversations (dialogue). For example, if the model is asked to always respond with emojis, then responses to any question should include only emojis. The rationale behind it is that Chat models tend to forget their role after few responses. Synthetic dataset created:
    - Samples an instruction that should be followed in a conversation
    - Concatenates this instruction to every user message within the conversation
    - Samples responses to each message using the model from the latest round of RLHF
    - Finally, such dataset can be used for further fine-tuning models for follow instructions over long conversations
- **Contribution**: The first highly competitive open-source LLMs. More
  specifically, the chat models and the efforts spent in fine-tuning them
  through data collection and different techniques such as `rejection sampling`
  and `GhostAttn`.
- **Takeaways**:
  - Quality instructions dataset is all you need to get a good chat model that follows user's instructions and engage in helpful dialogue
  - Time spent on aligning LLM to be helpful and safety yielded a high quality
    chat models

#nlp #llm
