The process of importing a module/package (after locating it):

- First checks if it is cached. If not, continue
- It creates a `ModuleType` object with that name
- Cache the module in `sys.modules`
- Executes the source code inside the module (first prefixing it with .py and then assign `__file__`)
    - In the case of the package/subpackage, it assign it the `__init__.py` file
    - It also executes all the `__init__.py` on the path
- Assign a variable to the module object

Below is in roughly what it is done in Python code:

```python
import sys, types

def import_module(modname):
    # Check if it is in the cache first
    if modname in sys.modules:
        return sys.modules[modname]

    sourcepath = modname + '.py'
    with open(sourcepath, 'r') as f:
        sourcecode = f.read()
    mod = types.ModuleType(modname)
    mod.__file__ = sourcepath

    # Cache the module
    sys.modules[modname] = mod

    # Convert it to Python ByteCode
    code = compile(sourcecode, sourcepath, 'exec')

    # Execute the code in the module from top to bottom
    # And update the state (globals) in the module's dictionary
    exec(code, mod.__dict__)

    # We return the cached one in case there is some patching inside the module
    return sys.modules[modname]
```

Finally, Python puts a lock when importing a module until it is done so that we don't have multiple threads trying to import the same module at the same time.
