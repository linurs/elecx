// - rename connector to male_connector
// - translate male connector and rotate (should as to be used for PCB)
include <connector_dim.scad>
include <../code/code_dim.scad>
include <../linurs/linurs_screw_dim.scad>

use <../linurs/linurs_screw.scad>
use <../code/code.scad>

module motherboard_con(type=0,code=0){ //,label=0){
  //color("LightGrey")
  difference(){
    union(){
      if(type==0){  
        translate([0,0,motherboard_con_h/2])
          cube([motherboard_con_head_w,
              motherboard_con_head_d,
              motherboard_con_h],
              center=true);  // upper body of the connector down to motherboard level
      }    
      translate([0,0,motherboard_con_out/2])
        cube([motherboard_con_w,
              motherboard_con_t,
              motherboard_con_out],
              center=true); // lower body of the connector laying on mother board  
      if(type==2){
          translate([-motherboard_con_head_w/2,0,0])
        code_stripe(code=code,s=[motherboard_con_head_w,motherboard_con_head_d,motherboard_con_h],inv=0); 
      }    
    }
    for(i=[-1,1]){ // mounting holes
      translate([i*motherboard_con_d_w/2,0, motherboard_con_out/2])
      screw(w=motherboard_con_out+0.1, d=M2_5, type=head_cyl, t=1);
    }
    if(type==2){  // add label
     translate([0,0, label_text_thick-0.01])rotate([-90,0,0])
       code_label(code=code, type=1);  // label
    }
  }
}

module connector(type=0,code=0, label=1, step=25.4){
  echo("connector");
     
  coding_height=motherboard_con_h-motherboard_con_out;   
  spacer_t=step/2-motherboard_con_t;  
  function get_thick(type=0)=(type==1)? spacer_t+pcb_thick:0; 
    
  difference(){
    union(){// add material  
         
      translate([con_w/2,
        (pcb_thick+motherboard_con_t-get_thick(type))/2,
        (coding_height+con_h)/2])  
        cube([con_w,
            motherboard_con_t-pcb_thick+get_thick(type),
          con_h-coding_height
        ],center=true); // main body of the connector
        
      for(x=[(con_w-con_d_w)/2,con_w+(con_d_w-con_w)/2]){ // add the two brackets
        translate([x,con_m_h/2+pcb_thick,pcb_d_h])
          cube([2*con_d,
                con_m_h,
                2*con_d],center=true);   
      }

      if(type==0){
      translate([
             con_w/2,
             motherboard_con_t/2,
             coding_height/2])
      cube([
            con_w,
            motherboard_con_t,
            coding_height],center=true);  
      }
      
      if(type==1){
             translate([
                           (con_w-motherboard_con_head_w)/2,               
                           motherboard_con_t/2,
                           0])
               code_stripe(code=code,
                   s=[motherboard_con_head_w,motherboard_con_head_d,con_h], inv=1); 
      }      
    }    
    
    for(x=[(con_w-con_d_w)/2,con_w+(con_d_w-con_w)/2]){
      translate([x,con_m_h/2+pcb_thick/2,pcb_d_h])
      rotate([90,0,0])
        screw_fix(w=con_m_h+pcb_thick, d=M2_5, type=head_cyl, sink=0, raise=con_m_h, t=0.5);
    }
     if(type==1){  // add label
     translate([con_w/2,
         (pcb_thick+motherboard_con_t-get_thick(type))/2,
         (coding_height+con_h)/2+(con_h-coding_height)/2-label_text_thick+0.01])
         rotate([90,0,0])
       code_label(code=code, type=1);  // label
    }
  }
}

//code=12;
// code minuimum
//code=0;
// code maximum
//
code=pow(2,code_n)-1;

//translate([0,
//                 motherboard_con_t/2,
//                 -motherboard_con_out  ])
//motherboard_con(type=2,code=code);
//
// translate([-con_w/2,
//                  0,
//                  0])  
//
connector(type=1,code=code);
