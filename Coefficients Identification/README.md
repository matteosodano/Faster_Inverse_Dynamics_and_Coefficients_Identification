# Coefficients Identification
The aim of this part of the project is to perform the identification of the dynamic coefficients of the KUKA LWR IV+ robot manipulator.


Each link of a robot manipulator can be described by 13 dynamic parameters: the mass (1), the coordinate of its center of mass (3), the symmetric body inertia matrix (6), the viscous friction coefficient (1), the Coulomb friction coefficient (1) and the offset coefficient (1). Stacking these parameters, for each link, in a vector $$, we obtain that the dynamical model of the robot can be written as

$$

It may happen that some parameters do not appear in the model, or they appear only in combination with others. Hence, some groups of parameters, called dynamic coefficients $$, can be isolated to have 

$$

where $$ is called Regression Matrix.
