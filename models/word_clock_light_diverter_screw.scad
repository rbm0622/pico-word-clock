// Word Clock Baffle with Interior Top-Mounting Tabs
// Corrected syntax and adjusted for border dimensions

// --- Dimensions from Stencil Source ---
width = 175;            // [cite: 1]
height = 130;           // [cite: 2]
border_lr = 25;         // [cite: 1]
border_tb = 8.2;        // [cite: 2]
cols = 11;              // [cite: 3]
rows = 10;              // [cite: 3]

// --- Baffle & Lip Settings ---
baffle_height = 18;     // 
wall_thickness = 1.2;   // 
edge_thickness = 2.5;   // 
lip_width = 4.0;        // [cite: 5]
lip_thickness = 2.0;    // [cite: 6]
rib_thickness = 1.5;    // [cite: 6]

// --- Interior Tab Settings ---
tab_thickness = 3.0;    // Thickness of the tab at the top
screw_dia = 3.5;        // Clearance for M3 screw

// --- Calculated Values ---
outer_width  = width  + border_lr * 2;  // [cite: 7]
outer_height = height + border_tb * 2;  // [cite: 7]
cell_w = width / cols;                 // [cite: 8]
cell_h = height / rows;                // [cite: 8]

// Tab sizing to fit the narrowest border (8.2mm)
tab_w = border_lr;
tab_h = border_tb;

difference() {
    union() {
        // 1. Outer Frame with Integrated Mounting Lip
        difference() {
            cube([outer_width, outer_height, baffle_height]); // [cite: 9]
            translate([edge_thickness, edge_thickness, -1])
                cube([outer_width - (edge_thickness * 2), outer_height - (edge_thickness * 2), baffle_height + 2]); // [cite: 9]
        }
        
        // Add the Lip (Inner ledge at the base)
        difference() {
            translate([edge_thickness, edge_thickness, 0])
                cube([outer_width - (edge_thickness * 2), outer_height - (edge_thickness * 2), lip_thickness]); // [cite: 11]
            translate([edge_thickness + lip_width, edge_thickness + lip_width, -1])
                cube([outer_width - (edge_thickness + lip_width) * 2, outer_height - (edge_thickness + lip_width) * 2, lip_thickness + 2]); // [cite: 12]
        }

        // 2. Internal Grid (Aligned to Stencil Letters)
        translate([border_lr, border_tb, 0]) {
            for (i = [0 : cols]) {
                translate([i * cell_w - wall_thickness / 2, 0, 0])
                    cube([wall_thickness, height, baffle_height]); // [cite: 13]
            }
            for (j = [0 : rows]) {
                translate([0, j * cell_h - wall_thickness / 2, 0])
                    cube([width, wall_thickness, baffle_height]); // [cite: 14]
            }
        }

        // 3. Interior Mounting Tabs (Top-Side)
        // Positioned at the top of the baffle height (Z = 15 to 18)
        z_pos = baffle_height - tab_thickness;
        
        translate([0, 0, z_pos]) cube([tab_w, tab_h, tab_thickness]);
        translate([outer_width - tab_w, 0, z_pos]) cube([tab_w, tab_h, tab_thickness]);
        translate([0, outer_height - tab_h, z_pos]) cube([tab_w, tab_h, tab_thickness]);
        translate([outer_width - tab_w, outer_height - tab_h, z_pos]) cube([tab_w, tab_h, tab_thickness]);

        // 4. Support Ribs
        for (y_pos = [border_tb, outer_height/2, outer_height - border_tb]) {
            translate([edge_thickness, y_pos - rib_thickness/2, 0])
                cube([border_lr - edge_thickness, rib_thickness, baffle_height]); // [cite: 15]
            translate([outer_width - border_lr, y_pos - rib_thickness/2, 0])
                cube([border_lr - edge_thickness, rib_thickness, baffle_height]); // [cite: 16]
        }
        for (x_pos = [border_lr, outer_width/2, outer_width - border_lr]) {
            translate([x_pos - rib_thickness/2, edge_thickness, 0])
                cube([rib_thickness, border_tb - edge_thickness, baffle_height]); // [cite: 17]
            translate([x_pos - rib_thickness/2, outer_height - border_tb, 0])
                cube([rib_thickness, border_tb - edge_thickness, baffle_height]); // 
        }
    }

    // 5. Subtract Screw Holes
    // Centered within the corner tabs
    translate([tab_w/2, tab_h/2, -1]) cylinder(h=baffle_height+2, d=screw_dia, $fn=32);
    translate([outer_width - tab_w/2, tab_h/2, -1]) cylinder(h=baffle_height+2, d=screw_dia, $fn=32);
    translate([tab_w/2, outer_height - tab_h/2, -1]) cylinder(h=baffle_height+2, d=screw_dia, $fn=32);
    translate([outer_width - tab_w/2, outer_height - tab_h/2, -1]) cylinder(h=baffle_height+2, d=screw_dia, $fn=32);
}