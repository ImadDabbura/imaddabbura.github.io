Augmented assignment operators such as `+=` and `*=` behave differently depending on whether the Python object is mutable or immutable. Let's take `+=` as an example: Python first checks if the first object implements `__iadd__` special method. If not, Python falls back on `__add__`. Since immutable objects don't implement any inplace operations, statement like `x += y` is the same as `x = x + y`.

For mutable objects such as lists:

```python
l = [1, 2]
old_id = id(l)
l += [3]            # the same as l.extend([3])
print(l)            #=> [1, 2, 3]
old_id == id(l)     #=> True
```

For mutable objects such as tuples:

```python
t = [1, 2]
old_id = id(t)
t += (3,)           # the same as t = t + (3,)
print(t)            #=> (1, 2, 3)
old_id == id(t)     #=> False
```
