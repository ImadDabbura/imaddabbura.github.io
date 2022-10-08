All user defined classes are hashable by defualt becuase they inherit `__hash__` from `object`, which is related to their `id()`. This guarantees that different instances have different hashes since they have different `id()`. Therefore, `hash(id(object)) == id(object)` which is different for different objects.

```python
class A:
    ...

a1 = A()
a2 = A()
id(a1) == hash(id(a1)) #=> True
id(a2) == hash(id(a2)) #=> True
```

If a user-defined class implements `__eq__`, then it needs to implement `__hash__` and has to guarantee that it is hashable if all its attributes are hashable and if `a == b` then `hash(a) == hash(b)`.
