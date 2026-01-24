// Word Clock Stencil with Border
// Units: millimeters

// inch = 25.4;

// Inner stencil size (original)
// width = 18.15;
width = 175;
height = 130;
thickness = 20;

// Border size
border = 20;

// Outer size
outer_width = width + border * 2;
outer_height = height + border * 2;

cols = 11;
rows = 10;

cell_w = width / cols;
cell_h = height / rows;

letters = [
    ["I", "T", "M", "I", "S", "E", "N", "A", "M", "P", "M"],
    ["A", "D", "Q", "U", "A", "R", "T", "E", "R", "E", "L"],
    ["T", "W", "E", "N", "T", "Y", "F", "I", "V", "E", "S"],
    ["H", "A", "L", "F", "O", "T", "E", "N", "H", "T", "O"],
    ["P", "A", "S", "T", "N", "R", "U", "N", "I", "N", "E"],
    ["O", "N", "E", "S", "I", "X", "T", "H", "R", "E", "E"],
    ["F", "O", "U", "R", "F", "I", "V", "E", "T", "W", "O"],
    ["E", "I", "G", "H", "T", "E", "L", "E", "V", "E", "N"],
    ["S", "E", "V", "E", "N", "T", "W", "E", "L", "V", "E"],
    ["T", "E", "N", "S", "E", "O", "C", "L", "O", "C", "K"]
];

difference() {
    // Outer plate with border
    cube([outer_width, outer_height, thickness]);

    // Letter cutouts (offset by border)
    for (r = [0:rows-1]) {
        for (c = [0:cols-1]) {
            translate([
                border + c * cell_w + cell_w / 2,
                border + height - (r * cell_h + cell_h / 2),
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
