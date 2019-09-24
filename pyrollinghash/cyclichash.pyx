# distutils: language=c++

# from libc.stdint cimport uint32_t, uint64_t
from libcpp.string cimport string

from pyrollinghash._cyclichash cimport CyclicHash as CPPCyclicHash


ctypedef unsigned uint
ctypedef string container
ctypedef unsigned long long hashvaluetype
ctypedef unsigned char chartype


cdef class CyclicHash:

    cdef CPPCyclicHash[hashvaluetype, chartype] *cpp_cyclic_hash

    def __cinit__(self, myn, mywordsize, seed1=None, seed2=None):
        if seed1 is not None and seed2 is not None:
            self.cpp_cyclic_hash = new CPPCyclicHash(
                myn, seed1, seed2, mywordsize
            )
        else:
            self.cpp_cyclic_hash = new CPPCyclicHash(myn, mywordsize)

    def hash(self, container c):
        return self.cpp_cyclic_hash.hash(c)

    def hashz(self, chartype outchar, uint n):
        return self.cpp_cyclic_hash.hashz(outchar, n)

    def update(self, chartype outchar, chartype inchar):
        self.cpp_cyclic_hash.update(outchar, inchar)

    def reverse_update(self, chartype outchar, chartype inchar):
        self.cpp_cyclic_hash.update(outchar, inchar)

    def eat(self, chartype inchar):
        self.cpp_cyclic_hash.eat(inchar)

    def hash_extend(self, chartype Y):
        return self.cpp_cyclic_hash.hash_extend(Y)

    def hash_prepend(self, chartype Y):
        return self.cpp_cyclic_hash.hash_prepend(Y)

    def reset(self):
        self.cpp_cyclic_hash.reset()

    @property
    def hashvalue(self):
        return self.cpp_cyclic_hash.hashvalue

    @property
    def n(self):
        return self.cpp_cyclic_hash.n

    @property
    def wordsize(self):
        return self.cpp_cyclic_hash.wordsize

    @property
    def mask1(self):
        return self.cpp_cyclic_hash.mask1

    @property
    def myr(self):
        return self.cpp_cyclic_hash.myr

    @property
    def maskn(self):
        return self.cpp_cyclic_hash.maskn

    def __dealloc__(self):
        if self.cpp_cyclic_hash != NULL:
            del self.cpp_cyclic_hash
