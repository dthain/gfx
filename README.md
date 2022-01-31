<html>

<head>
<title>gfx: A Simple Graphics Library (V2)</title>
<link href="style.css" rel="stylesheet" type="text/css">
<link href="../../style.css" rel="stylesheet" type="text/css">
</head>

<body>

<div class=header>
<h1>gfx: A Simple Graphics Library (V4)</h1>
</div>

This page describes <tt>gfx</tt>, a simple graphics library for CSE.
This library is meant to be simple and easy to learn, so that beginning
CSE students can get right into the interesting parts of programming.
The <tt>gfx</tt> library only requires that the programmer understand
how to invoke basic C functions with scalar arguments.
<p>
It is more than enough to explore raster and vector graphics,
create animations, draw fractal shapes, and write simple video games. 
It doesn't do <i>everything</i> that you might want a graphics
library to do.  As you learn more about programming, more advanced
libraries that you might consider using are <a href=http://www.opengl.org>OpenGL</a> for precise 3-D graphics, <a href=http://qt.nokia.com>Qt</a> for windowed applications, and  <a href=http://www.libsdl.org>SDL</a> for video games.

<h2>Connecting</h2>

This library runs on Unix machines with the X11 Windowing System.
At Notre Dame, your program will <i>run</i> on one of the student
servers and <i>display</i> on your desktop or laptop.

<h3>From a Linux Laptop or Desktop</h3>

There is nothing to install, just use ssh with the X forwarding option (-Y) enabled:

<div class=code>ssh -Y YOURNAME@studentXX.cse.nd.edu</div>

<h3> From a Mac Laptop or Desktop</h3>

Install the <a href=https://www.xquartz.org/>XQuartz</a> software on your laptop.
Start the XQuartz application. Then, open a Terminal and connect to one of the student machines:

<div class=code>ssh -Y YOURNAME@studentXX.cse.nd.edu</div>

<h3>From a Windows Laptop or Desktop</h3>
Install the <a href=https://oit.nd.edu/services/software/software-downloads/>X-Windows Client</a> and PuTTY on your laptop.
Start the X Windows application. Then, open PuTTY, enable <tt>Connection &gt; SSH &gt; X11 &gt; Enable X11 Forwarding</tt>, and connect to one of the student machines.

<h2>Getting Started</h2>

Download the following files and put them in your working directory:
<dir>
<li> <a href=gfx.c>gfx.c</a> (the source file: read if you like, but don't change)
<li> <a href=gfx.h>gfx.h</a> (the header file: read if you like, but don't change)
<li> <a href=example.c>example.c</a> (an example program: go ahead and change this)
</dir>
<p>
To compile a program that uses the <tt>gfx</tt> library, you need to
use the following command, which compiles your program with <tt>gfx.c</tt>
then adds the X11 and math libraries.  (X11 is short for the X Window System used on Unix based machines.)

<div class=code>gcc example.c gfx.c -o example -lX11 -lm</div>

Run the example program, and you should see a window pop up with a green triangle.  

<div class=code>./example</div>

<h2>Line by Line Example</h2>

To give you the idea of how to use the library, we will point out
the important parts of <tt>example.c</tt> in detail.  Then, below
you can read about how the individual functions work.
<p>
Begin by including <tt>gfx.h</tt>, to make the library available to the program.  Note that quotes rather than angle brackets are used in this statement.  Quotes indicate the header file is in the current directory, rather than in some system-defined place.

<div class=code>#include "gfx.h"</div>

To open a graphics window, call <tt>gfx_open</tt> once at the beginning of the program, giving the width and height of the window in pixels, and the title of the window on the screen:

<div class=code>gfx_open(xsize,ysize,"Example Graphics Program");</div>

<tt>gfx_color</tt> sets the current drawing color to a pale green:

<div class=code>gfx_color(0,255,0);</div>

Now, use the <tt>gfx_line</tt> function to draw a line from (100,100) to (200,100):

<div class=code>gfx_line(100,100,200,100);</div>

Wait for the user to press a key (or button):

<div class=code>c = gfx_wait();</div>

If the key is the letter 'q', break out of the loop:

<div class=code>if(c=='q') break;</div>

That shows you enough to get started.
There are a few more useful functions in the library,
read the following section to see them all.

<h2>Function Reference</h2>

<div class=func>void gfx_open( int width, int height, const char *title );</div>

<tt>gfx_open</tt> creates a new graphics window on the screen.
<tt>width</tt> is the width of the window in pixels.
<tt>height</tt> is the height of the window in pixels.
<tt>title</tt> is the name of the window in the title bar.

<div class=func>void gfx_line( int x1, int y1, int x2, int y2 );</div>

<tt>gfx_line</tt> draws a line in the graphics window, using the
current color, from location <tt>x1,y1</tt> to <tt>x2,y2</tt>

<div class=func>void gfx_color( int red, int green, int blue );</div>

<tt>gfx_color</tt> sets the current color for drawing, using the <a href=http://en.wikipedia.org/wiki/RGB_color_model>RGB color model</a>, in which you mix red, green, and blue components in order to get the desired color.  <tt>gfx_color</tt> takes three integers between 0 and 255, each representing red, green, and blue.  The following are some example colors:

<center>
<table>
<tr><th>Red<th>Green<th>Blue<th>Color Name
<tr><td>255<td>0<td>0<td>Red
<tr><td>0<td>255<td>0<td>Green
<tr><td>0<td>0<td>255<td>Blue
<tr><td>255<td>255<td>0<td>Yellow
<tr><td>255<td>255<td>255<td>White
<tr><td>100<td>100<td>100<td>Gray
<tr><td>0<td>0<td>0<td>Black
</table>
</center>

<div class=func>void gfx_clear();</div>

<tt>gfx_clear</tt> clears the window to the current background color,
which is black by default.

<div class=func>void gfx_clear_color( int red, int green, int blue );</div>

<tt>gfx_clear_color</tt> changes the background color, using
the same format as <tt>gfx_clear</tt> above.  The new background
color takes effect the next time <tt>gfx_clear</tt> is called.

<div class=func>char gfx_wait();</div>

<tt>gfx_wait</tt> waits until the user presses a key or mouse button.
If the user has pressed a mouse button, the integer 1, 2, or 3 will be returned,
indicating the button pressed.  If the user has pressed a key, that character
will be returned.  To determine the mouse location at that time, call <tt>gfx_xpos</tt> and <tt>gfx_ypos</tt>.

<div class=func>int gfx_xpos();
int gfx_ypos();
</div>

<tt>gfx_xpos()</tt> and <tt>gfx_ypos</tt> return the X and Y coordinates, respectively, of the mouse pointer
when the last key or button was pressed.

<div class=func>int gfx_event_waiting();</div>

<tt>gfx_wait</tt> causes the program to wait until something is pressed,
which can be inconvenient in a real-time program.  To avoid this, call
<tt>gfx_event_waiting</tt>, which returns true if an event (key or button press)
has occurred, otherwise returns false immediately.  If it returns true, then
you can call <tt>gfx_wait</tt> to retrieve the event without waiting.

<div class=func>void gfx_flush();</div>

<tt>gfx_flush</tt> flushes all output to the graphics window.
This forces all previous drawing commands to take effect.
Output is normally flushed after a called to <tt>gfx_wait</tt>.
If your program does not call <tt>gfx_wait</tt> then you need
to call <tt>gfx_flush</tt> after drawing to the screen.

</body>
</html>
