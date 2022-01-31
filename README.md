# gfx: A Simple Graphics Library for Unix

This page describes gfx, a simple graphics library for introductory CSE courses. This library is meant to be simple and easy to learn, so that beginning CSE students can get right into the interesting parts of programming. The gfx library only requires that the programmer understand how to invoke basic C functions with scalar arguments.

It is more than enough to explore raster and vector graphics, create animations, draw fractal shapes, and write simple video games. It doesn't do _everything_ that you might want a graphics library to do. As you learn more about programming, more advanced libraries that you might consider using are [OpenGL](http://www.opengl.org) for precise 3-D graphics, [Qt](http://qt.nokia.com) for windowed applications, and [SDL](http://www.libsdl.org) for video games.

Connecting
----------

This library runs on Unix machines with the X11 Windowing System. At Notre Dame, your program will _run_ on one of the student servers and _display_ on your desktop or laptop.

### From a Linux Laptop or Desktop

There is nothing to install, just use ssh with the X forwarding option (-Y) enabled:

```
ssh -Y YOURNAME@studentXX.cse.nd.edu
```

### From a Mac Laptop or Desktop

Install the [XQuartz](https://www.xquartz.org/) software on your laptop. Start the XQuartz application. Then, open a Terminal and connect to one of the student machines:

```
ssh -Y YOURNAME@studentXX.cse.nd.edu
```

### From a Windows Laptop or Desktop

Install the [X-Windows Client](https://oit.nd.edu/services/software/software-downloads/) and PuTTY on your laptop. Start the X Windows application. Then, open PuTTY, enable Connection > SSH > X11 > Enable X11 Forwarding, and connect to one of the student machines.

Getting Started
---------------

First clone this repository to your local machine:

```
git clone https://github.com/dthain/gfx
```

Then move into that directory:
```
cd gfx
```

Note that `gfx.h` and `gfx.c` constitute the library itself, which you are welcome to read, but should not change for a course assignment.  `example.c` is an example program that uses the library, and you can change that as much as you like.

To compile a program that uses the gfx library, you need to use the following command, which compiles your program with gfx.c then adds the X11 and math libraries. (X11 is short for the X Window System used on Unix based machines.)

```
gcc example.c gfx.c -o example -lX11 -lm
```

Run the example program, and you should see a window pop up with a green triangle.

```
./example
```

Line by Line Example
--------------------

To give you the idea of how to use the library, we will point out the important parts of example.c in detail. Then, below you can read about how the individual functions work.

Begin by including gfx.h, to make the library available to the program. Note that quotes rather than angle brackets are used in this statement. Quotes indicate the header file is in the current directory, rather than in some system-defined place.

```
#include "gfx.h"
```

To open a graphics window, call gfx\_open once at the beginning of the program, giving the width and height of the window in pixels, and the title of the window on the screen:

```
gfx_open(xsize,ysize,"Example Graphics Program");
```

gfx\_color sets the current drawing color to a pale green:

```
gfx_color(0,255,0);
```

Now, use the gfx\_line function to draw a line from (100,100) to (200,100):

```
gfx_line(100,100,200,100);
```

Wait for the user to press a key (or button):

```
c = gfx_wait();
```

If the key is the letter 'q', break out of the loop:

```
if(c=='q') break;
```

That shows you enough to get started. There are a few more useful functions in the library, read the following section to see them all.

Function Reference
------------------

```
void gfx_open( int width, int height, const char *title );
```

gfx\_open creates a new graphics window on the screen. width is the width of the window in pixels. height is the height of the window in pixels. title is the name of the window in the title bar.

```
void gfx_line( int x1, int y1, int x2, int y2 );
```

gfx\_line draws a line in the graphics window, using the current color, from location x1,y1 to x2,y2

```
void gfx_color( int red, int green, int blue );
```

gfx\_color sets the current color for drawing, using the [RGB color model](http://en.wikipedia.org/wiki/RGB_color_model), in which you mix red, green, and blue components in order to get the desired color. gfx\_color takes three integers between 0 and 255, each representing red, green, and blue.  Example [RGB Color Code Chart](https://www.rapidtables.com/web/color/RGB_Color.html).

```
void gfx_clear();
```

gfx\_clear clears the window to the current background color, which is black by default.

```
void gfx_clear_color( int red, int green, int blue );
```

gfx\_clear\_color changes the background color, using the same format as gfx\_clear above. The new background color takes effect the next time gfx\_clear is called.

```
char gfx_wait();
```

gfx\_wait waits until the user presses a key or mouse button. If the user has pressed a mouse button, the integer 1, 2, or 3 will be returned, indicating the button pressed. If the user has pressed a key, that character will be returned. To determine the mouse location at that time, call gfx\_xpos and gfx\_ypos.

```
int gfx_xpos(); int gfx_ypos();
```

gfx\_xpos() and gfx\_ypos return the X and Y coordinates, respectively, of the mouse pointer when the last key or button was pressed.

```
int gfx_event_waiting();
```

gfx\_wait causes the program to wait until something is pressed, which can be inconvenient in a real-time program. To avoid this, call gfx\_event\_waiting, which returns true if an event (key or button press) has occurred, otherwise returns false immediately. If it returns true, then you can call gfx\_wait to retrieve the event without waiting.

```
void gfx_flush();
```

gfx\_flush flushes all output to the graphics window. This forces all previous drawing commands to take effect. Output is normally flushed after a called to gfx\_wait. If your program does not call gfx\_wait then you need to call gfx\_flush after drawing to the screen.

