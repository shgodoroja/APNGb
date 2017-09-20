  APNG Assembler 2.91

  Creates APNG animation from PNG/TGA image sequence.

  http://apngasm.sourceforge.net/

  Copyright (c) 2010-2016 Max Stepin
  maxst@users.sourceforge.net

  License: zlib license

--------------------------------


  Changes in version 2.91:

- Code refactoring, some small optimizations
- CLI: Support for image strips as input
- GUI for Windows: progress bar bug fixed
- 64 bit biraries for Windows

  Changes in version 2.9:

- Duplicate frames optimization (add frame delays)

  Changes in version 2.8:

- Added 7zip and Zopfli compression options
- Added GUI version for Windows

  Changes in version 2.7:

- Better optimization after loading paletted PNG files

  Changes in version 2.6:

- Fixed a bug with loading 1,2,4-bit paletted PNG files

  Changes in version 2.5:

- Fixed a bug with loading mode2 or mode0 input files with tRNS

  Changes in version 2.4:

- Reads delay information from .txt files
- Accepts input files of different color types
- Better optimization
- zlib license

--------------------------------

Usage:

apngasm output.png frame001.png [options]
apngasm output.png frame*.png   [options]

Options :
1 10    : frame delay is 1/10 sec. (default)
-l2     : 2 loops (default is 0, forever)
-f      : skip the first frame
-hs##   : input is horizontal strip of ## frames (example: -hs12)
-vs##   : input is vertical strip of ## frames   (example: -vs12)
-kp     : keep palette
-kc     : keep color type
-z0     : zlib compression
-z1     : 7zip compression (default)
-z2     : Zopfli compression
-i##    : number of iterations (default -i15)

----------------------------------------------------------------
Example 1:

Let's say you have following frame sequence:
frame01.png
frame02.png
frame03.png

And you want to have 3/4 seconds delay between frames.
The correct command will be

apngasm output.png frame01.png 3 4


If frame02.txt is found with the following one-line content,
it will override delay information for frame 2:

delay=25/100

----------------------------------------------------------------
Example 2:

The same as above, but you added "invisible" frame00.png :
frame00.png - invisible
frame01.png
frame02.png
frame03.png

The correct command will be

apngasm output.png frame00.png 3 4 /f

That way APNG supported browsers and image viewers
will show frame01-frame02-frame03 animation,
while IE will display static frame00.png image.

----------------------------------------------------------------
Example 3:

apngasm output.png frame01.png

That way you'll get 1/10 sec delay.

----------------------------------------------------------------
Example 4:

Using this 2900x100 "filmstrip" image as input:
https://abs.twimg.com/a/1470716385/img/animations/web_heart_animation.png

apngasm output.png web_heart_animation.png -hs29

Switch -hs29 specifies that input is horizontal strip of 29 frames

----------------------------------------------------------------
Some optimizations used in APNG Assembler might re-sort the
palette, or change the color type from RGBA and RGB modes
to RGB and indexed modes. Those optimizations are only performed
when they are lossless, but if you want to avoid changing the
palette or colortype, use those switches to turn them off:

/kp     : keep palette
/kc     : keep color type

