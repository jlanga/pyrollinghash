# distutils: language=c++
from libc.stdint cimport uint8_t, uint32_t, uint64_t
from pyrollinghash._adler32 cimport Adler32 as CPPAdler32

cdef class Adler32:
    cdef CPPAdler32 *cpp_adler32

    def __cinit__(self, int window):
        self.cpp_adler32 = new CPPAdler32(window)

    def eat(self, uint8_t inchar):
        self.cpp_adler32.eat(inchar)

    def reset(self):
        self.cpp_adler32.reset()

    def update(self, uint8_t outchar, uint8_t inchar):
        self.cpp_adler32.update(outchar, inchar)

    def __dealloc__(self):
        if self.cpp_adler32 != NULL:
            del self.cpp_adler32

    # Attribute access
    @property
    def len(self):
        return self.cpp_adler32.len

    @property
    def Base(self):
        return self.cpp_adler32.Base

    @property
    def hashvalue(self):
        return self.cpp_adler32.hashvalue
