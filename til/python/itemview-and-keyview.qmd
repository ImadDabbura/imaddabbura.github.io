`dict.items()` and `dict.keys()` returns `ItemsView` and `KeysView` which are subclasses of `Set`. Therefore, we can do all the set operations on them such as intersection and union and the type of the object returned is a **Set**. Examples:

```python
d1 = dict(zip("abcd", range(1, 5))) #=> {'a': 1, 'b': 2, 'c': 3, 'd': 4}
d2 = dict(zip("cdef", range(3, 7))) #=> {'c': 3, 'd': 4, 'e': 5, 'f': 6}
```

Now we can do  any set operations on `.items()` or `.keys()` views.

```python
d1.keys() & d2.keys() #=> {'c', 'd'}
d1.keys() | d2.keys() #=> {'a', 'b', 'c', 'd', 'e', 'f'}
d1.items() - d2.items() #=> {('a', 1), ('b', 2)}
```

