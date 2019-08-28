use <regular_polygon.scad>;
module mounting_plate(w=80, d=30, nut_d=5.2, nut_height=2.4, plate_height=3, corner_radius=2){
  $fn=50;
  difference() {
  union(){
  translate([corner_radius,corner_radius,0])minkowski(){
    cube([w-2*corner_radius,d-2*corner_radius,plate_height]);
    cylinder(r=corner_radius,h=1);
  }
  }
  union(){
  for(j = [5 : 10 : w-5])
  for(i = [5 : 10 : d-5]) {
  translate([j,i,plate_height-2.4]){
      linear_extrude(height=10)regular_polygon(order=6, r=nut_d/2);
  }
  translate([j,i,0])cylinder(d=3,h=10);
  }
  }
  }
}

mounting_plate(w=30);
