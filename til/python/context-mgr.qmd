---
title: Reusing Fixtues By All Tests
date: 2022-12-28
categories: Python
---
There are some fixtures that we want to use them with every test
function/method such as fixtures that report the execution time of each test.
So instead of keep using the name of these fixtures in all tests, we can set
`autouse` to `True` when defining the fixture so it will be called always by
all tests in its scope.

```python
@pytest.fixture(autouse=True)
def test_time():
    start = time.time()
    yield
    end = time.time()
    print(f"test duration: {end - start:0.3} seconds")
```
