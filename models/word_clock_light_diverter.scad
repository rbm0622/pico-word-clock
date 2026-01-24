// Light Diverter for Word Clock
// Based on dimensions from word_clock_stencil.scad

// --- Original Dimensions from Source ---
inch = 25.4;

// Inner stencil size
width = 18.15;  // 
height = 13;    // 

// Border size
border = 2;     // [cite: 2]

// Grid configuration
cols = 11;      // 
rows = 10;      // 

// --- Diverter Specific Parameters ---

// Height of the diverter (Z-axis depth)
// Increase this to provide more distance between LEDs and the face
diverter_height = 10; 

// Thickness of the grid walls separating the lights
// Since the original scale is very small (18mm width), 
// we need very thin walls (0.2mm - 0.4mm) to leave room for light.
wall_thickness = 0.4; 

// --- Derived Calculations ---

outer_width = width + border * 2;   // [cite: 2]
outer_height = height + border * 2; // 

cell_w = width / cols;  // 
cell_h = height / rows; // [cite: 4]

// --- Geometry ---

difference() {
    // 1. The main solid block
    cube([outer_width, outer_height, diverter_height]);
    
    // 2. Subtract the light channels (holes)
    for (r = [0:rows-1]) {
        for (c = [0:cols-1]) {
            translate([
                // X: Start at border, move over columns, center in cell
                border + c * cell_w + cell_w / 2,
                
                // Y: Start at border, account for inverse Y (top-down), center in cell
                // Logic matches source file coordinate system 
                border + height - (r * cell_h + cell_h / 2),
                
                // Z: Lower slightly to ensure clean cut through bottom
                -1
            ])
            // Cut the square hole
            cube([
                cell_w - wall_thickness, // Width of hole
                cell_h - wall_thickness, // Height of hole
                diverter_height + 2      // Depth (plus padding for boolean diff)
            ], center = true); // Center the hole on the calculated coordinates
        }
    }
}