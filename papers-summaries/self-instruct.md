---
title: "Self-Instruct: Aligning Language Models with Self-Generated Instructions"
date: 2024-03-21
categories:
  - LLM
  - NLP
  - DL
---

**[Self-Instruct: Aligning Language Models with Self-Generated Instructions](https://arxiv.org/abs/2212.10560)**

- **Thesis**: Self-instruct is a framework that uses base LLMs (such as GPT) to
  generate samples of instructions, inputs, and outputs that will be used,
  after filtering low quality and very similar instructions, to align LLMs to
  follow user instructions.
- **Contributions**:
  - This framework allows us to generate almost annotation-free instructions
    that performs very close to InstructGPT
  - Because generated instructions are more creative/diverse than human-created
    instructions, LLMs fine-tuned on data using self-instruct outperforms the
    ones fine-tuned on public instruction data.
- **Method(s)**:
  - Vanilla GPT3 is used as the LM in all the steps of the generation pipeline
  - The authors started with $175$ pool of task seed that was written by them
  - Each instruction can have $>= 1$ input/output pairs
    - Not all tasks have inputs
  - Self-Instruct pipeline:
    - Instruction generation:
      - Sample 8 instruction: 6 instructions from seed instructions and 2 from previously generated instructions
      - Prompt the model to generate new instructions. Model can generate up to 8 instructions
    - Instruction classification:
      - Sample 12 classification instructions and 19 non-classification instructions from the seed tasks
      - Prompt the model to determine if the instructions generated are classification or non-classification tasks
    - Instance generation: Generating input (if required) and output for generated tasks
      - For classification tasks, model is asked first to determine the class of the task.
        Then conditioning on the instruction and the class, model is asked to generate
        the output. This is called _output-first_ approach
      - For non-classification tasks, model is first asked to generate input
        (if required else [NULL]). Then is it asked to generate the output for
        the task. This is called _input-first_ approach
    - Filtering: Generated instructions are cleaned up using some heuristics such as:
      - Too long or too short
      - Output is the same as input
      - Similar to at least 1 task from the seed tasks with >= 0.7 ROUGE-L
      - Same inputs but different outputs
      - etc.
  - The final instructions data is used to fine-tune GPT3
  - 252 high-quality instructions written by the authors are used to evaluate and compare models.
    - Human annotators (same authors) rank the response of the models to the these instructions from A (valid and satisfying response) to D (response is invalid or irrelevant)
- **Takeaways**:
  - More data (instructions) leads to better performance but it plateaus after certain dataset size. This is largely dependent on the evaluations data and its diversity
  - Data quality plays a critical role in improving performance. It led to $10\%$ increase in performance when output of each instruction is rewritten by $InstructGPT_{003}$
