// elecx
// The coordinate systems [0.0.0] point is the first PCB's lower right corner at the soldering side

include <library/linurs/linurs_screw_dim.scad>
include <motherboard/motherboard_dim.scad>
include <pcbmodule/pcbmodule_dim.scad>
include <wall/wall_dim.scad>

// branding text
branding="ELECX"; // As hole printable name


din_bracket_l=80;
din_two_holder=4;

// constants to look nicely and fit well together
pass_t=0.5;  //mm added so one body slides well into other
