use <steering.scad>;
use <servo_holder.scad>;

servo_holder();
a=33;
b=15;
rim=2;
hh=4;

difference(){

translate([-b/2-rim,-a/2,0])cube([b+rim+rim,a,hh]);
translate([-b/2,-a/2,0])cube([b,a,hh]);
    }

