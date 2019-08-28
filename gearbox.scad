use <regular_polygon.scad>;

gearbox_height=23;
gearbox_holes_distance=60;
gearbox_length=70;
gearbox_end_to_shaft = 25;
gearbox_end_to_hole = 19;

/* 23mm = 134 px */
/* = 145 px*/

shaft_total_length = 100;

module gearbox_model() {
  difference(){
  cube([gearbox_length,gearbox_holes_distance,gearbox_height]);
  union(){
    cube([gearbox_length/2,10,gearbox_height]);
    translate([0,gearbox_holes_distance-10,0])cube([gearbox_length/2,10,gearbox_height]);
    translate([gearbox_length-gearbox_end_to_hole, 0,0])cylinder(d=4,h=gearbox_height);
    translate([gearbox_length-gearbox_end_to_hole, gearbox_holes_distance,0])cylinder(d=4,h=gearbox_height);
  }
  }
}

module gearbox_model_xhole() {
  difference(){
  cube([gearbox_length,gearbox_holes_distance,gearbox_height]);
  union(){
    cube([gearbox_length/2-8,10,gearbox_height]);
    translate([0,gearbox_holes_distance-10,0])cube([gearbox_length/2-8,10,gearbox_height]);
    translate([gearbox_length-gearbox_end_to_hole, 0,0])cylinder(d=6,h=gearbox_height);
    translate([gearbox_length-gearbox_end_to_hole, gearbox_holes_distance,0])cylinder(d=6,h=gearbox_height);
  }
  }
  color([1,0,0])translate([gearbox_length-gearbox_end_to_hole, 0,0])cylinder(d=3.2,h=gearbox_height-10);
      translate([gearbox_length-gearbox_end_to_hole, gearbox_holes_distance,0])cylinder(d=3.2,h=gearbox_height-10);
    
}



module gearbox_drive_shaft() {
translate([gearbox_length-gearbox_end_to_shaft,-(shaft_total_length-gearbox_holes_distance)/2,gearbox_height/2])rotate([-90,0,0])linear_extrude(h=shaft_total_length)regular_polygon(order = 6, r=1.7);
}

module full_gearbox_model() {
/* gearbox_model(); */
color([1,0,0])gearbox_drive_shaft();
}
gearbox_model_xhole();
