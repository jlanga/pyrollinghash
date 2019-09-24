# distutils: language=c++

from pyrollinghash._characterhash cimport CharacterHash as CPPCharacterHash


ctypedef unsigned long long hashvaluetype
ctypedef unsigned char chartype

cdef class CharacterHash:

    cdef CPPCharacterHash[hashvaluetype, chartype] *cpp_character_hash

    def __cinint__(self, max, seed1=None, seed2=None):
        if seed1 is not None and seed2 is not None:
            self.cpp_character_hash = new CPPCharacterHash(max, seed1, seed2)
        else:
            self.cpp_character_hash = new CPPCharacterHash(max)

    @property
    def nbrofchars(self):
        return self.cpp_character_hash.nbrofchars

    @property
    def hashvalues(self):
        cdef size_t nbrofchars = self.cpp_character_hash.nbrofchars
        pyhashvalues = tuple(0 for i in range(nbrofchars))
        for i in range(nbrofchars):
            pyhashvalues[i] = self.cpp_character_hash.hashvalues[i]
        return pyhashvalues

    def __dealloc__(self):
        if self.cpp_character_hash != NULL:
            del self.cpp_character_hash
