// Empty module
// ============

show="assembly"; // [assembly,front,back,print_front,print_back,2d]
open=true; 
n=1; // [1,2,3,4]

include <module_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <../bracket/bracket.scad>
use <../pcb/pcb.scad>

module empty_back(n=1){
    h=15;  
    difference(){
         translate([0,0,bracket_offset_z])back_bracket(n=n);
         if(open==true){
             translate([
               0,
               h/2+pcb_h,
               pcb_w/2])
             cube([
               bracket_h,
               h,
               pcb_w],center=true);
         }    
    }
}

module empty_front(n=1){   
    difference(){
         h=15;
         translate([0,0,bracket_offset_z])front_bracket(n=n);
         if(open==true){ 
             translate([
               0,
               h/2+pcb_h,
               pcb_w/2])
             cube([
               bracket_h,
               15,
               pcb_w],center=true);
         }    
    }
}

module empty_assembly(n=1){
    pcb_assembly();
    empty_front(n=n);
    translate([pcb_l,0,0])empty_back(n=n);
}

if(show=="assembly"){
  empty_assembly(n=n);
}

if(show=="front"){
    empty_front(n=n);
}

if(show=="back"){
  empty_back(n=n);
}

if(show=="print_front"){
  rotate([0,-90,0])
    empty_front(n=n);
}

if(show=="print_back"){
  rotate([0,90,0])empty_back(n=n);
}

if(show=="2d"){
  translate([-50,-9,-40])empty_assembly(n=n);
}
