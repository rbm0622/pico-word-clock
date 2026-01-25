// Word Clock Stencil with Asymmetric Border
// Units: millimeters

inch = 25.4;

// Inner stencil size (original)
width = 18.15;
height = 13;
thickness = 2;

// Borders
border_lr = 50; // left & right
border_tb = 25; // top & bottom

// Outer size
outer_width  = width  + border_lr * 2;
outer_height = height + border_tb * 2;

cols = 11;
rows = 10;

cell_w = width / cols;
cell_h = height / rows;

letters = [
    ["I","T","M","I","S","E","N","A","M","P","M"],
    ["A","D","Q","U","A","R","T","E","R","E","L"],
    ["T","W","E","N","T","Y","F","I","V","E","S"],
    ["H","A","L","F","O","T","E","N","H","T","O"],
    ["P","A","S","T","N","R","U","N","I","N","E"],
    ["O","N","E","S","I","X","T","H","R","E","E"],
    ["F","O","U","R","F","I","V","E","T","W","O"],
    ["E","I","G","H","T","E","L","E","V","E","N"],
    ["S","E","V","E","N","T","W","E","L","V","E"],
    ["T","E","N","S","E","O","C","L","O","C","K"]
];

difference() {
    // Outer plate
    cube([outer_width, outer_height, thickness]);

    // Letter cutouts (offset into bordered area)
    for (r = [0:rows-1]) {
        for (c = [0:cols-1]) {
            translate([
                border_lr + c * cell_w + cell_w / 2,
                border_tb + height - (r * cell_h + cell_h / 2),
                -1
            ])
            linear_extrude(height = thickness + 2)
                text(
                    letters[r][c],
                    size = min(cell_w, cell_h) * 0.6,
                    halign = "center",
                    valign = "center",
                    font = "Stencil:style=Regular"
                );
        }
    }
}
