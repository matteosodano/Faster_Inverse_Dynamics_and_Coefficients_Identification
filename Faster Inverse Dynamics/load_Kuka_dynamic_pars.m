% gravity vector
g0 = 9.80665;
g = [0;0;-g0];

% link masses
m1 = 4.1948152162;
m2 = 4.2996847737;
m3 = 3.658530333;
m4 = 2.3846673548;
m5 = 1.7035567183;
m6 = 0.4000713156;
m7 = 0.6501439811;

% positions of centers of masses
c1x = -0.0216387515;
c1y = 0.01;
c1z = -0.0376881829;

c2x = 0.0003284751;
c2y = -0.0041132249;
c2z = 0.0823647642;

c3x = 0.0002593328;
c3y = 0.1137431845;
c3z = -0.000100257;

c4x = -0.0014648843;
c4y = -0.0000461;
c4z = 0.148580959;

c5x = -0.0003791484;
c5y = -0.0553526131;
c5z = -0.0101255137;

c6x = 0.0020739022;
c6y = 0.0586184696;
c6z = -0.044799983;

c7x = -0.0004601303;
c7y = 0.0014789221;
c7z = 0.0715608282;

% inertias of links
I1xx = 0.01;
I1xy = 0.01;
I1xz = 0.01;
I1yz = 0.01;
I1zz = 0.01;
I1yy = 0.0018932828;

I2xx = 0.0474108647;
I2yy = 0.05;
I2zz = 0.001601901;
I2xy = -0.00000621;
I2xz = 0.0001166457;
I2yz = -0.0009141575;

I3xx = 0.0469510749;
I3yy = 0.0008344566;
I3zz = 0.05;
I3xy = -0.000271431;
I3xz = 4.09E-008;
I3yz = -0.000577228;

I4xx = 0.0124233226;
I4yy = 0.0072708907;
I4zz = 0.0099884782;
I4xz = -0.0005187982;
I4xy = 0.000000225;
I4yz = -0.0005484476;

I5xx = 0.006322648;
I5yy = 0.0012020203;
I5zz = 0.0070806218;
I5xy = -0.0002163196;
I5xz = 0.00000652;
I5yz = -0.005;

I6xx = 0.0005278646;
I6yy = 0;
I6zz = 0.0034899625;
I6xy = 0.0000483;
I6xz = -0.0000375;
I6yz = -0.0010605344;

I7xx = 0;
I7yy = 0.0000323;
I7zz = 0.0001187527;
I7xy = -0.000000577;
I7xz = 0;
I7yz = 0;

I1 = [I1xx, I1xy, I1xz ; I1xy, I1yy, I1yz ; I1xz, I1yz, I1zz];
I2 = [I2xx, I2xy, I2xz ; I2xy, I2yy, I2yz ; I2xz, I2yz, I2zz];
I3 = [I3xx, I3xy, I3xz ; I3xy, I3yy, I3yz ; I3xz, I3yz, I3zz];
I4 = [I4xx, I4xy, I4xz ; I4xy, I4yy, I4yz ; I4xz, I4yz, I4zz];
I5 = [I5xx, I5xy, I5xz ; I5xy, I5yy, I5yz ; I5xz, I5yz, I5zz];
I6 = [I6xx, I6xy, I6xz ; I6xy, I6yy, I6yz ; I6xz, I6yz, I6zz];
I7 = [I7xx, I7xy, I7xz ; I7xy, I7yy, I7yz ; I7xz, I7yz, I7zz];

r1_c1 = [c1x;c1y;c1z];
r2_c2 = [c2x;c2y;c2z];
r3_c3 = [c3x;c3y;c3z];
r4_c4 = [c4x;c4y;c4z];
r5_c5 = [c5x;c5y;c5z];
r6_c6 = [c6x;c6y;c6z];
r7_c7 = [c7x;c7y;c7z];

% masses [kg]
masses = [m1,m2,m3,m4,m5,m6,m7];
% inertias [kg*m^2]
inertias = {I1,I2,I3,I4,I5,I6,I7};
% CoM vectors [m]
r_i_Ci_vectors = [r1_c1, r2_c2, r3_c3, r4_c4, r5_c5, r6_c6, r7_c7];