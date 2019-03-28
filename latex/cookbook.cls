% $Id$
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cookbook}
\typeout{Document Style `cookbook' <Mar 25, 2019>.}
\LoadClass{book}
\pagestyle{empty}
\usepackage[
	a5paper,
	tmargin=33mm,
	bmargin=27mm,
	lmargin=26mm,
	rmargin=26mm,
	nohead,
	nofoot
]{geometry}
\usepackage{CJKutf8}
\usepackage[T1]{fontenc}
\usepackage{makeidx}
\usepackage{xcolor}
\usepackage{graphicx}
\usepackage{wrapfig}
\usepackage{titlesec}
\usepackage[encoding=UTF8]{zhnumber}

\titleformat{\chapter}[display]{%
%	Format
	\huge\filcenter\bfseries
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
	\LARGE\filcenter\bfseries
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
	\normalsize\bfseries
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
	\begin{CJK*}{UTF8}{gkai}
	\begin{tabbing}
	\hspace{30mm}\= \kill
}{%
	\end{tabbing}
	\end{CJK*}
	\vspace{-2\baselineskip}
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
	\begin{CJK*}{UTF8}{gbsn}
	\renewcommand*\contentsname{目录}
}{%
	\clearpage
	\end{CJK*}
}
