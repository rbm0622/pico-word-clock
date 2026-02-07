include <word_clock_stencil.scad>;

translate([0, 0, 10]) {
    include <word_clock_light_diverter_channel.scad>;
}

 translate([0, 0, 50]) {
            include <word_clock_back_panel.scad>;
     }
