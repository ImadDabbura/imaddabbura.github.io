---
title: "Internet-augmented language models through few-shot prompting for open-domain question answering"
date: 2024-04-19
categories:
  - LLM
  - NLP
  - RAG
---

[Internet-augmented language models through few-shot prompting for open-domain question answering](https://arxiv.org/abs/2203.05115)

- Thesis: Improve the LM performance on ODQA w/o any fine tuning or learnable
  parameters by 1) Use google search as the retriever that return an up-to-date
  information, 2) Prompt the LM using the returned results separately utilizing
  few-shot prompting for each returned document, 3) Rerank the answers returned
  by LM. This helps reduce the hallucination and improve the factuality of the
  answers plus close the gap between small and large LMs using the web as a
  source for information.
- Method(s):
  - For every question, get the top-20 results returned from Google API
  - Split each document into paragraphs where each paragraph contains at most 6 sentences
  - Use TF-IDF as ranker to rank relevant paragraphs to the query
  - Use few-shot prompt on each of the top paragraphs to condition the LM and get answers
  - Rerank the answers according to their score using same LM as scorer
- Contributions:
  - Use of up to date information to condition LM

#nlp #rag

