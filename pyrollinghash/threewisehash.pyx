# distutils: language=c++

from libcpp.string cimport string

from pyrollinghash._threewisehash cimport ThreeWiseHash as CPPThreeWiseHash

ctypedef unsigned long long hashvaluetype
ctypedef unsigned char chartype
ctypedef string container

cdef class ThreeWiseHash:
    """ThreeWiseHash string hasher

    Arguments:
        myn (int): length of the n-grams to hash.
        mywordsize (int): bit length of the hash values.
        inchar (int): integer that enters the rolling hash. TODO
        outchar (int): integer that exits the rolling hash. TODO
        container (list[int]): list of integers to hash. TODO

    Attributes:
        hashvalue (int): current hash value.
        n (int): length of the n-grams to hash.
        wordsize(int): bit length of the hash values.

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
    """

    cdef CPPThreeWiseHash[hashvaluetype, chartype] *cpp_threewise_hash

    def __cinit__(self, myn, mywordsize=19):
        """Initialize the ThreewiseHash hasher

        Args:
            myn (int): length of the n-grams to hash.
            mywordsize (int): bit length of the hash values.
        """
        self.cpp_threewise_hash = new CPPThreeWiseHash(myn, mywordsize)

    def eat(self, chartype inchar):
        """Add one single letter

        Args:
            inchar (str): letter to be hashed.
        """
        self.cpp_threewise_hash.eat(inchar)

    def update(self, chartype outchar, chartype inchar):
        """Update the hash by adding a new letter to the end and removing the
        first.

        Args:
            inchar (int): integer that enters the rolling hash. TODO
            outchar (int): integer that exits the rolling hash. TODO
        """
        self.cpp_threewise_hash.update(outchar, inchar)

    def reset(self):
        """Reset the hash to the original state"""
        self.cpp_threewise_hash.reset()

    def hash(self, container c):
        """Hash an entire list instead of eating elements one by one.

        Args:
            container (list[int]): list of integers to hash. TODO
        """
        self.cpp_threewise_hash.hash(c)

    def __dealloc__(self):
        """Remove the hasher from memory"""
        if self.cpp_threewise_hash is not NULL:
            del self.cpp_threewise_hash

    @property
    def hashvalue(self):
        """int: current hash value"""
        return self.cpp_threewise_hash.hashvalue

    @property
    def n(self):
        """int: length of the n-grams to hash."""
        return self.cpp_threewise_hash.n

    @property
    def wordsize(self):
        """int: bit length of the hash values"""
        return self.cpp_threewise_hash.wordsize
