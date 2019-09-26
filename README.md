# pyrollinghash

A poor attempt to wrap in Cython the [rollinghashcpp](https://github.com/lemire/rollinghashcpp) library.

Note: Work in progress

Note: all hashes return 64-bit integers that later are converted to what you want


## Available hashers

### Adler32

```python
>>> from pyrollinghash import Adler32
>>> hasher = Adler32(3)  # Set window size to 3
>>> hasher.hashvalue     # The hasher is reset
0
>>> for i in range(3):  # Hash 0, 1 ,2
        hasher.eat(i)
>>> hasher.hashvalue
458756
>>> hasher.update(0, 3)  # Remove 0, add 3
>>> hasher.hashvalue
851975
>>> hasher.reset()
>>> hasher.hashvalue
0
>>> for i in range(1, 4):  # Same result?
        hasher.eat(i)
>>> hasher.hashvalue
851975
```

### CyclicHash

```python
>>> from pyrollinghash import CyclicHash
>>> hasher = CyclicHash(3, 64, 1, 1)
>>> hasher.hashvalue
0
>>> for i in range(3):  # Hash 0, 1 ,2
        hasher.eat(i)
>>> hasher.hashvalue
17145202471131414222
>>> hasher.update(0, 3)  # Remove 0, add 3
>>> hasher.hashvalue
7164181364666550526
>>> hasher.reset()
>>> hasher.hashvalue
0
>>> for i in range(1, 4):  # Check that we will get the same hash with 1-3
    hasher.eat(i)
>>> hasher.hashvalue
7164181364666550526
```


### GeneralHash

```python
>>> from pyrollinghash import GeneralHash
>>> hasher = GeneralHash(3, 19)
>>> hasher.hashvalue
0
>>> for i in range(3):  # Hash 0, 1 ,2
        hasher.eat(i)
>>> hasher.hashvalue
434959
>>> hasher.update(0, 3)  # Remove 0, add 3
>>> hasher.hashvalue
7153
>>> hasher.reset()
>>> hasher.hashvalue
0
>>> for i in range(1, 4):  # Check that we will get the same hash with 1-3
        hasher.eat(i)
>>> hasher.hashvalue
7153
```

### ThreeWiseHash

```python
>>> from pyrollinghash import ThreeWiseHash
>>> hasher = ThreeWiseHash(3, 64)
>>> hasher.hashvalue  # Not 0. Doesn't matter.
140542657667792
>>> for i in range(3):  # Hash 0, 1 ,2
        hasher.eat(i)
>>> hasher.hashvalue
9309819415051597224
>>> hasher.update(0, 3)  # Remove 0, add 3
>>> hasher.hashvalue
4181938747326092072
>>> hasher.reset()
>>> hasher.hashvalue
0
>>> for i in range(1, 4):  # Check that we will get the same hash with 1-3
    hasher.eat(i)
>>> hasher.hashvalue
4181938747326092072
```

### RabinKarpHash

```python
>>> from pyrollinghash import KarpRabinHash
>>> hasher = KarpRabinHash(3, 64)
>>> hasher.hashvalue
0
>>> for i in range(3):  # Hash 0, 1 ,2
    hasher.eat(i)
>>> hasher.hashvalue
5277449530275385433
>>> hasher.update(0, 3)  # Remove 0, add 3
>>> hasher.hashvalue
13252376563992438057
>>> hasher.reset()
>>> hasher.hashvalue
0
>>> for i in range(1, 4):  # Check that we will get the same hash with 1-3
    hasher.eat(i)
>>> hasher.hashvalue
13252376563992438057
```
