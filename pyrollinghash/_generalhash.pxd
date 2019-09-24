# distutils: language=c++
from libcpp.vector cimport vector
from libcpp.string cimport string
ctypedef string container

# cdef enum precomputationtype:
#     NOPRECOMP, FULLPERCOMP

# cdef extern from *:
#     ctypedef int precomputationtype "0"
cdef extern from *:
    ctypedef int NOPRECOMP "0"
    ctypedef int FULLPRECOMP "1"


cdef extern from "external/rollinghashcpp/generalhash.h":

    cdef cppclass GeneralHash[NOPRECOMP, hashvaluetype, chartype]:

        GeneralHash(int myn, int mywordsize) except +

        void reset()
        void update(chartype outchar, chartype inchar)
        void eat(chartype inchar)
        hashvaluetype hash(container c)

        hashvaluetype hashvalue
        const int wordsize
        int n
        hashvaluetype irreduciblepoly
        # CharacterHash<hashvaluetype,chartype> hasher
        const hashvaluetype lastbit
        vector[hashvaluetype] precomputedshift
