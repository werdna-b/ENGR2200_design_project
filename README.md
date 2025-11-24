# ENGR2200 Final Project

The grand finale for digial systems.

# Initialization

Start in a folder of your choice (hereafter "project root") and create a new vivado project named `final_project` inside this directory (make sure to use "create project subdirectory").

Go up to the parent of `project root` and git clone the repo. Rename the folder that is created to the same name as `project root` and hit "write into" or "merge folder" depending on OS.

Add Sources (alt + a) > Add or create design sources > Add Directories > `final_project/final_project.srcs` . The sources should appear in vivado's "design sources".




# Overview

### **vga_sync**
+ **Controls timing for VGA output**
+ **inputs**
    + clk
    + reset
+ **outputs**
    + vsync
    + hsync
    + video_on
    + p_tick
    + x [9:0]
    + y [9:0]

### **display**
+ **Takes input from vga_sync and prints stuff to the screen**
+ **inputs**
    + x [9:0]
    + y [9:0]
    + x1, x2, x3, x4 [47:0]
    + clk
    + videoOn
+ **outputs**
    + rgb [11:0]

 
# Details
 ### **vga_sync**
 vga_sync takes a standard 100MHz clock as input, as well as a reset line. When reset is pulled high, the clock is reset to its original state. 
 vsync and hsync are pulses sent to the vga monitor to tell it when a full line of pixels has been written, as well as when a full screen has been written.
 
 Our vga monitors are based on 640x480 pixel standards. However, there is a ~48p front and back porch of pixels that aren't visible. Thus, video_on is a signal that is high when the x,y coordinates are within the printable screen area.

 x and y are 12 bit vectors that report the current coordinates of the pixel being printed. p_tick does something I'm pretty sure

 ### **display**
 display takes the output x and y vectors from vga_sync and actually prints stuff with them. It checks if x and y are within certain bounds, and then it prints the appropriate rgb values to the screen.

 x1, x2, x3, and x4 are the color vectors coming in from other places. x1 corresponds to the first horizontal row of colors, x2 to the second, and so on

 rgb is a 12 bit output vector going straight to the vga pins on the fpga. They control the color value of the pixel currently being printed. 

 When videoOn is low, it theoretically won't print anything.

