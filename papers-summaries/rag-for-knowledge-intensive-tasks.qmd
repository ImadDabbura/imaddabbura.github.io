---
title: "Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks"
date: 2024-04-11
categories:
  - LLM
  - NLP
  - RAG
---

[Retrieval-Augmented Generation for Knowledge-Intensive NLP Tasks](https://proceedings.neurips.cc/paper/2020/hash/6b493230205f780e1bc26945df7481e5-Abstract.html)

- **Thesis**: Train end-to-end retrieval and generator that would provide more specific, diverse, and factual answers. This helps reduce hallucination, continuously update the non-parametric memory of the retriever by just indexing new documents.
- **Method(s)**: Train end-to-end query encoder and BART (generator) on question/answer pairs. Document encoder is initialized (from DPR) and not trained.
- **Contribution**: End-to-end training of RAG model with generation instead of extraction for answers.
- **Takeaways**:
  - Having up to date memory indexed by document encoder reduces hallucination and overcome cutoff knowledge of generator
  - End-to-end training of query encoder and generator
  - Generate more specific, diverse, and factual information
- **Improvements**:
  - No interaction between query and document
  - Document encoder is not updated and may not be optimal
- **Notes**:
  - Fine-tune only query encoder. No updates for document encoder because it is very expensive
  - Retriever is DPR bi-encoder using BERT-base uncased. Index is populated before training using document encoder
  - Generator is BART
  - Question and top-k documents are concatenated and passed to generator. BART conditions on them and start generating tokens
  - Index can be updated independently

#nlp #rag

