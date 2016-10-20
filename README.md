![logo](https://cloud.githubusercontent.com/assets/2619031/19565678/09137412-96e8-11e6-8e8a-5311ee4e9d74.png)
APNGb
=====
APNGb is a mac OS app which creates animated pngs from a series of png/tga images and disassembles an animated png into a series of png files. Assembling has optimization and compression capabilities, option to change frame delay for all or separated frames, playback options. See `Assembling feature` and `Disassembling feature` sections for more details.

 **It's built on the top of 2 executables created by Max Stepin: [APNG Assembler](http://apngasm.sourceforge.net) and [APNG Disassembler](http://apngdis.sourceforge.net). Big credits to Max!**

What is .apng ?
------
> The Animated Portable Network Graphics (APNG) file format is an extension to the Portable Network Graphics (PNG) specification. It allows for animated PNG files that work similarly to animated GIF files, while supporting 24-bit images and 8-bit transparency not available for GIFs. It also retains backward compatibility with non-animated PNG files.

Quality and size of .apng vs .gif
------
![genevadrive](https://cloud.githubusercontent.com/assets/2619031/19500576/db1f585e-959e-11e6-8503-1413e8f6f8ae.png)

APNG = 193 101 bytes

![genevadrive](https://cloud.githubusercontent.com/assets/2619031/19500577/dd662638-959e-11e6-91ae-feec506f5879.gif)

GIF = 229 346 bytes

Assembling feature
------
Creates an animated image (.apng) from a series of .png/.tga images.

> A number of optimization techniques used to make APNG files as small as possible: inter-frame optimization utilizing alpha-blend and dispose operations, smaller than the full-size subframes, dirty transparency, color type and palette optimizations, and various compression options: zlib, 7zip, Zopfli.

![screen shot 2016-10-19 at 02 25 43](https://cloud.githubusercontent.com/assets/2619031/19501211/e63b3906-95a3-11e6-8d92-5b20bd16a668.png)
![screen shot 2016-10-19 at 02 27 30](https://cloud.githubusercontent.com/assets/2619031/19501212/e63d3738-95a3-11e6-89d0-2721676921fe.png)

Disassembling feature
------
Breaks an .apng file into a series of .png images.

> Decoding is implemented by parsing all chunks in the APNG file, remuxing them into a sequence of static PNG images, as shown in the diagram below, and then using regular (unpatched) libpng to decode them.
Then, after processing blend/dispose operations, we finally get a vector of full-size frames in 32 bpp as the result.

![screen shot 2016-10-19 at 02 27 33](https://cloud.githubusercontent.com/assets/2619031/19501213/e63edb92-95a3-11e6-9bf3-f9f3d5846541.png)
![screen shot 2016-10-19 at 02 27 41](https://cloud.githubusercontent.com/assets/2619031/19501210/e6165b54-95a3-11e6-9a31-7986e47fdeb7.png)
TO DO
------
* Add unit tests.
* Improve UX design.
* Convert GIF to APNG.
* Optimize an apng file.

Credits
-------
- Once again many thanks to [Max Stepin](https://sourceforge.net/u/maxst/profile/)

- Icon for app app was downloaded from flaticon.com
> <div>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

License
------

APNG Assembler and APNG Disassembler are released under zlib/libpng license.

MIT License, Copyright (c) 2016 Stefan Godoroja

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
