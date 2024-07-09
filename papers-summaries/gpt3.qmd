---
title: "GPT3: Language Models are Few-Shot Learners"
date: 2022-02-03
categories:
  - LLM
  - NLP
  - DL
---

**[GPT3: Language Models are Few-Shot Learners](https://arxiv.org/abs/2005.14165)**

- **Thesis**: Move from architecture agnostic to task agnostic paradigm where we pre-train a very large language model on sufficiently large and diverse data that would result in a model that learned a wide variety of skills and absorbed patterns, which would allow the model to recognize or learn tasks at inference time on the fly w/o any training. Few-shot is what you need to perform non-trivial tasks, but zero-shot and one-shot are a good-start.
- **Methods**:
  - Model:
    - Context window size = 2048
    - Model architecture follows [[gpt2]]
    - $175B$ parameters
    - 96 layers
    - embedding dimension is $12,288$
    - 96 heads
- **Contribution**:
  - 175B LLM that learned variety of tasks
  - Illustrations of in-context learning potential and the differences between zero-, one-, and few-shot.
- **Takeaways**:
  - Model size follows power-law with validation logloss which correlates with performance of downstream tasks
  - Few-shot leads to almost comparable results as fine-tuned models for some NLP tasks
- **Improvements/Limitations**:
  - Scale of the model is prohibitively expensive to run inference -> we may need to use some form of model distillation because GPT3 have wide variety of skills that may not be needed in specific domains
  - It's autoregressive nature doesn't allow to look at surrounding context in both directions, which is needed to perform some tasks such as fill in the blanks
  - The model doesn't seem to have basic understanding of the physical world
  - The model lacks the context from video and other real-world physical interactions
  - Model has poor sample efficiency as it sees a lot of text during pre-training that human doesn't see during its lifetime
  - Self-supervised training objective is approaching its limits and we may need to change the objective by using something like reinforcement learning or add different modalities such as videos to provide better grounding
  - The model sometimes generate repetitive text, suffers from coherence in long-range dependencies of sequence, generate contradictory sequences, etc.
  - We don't know if the model actually learns new tasks from scratch at inference time or simply recognizing patterns
  - Tokens are all weighted equally during prediction, which is not right because there are more important tokens that others
  - The model is not interpretable
- **Importance**:
  - The largest LLM so far that helps us to use it is a wide variety of tasks w/o fine-tuning. For complex tasks, few-shot is very useful and leads to great results in some settings.
- **Notes**:
  - Larger models show steeper improvement for in-context learning through better performance with few-shot demonstrations
  - Create language systems that are able to perform any language tasks on the fly w/o the need for fine-tuning to adapt to domain-specific tasks. Therefore, move from architecture agnostic paradigm where we first pre-train models in semi-supervised fashion then fine-tune it on task-specific data to task agnostic paradigm where we only pre-train very large LMs on very large and diverse datasets and use only text to specify task with few examples and the model would learn (with no gradients -> in-context learning) what it is supposed to do
  - The reason to have task-agnostic models are:
    - Not all language tasks have large enough supervised training data to fine-tune the model on
    - Large models are meant to have large capacity to absorb general language understanding. When fine-tuned on narrow domain where training distribution is narrow, such models tend to pick up spurious correlations -> model's generalization suffers outside training distribution
    - Humans don't need thousand of examples to perform any new task. They need just task specification or at most few examples
    - Finally, we want the model to have the same flexibility as humans to be able to switch between different tasks smoothly such as doing arithmetic in a dialogue
  - We don't know whether LM recognizes task from skills and patterns learned during training or learns the task at inference time from the examples provided
    - Larger models demonstrate stronger ability to recognize tasks
  - Log loss is correlated with downstream tasks performance
  - Meta-learning in LM means the model learns a set of broad skills and pattern recognition abilities at training time that allows it to recognize or adapt to the new task at inference time
  - Performance of GPT3 improves with:
    - Increasing model size
    - Increasing dataset size and diversity
    - Description of the task in natural language
    - More demonstrative examples
  - The larger the model size -> the bigger the gap between zero-shot, one-shot, and few-shot examples. Therefore, LLMs suggest they are meta-learners
  - Disadvantages of fine-tuning:
    - Requires large labeled dataset for every task
    - Doesn't generalize well for out-of-distribution
    - Exploit spurious correlations/features in the training data
  - Zero-shot: Gives the model natural description of the task we want to solve. It is the most convenient and mimic how humans solve most of the tasks. Also, it is more robust and avoid spurious correlations. The main disadvantage is that the task may be not clear and LLM may not be able to figure out what is actually needed.
  - One-shot: Gives the model natural description of the task we want to solve plus and 1 demonstration of task and answer. Humans also use something like this in settings where it is not clear how the output should be presented.
  - Few-shot: Gives the model natural description of the task we want to solve plus few demonstrations. This approach still requires some kind of labeled data as we need more examples for tasks and their outputs. The number of examples are determined based on the difficulty of the task and the context window size.

#nlp #llm

