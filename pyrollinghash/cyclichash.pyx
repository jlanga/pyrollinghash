# distutils: language=c++

from libcpp.string cimport string
from pyrollinghash._cyclichash cimport CyclicHash as CPPCyclicHash


ctypedef unsigned uint
ctypedef string container
ctypedef unsigned long long hashvaluetype
ctypedef unsigned char chartype


cdef class CyclicHash:
    """CyclicHash string hasher

    Arguments:
        myn (int): length of the n-grams to hash.
        mywordsize (int): bit length of the hash values.
        seed1 (int): first seed to initialize the hash function.
        seed2 (int): second seed to initialize the hash fucntion.
        inchar (int): integer that enters the rolling hash. TODO
        outchar (int): integer that exits the rolling hash. TODO
        container (list[int]): list of integers to hash. TODO

    Attributes:
        hashvalue (int): current hash value.
        n (int): length of the n-grams to hash.
        wordsize(int): bit length of the hash values.
        mask1: TODO
        mask2: TODO
        myr: TODO
        maskn: TODO

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
    """

    cdef CPPCyclicHash[hashvaluetype, chartype] *cpp_cyclic_hash

    def __cinit__(self, myn, mywordsize, seed1=None, seed2=None):
        """
        Initialize the CyclicHash string hasher

        Args:
            myn (int): length of the n-grams to hash.
            mywordsize (int): bit length of the hash values.
            seed1 (int): first seed to initialize the hash function.
            seed2 (int): second seed to initialize the hash fucntion.
        """
        if seed1 is not None and seed2 is not None:
            self.cpp_cyclic_hash = new CPPCyclicHash(
                myn, seed1, seed2, mywordsize
            )
        else:
            self.cpp_cyclic_hash = new CPPCyclicHash(myn, mywordsize)

    def hash(self, container c):
        """Hash an entire list instead of eating elements one by one.

        Args:
            container (list[int]): list of integers to hash. TODO
        """
        return self.cpp_cyclic_hash.hash(c)

    def hashz(self, chartype outchar, uint n):
        """TODO
        """
        return self.cpp_cyclic_hash.hashz(outchar, n)

    def update(self, chartype outchar, chartype inchar):
        """Update the hash by adding a new letter to the end and removing the
        first.

        Args:
            inchar (int): integer that enters the rolling hash. TODO
            outchar (int): integer that exits the rolling hash. TODO
        """
        self.cpp_cyclic_hash.update(outchar, inchar)

    def reverse_update(self, chartype outchar, chartype inchar):
        """Inverse of update: update the hash by removing outchar from the end
        and adding inchar to the beginning.

        Args:
            inchar (int): integer that enters the rolling hash. TODO
            outchar (int): integer that exits the rolling hash. TODO
        """
        self.cpp_cyclic_hash.update(outchar, inchar)

    def eat(self, chartype inchar):
        """Add one single letter

        Args:
            inchar (str): letter to be hashed.
        """
        self.cpp_cyclic_hash.eat(inchar)

    def hash_extend(self, chartype Y):
        """TODO"""
        return self.cpp_cyclic_hash.hash_extend(Y)

    def hash_prepend(self, chartype Y):
        """TODO"""
        return self.cpp_cyclic_hash.hash_prepend(Y)

    def reset(self):
        """Reset the hash to the original state"""
        self.cpp_cyclic_hash.reset()

    def __dealloc__(self):
        """Remove the hasher from memory"""
        if self.cpp_cyclic_hash != NULL:
            del self.cpp_cyclic_hash

    @property
    def hashvalue(self):
        """int: current hash value"""
        return self.cpp_cyclic_hash.hashvalue

    @property
    def n(self):
        """int: length of the n-grams to hash."""
        return self.cpp_cyclic_hash.n

    @property
    def wordsize(self):
        """int: bit length of the hash values"""
        return self.cpp_cyclic_hash.wordsize

    @property
    def mask1(self):
        """int: TODO"""
        return self.cpp_cyclic_hash.mask1

    @property
    def myr(self):
        """int: TODO"""
        return self.cpp_cyclic_hash.myr

    @property
    def maskn(self):
        """int: TODO"""
        return self.cpp_cyclic_hash.maskn
