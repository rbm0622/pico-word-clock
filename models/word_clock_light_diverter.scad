// ==========================================
// Word Clock Light Diverter (Baffle) Generator
// ==========================================

// --- 1. DIMENSIONS (Measure your Stencil) ---
// Total width of the letter area (mm)
total_width = 175; 

// Total height of the letter area (mm)
total_height = 130;

// How thick should the diverter be? (Distance from LED to Faceplate)
diverter_depth = 10;

// --- 2. GRID LAYOUT (Count your Stencil) ---
// How many letters per row?
columns = 11;

// How many rows of text?
rows = 10;

// --- 3. WALL SETTINGS ---
// Thickness of the grid walls (mm)
// 0.8mm is usually good for 3D printing (2 perimeters)
wall_thickness = 0.8;

// --- 4. RENDER SETTINGS ---
// Add a backing plate? (true/false) - Useful for mounting LEDs
add_backing = false;
backing_thickness = 1.0;


// ==========================================
// MAIN RENDER LOGIC
// ==========================================

module light_diverter() {
    
    // Calculate individual cell size
    cell_w = total_width / columns;
    cell_h = total_height / rows;
    
    // Adjust inner hole size to account for wall thickness
    hole_w = cell_w - wall_thickness;
    hole_h = cell_h - wall_thickness;

    union() {
        difference() {
            // The main solid block
            cube([total_width, total_height, diverter_depth]);

            // Subtract the grid holes
            for (r = [0 : rows - 1]) {
                for (c = [0 : columns - 1]) {
                    translate([
                        (c * cell_w) + (wall_thickness / 2), 
                        (r * cell_h) + (wall_thickness / 2), 
                        -1 // Start slightly below to ensure clean cut
                    ])
                    cube([hole_w, hole_h, diverter_depth + 2]);
                }
            }
        }

        // Optional Backing Plate
        if (add_backing) {
            translate([0, 0, -backing_thickness])
            cube([total_width, total_height, backing_thickness]);
        }
    }
}

// Render the part
light_diverter();

// ==========================================
// INSTRUCTIONS
// ==========================================
// 1. Open your STL file in a viewer (like Cura or Meshmixer).
// 2. Measure the X and Y distance of the text block. Enter into total_width/height.
// 3. Count how many letters are in a row. Enter into 'columns'.
// 4. Count how many rows of text there are. Enter into 'rows'.
// 5. Press F5 to preview, F6 to render, then export as STL.