"""
Author - Abhay B and Sahil K (equal contrib)

"""

""" 
Section 0 ++> Libraries

"""
import numpy as np
#import matplotlib.pyplot as plt

"""

Section 1 ++> Importing Data

"""
path = "C:/Users/Kommalapati sahil/Desktop/MPC_Brunton/data_updates/20200908"

tempvar = np.genfromtxt("rot_speed.txt", delimiter = " ")

t = tempvar[:,0]

upsilon = tempvar[:,1]


del tempvar

tempvar = np.genfromtxt(path + "/export0.csv", delimiter = ",", skip_header = 6)
x = tempvar[:,1]
y = tempvar[:,2]

n = x.shape[0]
q=1

del tempvar

press = np.zeros((n,251))
velu = np.zeros((n,251))
velv = np.zeros((n,251))
helicity = np.zeros((n,251))
swstr = np.zeros((n,251))





for i in range(0,251):
    filename = path+"/export"+str(i)+".csv"
    export = np.genfromtxt(filename, delimiter = ",", skip_header = 6)
    press[:,i] = export[:,4]
    velu[:,i] = export[:,5]
    velv[:,i] = export[:,6]
    helicity[:,i] = export[:,7]
    swstr[:,i] = export[:,12]

del filename
del export

"""

Section 2 ++> Dynamic Mode Decomposition with Control

"""

# Subsection 2.1 - Setting up Xa and X2

X = np.vstack((velu,velv))

X1 = X[:,:-1]
X2 = X[:,1:]

del X

upsilon = upsilon[:-1]

Omega = np.vstack((X1,upsilon))

U, S, V = np.linalg.svd(Omega, full_matrices=False)

S = np.diag(S)

# Subsection 2.2 - Truncation

## Semilog of S and use that for deciding rtil

rtil = 50 # for now
Util = U[:,:rtil]
Sigtil = S[:rtil,:rtil]
Vtil = V[:,:rtil]

del U
del V

U, Sig, V = np.linalg.svd(X2, full_matrices=False)

Sig = np.diag(Sig)

## Semilog of Sig and use that for deciding r

r = 50;
Uhat    = U[:,:r] 
Sighat  = Sig[:r,:r]
Vbar    = V[:,:r]

U1 = Util[:-1,:]
U2 = Util[n+q:n+q+1,:]

# Subsection 2.3 - Estimating approximate A and B matrices

approxA = ((((Uhat.T @ X2) @ Vtil) @ np.linalg.inv(Sigtil)) @ U1.T) @ Uhat

approxB = (((Uhat.T @ X2) @ Vtil) @ np.linalg.inv(Sigtil)) @ U2.T

# Subsection 2.4 - Estimating the DMD Modes

w, v = np.linalg.eig(approxA)

w = np.diag(w)

Phi = ((((X2 @ Vtil) @ np.linalg.inv(Sigtil)) @ U1.T) @ Uhat) @ v

# Subsection 2.4 - Plotting the DMD Modes - (Sahil)


# Subsection 2.5 - Verification

# convert from truncated state to full state and compare with actual state - visualisation
# generate time series of truncated state with xtilk+1 = approxA@xtilk+approxB@uk
# convert truncated state to full state with xfull = Util@xtil





