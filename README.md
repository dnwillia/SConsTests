Testing SCons + Fortran
=======================

This repo contains some basic examples which test if SCons is working properly
for Fortran compilation.

Prerequisites
-------------

A fortran compiler.  You would need GNU Fortran or Intel Fortran installed on your system.

A virtual environment with SCons.  With your preferred Python interpreter do this:
Linux or MacOS
```
python -m venv venv
. ./venv/bin/activate
pip install scons
```

Windows
```
python -m venv venv
.\venv\Scripts\activate
pip install scons
```


Fortran Code
------------

The source code is divided into three modules:

- `main_prog.f` The main program in a fixed form file.  Depends on module_one
  and module_two.
- `module_one.f90`  A Fortran module containing two public functions, in free
  form, depends on module_two.
- `module_two.f90`  A Fortran module continaing a public function, in free form

Identical source code is in the `TestFlat` and `TestSConscript` directories.

TestFlat
--------

Here the Fortran files are all in one directory and can be compiled using
different SConstruct files:

- `SConstruct`  Uses the DefaultEnvironment to build the Program
- `SConstruct_gfortran2`  Defines an Environment, passing the tools, to build the
  Program
- `SConstruct_gfortran3`  Uses the DefaultEnvironment but reverses the order of
  the source files.

TestSConscript
--------------

Here the content from the SConstruct files from the `TestFlat` directory are
moved into SConscript files.  The code in this area can be built in two
different ways:

1. Individual SConstruct files that process the corresponding SConscript file.
2. A single SConstruct file that uses `variant_dir` for each.

Issues
------

I tried everything here with the scons repo checked out locally at tag 4.8.1 and
ran `pip install -e .` into the virtual environment.  The main issue at this point
is that:

- None of this code builds _out of the box_ at all on Windows.  The ifort tool
  does not configure properly even if you have it pre-configured in the
  environment.
- gfortran is configured by default, and is not located even if you have it in
  the path when calling `scons` on the command line.
- Explicitly put it into the Environment path solves that but then the Program's
  do not link.
