use <regular_polygon.scad>;
od=32;
bearing_od=22;
id=8;
hh=7.5;
$fn=50;

module bearing_wheel(){
translate([0,0,hh+1])rotate([0,180,0])difference(){
  union(){
    cylinder(d=od+3, h=hh+1);
    for(i = [0:15:360])
    rotate(i)translate([od/2,0,0])cube([2,1,hh+1]);
}
  translate([0,0,0])union(){
    cylinder(d=bearing_od, h=hh);
    cylinder(d=bearing_od-8, h=hh+1);
    linear_extrude(height=hh)regular_polygon(order=6, r=11.1);
  }
}
}

module drive_wheel(){
  difference(){
  union(){
    cylinder(d=od+3, h=hh+1);
    for(i = [0:15:360])
    rotate(i)translate([od/2,0,0])cube([2,1,hh+1]);
}
  union(){
    difference(){cylinder(d=od, h=hh+1);cylinder(d=6, h=hh+1);}
    linear_extrude(height=hh)regular_polygon(order=6, r=3/2);
  }
  }
  for(i=[0:60:360])
  rotate(i)translate([2,-0.5,0])cube([od/2-1,1,hh]);
}

color([1,0,0])translate([0,od+10,0])drive_wheel();
color([0,1,0])bearing_wheel(); 