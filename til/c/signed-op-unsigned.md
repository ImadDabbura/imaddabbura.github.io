---
title: Unintuitive Behavior on Operations with Signed & Unsigned Operands
date: 2023-08-01
categories: C
---
When an operation involves signed operand and unsigned operand, C implicitly casts the signed operand to unsigned and perform the operation. This would cause a lot of issues especially with relational operations. Below are some examples that yield unexpected results:

```c
-1 < 0U                         // The answer is 0 because (unsigned int) -1 yield 4294967295
2147483647U > -2147483647 - 1  //  The answer is 0 because TMin becomes TMax + 1 when converting to unsigned which is 2147483648
```