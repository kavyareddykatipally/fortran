! Created by  on 27/05/20.

program norm_error
    implicit none
    character(30) :: fname_dp,fname_sp,out_file
    integer :: stat1,stat2
    integer :: row,col,max_rows,max_cols
    integer, allocatable, dimension(:):: row_label1,row_label2
    real(8), allocatable, dimension(:,:) :: dp
    real(4), allocatable, dimension(:,:) :: sp
    real(8) :: norm_result
    norm_result = 0
    max_rows=1000
    max_cols=26
    allocate(row_label1(max_rows))
    allocate(row_label2(max_rows))
    allocate(dp(max_rows,max_cols))
    allocate(sp(max_rows,max_cols))

    fname_dp= 'dp.txt'
    fname_sp= 'sp.txt'
    out_file= 'norm_error.txt'
    ! open the file
    open(1,file=fname_dp,status='old',iostat=stat1)
    if (stat1 .ne. 0) then
        write(*,*) fname_dp, ' cannot be opened !'
        go to 99
    end if

    open(2,file=fname_sp,status='old',iostat=stat2)
    if (stat2 .ne. 0) then
        write(*,*) fname_sp, ' cannot be opened !'
        go to 98
    end if


    ! read array elements from the dp and sp files and calculate normalized error.
    do row = 1, max_rows
        read(1,*,err=99) row_label1(row), (dp(row,col),col=1,max_cols)
        read(2,*,err=98) row_label2(row), (sp(row,col),col=1,max_cols)
        norm_result = norm2(reshape(dp(row,:),(/13,2/)) - reshape(sp(row,:),(/13,2/)))
!        print *,"dp is",dp(row,:)
        open(3, file = out_file, Access = 'append',status='old')
        write(3,*) row_label1(row) , norm_result
!        norm_result = 0
    end do

    ! close the file
    99 close(1)
    98 close(2)


    ! print the function
!    PRINT *, dp(5,3)
!    PRINT *, dp(10,1)
!    PRINT *, sp(5,3)
!    PRINT *, sp(10,1)
!    print * ,"dp size is",size(dp)
!    print * ,"dp shape is",shape(dp)

end program norm_error