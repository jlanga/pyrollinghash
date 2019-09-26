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
        self.cpp_general_hash = new CPPGeneralHash(myn, mywordsize)

    def reset(self):
        self.cpp_general_hash.reset()

    def update(self, chartype outchar, chartype inchar):
        self.cpp_general_hash.update(outchar, inchar)

    def eat(self, chartype inchar):
        self.cpp_general_hash.eat(inchar)

    def hash(self, container c):
        self.cpp_general_hash.hash(c)

    @property
    def hashvalue(self):
        return self.cpp_general_hash.hashvalue

    @property
    def wordsize(self):
        return self.cpp_general_hash.wordsize

    @property
    def n(self):
        return self.cpp_general_hash.n

    @property
    def irreduciblepoly(self):
        return self.cpp_general_hash.irreduciblepoly

    @property
    def lastbit(self):
        return self.cpp_general_hash.lastbit

    # @property
    # def precomputedshift(self):
    #     return

    def __dealloc__(self):
        if self.cpp_general_hash != NULL:
            del self.cpp_general_hash
