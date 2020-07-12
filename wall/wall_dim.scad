include <../module/module_dim.scad>

wall_foot_l=8;
wall_foot_w=8;

wall_screw_gap=0.5;// gap to fit the screw
wall_d1=M3;
wall_d2=M3;

wall_l=module_l;
wall_l1=pcb_l;
wall_l2=module_l1;
wall_l3=pcb_l-2*wall_foot_l;
wall_l4=96;
wall_l5=20;
wall_ld=pcb_l-wall_foot_l;

wall_w=module_h+wall_foot_w;
wall_w1=wall_foot_w;
wall_w2=5;
wall_w3=5;
wall_w4=75;
wall_w5=13;
wall_wd=15;

wall_h=6.5;        // wall outside thickness
wall_h1=10;
wall_h2=2;
wall_h3=1;
wall_hd1=7;
wall_hd2=3;

wall_vent_n=20;
wall_lv=94;
wall_wv1=26;
wall_wv2=20;
wall_vent_x=1.5;
wall_vent_x2=wall_lv/(wall_vent_n-1);