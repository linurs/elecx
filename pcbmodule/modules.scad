// bracket
// A bracket of the elecbox module
// - type: 0 front bracket, 1 rear bracket
// - width 1..n in steps
// - var: 0 do not create intermediate mounting holes, 1 create intermediate mounting holes 

include <pcbmodule_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../library/linurs/linurs_screw_dim.scad>

use <../library/linurs/linurs_screw.scad>
use <bracket.scad>

module arduino(){
    difference(){
        bracket(type=0);
        translate([0,1+12/2,52.5+13/2])cube([20,12,13],center=true);
        translate([0,1+12/2,24+10/2])cube([20,12,10],center=true);
        translate([0,1+12+2/2,21.5+54/2])cube([20,2,54],center=true);
    }
}
//rotate([0,-90,0])
//arduino();

module 3DprinterIOfront(){
    difference(){
        bracket(type=0);
        translate([0,11/2,37.5+34/2])cube([20,11,34],center=true);        
    }
}
//rotate([0,-90,0])
//3DprinterIOfront();

module 3DprinterIOback(){
    difference(){
        translate([-100,0,0])bracket(type=1);
        translate([0,14/2,12+31/2])cube([20,14,31],center=true); 
        translate([0,14/2,53.5+18.5/2])cube([20,14,18.5],center=true);               
    }
}
//rotate([0,90,0])
//3DprinterIOback();

module Fetback(){
    difference(){
        translate([-100,0,0])bracket(type=1);
        translate([0,14/2,15+51/2])cube([20,14,51],center=true); 
       
    }
}
//rotate([0,90,0])
//Fetback();

module Stepperback(){
    difference(){
        translate([-100,0,0])bracket(type=1);
        translate([0,14/2,15+14/2])cube([20,14,14],center=true); 
        translate([0,14/2,30+14/2])cube([20,14,14],center=true); 
        translate([0,14/2,45+14/2])cube([20,14,14],center=true); 
        translate([0,14/2,60+14/2])cube([20,14,8],center=true); 
            
    }
}
//rotate([0,90,0])
//Stepperback();

module Stepperfront(){
    difference(){
        bracket(type=0);
        translate([0,14/2,15+14/2])cube([20,14,14],center=true); 
        translate([0,14/2,30+14/2])cube([20,14,14],center=true);    
       translate([0,14/2,60+14/2])cube([20,14,8],center=true);      
    }
}
//rotate([0,-90,0])
//Stepperfront();

module I2Cback(){
    difference(){
        translate([-100,0,0])bracket(type=1);
        translate([0,12/2,31+13/2])cube([20,12,13],center=true);       
    }
}
//rotate([0,90,0])
//I2Cback();

module I2Cfront(){
    difference(){
        bracket(type=0);
        translate([0,13/2,21+25/2])cube([20,13,25],center=true); 
        translate([0,5,49])rotate([0,90,0])cylinder(h=20,d=5.5,center=true, $fn=16);    
        translate([0,5,57])rotate([0,90,0])cylinder(h=20,d=5.5,center=true, $fn=16);      
    }
}
//rotate([0,-90,0])
//I2Cfront();

module MCP2221back(){
    h=12;
    w=13;
    z=31;
    difference(){
        translate([-100,0,0])bracket(type=1);
        translate([0,h/2+pcb_thick,z+w/2])cube([20,h,w],center=true);       
    }
}
//rotate([0,90,0])
//MCP2221back();

module MCP2221front(){
    h1=12;
    w1=12;
    z1=29;
    d2=4;
    h2=3;
    z2=66;
    difference(){
        bracket(type=0);
        translate([0,h1/2+pcb_thick,z1+w1/2])cube([20,h1,w1],center=true); 
        translate([0,h2+pcb_thick,z2])rotate([0,90,0])cylinder(h=20,d=d2,center=true, $fn=16);          
    }
}
//rotate([0,-90,0])
//MCP2221front();



module AvrCtrlback(){
    h1=12.5;
    w1=12;
    z1=14;
 
    h2=10;
    w2=39;
    z2=34.5;
    difference(){
        translate([-100,0,0])bracket(type=1);
        translate([0,h1/2+pcb_thick,z1+w1/2])cube([20,h1,w1],center=true);
        translate([0,h2/2+pcb_thick,z2+w2/2])cube([20,h2,w2],center=true);
        
        translate([-9,-2,0])cube([5,4,100]);
        
    }
}
//rotate([0,90,0])
//AvrCtrlback();

module AvrCtrlfront(){
    h1=14;
    w1=32;
    z1=12.5;
    
    h2=11.5;
    w2=13;
    z2=46.5;
    
    d3=4;
    h3=4.5;
    z3=67;
    
    d4=4.8;  //4.4 Loch 5 Ring
    h4=12;
    z4=63.5;
    
    d5=d4;
    h5=h4;
    z5=69.5;
    
    h6=9;
    
    difference(){
        bracket(type=0);
        translate([0,h1/2+pcb_thick,z1+w1/2])cube([20,h1,w1],center=true); 
        translate([0,h2/2+pcb_thick,z2+w2/2])cube([20,h2,w2],center=true);
    
    
    translate([-0.5,h6/2+pcb_thick,z3])cube([4,h6,h6],center=true);    
        translate([0,h3+pcb_thick,z3])rotate([0,90,0])cylinder(h=20,d=d3,center=true, $fn=16); 
    
    
        
        translate([0,h4+pcb_thick,z4])rotate([0,90,0])cylinder(h=20,d=d4,center=true, $fn=16);   
         translate([0,h5+pcb_thick,z5])rotate([0,90,0])cylinder(h=20,d=d5,center=true, $fn=16);   
        
    }
}
//rotate([0,-90,0])
//AvrCtrlfront();

module BatDocback(){
        translate([-100,0,0])bracket(type=1,width=2);
}
//rotate([0,90,0])
//BatDocback();

module BatDocfront(){
    d1=7;
    h1=10;
    z1=20;
    y1=2;
    
    d2=7;
    h3=10;
    z2=65;
    
    difference(){
        bracket(type=0, width=2);
        for(i=[-1,1]){
          translate([0,i*h1+20+pcb_thick,z1])rotate([0,90,0])cylinder(h=20,d=d1,center=true, $fn=16); 
          translate([0,i*h1+20+pcb_thick,z1])rotate([0,90,0])cube([d1+2*y1,y1,20],center=true); 
        }
 
        translate([0,h3+pcb_thick,z2])rotate([0,90,0])cylinder(h=20,d=d2,center=true, $fn=16);      
    }
}
//rotate([0,-90,0])
//BatDocfront();

