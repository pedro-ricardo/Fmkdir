!------------------------------------------------------------------------------
! C 'mkdir' function usage in Fortran
!------------------------------------------------------------------------------
!
! Compile it with
! gfortran -Wall -Wextra -g -fcheck=all -std=f2008 mkdir_c.f90 -o mkdir_c
!
! Author:
! Pedro Ricardo C. Souza
! Distributed by GitHub under GPL 3.0 licence 
! 
!------------------------------------------------------------------------------

program test
    use iso_c_binding
    implicit none
    
    !---------------
    ! Definition of folder access restrictions (Standard)
    integer(c_int16_t), parameter:: chmod=int(o'755',c_int16_t)
    !---------------
    
    !---------------
    ! Define a Fortran function and link it to mkdir C intrinsic
    interface 
        function mkdir(path,mode) result(status) bind(c,name="mkdir") 
            use iso_c_binding
            character(kind=c_char), intent(in):: path(*) 
            integer(c_int16_t), intent(in), value:: mode
            integer(c_int):: status 
        end function mkdir 
    end interface
    !---------------
    
    integer:: stat
    character(kind=c_char,len=20):: dirname
    
    ! Insert null character on string (match C strings)
    dirname = "Test_Code"//c_null_char
    
    ! Call function
    stat = mkdir(dirname,chmod)
    
    ! Print function return code:
    write(*,*)'mkdir exit code: ',stat
    !  0 = Success
    ! -1 = Fail
    
end program test
