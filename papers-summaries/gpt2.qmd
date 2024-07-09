---
title: "GPT2: Language Models are Unsupervised Multitask Learners"
date: 2021-04-11
categories:
  - LLM
  - NLP
  - DL
---

**[GPT2: Language Models are Unsupervised Multitask Learners](https://cdn.openai.com/better-language-models/language_models_are_unsupervised_multitask_learners.pdf)**

- **Thesis**: Train large models that generalize well to any downstream tasks w/o any fine-tuning or training needed. The main motivation is to have competent generalist model instead of narrow experts that are trained on specific dataset for specific domains. Zero-shot framework allows us to just use pre-trained large language models to perform any task. This is possible because the LM would need to predict the task before being able to predict the next tokens or string.
- **Methods**:
  - Use BPE build on utf-8 bytes to get middle ground between word-level and character-level LM
  - Model:
    - Very similar of GPT except:
      - Context window size increased from 512 to 1024
      - Batch size increased from 64 to 512
      - Layer normalization is added to input -> pre-activation
- **Contribution**: WebText dataset with sufficiently large and diverse data as well as zero-shot demonstrations and larger version of GPT with largest model having $1.5B$ parameters
- **Takeaways**: Training high capacity LLMs on very large and diverse datasets such as WebText will force the model to learn how to perform different tasks indirectly in order to predict next token from different domains and tasks. This allows us to use such models in zero-shot setup to perform different downstream tasks
- **Importance**: Major step to move towards training-free LLMs adaptation to downstream tasks with zero-shot.

- **Notes**:
  - LLMs store information in their parameters as is shown from answering questions which require factoid answers (closed-book)

#nlp #llm

