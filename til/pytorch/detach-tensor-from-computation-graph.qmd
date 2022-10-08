We can think of a `Tensor` that implements **Automatic Differentation** as a regular tensor that have, among other attributes, the following attribites that helps to capture its history:

- `inputs`: list of inputs such as tensors and scalars that created the output tensor. Leaf tensors have no inputs
- `operation`: function that was applied on the inputs to create the output tensor. Leaf tensors have no operations
- `data`: the output tensor from applying the operation on the inputs
- `requires_grad`: whether we want to track the history of the computations when creating new tensors. If False, inputs and operation attributes will be set to `None`

Therefore, to detach a tensor from a computation graph Or if we don't want to track temporary computations done on a tensor (such as during inference), we can do the following:

- `Tensor.detach()` returns new tensor sharing the same underlying storage but make it a leaf tensor. Therefore:
    - `inputs` will be set to `None`
    - `operation` will be set to `None`
    - `requires_grad` will be set to `False`
- `with torch.no_grad` let's us perform computations on tensors w/o tracking those computations
- Operating directly on `Tensor.data` avoids recoding the operations. Useful when updating a tensor or for initialization

```python
a = torch.tensor([[1., 2.]], requires_grad=True)
a  #=> tensor([[1., 2.]], requires_grad=True)

# The following will record the computation
b = a + 1
b.grad_fn  #=> <AddBackward0 at 0x7f81abadc8b0>

# All the following forms allow us to avoid recording the computation on the tensor
b = a.data + 1
b.grad_fn           #=> None
b.requires_grad     #=> False

b = a.detach() + 1
b.grad_fn           #=> None
b.requires_grad     #=> False

with torch.no_grad():
    b = a + 1
b.grad_fn           #=> None
b.requires_grad     #=> False

# Useful for updates/initialization because it keeps requires_grad attribute
a.data = torch.randint(10, size=(1, 2))
a.grad_fn           #=> None
b.requires_grad     #=> True
```
