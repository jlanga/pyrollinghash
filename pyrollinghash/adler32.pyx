# distutils: language=c++
from libc.stdint cimport uint8_t, uint32_t, uint64_t
from pyrollinghash._adler32 cimport Adler32 as CPPAdler32

cdef class Adler32:
    """Adler32 string hasher

    Attributes:
        len (int): size of the window to be hashed
        Base (int): modulo used (65521).
        hashvalue (int): the current value of the hash function

    >>> hasher = Adler32(3)
    >>> hasher.hashvalue
    0
    >>> for i in range(3):  # Hash 0, 1 ,2
            hasher.eat(i)
    >>> hasher.hashvalue
    458756
    >>> hasher.update(0, 3)  # Remove 0, add 3
    >>> hasher.hashvalue
    851975
    >>> hasher.reset()
    >>> hasher.hashvalue
    0
    >>> for i in range(1, 4):  # Check that we will get the same hash with 1-3
        hasher.eat(i)
    >>> hasher.hashvalue
    851975
    """
    def __init__(self, window):
        """Initialize the Adler32 hash

        Args:
            window (int): size of the window to be hashed.
        """
        pass

    cdef CPPAdler32 *cpp_adler32

    def __cinit__(self, int window):
        """Initialize the Adler32 hash

        Args:
            window (int): size of the window to be hashed.
        """
        self.cpp_adler32 = new CPPAdler32(window)

    def eat(self, uint8_t inchar):
        """Hash one single letter

        Args:
            inchar (str): letter to be hashed.
        """
        self.cpp_adler32.eat(inchar)

    def reset(self):
        """Reset the hash to the original state.
        """
        self.cpp_adler32.reset()

    def update(self, uint8_t outchar, uint8_t inchar):
        """Update the hash object by removing `outchar` and introducing `ìnchar`
        from the n-gram

        Args:
            outchar (str): first letter of the n-gram (the one that leaves).
            inchar (str): last letter of the n-gram (the one that enters).
        """
        self.cpp_adler32.update(outchar, inchar)

    def __dealloc__(self):
        """Remove the hasher
        """
        if self.cpp_adler32 != NULL:
            del self.cpp_adler32

    # Attribute access
    @property
    def len(self):
        """int: length of the window used"""
        return self.cpp_adler32.len

    @property
    def Base(self):
        """int: module used for hashing"""
        return self.cpp_adler32.Base

    @property
    def hashvalue(self):
        """int: current hash value"""
        return self.cpp_adler32.hashvalue
