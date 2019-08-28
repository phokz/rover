module servo_space(add=0){
thickness=1.5;
thickness2=5;
w=12.5;
d=23;
wires_spacing=1.4;
wires_w=4.5;
h=8;

 a=d+2*thickness2+add; b=w+2*thickness; c=10;
 translate([-b/2,-a/2,0])cube([b,a,h]);
}

module servo_holder(){
thickness=1.5;
thickness2=5;
w=12.5;
d=23;
wires_spacing=1.4;
wires_w=4.5;
h=8;
translate([-w/2-thickness,-d/2-thickness2,0])difference(){
  cube([w+2*thickness, d+2*thickness2,h]);
  union(){
    translate([thickness,thickness2,-1])cube([w,d,h+2]);
    translate([thickness+w/2,thickness2/2,h-8])cylinder(d=2,h=8,$fn=20);
    translate([thickness+w/2,d+thickness2*1.5,h-8])cylinder(d=2,h=8,$fn=20);
    translate([thickness+w/2,thickness2-wires_spacing,0])
      translate([-wires_w/2,0,0])color([1,0,0])cube([wires_w,wires_spacing,h]);
    translate([thickness+w/2,d+thickness2,0])
      translate([-wires_w/2,0,0])color([1,0,0])cube([wires_w,wires_spacing,h]);
  }
}
}
servo_holder();

servo_space();
