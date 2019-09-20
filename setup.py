from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize


extensions = [
    # Extension("rollinghashcpp", [],
    #     include_dirs= ["pyrollinghash/external/rollinghashcpp/"],
    #     library_dirs= ["pyrollinghash/external/rollinghashcpp/"]
    # ),
    Extension("adler32", [
        "pyrollinghash/adler32.pyx",
    ]),
    Extension("cyclichash", [
        "pyrollinghash/cyclichash.pyx"
    ])
]



setup(
    name="pyrollinghash",
    ext_modules=cythonize(extensions,
        compiler_directives={'language_level' : "3"},
    ),
    # include_dirs=[numpy.get_include(),"pyrollinghash/external/rollinghashcpp/"],
    # library_dirs= ["pyrollinghash/external/rollinghashcpp/"]
)
