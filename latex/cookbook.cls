% $Id$
%
% Copyright (C) 2019 by GONG Jie <gongjie.jie@gmail.com>
%
% Permission to use, copy, modify, and/or distribute this software for any
% purpose with or without fee is hereby granted.
%
% THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
% WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
% MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
% SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
% WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
% OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
% CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cookbook}
\typeout{Document Style `cookbook' <Mar 25, 2019>.}
\LoadClass{book}
\pagestyle{empty}
\usepackage[
	a5paper,
	tmargin=34mm,
	bmargin=28mm,
	lmargin=28mm,
	rmargin=28mm,
	nohead,
	nofoot
]{geometry}
\usepackage{xeCJK}
\setCJKmainfont[BoldFont=FandolSong-Bold.otf]{FandolSong-Regular.otf}
\setCJKsansfont[BoldFont=FandolHei-Bold.otf]{FandolHei-Regular.otf}
\setCJKmonofont{FandolFang-Regular.otf}
\newCJKfontfamily\script{FandolKai-Regular.otf}
\usepackage[T1]{fontenc}
\usepackage{makeidx}
\usepackage{xcolor}
\usepackage{graphicx}
\usepackage{wrapfig}
\usepackage{titlesec}
\usepackage{setspace}
\usepackage[encoding=UTF8]{zhnumber}

\titleformat{\chapter}[display]{%
%	Format
	\huge\filcenter\sffamily
}{%	Label
}{%	Sep
	0em
}{%	Before-code
}[%	After-code
]

\titlespacing{\chapter}{%
%	Left
	0pt
}{%	Before-sep
	0pt
}{%	After-sep
	0pt
}[%	Right-sep
	0pt
]

\titleformat{\section}[hang]{%
%	Format
	\LARGE\filcenter\rmfamily
}{%	Label
	\zhdigits{\arabic{section}}
}{%	Sep
	0em
}{%	Before-code
	{、}%
}[%	After-code
]

\titlespacing{\section}{%
%	Left
	0pt
}{%	Before-sep
	0pt
}{%	After-sep
	0pt
}[%	Right-sep
	0pt
]

\titleformat{\subsection}[hang]{%
%	Format
	\normalsize\sffamily
}{%	Label
	\zhdigits{\arabic{subsection}}
}{%	Sep
	0em
}{%	Before-code
	{、}%
}[%	After-code
]

\titlespacing{\subsection}{%
%	Left
	0pt
}{%	Before-sep
	0pt
}{%	After-sep
	0pt
}[%	Right-sep
	0pt
]

\newcommand\category[1]{%
	\chapter*{#1}
	\thispagestyle{empty}
	\addcontentsline{toc}{chapter}{#1}
}

\newenvironment{recipe}[1]{%
	\section{#1}
}{}

\newenvironment{ingredients}{%
	\subsection{原料}
	\script%
	\begin{tabbing}
	\hspace{30mm}\= \kill
}{%
	\end{tabbing}
}

\newcommand{\ingredient}[2]{%
	#1
	\>#2\\
}

\newenvironment{method}{%
	\subsection{制作方法}
	\begin{enumerate}
}{%
	\end{enumerate}%
}

\newenvironment{note}{%
	\subsection{特点}
}{}

\newenvironment{cookbook}{%
	\renewcommand*\contentsname{目录}
	% Setting the indentation to be two Chinese characters size.
	\setlength{\parindent}{2em}
	\setlength{\parskip}{0pt}
	\onehalfspacing
}{%
	\clearpage
}

% vim: filetype=tex noautoindent
% vim: fileencoding=utf-8
% vim: textwidth=78 tabstop=4 shiftwidth=4 softtabstop=4
