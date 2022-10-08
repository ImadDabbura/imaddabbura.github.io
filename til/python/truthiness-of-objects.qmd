When trying to evaluate the truthiness of an object `x`, basically the following is done in order:

- `x.__bool__()` is called. If `__bool__` is not implemented, then
- `x.__len__()` is called. If `__len__()` is not implemented, then
- return `True`.
As a result, all user defined objects are truthy unless `__bool__` or `__len__` are implemented. Also, we can use `if iterable` w/o the need to use `if len(iterable)`.

```python
class A:
    ...

class B:
    def __bool__(self):
        print("In __bool__")
        return False

class C:
    def __len__(self):
        print("In __len__")
        return False

class D:
    def __bool__(self):
        print("In __bool__")
        return False

    def __len__(self):
        print("In __len__")
        return False
```

```python
if A(): print("Truthy")     #=> "Truthy"
if B(): print("Truthy")     #=> "In __bool__"
if C(): print("Truthy")     #=> "In __len__"
if D(): print("Truthy")     #=> "In __len__"
```
