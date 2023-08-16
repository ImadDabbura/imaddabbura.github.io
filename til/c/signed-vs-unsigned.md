---
title: Notes on Data Type Conversion
date: 2023-08-14
categories: C
---
- When casting between signed and unsigned integers of the same data size, the bit representation doesn't change but the interpretation of the bits change.
- Positive integers have the same bit representation regardless if they are signed or unsigned, but of course the interpretation is different.