use <steering.scad>;
$fn=30;
difference(){
  translate([0,0,4])base();
  union(){
    translate([50,-75,0])rotate([0,0,0])gearbox_model_xhole();
    /* system mount holes */
    for (x=[23:20:125]) {
      translate([x,-20,0])cylinder(d=3.2, h=4);
      translate([x,-70,0])cylinder(d=3.2, h=4);
    }
    for (x=[51:12:80]) {
      translate([x,-20,0])cylinder(d=3.2, h=4);
      translate([x,-70,0])cylinder(d=3.2, h=4);
    }
  }
}
