# fortran
metos3d fortran code
Made few changes in insolation and model files in N-DOP folder. 

Main file used to run the entire model is main.f90.

sp denotes single precision and dp denotes double precision.

random_sp.txt and random_dp.txt are generated random "y" values.

sp.txt and dp.txt are generated "q" values from random "y" values.

dp_norm.txt and sp_norm.txt are normalized values for sp.txt and dp.txt.

norm_error.f90 file contains fortran code to calculate normalized error value between sp and dp i.e Norm2(dp-sp).

norm_error.py has python code to plot histogram of normalized errors.

norm_error.png is the plotted histogram of errors.

![image](https://user-images.githubusercontent.com/32735211/83162787-861cca00-a10a-11ea-8fd3-7e107249ff59.png)
