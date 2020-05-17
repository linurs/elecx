#!/bin/bash
# top view in openscad 
# place object that center is in the middle

# distance acts as zoom, it is the distance between camera and object
distance=300

x_size=1000
y_size=1000

x_page=$((2*$x_size))
y_page=$((2*$y_size))

openscad --o front.png --camera=0,0,0,0,0,0,$distance  --imgsize=$x_size,$y_size --render --projection=ortho --colorscheme=Tomorrow pcb.scad
openscad --o side.png --camera=0,0,0,0,90,0,$distance --imgsize=$x_size,$y_size --render --projection=ortho --colorscheme=Tomorrow pcb.scad
openscad --o top.png --camera=0,0,0,90,0,0,$distance --imgsize=$x_size,$y_size --render --projection=ortho --colorscheme=Tomorrow pcb.scad
convert -size "$x_size"x$y_size   xc:white  title.png

convert -size "$x_page"x$y_page   xc:wheat  drawing.png
composite -geometry  +0+0                 front.png drawing.png drawing.png
composite -geometry  +"$x_size"+0         side.png drawing.png drawing.png
composite -geometry  +0+$y_size           top.png drawing.png drawing.png
composite -geometry  +"$x_size"+$y_size   title.png drawing.png drawing.png
