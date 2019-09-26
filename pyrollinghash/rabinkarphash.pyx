# distutils: language=c++

from libcpp.string cimport string

from pyrollinghash._rabinkarphash cimport KarpRabinHash as CPPKarpRabinHash

ctypedef string container
ctypedef unsigned long long hashvaluetype
ctypedef unsigned char chartype

cdef class KarpRabinHash:
    """Karp-Rabin string hasher

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
        HASHMASK (???): TODO
        BtoN (???): TODO
        B (???): TODO

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
    """

    cdef CPPKarpRabinHash[hashvaluetype, chartype] *cpp_karp_rabin_hash

    def __cinit__(self,  myn, mywordsize):
        """
        Initialize the KarpRabin string hasher

        Args:
            myn (int): length of the n-grams to hash.
            mywordsize (int): bit length of the hash values.
        """
        self.cpp_karp_rabin_hash = new CPPKarpRabinHash(myn, mywordsize)

    def hash(self, container c):
        """Hash an entire list instead of eating elements one by one.

        Args:
            container (list[int]): list of integers to hash. TODO
        """
        return self.cpp_karp_rabin_hash.hash(c)

    def update(self, chartype outchar, chartype inchar):
        """Update the hash by adding a new letter to the end and removing the
        first.

        Args:
            inchar (int): integer that enters the rolling hash. TODO
            outchar (int): integer that exits the rolling hash. TODO
        """
        self.cpp_karp_rabin_hash.update(outchar, inchar)

    def eat(self, chartype inchar):
        """Add one single letter

        Args:
            inchar (str): letter to be hashed.
        """
        self.cpp_karp_rabin_hash.eat(inchar)

    def reset(self):
        """Reset the hash to the original state"""
        self.cpp_karp_rabin_hash.reset()

    def __dealloc__(self):
        """Remove the hasher from memory"""
        if self.cpp_karp_rabin_hash != NULL:
            del self.cpp_karp_rabin_hash

    @property
    def hashvalue(self):
        """int: current hash value"""
        return self.cpp_karp_rabin_hash.hashvalue

    @property
    def n(self):
        """int: length of the n-grams to hash."""
        return self.cpp_karp_rabin_hash.n

    @property
    def wordsize(self):
        """int: bit length of the hash values"""
        return self.cpp_karp_rabin_hash.wordsize

    @property
    def HASHMASK(self):
        """TODO"""
        return self.cpp_karp_rabin_hash.HASHMASK

    @property
    def BtoN(self):
        """TODO"""
        return self.cpp_karp_rabin_hash.BtoN

    @property
    def B(self):
        """TODO"""
        return self.cpp_karp_rabin_hash.B
