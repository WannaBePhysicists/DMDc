# DMDc on Flow over a Cylinder for control with MPC
MPC to supress shedding in a cylinder by using a DMDc linearized model of fluid flow.

Contents of the Repository. 

reduced_order_model.py - python script to generate a reduced order model of flow. Takes the data generated from ANSYS. Utilizes the Dynamic Mode Decomposition (DMD with Control) algorithm for linearized model reduction.  

DMDc_MPC_flow_over_cyl_2d.ipny - Ipython notebook to see the entire workflow. Expands on the code used in reduced_order_model.py, but with cleaner code and succint descriptions. 

MPC_DMDcV1.m - utilizes the A, B, Uhat, x0 matrices from notebook to implement MPC on the linearized system.
