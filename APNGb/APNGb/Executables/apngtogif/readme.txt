  APNG to GIF Converter 1.8

  This program converts APNG animations into animated GIF format.
  Wu quantizer is used for true-color files.

  http://apng2gif.sourceforge.net/

  Copyright (c) 2010-2017 Max Stepin
  maxst@users.sourceforge.net

  License: zlib license

--------------------------------

  Changes in version 1.8:

- Improved APNG decoder based on apngdis 2.9

- Adjusted number of loops

- Duplicate frames optimization

- 64 bit biraries for Windows

--------------------------------

  Usage (for command-line version): 

apng2gif anim.png [anim.gif] [-t tlevel] [-b bcolor]

  Options:

-t 128 

  will set the transparency threshold level as 128, so pixels 
  with alpha level less than 128 will become fully transparent.

-b 255 0 0 
-b "#ff0000"

  will set the background color as red, so partially transparent 
  pixels will be composed over red. When -b is used, -t is ignored.

  When no options are specified, default threshold is 128, 
  no background color.
