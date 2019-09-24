from distutils.core import setup
# from distutils.extension import Extension
from Cython.Build import cythonize


extensions = [
    # Extension("rollinghashcpp", [],
    #     include_dirs= ["pyrollinghash/external/rollinghashcpp/"],
    #     library_dirs= ["pyrollinghash/external/rollinghashcpp/"]
    # ),
    "pyrollinghash/adler32.pyx",
    "pyrollinghash/cyclichash.pyx",
    "pyrollinghash/characterhash.pyx",
    "pyrollinghash/generalhash.pyx",
    "pyrollinghash/generalhashprecomp.pyx",
    "pyrollinghash/rabinkarphash.pyx",
    "pyrollinghash/threewisehash.pyx"
]

setup(
    name="pyrollinghash",
    ext_modules=cythonize(
        extensions,
        compiler_directives={
            'language_level': '3',
            'embedsignature': True
        },
    ),
    # include_dirs=[numpy.get_include(),"pyrollinghash/external/rollinghashcpp/"],
    # library_dirs= ["pyrollinghash/external/rollinghashcpp/"]
)
