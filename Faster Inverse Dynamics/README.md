# Faster Inverse Dynamics
This work aims to compare the classical and the modified Denavit-Hartenberg conventions in terms of computational speed when using the Newton-Euler algorithm.

## Denavit-Hartenberg Conventions
In the following table, the Denavit-Hartenberg parameters are assigned to the KUKA LWR IV+ robot manipulator, according to both the classical convention and to the modified one.

<p align="center"> <img width="400" height="260" src="https://user-images.githubusercontent.com/62264708/83118269-71badc00-a0ce-11ea-8b11-095c200efd5c.PNG"> </p>

Notice how link length, offset length and joint angle are the same for both the conventions, whereas the twist angle for the modified DH convention is equal the classical one, but shifted of one index forward.

Another thing to do when working with different frames is to express all the dynamic parameters with respect to the used frame. So, if the centers of mass and the inertia matrices are expressed with respect to the classical DH frames (as it happens in this case), it is needed to modify them before applying the Newton-Euler algorithm with the modified convention as:

$$
$$
$$
