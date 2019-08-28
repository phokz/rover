module halfcyl_plug(){
d=8;
$fn=100;
cylinder(d=d+3,h=1);

difference(){
translate([0,0,1])cylinder(r1=d/2+0.1, r2=d/2-0.1,h=8);
translate([0,-10,1])cube([20,20,21]);
}
}

halfcyl_plug();
translate([14,0,0])halfcyl_plug();
