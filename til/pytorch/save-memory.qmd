To avoid allocating new memory when operating on tensors, we can either:
- Do inplace operations
```python
x = torch.randn(1000, 1000)
before = id(x)
x.add_(100)
id(x) == before #=> True
```
- Or change the current object that the tensor is pointing to
```python
x = torch.randn(1000, 1000)
before = id(x)
x += 100
id(x) == before #=> True
```
- Or assign the result of the operation to the previously allocated tensor
```python
x = torch.randn(1000, 1000)
before = id(x)
x[:] = x + 100
id(x) == before #=> True
```
Otherwise, if we do the following, it will create new object and make `x` point to it. This will put pressure on the host memory.
```python
x = torch.randn(1000, 1000)
before = id(x)
x = x + 100
id(x) == before #=> False
```
