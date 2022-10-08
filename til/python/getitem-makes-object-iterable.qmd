Any object that implement `__getitem__` special method is iterable and you can use `in` operater to check if an item is in the object even if the object doesn't impelement `__contain__` special method.
- Python generate indexes starts from zero and iterate over all items until the object returns Error -> Stop Iteration
    - The main assumption is that the object takes integers as indices
- To check if an item is in the object, Python iterates over all items (using the above method)

```python
class L:
    def __init__(self, length=10):
        self.data = list(range(length))

    def __getitem__(self, idx):
        return self.data[idx]

    def __repr__(self):
        res = f"{self.__class__.__name__}: {self.data[:10]}"
        if len(self.data) > 10:
            res = res[:-1] + ", ...]"
        return res
```

```python
l = L()
l[i for i in l] #=> L: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
1 in l          #=> True
```
