%&latex
\ProvidesClass{pkgtest}[2009/03/13 v0.1 Test suite for LaTeX packages]
% Copyright (c) 2009 - Martin Scharrer <martin@scharrer-online.de>
% This file is under the LaTeX Project Public Licence (LPPL) v1.3c or later.

\def\pkgtest@class{report}

\DeclareOption{article}{\def\pkgtest@class{article}}
\DeclareOption{book}{\def\pkgtest@class{book}}
\DeclareOption{report}{\def\pkgtest@class{report}}

\ProcessOptions\relax

\LoadClassWithOptions{\pkgtest@class}
\RequirePackage{pkgtest}

