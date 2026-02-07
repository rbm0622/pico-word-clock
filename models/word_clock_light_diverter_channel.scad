// Word Clock Baffle with Top-Mounting Tabs, Screw Holes, and Row Channels
// Based on word_clock_stencil.scad dimensions

// --- Dimensions from Stencil Source ---
width = 175;           // 
height = 130;          // 
border_lr = 25;        // 
border_tb = 8.2;       // 
cols = 11;             // 
rows = 10;             // 

// --- Baffle & Lip Settings ---
baffle_height = 18;    // 
wall_thickness = 1.2;  // 
edge_thickness = 2.5;  // 
lip_width = 4.0;       // 
lip_thickness = 2.0;   // 
rib_thickness = 1.5;   // 

// --- New Feature Settings ---
tab_thickness = 3.0;   // Mounting tab thickness at the top 
screw_dia = 3.5;       // M3 screw clearance hole 
channel_width = 10;    // 1 cm wide 
channel_depth = 5;     // 0.5 cm deep 

// --- Calculated Values ---
outer_width  = width  + border_lr * 2; // 
outer_height = height + border_tb * 2; // 
cell_w = width / cols;                 // 
cell_h = height / rows;                // 

// Tab sizing to fit corners
tab_w = border_lr;
tab_h = border_tb;

difference() {
    union() {
        // 1. Outer Frame with Integrated Mounting Lip
        difference() {
            cube([outer_width, outer_height, baffle_height]); // 
            translate([edge_thickness, edge_thickness, -1])
                cube([outer_width - (edge_thickness * 2), outer_height - (edge_thickness * 2), baffle_height + 2]); // 
        }
        
        // Add the Lip
        difference() {
            translate([edge_thickness, edge_thickness, 0])
                cube([outer_width - (edge_thickness * 2), outer_height - (edge_thickness * 2), lip_thickness]); // 
            translate([edge_thickness + lip_width, edge_thickness + lip_width, -1])
                cube([outer_width - (edge_thickness + lip_width) * 2, outer_height - (edge_thickness + lip_width) * 2, lip_thickness + 2]); // 
        }

        // 2. Internal Grid
        translate([border_lr, border_tb, 0]) { // 
            for (i = [0 : cols]) {
                translate([i * cell_w - wall_thickness / 2, 0, 0])
                    cube([wall_thickness, height, baffle_height]); // 
            }
            for (j = [0 : rows]) {
                translate([0, j * cell_h - wall_thickness / 2, 0])
                    cube([width, wall_thickness, baffle_height]); // 
            }
        }

        // 3. Interior Mounting Tabs (Top-Side)
        // Positioned flush with the top of the baffle (Z = 15 to 18) 
        z_pos = baffle_height - tab_thickness;
        translate([0, 0, z_pos]) cube([tab_w, tab_h, tab_thickness]);
        translate([outer_width - tab_w, 0, z_pos]) cube([tab_w, tab_h, tab_thickness]);
        translate([0, outer_height - tab_h, z_pos]) cube([tab_w, tab_h, tab_thickness]);
        translate([outer_width - tab_w, outer_height - tab_h, z_pos]) cube([tab_w, tab_h, tab_thickness]);

        // 4. Support Ribs
        for (y_pos = [border_tb, outer_height/2, outer_height - border_tb]) { // 
            translate([edge_thickness, y_pos - rib_thickness/2, 0])
                cube([border_lr - edge_thickness, rib_thickness, baffle_height]); // 
            translate([outer_width - border_lr, y_pos - rib_thickness/2, 0])
                cube([border_lr - edge_thickness, rib_thickness, baffle_height]); // 
        }
        for (x_pos = [border_lr, outer_width/2, outer_width - border_lr]) { // 
            translate([x_pos - rib_thickness/2, edge_thickness, 0])
                cube([rib_thickness, border_tb - edge_thickness, baffle_height]); // 
            translate([x_pos - rib_thickness/2, outer_height - border_tb, 0])
                cube([rib_thickness, border_tb - edge_thickness, baffle_height]); // 
        }
    }

    // 5. Subtract Screw Holes (Centered in tabs) 
    translate([tab_w/2, tab_h/2, -1]) cylinder(h=baffle_height+2, d=screw_dia, $fn=32);
    translate([outer_width - tab_w/2, tab_h/2, -1]) cylinder(h=baffle_height+2, d=screw_dia, $fn=32);
    translate([tab_w/2, outer_height - tab_h/2, -1]) cylinder(h=baffle_height+2, d=screw_dia, $fn=32);
    translate([outer_width - tab_w/2, outer_height - tab_h/2, -1]) cylinder(h=baffle_height+2, d=screw_dia, $fn=32);

    // 6. Subtract Row Channels
    // Extends past the internal baffle (width) but stops at the outer wall (edge_thickness) 
    channel_len = outer_width - (edge_thickness * 2);
    for (j = [0 : rows - 1]) {
        row_y_center = border_tb + (j + 0.5) * cell_h; // 
        translate([edge_thickness, row_y_center - (channel_width / 2), baffle_height - channel_depth])
            cube([channel_len, channel_width, channel_depth + 1]);
    }
}