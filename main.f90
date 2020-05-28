module inputs
    integer, parameter:: rkind = 8
    contains
    subroutine show_consts()
        if (rkind == 4) then
            print *, "Single-Precision Mode"
            else
            print *, "Double_Precision Mode"
        end if
    end subroutine show_consts

    SUBROUTINE init_random_seed()
        INTEGER :: i, n1, clock
        INTEGER, DIMENSION(:), ALLOCATABLE :: seed

        CALL RANDOM_SEED(size = n1)
        ALLOCATE(seed(n1))

!        CALL SYSTEM_CLOCK(COUNT=clock)
!        seed = clock + 37 * (/ (i - 1, i = 1, n1) /)
        seed = 2 + 37 * (/ (i - 1, i = 1, n1) /)
        CALL RANDOM_SEED(GET = seed)

        DEALLOCATE(seed)
    END SUBROUTINE

end module inputs

! main program for the N-DOP model:
program main
    use inputs
    implicit none
    integer :: n = 2
    integer :: m = 7
    integer :: nz = 13
    integer :: nbc = 2
    integer :: ndc = 2
    integer :: ndiag = 0
    integer :: loop
!    real(kind = 4) :: rand
    real(kind = rkind) :: t
    real(kind = rkind) :: dt = 0.0003472222222222
    real(kind = rkind), allocatable, dimension(:,:) :: q
    real(kind = rkind), allocatable, dimension(:,:) :: y
    real(kind = rkind) :: factor
    real(kind = rkind), allocatable, dimension(:) :: u
    real(kind = rkind), allocatable, dimension(:) :: bc
    real(kind = rkind), allocatable, dimension(:,:) :: dc
    real(kind = rkind), allocatable, dimension(:,:) :: diag

    allocate(q(nz, n))
    allocate(y(nz, n))
    allocate(bc(nbc))
    allocate(dc(nz, ndc))
    allocate(diag(nz, ndiag))
    allocate(u(m))

    call show_consts()
!    call random_number(rand)
!    print *, "Random number:",rand
    ! variables that remain constant:
    q = 0.0
    factor = 2.17
    bc(1) = 32.344
    bc(2) = 0.0

    open(unit=20,file='../z.txt')
    read(20,*) dc(:,1)
    close(20)
    open(unit=20,file='../dz.txt')
    read(20,*) dc(:,2)
    close(20)
    ! write(*,*) dc

    t = 0.0
    u = (/0.02,2.0,0.5,30.0,0.67,0.5,0.858/)

    ! variables that can be varied:
    call init_random_seed()
    do loop = 1,1000
        call random_number(y)
!        print *, "The value of y is:",y
        ! do not change:
        y = factor*y
        !write(*,*) y
        call metos3dbgc(n, nz, m, nbc, ndc, dt, q, t, y, u, bc, dc, ndiag, diag)
        if (rkind == 4) then
            open(1, file = 'sp.txt', Access = 'append',status='old')
            write(1,*) loop , q
            open(3, file = 'random_sp.txt', Access = 'append',status='old')
            write(3,*) loop , y
!            open(5, file = 'sp_norm.txt', Access = 'append',status='old')
!            write(5,*) loop , NORM2(q)
            !        write(*,*) "The value of q is:",q
            close(1)
            close(3)
!            close(5)
!            call sleep(1)
        else
            open(2, file = 'dp.txt', Access = 'append',status='old')
            write(2,*) loop , q
            open(4, file = 'random_dp.txt', Access = 'append',status='old')
            write(4,*) loop , y
!            open(6, file = 'dp_norm.txt', Access = 'append',status='old')
!            write(6,*) loop , NORM2(q)
            close(2)
            close(4)
!            close(6)
!            call sleep(1)
        end if
    end do
    deallocate(q,y,dc,diag,u,bc)


end program