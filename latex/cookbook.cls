% $Id: cookbook.cls 639 2019-06-08 07:55:01Z neo $
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cookbook}
\typeout{Document Style `cookbook' <Mar 25, 2019>.}
\LoadClass{article}
\pagestyle{empty}
\usepackage[a5paper,
	tmargin=33mm, bmargin=27mm,
	lmargin=26mm, rmargin=26mm,
	nohead, nofoot]{geometry}
\usepackage{CJKutf8}
\usepackage[T1]{fontenc}
\usepackage{graphicx}
\usepackage{wrapfig}

\newenvironment{recipe}[1]{
\subsection{#1}
}{}

\newenvironment{ingredients}{
\textbf{一、原料：\\}
\begin{tabbing}
\hspace{38mm}\= \kill
}{
\end{tabbing}
}

\newcommand{\ingredient}[2]{
#1
\>#2\\
}

\newenvironment{method}{
\textbf{二、制作方法：\\}
\begin{enumerate}
}{
\end{enumerate}
}

\newenvironment{note}{
\textbf{三、特点：}\\
}{}

\newenvironment{cookbook}{
\begin{CJK*}{UTF8}{gbsn}
}{
\clearpage
\end{CJK*}
}

% Disable chapter, section and subsection numbering
%\setcounter{secnumdepth}{0} 
