# Pico Word Clock

# Summary

A word clock built with a Raspberry Pi Pico W uses a 10 × 11 grid of letters (110 total) backed by a WS2812B addressable LED strip to display the time in words rather than numbers, lighting up phrases like “IT IS A QUARTER PAST TEN.” The Raspberry Pi Pico W acts as the controller, handling precise LED timing and using its built-in Wi-Fi to synchronize the time via NTP, keeping the clock accurate without manual adjustment. Each word in the grid maps to specific LED positions, and the software determines which words to illuminate based on the current time, typically rounded to five-minute intervals. The result is a clean, readable piece of functional art that combines simple hardware, Python-based firmware, and a minimalist, conversation-starting design.

## Example outputs

**3:00 AM** → `IT IS THREE OCLOCK AM`

**3:15 PM** → `IT IS A QUARTER PAST THREE PM`

**11:45 AM** → `IT IS A QUARTER TO TWELVE AM`

# Hardware

*   Raspberry Pi Pico 2 W
*   Pixels Strip WS2812B
*   Wires
*   Connectors
*   Small breadboard

# Bill of materials

<table><tbody><tr><td><strong>Item</strong></td><td><strong>Price</strong></td><td><strong>Amazon</strong></td></tr><tr><td>Raspberry Pi Pico W</td><td>16.31</td><td><a href="https://a.co/d/6KEXnaS"><u>https://a.co/d/6KEXnaS</u></a></td></tr><tr><td>60 Pixels Strip WS2812B</td><td>6.99</td><td><a href="https://a.co/d/9gVl9jp"><u>https://a.co/d/9gVl9jp</u></a></td></tr><tr><td>10 Packs Solderless LED Strip Connector</td><td>12.99</td><td><a href="https://a.co/d/9E523mY"><u>https://a.co/d/9E523mY</u></a></td></tr><tr><td>60 Pixels Strip WS2812B</td><td>6.99</td><td><a href="https://a.co/d/9gVl9jp"><u>https://a.co/d/9gVl9jp</u></a></td></tr><tr><td>20 Pcs 3 Pin 10mm Solderless</td><td>8.99</td><td><a href="https://a.co/d/1o7WKmw"><u>https://a.co/d/1o7WKmw</u></a></td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td><i><strong>Total</strong></i></td><td><i><strong>52.27</strong></i></td><td>&nbsp;</td></tr></tbody></table>

# Notes

*   11 x 10 Grid. 110 pixels.
*   Even rows red left to right. Odd rows opposite.

# References (thank you)

*   [Word Clock Face](https://github.com/bk1285/rpi_wordclock)
*   Sample Neopixel Code [Nerd CaveNerd Cave](https://youtu.be/MCBSYVftAWE?si=S6USrQKy7EuSgAmb)