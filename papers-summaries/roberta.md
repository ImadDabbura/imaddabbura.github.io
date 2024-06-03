---
title: "RoBERTa: A Robustly Optimized BERT Pretraining Approach"
date: 2021-11-10
categories:
  - LLM
  - NLP
  - DL
---

**[RoBERTa: A Robustly Optimized BERT Pretraining Approach](http://arxiv.org/abs/1907.11692)**

- **Thesis**: Better hyperparameter/design decisions is all you need to improve BERT's performance to be on-par or better than all other pretraining models/objectives. BERT was significantly undertrained and not much time was spent to optimize hyperparameters. RoBERTa basically is just a reimplementation of BERT with some minor changes to tokenizer, hyperparameters, datasets, etc.
- **Methods**:
  - Model: similar to [[bert]]
  - Training methodology:
    - Train on 512 sequence length all the time as opposed to BERT that trains for only $10\%$ of the steps on 512 sequences and the rest $90\%$ of the steps on 256 sequences
    - Mixed-precision training
    - Static vs dynamic masking:
      - BERT used static masking where the training data was duplicated 10 times and the masking pattern for each training copy for each sequence was generated once during preprocessing. Therefore, for 40 epochs, each sequence with the same mask would be seen 4 times
      - Dynamic masking generates mask pattern every time sequence is fed to the model.
    - Sentence-pair vs sequence-pair (w/ nsp loss):
      - BERT used sequence pair where each sequence can have multiple linguistic sentences
      - Sentence-pair: Each input has linguistic sentence pair that are
        either sampled from the same document or different document. Performed worse, may be due to difficulty of BERT learning long-range dependencies
    - full-sentences vs doc-sentences (w/o nsp loss):
      - full-sentences mean sentences are sampled from contiguous text that
        can cross document boundaries (insert document seperator special token).
      - doc-sentences is the same as full-sentences but can't cross document
        boundaries. This means we may end up with less tokens than 512 if we
        sample close to the document edge. Performs slightly better than full-sentences but requires changing batch size. To avoid complexity, RoBERTa uses full-sentences
    - Batch size: It is easier to train large batch sizes with less steps because we can use distributed data parallel training. Other works have shown that increasing batch sizes improves downstream tasks performance
    - BPE tokenizer with 50K vocabulary size
- **Contribution**: Improve hyperparameter decision choices of BERT that proved that BERT was massively undertrained
  - Train longer, with larger batch, over larger dataset and longer sequences
  - Remove next sentence prediction
  - Use dynamic pattern for masked language (BERT uses static)
  - CC-News dataset that is similar in size to private datasets that are used to fine-tune. This dataset will be used to control for the effectiveness of increasing pre-trained dataset size
- **Importance**: deep bidirectional transformer with MLM and smart design choices is all you need :)
- **Takeaways**: RoBERTa proved that MLM is still a good training objective that can lead to a model that matches or exceeds other models on many benchmarks.
- **Improvements**:
  - It isn't clear what is the effect of different % for MLM
  - In this setup, if we have multiple masked tokens in one sentence, the
    prediction of the each masked token doesn't take into account the
    prediction of other masked tokens.

#nlp #llm
