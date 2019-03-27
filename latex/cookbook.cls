% $Id: cookbook.cls 639 2019-06-08 07:55:01Z neo $
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cookbook}
\typeout{Document Style `cookbook' <Mar 25, 2019>.}
\LoadClass{book}
\pagestyle{empty}
\usepackage[a5paper,
	tmargin=33mm, bmargin=27mm,
	lmargin=26mm, rmargin=26mm,
	nohead, nofoot]{geometry}
\usepackage{CJKutf8}
\usepackage[T1]{fontenc}
\usepackage{makeidx}
\usepackage{xcolor}
\usepackage{graphicx}
\usepackage{wrapfig}
\usepackage{titlesec}
\usepackage{xstring}
\usepackage[encoding=UTF8]{zhnumber}

\newcommand\category[1]{%
\chapter*{#1}%
\thispagestyle{empty}
\addcontentsline{toc}{chapter}{#1}
}

\newcommand{\sectionseq}[1]{
\StrBehind[1]{#1}{.}[\seq]
\zhdigits{\seq}
}

\newcommand{\subsectionseq}[1]{%
\StrBehind[2]{#1}{.}[\seq]
\zhdigits{\seq}
}

\titleformat{\chapter}[display]
{\huge\filcenter\bfseries}	% Format
{}	% Label
{0em}	% Sep
{}	% Before
[\vspace{-1.2\baselineskip}]	% After

\titleformat{\section}[hang]
{\LARGE\filcenter\bfseries}	% Format
{\sectionseq{\thesection}}	% Label
{0em}	% Sep
{、}	% Before
[]	% After

\titleformat{\subsection}[hang]
{\normalsize\bfseries}	% Format
{\subsectionseq{\thesubsection}}	% Label
{0em}	% Sep
{、}	% Before
[]	% After

\newenvironment{recipe}[1]{
\section{#1}
}{}

\newenvironment{ingredients}{
\subsection{原料}
\begin{CJK*}{UTF8}{gkai}
\begin{tabbing}
\hspace{30mm}\= \kill
}{
\end{tabbing}
\end{CJK*}
\vspace{-2\baselineskip}
}

\newcommand{\ingredient}[2]{%
#1
\>#2\\
}

\newenvironment{method}{
\subsection{制作方法}
\begin{enumerate}
}{
\end{enumerate}
}

\newenvironment{note}{
\subsection{特点}
}{}



\newenvironment{cookbook}{
\begin{CJK*}{UTF8}{gbsn}
\renewcommand*\contentsname{目录}
}{
\clearpage
\end{CJK*}
}
