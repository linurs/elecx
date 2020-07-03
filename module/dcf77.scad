// Dcf77 module
// ============

dcf77="assembly"; // [assembly,front,back,print_front,print_back,antenna]

include <../pcb/pcb_dim.scad>
include <../bracket/bracket_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module dcf77_back(){  
 translate([0,0,bracket_offset_z])back_bracket(n=1);
}

module dcf77_front(){  
    dLED=5.5;
    zLED=39.5;
    
    difference(){
        translate([0,0,bracket_offset_z])front_bracket(n=1);
   
        translate([
          0,
          pcb_h+dLED/2,
          zLED])rotate([0,90,0])
        cylinder(d=dLED, h=bracket_h, center=true, $fn=16); 
    }
}

module dcf77_assembly(){
    pcb_assembly();
    dcf77_front();
    translate([pcb_l,0,0])dcf77_back();
}

module dcf77_antenna(){
    w=7.3;
    h=8.2;
    l=5;
    t=1;
    t2=5;
    translate([0,w/2+t+(l+t)/2,h/2+t-t2/2])difference(){
        cube([w+2*t,l+t,h+2*t],center=true);
        translate([0,t/2,0])cube([w,l*1.01,h],center=true);
    }
    difference(){
    cube([w+2*t,w+2*t,t2],center=true);
    rotate([0,180,0])screw_fix(w=t2*1.01, d=M3, type=head_no, t=1);
    }
}

if(dcf77=="assembly"){
  dcf77_assembly();
}

if(dcf77=="front"){
   dcf77_front();
}

if(dcf77=="back"){
   dcf77_back();
}

if(dcf77=="print_front"){
  rotate([0,-90,0])
    dcf77_front();
}

if(dcf77=="print_back"){
  rotate([0,90,0])dcf77_back();
}

if(dcf77=="antenna"){
  dcf77_antenna();
}