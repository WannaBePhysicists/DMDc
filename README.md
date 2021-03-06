# DMDc on Flow over a Cylinder for control with MPC

MPC to supress shedding in a cylinder by using a DMDc linearized model of fluid flow.

Contents of the Repository. 

## Notebooks

DMDc_MPC_flow_over_cyl_2d.ipny - Ipython notebook to see the entire workflow. Expands on the code used in reduced_order_model.py, but with cleaner code and succint descriptions. 

## Modules

reduced_order_model.py - python script to generate a reduced order model of flow. Takes the data generated from ANSYS. Utilizes the Dynamic Mode Decomposition (DMD with Control) algorithm for linearized model reduction.  

MPC_DMDcV1.m - utilizes the A, B, Uhat, x0 matrices from notebook to implement MPC on the linearized system.

## Bibliography links

*DMDc by Proctor et al. (2014)* https://arxiv.org/abs/1409.6358
