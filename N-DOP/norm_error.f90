! Created by  on 27/05/20.

!@author: Kavya reddy

program norm_error
    implicit none
    character(30) :: fname_dp,fname_sp,out_file
    integer :: stat1,stat2,stat3
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
    ! open the file double-precision(dp)
    open(1,file=fname_dp,status='old',iostat=stat1)
    if (stat1 .ne. 0) then
        write(*,*) fname_dp, ' cannot be opened !'
        go to 99
    end if
    ! open the file single-precision(sp)
    open(2,file=fname_sp,status='old',iostat=stat2)
    if (stat2 .ne. 0) then
        write(*,*) fname_sp, ' cannot be opened !'
        go to 98
    end if
    ! open the output file (norm_error.txt)
    open(3, file = out_file, Access = 'append',status='old',iostat=stat3)
    if (stat3 .ne. 0) then
        write(*,*) out_file, ' cannot be opened !'
        go to 97
    end if
    write(3,*) "         ","RUN","    ","NORM_ERROR"
    ! read array elements from the dp and sp files and calculate normalized error.
    do row = 1, max_rows
        read(1,*,err=99) row_label1(row), (dp(row,col),col=1,max_cols)
        read(2,*,err=98) row_label2(row), (sp(row,col),col=1,max_cols)
        norm_result = norm2(reshape(dp(row,:),(/13,2/)) - reshape(sp(row,:),(/13,2/)))
        write(3,*) row_label1(row) , norm_result
        norm_result = 0
    end do

    ! close the files
    99 close(1)
    98 close(2)
    97 close(3)

end program norm_error