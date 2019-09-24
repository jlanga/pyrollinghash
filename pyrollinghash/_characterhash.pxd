# distutils: language=c++

ctypedef unsigned long long uint64
ctypedef unsigned long long hashvaluetype

cdef extern from "external/rollinghashcpp/characterhash.h":

    cdef cppclass CharacterHash[hashvaluetype, chartype]:

        CharacterHash(uint64 max) except +
        CharacterHash(uint64 max, uint64 seed1, uint64 seed2) except +

        # enum {nbrofchars = 1 << ( sizeof(chartype)*8 )};
        size_t nbrofchars
        # hashvaluetype hashvalues[1 << ( sizeof(chartype)*8 )];
        unsigned long long* hashvalues
