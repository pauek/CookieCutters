#!/bin/bash

for file in ?.scad; do
   echo openscad -o ${file%.scad}.stl $file
done
