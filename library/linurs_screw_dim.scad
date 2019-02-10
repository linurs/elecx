// Metric screws and nuts 
// urs@linurs.org 2015

// contains dimensions of linurs_screw and can be included in other 
// OpenScad files 


// Consistent parameters in this file
// d screw diameter M2_5, M3, ... (enumeration with screw_d)
// t millimeters added to diameters 
//   For the screw, head, nut = 0. 
//   For the piece where the screw, nut, ... passes through = 0.5 so it slides in well

// enumerations of metric threads
M2_5=0;
M3=1;
M4=2;
M5=3;

// enumerations screw head type
head_cyl=0; // cylinder
head_cnt=1; // countrsunk
head_no=2;  // no head at all
head_hex=3;  // no head at all

// screw diameters
screw_d=[
2.5, // M2.5
3.0, // M3
4.0, // M4
5.0  // M5
];

// sizes for hex nuts
screw_hex=[
//   s,   e,   h
 [ 5.0, 5.8, 1.7], // M2.5
 [ 5.5, 6.4, 2.0], // M3
 [ 7.0, 8.1, 2.8], // M4
 [ 8.0, 9.2, 3.5]  // M5
];

// sizes for cylinder screw heads
screw_cyl=[
//   d,   h
 [ 4.5, 1.6], // M2.5
 [ 5.5, 2.0], // M3
 [ 7.0, 2.6], // M4
 [ 8.5, 3.3]  // M5
];

// sizes for countersunk screw heads
screw_cnt=[
//   d,   h
 [ 4.7, 1.50], // M2.5
 [ 5.6, 1.65], // M3
 [ 7.4, 2.20], // M4
 [ 9.2, 2.50]  // M5
];
