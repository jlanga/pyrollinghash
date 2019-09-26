# distutils: language=c++

from libcpp.string cimport string

from pyrollinghash._generalhash cimport \
    GeneralHash as CPPGeneralHash

ctypedef string container
ctypedef unsigned long long hashvaluetype
ctypedef unsigned char chartype

cdef extern from *:
    ctypedef int NOPRECOMP "0"
    ctypedef int FULLPRECOMP "1"
# cdef extern from *:
#     ctypedef int precomputationtype "0"


cdef class GeneralHash:
    """GeneralHash string hasher

    Arguments:
        myn (int): length of the n-grams to hash.
        mywordsize (int): bit length of the hash values.
        inchar (int): integer that enters the rolling hash. TODO
        outchar (int): integer that exits the rolling hash. TODO
        container (list[int]): list of integers to hash. TODO

    Attributes
        hashvalue (int): current hash value.
        wordsize (int): bit length of the hash values.
        n (int): length of the n-grams to hash.
        irreduciblepoly (???): ??? TODO
        lastbit (???): ??? TODO

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
    """

    cdef CPPGeneralHash[NOPRECOMP, hashvaluetype, chartype] *cpp_general_hash

    def __cinit__(self, int myn, int mywordsize=19):
        """Initialize the GeneralHash hasher

        Args:
            myn (int): length of the n-grams to hash.
            mywordsize (int): bit length of the hash values.
        """
        self.cpp_general_hash = new CPPGeneralHash(myn, mywordsize)

    def reset(self):
        """Reset the hasher to the original state."""
        self.cpp_general_hash.reset()

    def update(self, chartype outchar, chartype inchar):
        """Update the hash by adding a new letter to the end and removing the
        first.

        Args:
            inchar (int): integer that enters the rolling hash. TODO
            outchar (int): integer that exits the rolling hash. TODO
        """
        self.cpp_general_hash.update(outchar, inchar)

    def eat(self, chartype inchar):
        """Add one single letter to end of the n-gram

        Args:
            inchar (str): letter to be hashed.
        """
        self.cpp_general_hash.eat(inchar)

    def hash(self, container c):
        """
        Hash an entire list instead of eating elements one by one.

        Args:
            container (list[int]): list of integers to hash. TODO
        """
        self.cpp_general_hash.hash(c)

    def __dealloc__(self):
        """Remove the hasher from memory"""
        if self.cpp_general_hash != NULL:
            del self.cpp_general_hash

    @property
    def hashvalue(self):
        """int: current hash value"""
        return self.cpp_general_hash.hashvalue

    @property
    def wordsize(self):
        """int: bit length of the hash values"""
        return self.cpp_general_hash.wordsize

    @property
    def n(self):
        """int: length of the n-grams to hash."""
        return self.cpp_general_hash.n

    @property
    def irreduciblepoly(self):
        """???: TODO"""
        return self.cpp_general_hash.irreduciblepoly

    @property
    def lastbit(self):
        """???: TODO"""
        return self.cpp_general_hash.lastbit

    # @property
    # def precomputedshift(self):
    #     return
