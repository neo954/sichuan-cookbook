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
\usepackage[open]{bookmark}
\usepackage{tocloft}
\usepackage{makeidx}
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

	\newlength{\headerwidth}%

	\newcommand\category[1]{%
		\settowidth{\headerwidth}{##1}%
		\ifthenelse{\lengthtest{\headerwidth<5em}}{%
			\chapter*{\makebox[5em][s]{##1}}%
		}{%
			\chapter*{##1}%
		}
		\thispagestyle{empty}%
		\addcontentsline{toc}{chapter}{##1}%
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
			\section[\zhdigits{\arabic{section}}、##2]{\makebox[5em][s]{##2}}
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

	\newcounter{step}[subsection]
	\tocloftpagestyle{plain}
	\setlength{\cftbeforetoctitleskip}{0pt}
	\setlength{\cftaftertoctitleskip}{0pt}
	\renewcommand{\cfttoctitlefont}{\hfil\Large\rmfamily}
	\renewcommand{\cftaftertoctitle}{\hfil}
	\renewcommand{\cftchapfont}{\normalsize\sffamily}
	\renewcommand{\cftsecfont}{\normalsize\rmfamily}
	\renewcommand{\cftsecpagefont}{\normalsize\rmfamily}
	\renewcommand{\cftsecpresnum}{}
	\renewcommand{\cftsecaftersnum}{}
	\setlength{\cftsecindent}{0em}
	\setlength{\cftsecnumwidth}{0em}
	\renewcommand{\thechapter}{}
	\renewcommand{\thesection}{}
	\renewcommand{\thesubsection}{}
	\renewcommand*\contentsname{\makebox[5em][s]{目录}}
	\setcounter{tocdepth}{1}
	\addtocontents{toc}{\cftpagenumbersoff{chapter}}
	% Setting the indentation to be two Chinese characters size.
	\setlength{\parindent}{2em}
	\setlength{\parskip}{0pt}
	\onehalfspacing
}{%
}

% vim: filetype=tex noautoindent
% vim: fileencoding=utf-8
% vim: textwidth=78 tabstop=4 shiftwidth=4 softtabstop=4
