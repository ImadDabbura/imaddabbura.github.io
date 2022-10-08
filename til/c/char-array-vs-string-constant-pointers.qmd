In C, there is two ways to define a string:

1. Define it as an array of character such as:
```C
char aname[] = "Imad";
```
- The array would be of size number of characters plus 1 for the null terminating character.
2. Or define it as a pointer to string constant such as:
```C
char *pname = "Imad";
```

They are almost identical except for 1 **subtle difference**:
- `aname` will always point to the same storage and can't be changed to point to something else. The characters themselves can be changes.
- `pname` is a pointer so it can be changed to point to something else. If we try to modify the underlying characters, the result is undefined.
