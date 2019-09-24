# distutils: language=c++

from libcpp.string cimport string

from pyrollinghash._rabinkarphash cimport KarpRabinHash as CPPKarpRabinHash

ctypedef string container
ctypedef unsigned long long hashvaluetype
ctypedef unsigned char chartype

cdef class KarpRabinHash:

    cdef CPPKarpRabinHash[hashvaluetype, chartype] *cpp_karp_rabin_hash

    def __cinit__(self,  myn, mywordsize):
        self.cpp_karp_rabin_hash = new CPPKarpRabinHash(myn, mywordsize)

    def hash(self, container c):
        return self.cpp_karp_rabin_hash.hash(c)

    def update(self, chartype outchar, chartype inchar):
        self.cpp_karp_rabin_hash.update(outchar, inchar)

    def eat(self, chartype inchar):
        self.cpp_karp_rabin_hash.eat(inchar)

    @property
    def hashvalue(self):
        return self.cpp_karp_rabin_hash.hashvalue

    @property
    def n(self):
        return self.cpp_karp_rabin_hash.n

    @property
    def wordsize(self):
        return self.cpp_karp_rabin_hash.wordsize

    @property
    def HASHMASK(self):
        return self.cpp_karp_rabin_hash.HASHMASK

    @property
    def BtoN(self):
        return self.cpp_karp_rabin_hash.BtoN

    @property
    def B(self):
        return self.cpp_karp_rabin_hash.B

    def __dealloc__(self):
        if self.cpp_karp_rabin_hash != NULL:
            del self.cpp_karp_rabin_hash
