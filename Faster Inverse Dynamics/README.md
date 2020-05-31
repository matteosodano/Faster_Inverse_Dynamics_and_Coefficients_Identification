# Faster Inverse Dynamics
This work aims to compare the classical and the modified Denavit-Hartenberg conventions in terms of computational speed when using the Newton-Euler algorithm.

## Denavit-Hartenberg Conventions
In the following table, the Denavit-Hartenberg parameters are assigned to the KUKA LWR IV+ robot manipulator, according to both the classical convention and to the modified one.

<p align="center"> <img width="400" height="260" src="https://user-images.githubusercontent.com/62264708/83118269-71badc00-a0ce-11ea-8b11-095c200efd5c.PNG"> </p>

Notice how link length, offset length and joint angle are the same for both the conventions, whereas the twist angle for the modified DH convention is equal the classical one, but shifted of one index forward.

Another thing to do when working with different frames is to express all the dynamic parameters with respect to the used frame. So, if the centers of mass and the inertia matrices are expressed with respect to the classical DH frames (as it happens in this case), it is needed to modify them before applying the Newton-Euler algorithm with the modified convention as:

<p align="center"> <img src="https://user-images.githubusercontent.com/62264708/83349146-cd859f00-a332-11ea-922b-84e7165ac957.png"> </p>
<p align="center"> <img src="https://user-images.githubusercontent.com/62264708/83349147-ce1e3580-a332-11ea-9ec1-9120bc0273ba.png"> </p>
<p align="center"> <img src="https://user-images.githubusercontent.com/62264708/83349148-ceb6cc00-a332-11ea-9dfe-48124cbbaabf.png"> </p>

It has been validated that the Newton-Euler algorithm using the modified DH is faster than the one using the classical DH. The main reason lays in the final loop of the algorithm, where the algorithm with the modified DH performs one operation less than the one with the classical DH. This can be seen in `modDH_NE.m` with `modDH_finalloop.m` and `orDH_NE.m` with `orDH_finalloop.m` (the `xxx_finalloop.m` function isolates the aforementioned loop, in order to put in light the difference).
