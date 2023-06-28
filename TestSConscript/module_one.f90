module module_one
  use module_two
  implicit none
  private
  public :: sayHelloOne
  public :: tellTwoSayHello
contains
  subroutine sayHelloOne()
    print *,"Hello from module one!"
  end subroutine sayHelloOne
  subroutine tellTwoSayHello()
    print *,"Module 1 tells module 2 to say hello."
    call sayHelloTwo()
  end subroutine tellTwoSayHello
end module module_one