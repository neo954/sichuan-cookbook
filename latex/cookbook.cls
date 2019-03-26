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

\def\ingredient#1{\def\@ingredientl{#1}}
\def\@ingredient{}

\newenvironment{recipe}{\begingroup
}{\endgroup}

\newenvironment{cookbook}{\begingroup
}{\endgroup}

% Disable chapter, section and subsection numbering
%\setcounter{secnumdepth}{0} 
