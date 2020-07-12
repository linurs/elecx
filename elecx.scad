// Assembly of the elecx
// =====================
// Check how the components fit together and animate

// Parameters for customizer
show="assembly"; //[assembly,animate]
n=1;//[1,2,3,4]
/* [Parts] */
first_wall=true;
second_wall=true;
empty_assembly=true;
foot=true;
foot_type="dinrail"; //[none,dinrail,bracket] 
motherboard=true;
dinrailholder=true;
dinrail=true;
head=true;
/* [Options] */
vent=true;
brand=true;

include <bracket/bracket_dim.scad>
include <wall/wall_dim.scad>
include <foot/foot_dim.scad>
include <motherboard/motherboard_dim.scad>

include <library/din41612/din41612_male_dim.scad>
include <library/din41612/din41612_female_dim.scad>
include <dinrail/dinrail_elecx_dim.scad>

use <pcb/pcb.scad>
use <motherboard/motherboard.scad>
use <wall/wall.scad>
use <module/empty.scad>
use <foot/foot.scad>
use <dinrail/dinrail_elecx.scad>
use <head/head.scad>

if(show=="animate"){
  n=floor(6*$t)+1;
  rotate([0,0,-$t*360]){
    
    translate(motherboard_offset(n))motherboard_assembly(n=n);  
    
    if(($t>0.1)&&($t<0.8))
        color("blue")translate(foot_offset)foot(n=n,type="none");
    else 
        color("blue")translate(foot_offset)foot(n=n,type="bracket");   
    
    if(($t>0.2)&&($t<0.8))
        color("yellow")translate(dinrailholder_offset)dinrail_elecx(n=n);     
    
    if($t>0.3)
        translate(assembly_offset(n))empty_assembly(n=n,open=false);
   
    if($t>0.4)
      color("blue")translate(head_offset)rotate([0,180,0])head(n=n,vent=true,brand=true);
    
    if($t>0.5)
      color("blue")translate(first_wall_offset(n))rotate([0,180,180])wall(vent=vent,brand=brand);
      color("blue")translate(second_wall_offset(n))rotate([0,180,0])wall(vent=vent,brand=brand);    
  }      
}

if(show=="assembly"){
  // empty assembly  
  if(empty_assembly==true)    
      translate(assembly_offset(n))
      empty_assembly(n=n);
  
  // first wall
  if(first_wall==true)
      translate(first_wall_offset(n))  
      rotate([0,180,180])
      wall(vent=vent, brand=brand);
  
  // second wall  
  if(second_wall==true)
      translate(second_wall_offset(n))  
      rotate([0,180,0])
      wall(vent=vent, brand=brand);   
  
  //foot
  if(foot==true)
      translate(foot_offset)foot(n=n,type=foot_type);   
  
  //head
  if(head==true) 
      translate(head_offset)  
      rotate([0,180,0])head(n=n,vent=vent);   
  
  //motherboard
  if(motherboard==true)
      translate(motherboard_offset(n))motherboard_assembly(n=n);   
   
  //dinrailholder
  if(dinrailholder==true) 
      translate(dinrailholder_offset)dinrail_elecx(n=n,dinrail=dinrail);   
}

function assembly_offset(n)=     [bracket_h2+bracket_gap/2-module_l/2,
                      bracket_w1-module_w(n)/2,0];
function first_wall_offset(n)=   [0,-wall_h/2-module_w(n)/2-bracket_gap/2,
                      module_h/2+bracket_offset_z];
function second_wall_offset(n)=  [0,wall_h/2+module_w(n)/2+bracket_gap/2,
                      module_h/2+bracket_offset_z];
foot_offset=         [0,0,motherboard_z_offset-foot_h4];
head_offset=         [0,0,module_h-wall_w2];
function motherboard_offset(n)=  [-motherboard_l/2,
                      (n-1)*step/2-motherboard_w(n)+bracket_h2+bracket_gap/2,
                      motherboard_z_offset];
dinrailholder_offset=[0,0,motherboard_z_offset-foot_h4-dinrail_screw_l1];  