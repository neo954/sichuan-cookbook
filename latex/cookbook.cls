% BSD 3-Clause License
%
% Copyright (C) 2019 GONG Jie <gongjie.jie@gmail.com>
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% 1. Redistributions of source code must retain the above copyright notice, this
%    list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright notice,
%    this list of conditions and the following disclaimer in the documentation
%    and/or other materials provided with the distribution.
%
% 3. Neither the name of the copyright holder nor the names of its
%    contributors may be used to endorse or promote products derived from
%    this software without specific prior written permission.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
% DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
% FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
% DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
% SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
% OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cookbook}
\typeout{Document Style `cookbook' <Mar 25, 2019>.}
\LoadClass{book}
\usepackage[
	paper=a5paper,
	top=34mm,
	bottom=30mm,
	inner=28mm,
	outer=28mm,
	headheight=5mm,
	headsep=2mm,
	footskip=5mm
]{geometry}
\usepackage{xeCJK}
	\xeCJKDeclareSubCJKBlock{Tofu}{
		`𤆵
	}
	\setCJKmainfont[
		BoldFont=Noto Serif CJK SC Medium,
		Tofu=Noto Sans CJK SC,
		FallBack=Noto Sans CJK SC
	]{Noto Serif CJK SC}
	\setCJKsansfont[
		BoldFont=Noto Sans CJK SC Bold
	]{Noto Sans CJK SC Medium}
	\setCJKmonofont{Noto Sans Mono CJK SC}
	\newCJKfontfamily[kai]\kafamily{FandolKai-Regular.otf}
\usepackage[T1]{fontenc}
\usepackage[encoding=UTF8]{zhnumber}
\usepackage{tocloft}
\usepackage{makeidx}
\usepackage{fancyhdr}
	\pagestyle{fancy}
\usepackage{xcolor}
\usepackage{graphicx}
\usepackage{wrapfig}
\usepackage{titlesec}
\usepackage{setspace}
\usepackage{ifthen}

\newenvironment{cookbook}{%
	\titleformat{\chapter}[display]{%
	%	Format
		\Huge\filcenter\sffamily\bfseries%
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
		\LARGE\filcenter\rmfamily\bfseries%
	}{%	Label
		\ifthenelse{\value{chapter}>999}{%
		}{%
			\zhdigits{\arabic{section}}%
		}%
	}{%	Sep
		0em
	}{%	Before-code
		\ifthenelse{\value{chapter}>999}{%
		}{%
			{、}%
		}%
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
		\normalsize\sffamily%
	}{%	Label
		\zhdigits{\arabic{subsection}}%
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

	% A temporary variable, use to store the text width of the chapter name
	\newlength{\headerwidth}%

	\newcommand\category[1]{%
		% Calculate the text width of the chapter name
		\settowidth{\headerwidth}{##1}%
		\ifthenelse{\lengthtest{\headerwidth<5em}}{%
			\chapter*{\makebox[5em][s]{##1}}%
		}{%
			\chapter*{##1}%
		}
		\thispagestyle{fancy}%
		\addcontentsline{toc}{chapter}{%
			% Use different text for the table of contents and bookmarks
			\texorpdfstring{\makebox[10em][s]{##1}}{##1}%
		}%
		\setlength{\headerwidth}{0pt}%
	}

	\newcommand\division[1]{%
		\settowidth{\headerwidth}{##1}%
		\subsection[##1]{\makebox[4em][s]{##1}：}
		\setlength{\headerwidth}{0pt}%
	}

	\newenvironment{recipe}[2][]{%
		\newcommand{\ingredients}{%
			\division{原料}%
		}

		\newcommand{\ingredient}[2]{%
			{%
				\kafamily%
				\noindent%
				\mbox{%
					\hspace{2em}%
					\makebox[9em][s]{%
						\mbox{####1}\hfil\mbox{####2}%
					}%
					\hspace{2em}%
				}%
			}%
		}

		\newcommand{\step}{%
			\stepcounter{step}%
			\par\arabic{step}.%
		}

		\newcommand{\cooking}{%
			\division{制作方法}%
		}

		\newcommand{\notice}{%
			\division{注意事项}%
		}

		\newcommand{\notes}{%
			\division{特点}%
		}

		\ifthenelse{\value{chapter}>999}{%
			\section[##2]{\makebox[5em][s]{##2}}
		}{%
			\section[%
				% Use different text for the table of contents and bookmarks
				\texorpdfstring{\zhdigits{\arabic{section}}、##2}{##2}%
			]{\makebox[5em][s]{##2}}
		}%
		\ifthenelse{\equal{##1}{}}{%
		}{%
			\begin{center}%
			\sffamily（原##1）%
			\end{center}%
		}%
	}{%
		\vspace{1\baselineskip}
	}

	% A new counter used in the command \step
	\newcounter{step}[subsection]

	% Customize the head and foot
	\fancyhead{}	% Clear all fields
	\fancyfoot{}	% Clear all fields
	\fancyhead[RO,LE]{}
	% Customize the page numbers
	\fancyfoot[LE,RO]{%
		\hspace{2em}%
		{‧\makebox[2em][s]{\hfil\mbox{\thepage}\hfil}‧}%
		\hspace{2em}%
	}
	\fancyfoot[LO,CE]{}
	\fancyfoot[CO,RE]{}
	\renewcommand{\headrulewidth}{0pt}
	\renewcommand{\footrulewidth}{0pt}

	% Customize the table of contents
	\tocloftpagestyle{fancy}
	\setlength{\cftbeforetoctitleskip}{0pt}
	\setlength{\cftaftertoctitleskip}{0pt}
	% Centering table of contents title by using \hfil
	\renewcommand{\cfttoctitlefont}{\hfil\Large\rmfamily}
	\renewcommand{\cftaftertoctitle}{\hfil}
	\renewcommand{\cftdot}{…}
	\renewcommand\cftdotsep{0.2}
	\cftsetpnumwidth{1.5em}
	\cftsetrmarg{1.6em}
	% Centering chapter titles by using \hfil
	\renewcommand{\cftchapfont}{\hfil\normalsize\sffamily}
	\renewcommand{\cftchapafterpnum}{\hfil}
	\setlength{\cftchapindent}{1.6em}
	\setlength{\cftchapnumwidth}{0em}
	\renewcommand{\cftsecfont}{\normalsize\rmfamily}
	\renewcommand{\cftsecpagefont}{\normalsize\rmfamily}
	\renewcommand{\cftsecpresnum}{}
	\renewcommand{\cftsecaftersnum}{}
	\setlength{\cftsecindent}{0em}
	\setlength{\cftsecnumwidth}{0em}
	\renewcommand{\thechapter}{}
	\renewcommand{\thesection}{}
	\renewcommand{\thesubsection}{}
	\renewcommand\cftsecdotsep{\cftdotsep}
	\renewcommand\contentsname{%
		% Use different text for the table of contents and bookmarks
		\texorpdfstring{%
			\makebox[\textwidth][s]{
				\hfil\makebox[5em][s]{目录}\hfil%
			}%
		}{目录}%
	}
	\setcounter{tocdepth}{1}
	\addtocontents{toc}{\cftpagenumbersoff{chapter}}
	\addtocontents{toc}{\cftpagenumberson{section}}

	% Set the indentation to be two Chinese characters size.
	\setlength{\parindent}{2em}
	\setlength{\parskip}{0pt}
	% Set line spacing
	\onehalfspacing
}{%
}

% vim: filetype=tex noautoindent
% vim: fileencoding=utf-8
% vim: textwidth=78 tabstop=4 shiftwidth=4 softtabstop=4
