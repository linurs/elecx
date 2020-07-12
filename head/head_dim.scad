include <../module/module_dim.scad>
include <../wall/wall_dim.scad>

head_gap=0.5;

head_l1=2;
head_l2=head_l1+bracket_h2;
head_l3=wall_l5;
head_l=module_l+head_gap+2*head_l1;

head_w1=2;
head_w2=head_w1+wall_h2+head_gap;
head_w3=wall_h1-wall_h2-head_gap;
function head_w(n)=module_w(n)+head_gap+2*head_w1+2*wall_h;

head_h2=1;
head_h1=head_h2+4;
head_h=wall_w2+head_h1;