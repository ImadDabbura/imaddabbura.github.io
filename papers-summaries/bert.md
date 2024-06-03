---
title: "BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding"
date: 2021-10-21
categories:
  - LLM
  - NLP
  - DL
---

**[BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding](https://arxiv.org/abs/1810.04805)**

- **Thesis**: Build architecture agnostic model that learns rich contextualized representations of tokens from attending to both right and left contexts. Having access to surrounding context from both directions is critical to build such representations which are critical for token and sentence level tasks such as classification and QA.
- **Methods**:
  - Model:
    - Encoder-only transformer
    - There are two models:
      - Base: L = 12, hidden_dim = 768, n_heads = 12 -> total_params = 110M
      - Large: L = 24, hidden_dim = 1024, n_heads = 16 -> total_params = 340M
    - 512 context window size
      - Due to computational cost, train $90\%$ of the steps with sequence length of 128 and last $10\%$ steps with sequence length of 512 tokens
    - Training loss is the sum of the mean MLM likelihoods and the mean of the NSP likelihood
  - "Sentence" in BERT refers to contiguous span of text and not necessarily a linguistic sentence
  - Tokenizer: WordPiece with 30,000 vocabulary
  - `[CLS]` is prepended to every sequence as the first token. The final hidden vector of this token is used the consolidated representation for the full sequence in classification tasks where an output layer would typically be added to project it to output needed to classification tasks such as vocabulary or number of classes
  - "Sequence" input consists of 2 sentences separated by `[SEP]` token during pre-training. Therefore, we have two sentences: _A_ & _B_.
    - We would have token embedding for each sentence
    - We would add token embedding `E[A]` for each token in sentence _A_ and token embedding `E[B]` for each token in sentence _B_
    - Therefore, input token embedding would be the sum of token embedding, position embedding, and segment embedding
  - The final hidden vector of each token is the contextualized token embedding $T_i\in{R^H}$
  - _Masked language model (MLM)_: predict the masked word
    - For every sequence, $15\%$ of the token positions will be masked at random. Out of the $15\%$ token positions:
      - $80\%$ will be replaced with the `[MASK]` token
      - $10\%$ will be replaced with random token. This doesn't harm the language understanding because it happens only $1.5\%$ ($10\%$ x $15\%$)
      - $10\%$ will keep the same token to bias the representation towards the actual observed token
    - This would force the model to keep contextualized token representation as the model can't predict which token will be masked
    - For masked tokens, use their final hidden representations as input to softmax layer over the vocabulary to get the prediction (probability distribution). Cross entropy loss is used over these masked tokens
  - _Next sentence prediction (NSP)_: Predict whether sentence _B_ is the next sentence to _A_. This objective helps understand the relationships between sentences, which is needed for tasks such as QA.
    - Every sentence _A_ would be followed by:
      - $50\%$ of the time with actual next sentence from corpus
      - $50\%$ of the time with random sentence from corpus
    - The `[CLS]` final hidden vector would be an input to softmax layer as binarized classifier to predict whether sentence _B_ is next sentence.
  - Fine-tuning:
    - Change input/output based on the downstream task.
      - For classification, input has `[CLS]` followed by the sentence (full text). The `[CLS]` final hidden vector would be fed to softmax layer to get the prediction -> newly added parameters are $W \in R^{K x H}$ where $K$ is number of classes
      - For QA, input has `[CLS]` followed by question tokens (sentence _A_) followed by separator `[SEP]` followed by answer tokens (sentence _B_). Two new tokens are introduced: `S` $\in{R^H}$ for start span token and `E` $\in{R^H}$ for end span token. Each token of the paragraph (sentence _B_) final hidden vector is dot-product with `S` followed by softmax over all tokens in sentence _B_ to get the start span. The token with highest probability would be the start token. The same is done for end token `E`. The objective is the sum of the likelihoods of both the start and the end tokens.
    - Each task would almost have the same model (except the output layer) and initialized with the same pre-trained model -> Each task would have its own fine-tuned model
- **Contribution**:
  - Importance of contextualized token representations using deep
    bidirectional transformer
- **Importance**: This the first transformer-based architecture that uses deep bidirectional transformer (encoder-only) to create rich representations for tokens. Different downstream tasks can use the same model but may add output layer specific to the task and obtains better performance than auto-regressive or LMs or left-to-right models in general
- **Takeaways**:
  - Fine-tuning outperforms feature-based approaches even if we use representations from BERT from different layers.
  - Model size leads to improve performance on downstream tasks
- **Improvements**:
  - It isn't clear what is the effect of different % for MLM
  - I am not convinced we need NSP to achieve better performance
  - In this setup, if we have multiple masked tokens in one sentence, the
    prediction of the each masked token doesn't take into account the
    prediction of other masked tokens.
- **Notes**:
  - Pre-trained language representations usage approaches:
    - _Feature-based_ approach: Use pre-trained token representations in task-specific architectures as embeddings and train the architecture. ELMO is an example of this approach
    - _Fine-tuning_ approach: Fine-tune all parameters of the model to the downstream task such as GPT/BERT
  - ELMO word embeddings, which are concatenated word embeddings from bidirectional LSTMs (training LSTM from left to right and right to left), are contextualized word embeddings. However, previous approaches to ELMO such as word2vec and GloVe were contextless word embeddings.
    - _Contextualized word embeddings_: We know that the same word could have different meanings depending on its context. Therefore, the same word would have different embeddings in different context.
    - _Contextless word embeddings_: Each word would have the same embedding obtained from pre-training regardless of its context

#nlp #llm
