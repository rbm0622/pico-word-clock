// Word Clock LED Back Panel (Clean Version)
// Matches width=175, height=130, borders 50/20

// --- Dimensions from Stencil ---
width = 175;           
height = 130;          
border_lr = 50;        
border_tb = 20;        
cols = 11;             
rows = 10;             

// --- Panel Settings ---
panel_thickness = 3.0; 
tolerance = 0.5;       // Adjust this if the fit is too tight
wire_hole_r = 1.5;     // Radius for LED wire holes
power_exit_r = 4.5;    // Large hole for power cable

// --- Calculated Outer Dimensions ---
// Formula: Width + (Border * 2)
outer_w = width + (border_lr * 2) - (tolerance * 2);
outer_h = height + (border_tb * 2) - (tolerance * 2);

// --- Grid Spacing ---
cell_w = width / cols;
cell_h = height / rows;

difference() {
    // 1. The Main Plate
    cube([outer_w, outer_h, panel_thickness]);

    // 2. LED Alignment/Wire Holes
    // Centers the holes behind each letter based on asymmetric borders
    translate([border_lr - tolerance, border_tb - tolerance, 0]) {
        for (r = [0 : rows - 1]) {
            for (c = [0 : cols - 1]) {
                translate([
                    c * cell_w + cell_w / 2, 
                    height - (r * cell_h + cell_h / 2), 
                    -1
                ])
                cylinder(h = panel_thickness + 2, r = wire_hole_r, $fn=20);
            }
        }
    }

    // 3. Power Cable Exit (Bottom Right Corner)
    translate([outer_w - 20, 20, -1])
        cylinder(h = panel_thickness + 2, r = power_exit_r, $fn=30);
}