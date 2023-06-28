Testing SCons + Fortran
=======================

This repo contains some basic examples which test if SCons is working properly
for Fortran compilation.

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

- None of this code builds at all on Windows.  The ifort tool does not configure
  properly even if you have it pre-configured in the environment.

- On MacOS the aliases for f77, f90, f95, etc... are not provided.  This seems
  to cause an issue with the `FORTRAN` construction variable which ends up
  defaulting to `f77` which does not exist.  Without the modified gfortran.py
  module in the `site_tools` area none of the code will build on MacOS.  Without
  the modifiations to the tool this is the error:

```
dnwillia@comp TestFlat % scons -f SConstruct_gfortran1
scons: Reading SConscript files ...
scons: done reading SConscript files.
scons: Building targets ...
f77 -o main_prog.o -c main_prog.f
sh: f77: command not found
scons: *** [main_prog.o] Error 127
scons: building terminated because of errors.
dnwillia@comp TestFlat % 
```

- Building code with fortran modules does not seem to work properly when using
  `variant_dir` and `duplicate=False`.  You get the build error below, note the
  warning reporting that no dependency information is generated for module_two.

```
dnwillia@comp SConsTests % scons -f SConstructVariant --warn=all
scons: Reading SConscript files ...
scons: done reading SConscript files.
scons: Building targets ...
gfortran -o TestSConscript/builds1/darwin/module_two.o -c -JTestSConscript/builds1/darwin TestSConscript/builds1/darwin/module_two.f90
gfortran -o TestSConscript/builds1/darwin/module_one.o -c -JTestSConscript/builds1/darwin TestSConscript/builds1/darwin/module_one.f90
gfortran -o TestSConscript/builds1/darwin/main_prog.o -c -JTestSConscript/builds1/darwin TestSConscript/builds1/darwin/main_prog.f
gfortran -o TestSConscript/builds1/darwin/main_prog.exe TestSConscript/builds1/darwin/module_one.o TestSConscript/builds1/darwin/module_two.o TestSConscript/builds1/darwin/main_prog.o

scons: warning: No dependency generated for file: module_two.mod (referenced by: TestSConscript/module_one.f90) -- file not found
File "/Users/dnwillia/Developer/SConsTests/venv/bin/scons", line 8, in <module>
gfortran -o TestSConscript/builds2/darwin/module_one.o -c -JTestSConscript/builds2/darwin TestSConscript/module_one.f90
TestSConscript/module_one.f90:2:7:

    2 |   use module_two
      |       1
Fatal Error: Cannot open module file 'module_two.mod' for reading at (1): No such file or directory
compilation terminated.
scons: *** [TestSConscript/builds2/darwin/module_one.o] Error 1
scons: building terminated because of errors.
```
