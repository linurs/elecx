// code stripes 
//
// to do:
// - convert code in bits using loop, if possible with scad
// - consider other forms than cubes (why not characters?)

include <code_dim.scad>

module code_label(code=0,type=0){
 code_str=str(code);   
 if(type==0)   
 cube([label_width,label_thick,label_height],center=true);            
 rotate([90,0,180])linear_extrude(height = label_text_thick) 
 text(code_str,
    font = "Courier:style=Bold",
    size=label_size,
    halign ="center",
    valign ="center");
}

module code_stripe(code=code,s=[100,8,10],inv=0){
       
 bit_x=s.x/code_n/2; // x dimension of half bit without pass considered   
    
 function bit(inv=0,bit=0,x=0)=(inv==0)
  ?bit_x*(2*x+bit+1/2)
  :bit_x*(((bit+1)%2)+2*x+1/2);  ;  
  
 function zpos(inv=0)=(inv==0)
  ?s.z/2-pass/2
  :s.z/2+pass/2;        
          
 function get_bit(x=0)=((x%2)==0)? 0:1;
 function get_rest(x=0)=floor(x/2);  
 function p(x)=pow(2,x);
 
 // since variables can not be overwritten in OpenSCAD as required in lops 
 // individual variables per bits are created     
 d13=floor((code                                                                                                                )/p(13));
 d12=floor((code-d13*p(13)                                                                                                      )/p(12));     
 d11=floor((code-d13*p(13)-d12*p(12)                                                                                            )/p(11));         
 d10=floor((code-d13*p(13)-d12*p(12)-d11*p(11)                                                                                  )/p(10));
 d9 =floor((code-d13*p(13)-d12*p(12)-d11*p(11)-d10*p(10)                                                                        )/p(9));          
 d8 =floor((code-d13*p(13)-d12*p(12)-d11*p(11)-d10*p(10)-d9*p(9)                                                                )/p(8));       
 d7 =floor((code-d13*p(13)-d12*p(12)-d11*p(11)-d10*p(10)-d9*p(9)-d8*p(8)                                                        )/p(7));    
 d6 =floor((code-d13*p(13)-d12*p(12)-d11*p(11)-d10*p(10)-d9*p(9)-d8*p(8)-d7*p(7)                                                )/p(6));     
 d5 =floor((code-d13*p(13)-d12*p(12)-d11*p(11)-d10*p(10)-d9*p(9)-d8*p(8)-d7*p(7)-d6*p(6)                                        )/p(5));          
 d4 =floor((code-d13*p(13)-d12*p(12)-d11*p(11)-d10*p(10)-d9*p(9)-d8*p(8)-d7*p(7)-d6*p(6)-d5*p(5)                                )/p(4));       
 d3 =floor((code-d13*p(13)-d12*p(12)-d11*p(11)-d10*p(10)-d9*p(9)-d8*p(8)-d7*p(7)-d6*p(6)-d5*p(5)-d4*p(4)                        )/p(3));   
 d2 =floor((code-d13*p(13)-d12*p(12)-d11*p(11)-d10*p(10)-d9*p(9)-d8*p(8)-d7*p(7)-d6*p(6)-d5*p(5)-d4*p(4)-d3*p(3)                )/p(2));        
 d1 =floor((code-d13*p(13)-d12*p(12)-d11*p(11)-d10*p(10)-d9*p(9)-d8*p(8)-d7*p(7)-d6*p(6)-d5*p(5)-d4*p(4)-d3*p(3)-d2*p(2)        )/p(1));   
 d0 =floor((code-d13*p(13)-d12*p(12)-d11*p(11)-d10*p(10)-d9*p(9)-d8*p(8)-d7*p(7)-d6*p(6)-d5*p(5)-d4*p(4)-d3*p(3)-d2*p(2)-d1*p(1))/p(0));   

 d=[d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13];
       
 for (x = [ 0 : code_n - 1 ]) {    
    translate([bit(inv,d[x],x),
                   0,
                   zpos(inv)])
    
    cube([bit_x-pass, 
              s.y,
              s.z-pass],
             center=true);    // coded bits
      
    if(       ((d[x]==0)&&(d[x-1]==1)&&(inv==0))  
           ||  ((d[x]==1)&&(d[x-1]==0)&&(inv==1))  )
        {
          translate([x*bit_x*2,
                        0,
                        zpos(inv)])
          cube([pass*2,s.y,s.z-pass],center=true);  // fillers for not necessary pass gaps
    }
 }    
}

//
code=218;
//code=0;
//code=pow(2,code_n)-1;
s=[100,8,10];

//
color("Red")
code_stripe(code=code,s=s,inv=0);
//
color("Blue")
code_stripe(code=code,s=s,inv=1);

//translate([0,0,20])code_label(code=code,type=1);
