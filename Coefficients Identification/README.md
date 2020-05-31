# Coefficients Identification
The aim of this part of the project is to perform the identification of the dynamic coefficients of the KUKA LWR IV+ robot manipulator.


Each link of a robot manipulator can be described by 13 dynamic parameters: the mass (1), the coordinate of its center of mass (3), the symmetric body inertia matrix (6), the viscous friction coefficient (1), the Coulomb friction coefficient (1) and the offset coefficient (1). Stacking these parameters, for each link, in a vector <img src="https://user-images.githubusercontent.com/62264708/83349825-ff4d3480-a337-11ea-800e-2752d56c192d.png">, we obtain that the dynamical model of the robot can be written as

<p align="center"> <img src="https://user-images.githubusercontent.com/62264708/83349828-ff4d3480-a337-11ea-8a05-de4ca9d3c3f4.png"> </p>


It may happen that some parameters do not appear in the model, or they appear only in combination with others. Hence, some groups of parameters, called dynamic coefficients <img src="https://user-images.githubusercontent.com/62264708/83349829-ffe5cb00-a337-11ea-9d31-e7841e4982dd.png">, can be isolated to have 

<p align="center"> <img src="https://user-images.githubusercontent.com/62264708/83349832-ffe5cb00-a337-11ea-8910-92e48a0fbaa8.png"> </p>

where <img src="https://user-images.githubusercontent.com/62264708/83349823-feb49e00-a337-11ea-99f8-350e397635a1.png">, is called Regression Matrix.

Finally, the Identification Problem can be formalized. The robot is commanded to perform some persistently exciting trajectories. In this way, the input torque and the joint trajectories are known, while the joint velocities and accelerations can be reconstructed via numeric differentiation and filtering. Then, the dynamic coefficients are obtained as

<p align="center"> <img src="https://user-images.githubusercontent.com/62264708/83350156-71267d80-a33a-11ea-9401-49bf585c04cd.png"> </p>
 
where the regression matrix has been pseudo-inverted. In order to obtain "good" persistently exciting trajectories, it is needed that the ratio between the maximum and the minimum singular value of the regression matrix is small (e.g., between 50 and 70), i.e.

<p align="center"> <img src="https://user-images.githubusercontent.com/62264708/83350154-6c61c980-a33a-11ea-81fa-cf130ad50e6d.png"> </p>

Two kinds of trajectories have been used:
- sinusoidal trajectories: their periodicity, though, causes the condition number to be very high (between 200 and 1000). They are not used for the identification problem;
- cubic trajectories: a matrix of knots is defined, as well as the phase duration. Then, the robot is forced to move from a joint configuration (i-th knot) to another one (i+1-th knot) with cubics. Condition numbers around 60 are obtained.

Every trajectory has been designed in MATLAB R2018b, validated in V-REP for collision checking and executed on the real KUKA LWR IV+ robot manipulator in the Robotics Laboratory at the DIAG Laboratory of University La Sapienza, Rome.

After the identification, we also went through a validation phase. We designed new trajectories and compared two results (see Figure below):
- torques obtained from the robot itself (in blue);
- torques obtained using the coefficients retrieved from the identification phase (in red).

<p align="center"> <img width = 1000 src="https://user-images.githubusercontent.com/62264708/83350554-1fcbbd80-a33d-11ea-8340-926f4ba10c5f.png"> </p>

The estimation of the torques gives good results: the discontinuities are caused by a poor estimation of the damping terms (indeed, they are present when the joint velocity changes sign). It can be easily observed how the dynamic coefficients related to the sixth and seventh link are approximately estimated since the validation gives unsatisfactory results.
