Variables used in any form of comprehensions such as list/tuple comprehensions have their own scope and don't mask/change variables in the outer scope. For example, if we have a global variable `x` and we use `x` in a list comprehension, it doesn't mask or change the global variable `x` and it is local to the list comprehension.

```python
x = 10
l = [x for x in range(100) if x % 2 == 0]
print(x) #=> 10
```
