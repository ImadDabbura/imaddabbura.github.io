---
title: What Is Null Actually?
date: "2022-10-13"
categories: SQL
---
`Null` is a special value that represents an **unknown value**. Any arithmatic operation (`+,-,*, /`) that has at least one `Null` operand results in `Null`. The same thing applies with comparisons: All comparisons with `Null` would result in `Null`. Even `Null = Null` returns `Null`. Therefore,

- `and` operator:
    - `true and Null` results in `Null`
    - `false and Null` results in `false`
    - `Null and Null` results in `Null`
- `or` operator:
    - `true or Null` results in `true`
    - `false or Null` results in `Null`
    - `Null or Null` results in `Null`
- `not` operator:
    - `not Null` results in `Null`
- To test if a value is `Null`, use `IS NULL` or `IS NOT NULL`
- In `where` clause, recods that evaluates to either `false` or `Null` are excluded
- Aggregation functions such as `sum` and `average` discard `Null` records
- `count(*)` returns the number of records in a table. But `count(field)` returns the number of not `Null` records in the table. This means if the field is empty (`Null` values only), `count(field)` will return *zero*.
