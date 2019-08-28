use <gears.scad>;
use <servo_holder.scad>;
use <mounting_plate.scad>;
use <flexbatter.scad>;
use <regular_polygon.scad>;
use <my_servo_spline.scad>;
use <nut.scad>;

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

rozvor=82;
d=30;
h=8;
vnitrek=rozvor-h;
shaft=8;
shaft_len=20;
teeth=26;
height=4;
$fn=50;

module steer_gear(){
  difference() {
    union() {
      /* shaft */
      translate([10.4/2,0,0])rotate([0,90,0])cylinder(d=shaft, h=shaft_len-10.4/2);

      /* doplneni valecku na proti ozubenemu pulkolu */
      cylinder(d=16,h=4);
      
      /* pulkolo */
      translate([0,0,height/2])gear (
        number_of_teeth = teeth,
        thickness       = height,
        hole_diameter   = 10.4,
        teeth_to_hide = teeth/2-1
      );
  }
  union(){
    cylinder(d=10.4,h=10);
    translate([-50,-50,-10])cube([100,100,10]);
  }
}
}

module mid_gear(){
 color([1,0,0])translate([0,-rozvor/2-h/2,0])translate([0,0,height/2])gear (
  number_of_teeth = teeth,
  thickness       = height,
  hole_diameter   = 10.4
);
}

module steering() {
translate([0,-shaft_len,0])rotate([0,0,90])steer_gear();
translate([0,-rozvor+shaft_len-h,0])rotate([0,0,-90])steer_gear();
mid_gear();
}

module base() {
translate([0,0,0]){
/* zakladna */
difference(){
translate([-10.4/2,-h-vnitrek+7,-4]){
  union() {
    color([0,0,1])cube([130,vnitrek-14,4]);
    color([1,0,0])translate([60,-5,0])cube([71,70,4]);
    color([1,0,1])translate([60+70-23.5,0,0])cylinder(d=6.1,h=15.4);
    color([1,0,1])translate([60+70-23.5,60,0])cylinder(d=6.1,h=15.4);
  }
}
  union() {
    /* servo space */
    translate([25,-rozvor/2-h/2,-5])rotate([0,0,90])servo_space(add=5);
    translate([0,0,-5]){
      translate([0,-rozvor/2-h/2,0]){nut(); cylinder(d=3.2, h=10);}
      translate([0,-shaft_len,0])rotate([0,0,90]){nut(); cylinder(d=3.2, h=10);}
      translate([0,-rozvor+shaft_len-h,0])rotate([0,0,-90]){nut(); cylinder(d=3.2, h=10);}
    }

  }
}
/* kolik na stredni kolo */
color([0,1,0])translate([0,-rozvor/2-h/2,0])difference(){cylinder(d=10,h=4);cylinder(d=7,h=4);}
/* kolik na prve kolo */
color([0,1,0])translate([0,-shaft_len,0])rotate([0,0,90])difference(){cylinder(d=10,h=4);cylinder(d=7,h=4);}
/* kolik na druhe kolo */
color([0,1,0])translate([0,-rozvor+shaft_len-h,0])rotate([0,0,-90])difference(){cylinder(d=10,h=4);cylinder(d=7,h=4);}
}
}

module pins() {
/* zajistovaci kolicky */
for (x = [20:15:60]) {
  translate([x,0,0]){
    difference(){
      union(){
        cylinder(d=12,h=3);
        translate([0,0,3])cylinder(r2=3.4, r1=3.5,h=4.1);
      }
      union(){
        cylinder(d=6.2,h=2);
        cylinder(d=3.2,h=7.1);
      }
    }
  }
}

}

module servo_gear() {
/* servo gear */
translate([0,10,0])union(){translate([0,0,2])gear (
  number_of_teeth = 16,
  thickness       = 4,
  hole_diameter   = 6 
);
  my_servo_spline(h=3.2);
  translate([0,0,3.2])difference(){cylinder(d=7, h=0.8);cylinder(d=3.2,h=0.8);}
}
}


pins();
servo_gear();
steering();
base();
