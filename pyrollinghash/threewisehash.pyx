# distutils: language=c++

from libcpp.string cimport string

from pyrollinghash._threewisehash cimport ThreeWiseHash as CPPThreeWiseHash

ctypedef unsigned long long hashvaluetype
ctypedef unsigned char chartype
ctypedef string container

cdef class ThreeWiseHash:

    cdef CPPThreeWiseHash[hashvaluetype, chartype] *cpp_threewise_hash

    def __cinit__(self, myn, mywordsize=19):
        self.cpp_threewise_hash = new CPPThreeWiseHash(myn, mywordsize)

    def eat(self, chartype inchar):
        self.cpp_threewise_hash.eat(inchar)

    def update(self, chartype outchar, chartype inchar):
        self.cpp_threewise_hash.update(outchar, inchar)

    def reset(self):
        self.cpp_threewise_hash.reset()

    def hash(self, container c):
        self.cpp_threewise_hash.hash(c)

    def __dealloc__(self):
        if self.cpp_threewise_hash is not NULL:
            del self.cpp_threewise_hash

    @property
    def hashvalue(self):
        return self.cpp_threewise_hash.hashvalue

    @property
    def n(self):
        return self.cpp_threewise_hash.n

    @property
    def wordsize(self):
        return self.cpp_threewise_hash.wordsize
