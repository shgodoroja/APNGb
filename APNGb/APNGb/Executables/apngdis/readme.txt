  APNG Disassembler 2.9

  Deconstructs APNG files into individual frames.

  http://apngdis.sourceforge.net/

  Copyright (c) 2010-2017 Max Stepin
  maxst@users.sourceforge.net

  License: zlib license

--------------------------------

  Usage:

apngdis anim.png [name]

--------------------------------

Decoding is implemented by parsing all chunks in the APNG file,
remuxing them into a sequence of static PNG images, and then using
regular (unpatched) libpng to decode them.

Then, after processing blend/dispose operations, we get a vector of
full-size frames in 32 bpp as the result.



Other useful tools:

APNG Assembler     -  http://apngasm.sourceforge.net/
gif2apng converter -  http://gif2apng.sourceforge.net/
