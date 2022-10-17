--------------------------------------------------------------
 rcs-multi
 version 0.1, Mar 23rd, 2009
--------------------------------------------------------------

This package lets you typeset keywords of the version
control system RCS inside your LaTeX files anywhere
you like. Like the very similar package 'svn-multi' the usage of
multiple files for one LaTeX document is well supported.

Copyright (C) 2009 Martin Scharrer
E-mail: martin@scharrer-online.de
WWW: http://www.scharrer-online.de/latex/rcs-multi/

This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3c
of this license or (at your option) any later version.
The latest version of this license is in
  http://www.latex-project.org/lppl.txt
and version 1.3c or later is part of all distributions of LaTeX
version 2008/05/04 or later.

This work has the LPPL maintenance status `maintained'.

The Current Maintainer of this work is Martin Scharrer.



Tiny example:
~~~~~~~~~~~~~
Put the following RCS keyword at the start of all your LaTeX files of
your document:

\rcsid{$Id$}

RCS will expand the keyword the next time the files are committed and
then the RCS information can be typeset using
    \rcsauthor, \rcsrev, \rcsdate, \rcshour, ...
which will hold the information of the latest comitted file
anywhere in your multi-file LaTeX document.

Also per-file macros exist:
    \rcsfileauthor, \rcsfilerev, ...
which hold the keyword values of the current file.


INSTALL:
~~~~~~~~
From the .dtx file (if you don't get the .sty files directly):
==================
Unpack the zip file and run 'make'.
You also can do it manually:
  [pdf]latex rcs-multi.ins      # for the style file and perl script
  [pdf]latex rcs-multi.dtx      # for the documentation
2x[pdf]latex example-main       # for the example

Place the .sty file rcs-multi.sty into your TEXMF tree, e.g. in
  $TEXMF/tex/latex/rcs-multi

