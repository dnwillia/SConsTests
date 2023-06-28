c
c  This compiles manually with:
c    gfortran module_two.f90 module_one.f90 main_prog.f -o main_prog.exe
c  Module two must be compiled first because module one and the main prog both
c  depend on it.
c
c  Expected output:
c    Hello from module one!
c    Hello from module two!
c    Module 1 tells module 2 to say hello.
c    Hello from module two!
c
      program main_prog
      use module_one
      use module_two
      call sayHelloOne
      call sayHelloTwo
      call tellTwoSayHello
      end program main_prog