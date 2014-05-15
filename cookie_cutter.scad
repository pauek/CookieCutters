// Cookie cutter generator
// Pau Fernández <pauek@minidosis.org>
// GNU GPL v2

module dxf(file, layer, height) {
   orig = dxf_cross(file = file, layer = layer);
   translate([-orig[0], -orig[1], 0])
      linear_extrude(height = height)
         import(file = file, layer = layer);
}

module needle(height, thin, edge_height) {
   H1 = height - edge_height;
   H2 = edge_height;
   union() {
      cylinder(r = thin, h = H1, $fn = 6);
      translate([0, 0, H1]) {
         cylinder(r1 = thin, r2 = 0, h = H2, $fn = 6);
      }
   }
}

module wall(file, layer, height, thin) {
   difference() {
      minkowski() {
        dxf(file, layer, 0.01);
        cylinder(r = thin, h = height, $fn = 6);
      }
      translate([0, 0, -1]) dxf(file, layer, height + 2);
   }
}

module cutter(file, layer, height, edge_height, wall_thickness) {
   thin = wall_thickness * 1.1;
   difference() {
      minkowski() {
        dxf(file, layer, 0.01);
        needle(height, thin, edge_height);
      }
      translate([0, 0, -1]) dxf(file, layer, height + 2);
   }
}

module cookie_cutter(file, height, edge_height, wall_thickness) {
   union () {
      cutter(file, "cutter", height, edge_height, wall_thickness);
      wall(file, "outer", 1, 5);
   }
}

module cookie_cutter_join(file, height, edge_height, wall_thickness) {
   mirror([1, 0, 0]) union () {
      cutter(file, "cutter", height, edge_height, wall_thickness);
      wall(file, "outer", 1.5, 6);
      dxf(file, "join", 1.5);
   }
}
