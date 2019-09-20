# distutils: language=c++

from libc.stdint cimport uint32_t
from libcpp.string cimport string

ctypedef uint32_t uint32
ctypedef uint32_t hashvaluetype
ctypedef unsigned char chartype
ctypedef string container
ctypedef unsigned int uint

cdef extern from "external/rollinghashcpp/cyclichash.h":

    cdef cppclass CyclicHash[hashvaluetype, chartype]:
        CyclicHash(int myn, int mywordsize) except +
        CyclicHash(int myn, uint32 seed1, uint32 seed2, int mywordsize) except +
        hashvaluetype hash[container](container)
        hashvaluetype hashz(chartype, uint)
        void update(chartype, chartype)
        void reverse_update(chartype, chartype)
        void eat(chartype inchar)
        hashvaluetype hash_extend(chartype Y)
        hashvaluetype hash_prepend(chartype Y)
        void reset()

        hashvaluetype hashvalue
        int n
        const int wordsize
        # CharacterHash[hashvaluetype, chartype] hasher  # TODO
        const hashvaluetype mask1
        const int myr
        const hashvaluetype maskn
