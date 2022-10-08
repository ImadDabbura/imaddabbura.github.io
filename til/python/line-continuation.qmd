We can use "\" for line continuation as long as there is no space after it; otherwise, Python interpreter will treat it as a character. 

But the more pythonistic way is to use with {}, [], or () where line breaks will be ignored. For example:
```python
string = (
    "first "
    "name"
    )
print(string) #=> "first name"
```
