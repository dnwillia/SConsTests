module module_two
  implicit none
  private
  public :: sayHelloTwo
contains
  subroutine sayHelloTwo()
    print *,"Hello from module two!"
  end subroutine sayHelloTwo
end module module_two