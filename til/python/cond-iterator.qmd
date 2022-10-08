 We can pass a callable that doesn't take arguments and generate values to `iter()` and pass marker value (element). It will return a callable iterator that keeps returning values until the `returned value == element`.

 ```python
 def gen():
     return random.randint(1, 10)

cond_iterator = iter(gen, 1)
[e for e in cond_iterator] #=> [6, 10, 2, 4, 3, 6, 7, 5, 5, 4, 7, 10, 8, 10, 10, 8]
 ```
