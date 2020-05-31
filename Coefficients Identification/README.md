# Coefficients Identification
The aim of this part of the project is to perform the identification of the dynamic coefficients of the KUKA LWR IV+ robot manipulator.


Each link of a robot manipulator can be described by 13 dynamic parameters: the mass (1), the coordinate of its center of mass (3), the symmetric body inertia matrix (6), the viscous friction coefficient (1), the Coulomb friction coefficient (1) and the offset coefficient (1). Stacking these parameters, for each link, in a vector <img src="https://user-images.githubusercontent.com/62264708/83349825-ff4d3480-a337-11ea-800e-2752d56c192d.png">, we obtain that the dynamical model of the robot can be written as

<p align="center"> <img src="https://user-images.githubusercontent.com/62264708/83349828-ff4d3480-a337-11ea-8a05-de4ca9d3c3f4.png"> </p>


It may happen that some parameters do not appear in the model, or they appear only in combination with others. Hence, some groups of parameters, called dynamic coefficients <img src="https://user-images.githubusercontent.com/62264708/83349829-ffe5cb00-a337-11ea-9d31-e7841e4982dd.png">, can be isolated to have 

<p align="center"> <img src="https://user-images.githubusercontent.com/62264708/83349832-ffe5cb00-a337-11ea-8910-92e48a0fbaa8.png"> </p>

where <img src="https://user-images.githubusercontent.com/62264708/83349823-feb49e00-a337-11ea-99f8-350e397635a1.png">, is called Regression Matrix.

Finally, the Identification Problem can be formalized. The robot is commanded to perform some particularly exciting trajectories. In this way, the input torque and the joint trajectories are known, while the joint velocities and accelerations can be reconstructed via numeric differentiation and filtering. Then:

<p align="center"> <img src="https://user-images.githubusercontent.com/62264708/83349832-ffe5cb00-a337-11ea-8910-92e48a0fbaa8.png"> </p>
