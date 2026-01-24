// --- WORD CLOCK LIGHT DIVERTER GENERATOR ---

// 1. DIMENSIONS
// Measure your STL (or the bed size you printed it on)
total_width = 200; 
total_height = 200;
diverter_height = 15; // How deep the light grid should be (Z-axis)

// 2. GRID LAYOUT
// Standard word clocks are often 11x10 or 16x16. Count your letters!
columns = 11; 
rows = 10;

// 3. WALL SETTINGS
wall_thickness = 2.0; // Thickness of the grid lines
outer_wall = 2.0;     // Thickness of the outer frame

// 4. ALIGNMENT OFFSET
// Use these to shift the grid to match your stencil exactly
offset_x = 0;
offset_y = 0;

// 5. RENDER SETTINGS
show_stencil = true; // Set to true to see your STL overlay (Ghosted)

// --- CODE BELOW ---

module light_diverter() {
    
    // Calculate the size of the inner area where letters exist
    inner_w = total_width - (2 * outer_wall);
    inner_h = total_height - (2 * outer_wall);
    
    // Calculate size of individual light cells
    // (Total inner space - total space taken by internal walls) / number of cells
    cell_w = (inner_w - (wall_thickness * (columns - 1))) / columns;
    cell_h = (inner_h - (wall_thickness * (rows - 1))) / rows;

    difference() {
        // The main solid block
        translate([0, 0, diverter_height/2])
        cube([total_width, total_height, diverter_height], center=false);

        // Subtract the light chambers
        for (r = [0 : rows - 1]) {
            for (c = [0 : columns - 1]) {
                
                // Calculate position for specific cell
                x_pos = outer_wall + (c * (cell_w + wall_thickness));
                y_pos = outer_wall + (r * (cell_h + wall_thickness));
                
                translate([x_pos, y_pos, -1])
                cube([cell_w, cell_h, diverter_height + 2]);
            }
        }
    }
}

// Draw the Diverter
color("black") 
translate([offset_x, offset_y, 0])
light_diverter();

// Draw the Stencil for Alignment (Visual Reference Only)
if (show_stencil) {
    %translate([0, 0, diverter_height]) 
    import("word_clock_stencil.stl");
}