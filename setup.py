from distutils.core import setup
from Cython.Build import cythonize

extensions = [
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
)
