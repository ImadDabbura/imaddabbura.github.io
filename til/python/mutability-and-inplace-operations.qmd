For immutable objects, inplace operation such as "+=" creates a new object and assign the variable to the newly created object. 

```python
s = "test"
old_id = id(s)
s += " another test"
old_id == id(s) #=> False
```

But for mutable objects, it doesn't create a new object. It extends/updates the existing object.

```python
l = [1]
old_id = id(l)
l += [2]
old_id == id(l) #=> True
```
