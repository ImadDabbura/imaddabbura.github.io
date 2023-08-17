---
title: Notes on Data Type Conversion
date: 2023-08-14
categories: C
---
- When casting between signed and unsigned integers of the same data size, the bit representation doesn't change but the interpretation of the bits change.
- Positive integers have the same bit representation regardless if they are signed or unsigned, but of course the interpretation is different.
- For arithmetic operation:
    - If one of the operands is long double, then the other is converted to long double
    - Else if one of the operands is double, then the other is converted to double
    - Else if one of the operands is float, then the other is converted to float
    - Else if one of the operands is long int, then the other is converted to long int
    - Else if one of the operands is int, then the other is converted to int