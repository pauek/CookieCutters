#!/bin/bash

for lett in A B C D E F G H I J K L M N O P Q R S T U V W X Y Z; do
   cat > ${lett}.scad <<EOF
include <../cookie_cutter.scad>;
include <config.scad>;
cookie_cutter_join("${lett}.dxf", height, nozzle_diameter);
EOF
done
