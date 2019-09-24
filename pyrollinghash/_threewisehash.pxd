# distutils: language=c++

from libcpp.deque cimport deque
from libcpp.string cimport string

ctypedef string container

cdef extern from "external/rollinghashcpp/threewisehash.h":

    cdef cppclass ThreeWiseHash[hashvaluetype, chartype]:

        ThreeWiseHash(int myn, int mywordsize)

        void eat(chartype inchar)
        void update(chartype outchar, chartype inchar)
        void reset()
        # void __updateHashValue()
        hashvaluetype hash(container c)

        hashvaluetype hashvalue
        int n
        int wordsize
        # deque[chartype] ngram
        # vector[CharacterHash[hashvaluetype, chartype]] hashers
        # CharacterHash[hashvaluetype, chartype] hasher
