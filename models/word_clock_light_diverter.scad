// Word Clock Baffle with Ribs and Mounting Lip
// Based on word_clock_stencil.scad dimensions

// --- Dimensions from Stencil Source ---
width = 175;           // [cite: 1]
height = 130;          // [cite: 2]
border_lr = 25;        // 
border_tb = 8.2;        // 
cols = 11;             // 
rows = 10;             // 

// --- New Baffle & Lip Settings ---
baffle_height = 18;    // Total depth
wall_thickness = 1.2;  // Grid wall thickness
edge_thickness = 2.5;  // Outer frame thickness
lip_width = 4.0;       // How far the lip sticks out to hold the backplate
lip_thickness = 2.0;   // Vertical thickness of the lip
rib_thickness = 1.5;   // Thickness of support ribs

// --- Calculated Values ---
outer_width  = width  + border_lr * 2; // [cite: 4]
outer_height = height + border_tb * 2; // [cite: 4]
cell_w = width / cols;                 // 
cell_h = height / rows;                // 

difference() {
    // 1. Outer Frame with Integrated Mounting Lip
    difference() {
        // Main outer wall
        cube([outer_width, outer_height, baffle_height]);
        
        // Hollow out the center
        translate([edge_thickness, edge_thickness, -1])
            cube([outer_width - (edge_thickness * 2), outer_height - (edge_thickness * 2), baffle_height + 2]);
    }
    
    // Add the Lip (Inner ledge at the base)
    difference() {
        translate([edge_thickness, edge_thickness, 0])
            cube([outer_width - (edge_thickness * 2), outer_height - (edge_thickness * 2), lip_thickness]);
        translate([edge_thickness + lip_width, edge_thickness + lip_width, -1])
            cube([outer_width - (edge_thickness + lip_width) * 2, outer_height - (edge_thickness + lip_width) * 2, lip_thickness + 2]);
    }

    // 2. Internal Grid (Aligned to Stencil Letters)
    translate([border_lr, border_tb, 0]) {
        for (i = [0 : cols]) {
            translate([i * cell_w - wall_thickness / 2, 0, 0])
                cube([wall_thickness, height, baffle_height]);
        }
        for (j = [0 : rows]) {
            translate([0, j * cell_h - wall_thickness / 2, 0])
                cube([width, wall_thickness, baffle_height]);
        }
    }

    // 3. Support Ribs (Connecting Frame to Grid)
    // Ribs on Left/Right
    for (y_pos = [border_tb, outer_height/2, outer_height - border_tb]) {
        // Left rib
        translate([edge_thickness, y_pos - rib_thickness/2, 0])
            cube([border_lr - edge_thickness, rib_thickness, baffle_height]);
        // Right rib
        translate([outer_width - border_lr, y_pos - rib_thickness/2, 0])
            cube([border_lr - edge_thickness, rib_thickness, baffle_height]);
    }
    
    // Ribs on Top/Bottom
    for (x_pos = [border_lr, outer_width/2, outer_width - border_lr]) {
        // Bottom rib
        translate([x_pos - rib_thickness/2, edge_thickness, 0])
            cube([rib_thickness, border_tb - edge_thickness, baffle_height]);
        // Top rib
        translate([x_pos - rib_thickness/2, outer_height - border_tb, 0])
            cube([rib_thickness, border_tb - edge_thickness, baffle_height]);
    }
    // Corner screw holes
    // Parameters: clearance for M3 screw (adjust if needed)
    screw_hole_dia = 3.2;
    screw_hole_r = screw_hole_dia / 2;
    // Distance from outer edges inward to locate holes
    mount_offset = 8;

    for (p = [
            [mount_offset, mount_offset],
            [outer_width - mount_offset, mount_offset],
            [mount_offset, outer_height - mount_offset],
            [outer_width - mount_offset, outer_height - mount_offset]
        ]) {
        translate([p[0], p[1], -1])
            cylinder(h = baffle_height + 2, r = screw_hole_r, $fn = 40);
    }
}