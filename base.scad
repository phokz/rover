$fn=30;
use <mounting_plate.scad>;
use <flexbatter.scad>;
use <regular_polygon.scad>;
use <kolecko2.scad>;
use <steering.scad>;

include <gearbox.scad>;

corner_radius = 3;
rantl_height = 10;
rantl_thick = 2;
w=80;
d=140;
plate_height=3;

module center_cube(x=10,y=10,z=1) {
  translate([-x/2, -y/2, 0])cube([x,y,z]);
}

module rover_mount(){
difference(){
mounting_plate(w=w, d=d, nut_d=6.2, nut_height=2.4, plate_height=plate_height, corner_radius=corner_radius);
  union(){
     /* holes in mounting plate */
   /* dira v boku na drzak baterky */
    color([0,1,0])translate([0,gearbox_length+gearbox_spacing,0])cube([w,25,rantl_height+plate_height+1]);
   /* dira na motory */
   translate([w/2,gearbox_spacing+rantl_thick+gearbox_length/2,0])center_cube(x=(gearbox_holes_distance-5),y=gearbox_length-32,z=10);
   translate([w/2,gearbox_spacing+rantl_thick+gearbox_length/2+32,0])center_cube(x=38,y=32,z=10);
   /* dira na loziska */      
  }
}
}

translate([0,gearbox_length+gearbox_spacing,0])cube([w-15,25,plate_height]);


module rover_rantl() {
difference(){
translate([corner_radius,corner_radius,plate_height])minkowski(){
    cube([w-2*corner_radius,d-2*corner_radius,rantl_height]);
    cylinder(r=corner_radius,h=1);
  }
union() {
    /* vnitrni prostor */
    translate([corner_radius+rantl_thick,corner_radius+rantl_thick,plate_height])minkowski(){
    cube([w-2*corner_radius-2*rantl_thick,d-2*corner_radius-2*rantl_thick,rantl_height]);
    cylinder(r=corner_radius,h=1);
  }
  /* diry na osu */
    color([1,0,0])translate([0,gearbox_end_to_shaft+rantl_thick+gearbox_spacing,gearbox_height/2])rotate([0,90,0])cylinder(d=8,h=rantl_thick);  
    color([1,0,0])translate([w-rantl_thick,gearbox_end_to_shaft+rantl_thick+gearbox_spacing,gearbox_height/2])rotate([0,90,0])cylinder(d=8,h=rantl_thick);  
   /* dira v boku na drzak baterky */
    color([0,1,0])translate([0,gearbox_length+gearbox_spacing,0])cube([w,25,rantl_height+plate_height+1]);
    }
}
}

gearbox_spacing=2;
module drive_shaft() {
translate([-(shaft_total_length-w)/2,gearbox_end_to_shaft+rantl_thick+gearbox_spacing,gearbox_height/2])rotate([0,90,0])linear_extrude(h=shaft_total_length)regular_polygon(order = 6, r=1.7);
}

module battery_holder(){
translate([w-12,14+gearbox_length,0]){
rotate([0,0,180])flexbatter18650(n=1);
}
}

module shaft_and_drive_wheels() {
  /* color([1,0,0])drive_shaft(); */
  translate([-(shaft_total_length-w)/2,-5,gearbox_height/2]){
  rotate([0,90,0])drive_wheel();
  rotate([0,-90,0])translate([0,0,-shaft_total_length])drive_wheel();
  }
}

translate([80-5,50,0])rotate([0,0,90])full_gearbox_model();

translate([8.5-5,100,0])shaft_and_drive_wheels();
rotate([0,0,90])translate([0,0,gearbox_height/2]){
  steering();
  base();
}

