![header-logo](https://cloud.githubusercontent.com/assets/2619031/21511755/0dcd98dc-cca5-11e6-86bf-d5b07a477523.png)

APNGb
=====
APNGb is a macOS app which creates animated png from a series of png frames and disassembles animated png into a series of png frames. Assembling has optimization and compression capabilities, option to change frame delay for all or selected frames, playback options. See `Assembling feature` and `Disassembling feature` sections for more details.

* Compatibility: macOS 10.11 and later
* Over 1.5k downloads (sourceforge statistics)


 **It's built on the top of 2 executables created by Max Stepin: [APNG Assembler](http://apngasm.sourceforge.net) and [APNG Disassembler](http://apngdis.sourceforge.net). Big credits to Max!**

What is apng ?
------
> The Animated Portable Network Graphics (APNG) file format is an extension to the Portable Network Graphics (PNG) specification. It allows for animated PNG files that work similarly to animated GIF files, while supporting 24-bit images and 8-bit transparency not available for GIFs. It also retains backward compatibility with non-animated PNG files.

Why apng is better than gif ?
------
Both GIF and APNG are lossless, but APNG tend to be smaller in size and provides better image quality (color, transparency). APNG is supported by web-browsers like Safari (both macOS and iOS), Firefox (desktop and Android), Chrome (add-ons), Opera (v12 and earlier).

Take a look at below examples:

![world-cup-2014-42](https://cloud.githubusercontent.com/assets/2619031/21534194/c3e98950-cd63-11e6-84ed-043c16400368.png)

APNG = 30 823 bytes

![world-cup-2014-42](https://cloud.githubusercontent.com/assets/2619031/21534196/c4b08316-cd63-11e6-8ae1-82aaf2a5cc95.gif)

GIF = 43 132 bytes

Assembling feature
------
Creates an animated apng/png from a series of png images.

> A number of optimization techniques used to make APNG files as small as possible: inter-frame optimization utilizing alpha-blend and dispose operations, smaller than the full-size subframes, dirty transparency, color type and palette optimizations, and various compression options: zlib, 7zip, Zopfli.

Disassembling feature
------
Breaks an apng/png file into a series of png images.

> Decoding is implemented by parsing all chunks in the APNG file, remuxing them into a sequence of static PNG images, as shown in the diagram below, and then using regular (unpatched) libpng to decode them.
Then, after processing blend/dispose operations, we finally get a vector of full-size frames in 32 bpp as the result.

Few app screenshots
-----
 <iframe src="http://albumizr.com/a/qznS" scrolling="no" frameborder="0" allowfullscreen width="700" height="400"></iframe>

TO DO
------
* Add unit tests.
* Convert GIF to APNG.
* Optimize apng file.

License
------
* MIT License, Copyright (c) 2016 Stefan Godoroja.
* APNG Assembler and APNG Disassembler are released under zlib/libpng license.
[More details](https://github.com/mancunianetz/APNGb/blob/master/LICENSE)
