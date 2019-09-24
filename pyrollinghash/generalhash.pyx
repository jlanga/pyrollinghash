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
