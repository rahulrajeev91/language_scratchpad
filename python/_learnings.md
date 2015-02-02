Python Learnings
================

Mutable default arguments
-------------------------

__NOTE__: Information taken from [python guide](http://docs.python-guide.org/en/latest/writing/gotchas/)

Let's say you want to define a function that accepts a list as a parameter, and you
want the default value of that list to be the empty list, so you write:

```python
def append_to(element, to=[]):
    to.append(element)
    return to
```

If everything was okay, you would expect the following behavior:

```
my_list = append_to(12)
print my_list

my_other_list = append_to(42)
print my_other_list
```

```
[12]
[42]
```

But what you get instead is:

```
[12]
[12, 42]
```

A new list is created once when the function is defined, and the same list is used in each successive call.

Python’s default arguments are evaluated once when the function is defined, instead of each time the function is called (like it is in say Ruby). This means that if you use a mutable default argument and mutate it, you will and have mutated that object for all future calls to the function as well.

### What you should do
Create a new object each time the function is called, by using a default arg to signal that no argument was provided (`None` is often a good choice):

```python
def append_to(element, to=None):
    if to is None:
        to = []
    to.append(element)
    return to
```

Late Binding Closures
---------------------
Another common source of confusion is the way Python binds its variables in closures (or in the surrounding global scope).

### What You Wrote
```
def create_multipliers():
    return [lambda x : i * x for i in range(5)]
```
### What You Might Have Expected to Happen
````
for multiplier in create_multipliers():
    print multiplier(2)
```
A list containing five functions that each have their own closed-over i variable that multiplies their argument, producing:

```
0
2
4
6
8
```
What Does Happen
```
8
8
8
8
8
```
Five functions are created; instead all of them just multiply x by 4.

Python’s closures are late binding. This means that the values of variables used in closures are looked up at the time the inner function is called.

Here, whenever any of the returned functions are called, the value of i is looked up in the surrounding scope at call time. By then, the loop has completed and i is left with its final value of 4.

What’s particularly nasty about this gotcha is the seemingly prevalent misinformation that this has something to do with lambdas in Python. Functions created with a lambda expression are in no way special, and in fact the same exact behavior is exhibited by just using an ordinary def:

```
def create_multipliers():
    multipliers = []

    for i in range(5):
        def multiplier(x):
            return i * x
        multipliers.append(multiplier)

    return multipliers
```

### What You Should Do Instead
The most general solution is arguably a bit of a hack. Due to Python’s aforementioned behavior concerning evaluating default arguments to functions (see Mutable Default Arguments), you can create a closure that binds immediately to its arguments by using a default arg like so:

```
def create_multipliers():
    return [lambda x, i=i : i * x for i in range(5)]
```
Alternatively, you can use the functools.partial function:

```
from functools import partial
from operator import mul

def create_multipliers():
    return [partial(mul, i) for i in range(5)]
```
