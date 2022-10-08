Using `None` for default argument values is especially important when the arguments are mutable. If for example we used an empty list as the default value, it would be shared by all the calls to the function.

This happens because a function gets evaluated once per module load after the program starts up. As a result, default argument value is evaluated only once. This can cause odd behaviors for dynamic values (such as `{}`, `[]`, or `datetime.now()`).
Therefore:

- Use `None` as the default value for any keyword argument that has a dynamic value. Document the actual default behavior in the function’s docstring.
- Using `None` to represent keyword argument default values also works correctly with type annotations.

```python
def func(y=[]):
    y.append("test")
    print(id(y), y)

# The following two call will use the same object for the default arg
func() #=> 140511381181056 ['test']
func() #=> 140511381181056 ['test', 'test']

# Notice how the argument is a different object
func([]) #=> 140511380870592 ['another', 'test']
```
