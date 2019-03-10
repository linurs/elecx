// elecbox
include <../library/linurs/linurs_screw_dim.scad>
include <../motherboard/motherboard_dim.scad>
include <../pcbmodule/pcbmodule_dim.scad>
include <../wall/wall_dim.scad>

// head
head_free_z=6;             // free space inside head
head_t=1;                  // thickness of the head
head_z=head_free_z+head_t; // outer z dimension of head
head_side_wall_stand=head_z-(bracket_h-pcb_h+bracket_offset_z);

head_groove_z=4;
head_brand_x=2;
head_undercut=2;
head_groove_access_x=20;
