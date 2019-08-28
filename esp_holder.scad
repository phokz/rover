module esp_holder(){
thickness=1.5;
w=2*2.54+0.1;
d=4*2.54+0.1;
h=10;
translate([0,0,1])difference(){
  cube([w+2*thickness, d+2*thickness,h]);
  translate([thickness,thickness,0])cube([w,d,h]);
}
w2=w-0.8;
d2=d-0.8;
thickness2=thickness+0.4;
h2=1;
translate([0,0,0])difference(){
  cube([w2+2*thickness2, d2+2*thickness2,h2]);
  translate([thickness2,thickness2,0])cube([w2,d2,h2]);
}
}
esp_holder();
