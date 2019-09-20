# distutils: language=c++
from libc.stdint cimport uint32_t, uint8_t

cdef extern from "external/rollinghashcpp/adler32.h":

    cdef cppclass Adler32:
        Adler32(int) except +
        uint32_t sum1, sum2, Base, hashvalue
        int len
        void eat(uint8_t)
        void reset()
        void update(uint8_t, uint8_t)
