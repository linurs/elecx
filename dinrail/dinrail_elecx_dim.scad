// din rail holder for elecx 

include <../foot/foot_dim.scad>
include <../library/dinrail/dinrail_holder_dim.scad>
din_two_holder=4;
dinholder_x=foot_l;// 110;  // x dimension of the assembled din holder

function two_holder(n)=n>=din_two_holder;
 