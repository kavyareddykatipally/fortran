# -*- coding: utf-8 -*-
"""
@author: Kavya reddy

"""

import matplotlib.pyplot as plt
import numpy as np

data= np.loadtxt('/Users/kavya/Documents/GitHub/model-master/model/N-DOP/norm_error.txt', unpack=False, skiprows=1, usecols=1)

# set bins' interval for your data
print(data.shape)
plt.hist(data, histtype='bar', bins = 1000)
plt.xlabel('NORM_ERROR')
plt.ylabel('Frequency of occurance')
plt.title('Normalized error of DP and SP')
plt.legend()
# plt.show()
plt.savefig("norm_error.png")