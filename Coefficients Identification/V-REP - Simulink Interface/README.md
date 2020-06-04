# VREP - Simulink interface
To run this, you should have a file of joint trajectories previously generated (N+1 columns: the first one has the time instant, the others accounts for the joints). This file has to be linked at `line 4` of `load_path.m`. Modify also `line 2` for the total execution time and `line 30` of the same file the total number of columns found.

Then, keep open the Simulink file and the V-REP scene. In Simulink, modify the total execution time (and the number of scopes, if needed) and run. The movement will start also in V-REP.

IMPORTANT: in Simulink, you may need to modify the callbacks function. Go to `Simulation > Model Properties > Model Properties > Callbacks` and modify InitFcn and StopFcn as suggested in the corresponding `txt` files.
