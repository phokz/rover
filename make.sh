#!/bin/bash

for i in 0*scad; do
 output=$(echo $i | sed -e s/scad/stl/);
 openscad -o $output $i
done