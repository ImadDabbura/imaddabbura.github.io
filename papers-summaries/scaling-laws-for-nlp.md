---
title: "Scaling Laws for Neural Language Models"
date: 2024-01-05
categories:
  - LLM
  - NLP
  - DL
---
**[Scaling Laws for Neural Language Models](http://arxiv.org/abs/2001.08361)**

- **Thesis**: Provide empirical analysis and equations of how to go about the relationship between performance (measured in cross-entropy loss) for LLM and may factors such as model size, dataset size, compute budget, etc.
- **Methods**: 
	- Trained mainly decoder-only transformers with different variations and hyper-parameters plus LSTMs with context size of 1024 tokens.
	- Compute budget = $6NBS$ where $N$ is number of parameters excluding embedding parameters, $B$ is batch size, $S$ is number of steps (optimization update), and $6$ to account for forward and backward passes
- **Contribution**: Simple equations and power-law relationships that we can use as a reference when allocating our compute budget.
- **Takeaways**: The main factors that affect LLMs performance are 1) model size, 2) dataset size, 3) compute budget. Other factors such as architectural hyper-parameters such at best weak effect on the model's performance. The test loss would continue to decrease as we increase compute in a log-linear fashion.
- **Notes**:
	- There is negative relationship between model size, dataset size, and compute time with cross entropy loss. As we increase one of them -> loss improves. This relationship can be described by power-laws equations.
	- Larger models are sample-efficient -> needs much less compute time to get to the same loss as smaller models $\therefore$ use less data points and less optimization steps. 
	- For a fixed compute budget, large models can stop long before convergence and still performs better than small models
	- If we have more compute budget, allocating most of it to larger models yield the most improvement (we may need to increase dataset size to avoid iterating over the same data multiple times). Followed by larger batches to utilize parallelism. Finally, increase training steps (epochs).
	- When including embeddings parameters, performance is strongly dependent on number of layers and the number of parameters. However, w/o including embedding parameters, any combination of layer/paramaters_size converge to the same trend
	- Transformer outperforms LSTM. LSTM plateaus after < 100 tokens while transformer improves through whole context. For the early tokens, LSTM performs similar to Transformer, but for tokens that are later in the context LSTM suffers. As Transformer model size increases -> improves its ability to recognize patters and have lower loss for later tokens
	- Performance improves with model size regardless of what test data is used; however, for a given model size, there is narrow gap between losses for different test data. WebText2 has the lowest loss
		- There is a constant penalty between test loss and validation loss regardless of training and test data. In other words, when testing the model on a different distribution, the test loss is a constant factor more than the validation loss. So we can predictably predict test loss from validation loss
	- Test loss keeps improving as we increase model size and dataset size in almost perfect power law in model size. For smaller datasets, larger models stop improving early and starts to overfit
	- For a fixed compute budget, we have optimal model size that would yield the best test loss
	- Larger models require less steps to train compared with smaller models
	- There is very weak dependence on architecture and optimizer hyper-parameters such as number of attention heads or width/depth of the model
	- LLM performance depends largely on three factors:
		- Model size (excluding embedding)
		- Dataset size
		- Compute budget
		- When not bottlenecked by other two factors, model's performance follows power-law relationship with these factors. For example, Increasing model size would improve performance in a power-law relationship assuming we're not bottlenecked by dataset size or compute budget
	- Model size and dataset size must be changed together to avoid overfitting. If we hold one of them context we hit diminishing returns and enter overfitting. For each $8x$ increase in model size, we need to increase the dataset size by $5x$

#nlp #llm
