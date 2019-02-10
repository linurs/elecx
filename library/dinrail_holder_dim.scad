// din holder
include <dinrail_dim.scad> 
include <linurs_screw_dim.scad>

// dimension for the din holder
dinholder_x=110;  // x dimension of the assembled din holder
dinholder_y=26;   // y dimension of the assembled din holder
dinholder_z=3;    // z dimension when bracket is not used
dinholder_bracket_z=dinholder_z; // z dimension of the bracket
dinrail_screw=M3; // the screws to fit it together
dinrail_screw_l=8; // lenght of the screws to fit it together

olp=0.1; // small distance used to overlap and make difference() look nice and fix mainfold errors
dinholder_pass=0.5; // gap to fit well together

// lever
dinrail_lever_w=10;
dinrail_lever_wedge=2; // overlap of wedge
dinholder_lever_wall=(dinholder_y-dinrail_lever_w)/2; // y dimension wall of lever  
dinholder_lever_cover=3;

// lever holder
dinrail_g=2; // gap to make holder larger than din rail to slide it onto the rail
dinrail_lever_h=4;
