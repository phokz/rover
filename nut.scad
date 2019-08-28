use <regular_polygon.scad>;
module nut(nut_d=6.4,h=2.4) {
  linear_extrude(height=h)regular_polygon(order=6, r=nut_d/2);
}
