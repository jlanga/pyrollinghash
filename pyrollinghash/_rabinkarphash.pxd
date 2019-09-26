# distutils: language=c++
from libcpp.string cimport string


ctypedef unsigned long long uint32
ctypedef unsigned uint
ctypedef string container

cdef extern from "external/rollinghashcpp/rabinkarphash.h":

    cdef cppclass KarpRabinHash[hashvaluetype, chartype]:

        KarpRabinHash(int myn, int mywordsize) except +
        hashvaluetype hash(container c)
        void eat(chartype inchar)
        void update(chartype outchar, chartype inchar)
        void reset()

        hashvaluetype hashvalue
        int n
        const int wordsize
        # CharacterHash<hashvaluetype,chartype> hasher
        const hashvaluetype HASHMASK
        hashvaluetype BtoN
        hashvaluetype B
