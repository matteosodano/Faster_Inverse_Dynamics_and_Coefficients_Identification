## Faster Inverse Dynamics and Coefficients Identification
Developed by: M. Sodano, F. Roscia, A. Wrona (2020).

Supervisor: prof. A. De Luca.

Achievement: Robotics II exam.\
<br>

In this work, the dynamic model of a robot manipulator has been investigated. Two problems have been addressed: 
- *Faster Inverse Dynamics*: consists in comparing the effects of classical and modified Denavit-Hartenberg conventions using Newton-Euler algorithm. In particular, we focused on the required computational time.
- *Coefficients Identification*: regards the design of some persistently exciting trajectories that allow to identify the dynamic coefficients of the manipulator. This topic is particularly interesting because the manufacturer did not publish the dynamic parameters, nor the dynamic coefficients.

In the whole work, we referred to the KUKA LWR IV+ 7R robot manipulator. Simulations in the DIAG Robotics Laboratory have been performed to collect data for the second part.


## Implementation Details
The code has been written in MATLAB R2018b. V-REP PRO EDU (now *CoppeliaSim*) has been used to check the trajectories designed for the identification part. 
 
## References
Jubien A., Gautier M., Janot A., (2014), *Dynamic Identification of the Kuka LightWeight Robot: comparison between actual and confidential Kuka's parameters*, IEEE/ASME International Conference on Advanced Intelligent Mechatronics (AIM), France, pp. 483-488.

Gaz. C., Flacco F., De Luca A., (2014), *Identifying the Dynamic Model Used by the KUKA LWR: A Reverse Engineering Approach*, IEEE International Conference on Robotics and Automation (ICRA), Hong Kong, pp. 1386-1392.
