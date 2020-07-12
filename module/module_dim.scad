include <../bracket/bracket_dim.scad>

module_l=pcb_l+2*bracket_h2+bracket_gap;
module_l1=module_l-2*bracket_h1;
module_h=bracket_l;

function module_w(n)=bracket_w(n);