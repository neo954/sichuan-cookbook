% BSD 3-Clause License
%
% Copyright (c) 2023, 2024 Quux System and Technology. All rights reserved.
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
	[2024/02/26 v1.0.2 XeLaTeX document class]
\LoadClass[openany]{book}
\usepackage[
	paper=a5paper,
	top=25.845833mm,
	bottom=35.802408mm,
	inner=25.845833mm,
	outer=25.845833mm,
	headheight=5.291666mm,
	headsep=2.116666mm,
	footskip=9.956575mm,
	marginparwidth=15.875mm,
	marginparsep=3.527777mm
]{geometry}
\usepackage[zihao=5]{ctexsize}
\usepackage[quiet]{xeCJK}
	\xeCJKsetup{
		AutoFallBack=true,
		CheckSingle=true,
		CJKecglue={\,}
	}
	\xeCJKDeclareCharClass{CJK}{%
		"24EA,          % Circled Digit Zero
		"2460 -> "2473, % Circled Digit One - Circled Number Twenty
		"3251 -> "325F, % Circled Number Twenty One - Circled Number Thirty Five
		"32B1 -> "32BF  % Circled Number Thirty Six - Circled Number Fifty
	}
	\xeCJKDeclareSubCJKBlock{Ext-A}{
		"3400 -> "4DBF
	}
	\xeCJKDeclareSubCJKBlock{Ext-B}{
		"20000 -> "2A6DF
	}
	\xeCJKDeclareSubCJKBlock{Ext-C}{
		"2A700 -> "2B73F
	}
	\xeCJKDeclareSubCJKBlock{Ext-D}{
		"2B740 -> "2B81F
	}
	\xeCJKDeclareSubCJKBlock{Ext-E}{
		"2B820 -> "2CEAF
	}
	\xeCJKDeclareSubCJKBlock{Ext-F}{
		"2CEB0 -> "2EBEF
	}
	\xeCJKDeclareSubCJKBlock{Ext-I}{
		"2EBF0 -> "2EE5F
	}
	\xeCJKDeclareSubCJKBlock{Supplement}{
		"2F800 -> "2FA1F
	}
	\xeCJKDeclareSubCJKBlock{Ext-G}{
		"30000 -> "3134F
	}
	\xeCJKDeclareSubCJKBlock{Ext-H}{
		"31350 -> "323AF
	}
	\setCJKmainfont[
		BoldFont=Noto Serif CJK SC Medium,
		Ext-B={[AutoFakeBold=1.025]{HanaMinB}},
		Ext-C={[AutoFakeBold=1.025]{HanaMinB}},
		Ext-D={[AutoFakeBold=1.025]{HanaMinB}},
		Ext-E={[AutoFakeBold=1.025]{HanaMinB}},
		Ext-F={[AutoFakeBold=1.025]{HanaMinB}},
		Supplement={[AutoFakeBold=1.025]{HanaMinA}},
		Ext-G={[AutoFakeBold=1.025]{sim-ch_n5100}},
		FallBack={[AutoFakeBold=1.025]{HanaMinA}}
	]{Noto Serif CJK SC}
	\setCJKsansfont[
		BoldFont=Noto Sans CJK SC Bold
	]{Noto Sans CJK SC Medium}
	\setCJKmonofont[
		BoldFont=Noto Sans Mono CJK SC Bold
	]{Noto Sans Mono CJK SC}
	\newCJKfontfamily[fang]\fsfamily[
	]{FandolFang-Regular.otf}
	\newCJKfontfamily[kai]\kafamily[
		Ext-A=TW-Kai,
		Ext-B=TW-Kai-Ext-B,
		Ext-C=TW-Kai-Ext-B,
		Ext-D=TW-Kai-Ext-B,
		Supplement=TW-Kai-Ext-B,
		FallBack=TW-Kai
	]{FandolKai-Regular.otf}
\usepackage[T1]{fontenc}
\usepackage[encoding=UTF8]{zhnumber}
\usepackage{tocloft}
\usepackage{fancyhdr}
\usepackage{imakeidx}
	\makeindex[%
		title=索引,
		noautomatic=true,
		columns=2,
		columnsep=18bp,
	]
	\indexsetup{%
		level=\indextitle,
		firstpagestyle=fancy,
		othercode=,
	}
\usepackage{xcolor}
\usepackage{xparse}
\usepackage{graphicx}
\usepackage{wrapfig}
\usepackage{subcaption}
	% Caption label format
	\DeclareCaptionLabelFormat{cookbook}{图#2}
	% Caption separator style
	\DeclareCaptionLabelSeparator{cookbook}{\hspace{1em}}
	% Caption format
	\DeclareCaptionFormat{cookbook}{%
		\@hangfrom{\kafamily#1#2}%
		\advance\caption@parindent\hangindent\relax%
		\advance\caption@hangindent\hangindent\relax%
		\caption@@par{\kafamily#3}\par%
	}
\usepackage{titlesec}
\usepackage{setspace}
\usepackage{ifthen}
\usepackage{endnotes}
\usepackage{etoolbox}
\usepackage{needspace}
% Empty all blank pages created by \cleardoublepage
\usepackage{emptypage}
	\pagestyle{empty}
\usepackage{nicefrac}
\usepackage{hyperref}
\usepackage{pgffor}

\newenvironment{cookbook}{%
	\titleformat{\chapter}[display]{%
	%	Format
		\huge\filcenter\sffamily\bfseries%
	}{%	Label
	}{%	Sep
		0em
	}{%	Before-code
	}[%	After-code
	]%

	\titlespacing{\chapter}{%
	%	Left
		0pt
	}{%	Before-sep
		1.0625\baselineskip
	}{%	After-sep
		0\baselineskip plus .0625\baselineskip
	}[%	Right-sep
		0pt
	]%

	\titleformat{\section}[hang]{%
	%	Format
		\Large\filcenter\rmfamily\bfseries%
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
	]%

	\titlespacing{\section}{%
	%	Left
		0pt
	}{%	Before-sep
		0pt
	}{%	After-sep
		0pt
	}[%	Right-sep
		0pt
	]%

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
	]%

	\titlespacing{\subsection}{%
	%	Left
		0pt
	}{%	Before-sep
		0pt
	}{%	After-sep
		0pt
	}[%	Right-sep
		0pt
	]%

	% A temporary variable, use to store the text width of the chapter name
	\newlength{\spanwidth}%
	% A temporary variable, use to store the text height of the section name
	\newlength{\spanheight}%

	\newcommand\category[1]{%
		% Calculate the text width of the chapter name
		\settowidth{\spanwidth}{##1}%
		\ifthenelse{\lengthtest{\spanwidth<5em}}{%
			\chapter*{\hbadness=10000\makebox[5em][s]{##1}}%
		}{%
			\chapter*{##1}%
		}%
		\thispagestyle{fancy}%
		\addcontentsline{toc}{chapter}{%
			% Use different text for the table of contents and bookmarks
			\texorpdfstring{\hbadness=10000\makebox[11em][s]{##1}}{##1}%
		}%
		\setlength{\spanwidth}{0pt}%
	}%

	\newcommand\division[1]{%
		\settowidth{\spanwidth}{##1}%
		\subsection[##1]{\hbadness=10000\makebox[4em][s]{##1}：}%
		\setlength{\spanwidth}{0pt}%
	}%

	% The vertical space before and after recipe
	\newlength{\cookbookbeforerecipeskip}%
	\setlength{\cookbookbeforerecipeskip}{0pt}%  Draft default value
	\newlength{\cookbookafterrecipeskip}%
	\setlength{\cookbookafterrecipeskip}{0pt}%  Draft default value

	\NewDocumentEnvironment{recipe}{ O{} m O{} }{%
		% Use endnote instead of footnote
		\let\footnote=\endnote%
		\let\footnotemark=\endnotemark%
		\let\footnotetext=\endnotetext%

		% Allow .9em overfull
		\hfuzz=.9em%

		\newcommand{\ingredients}{%
			\division{原料}%
		}%

		\newcommand{\ingredientindex}[1]{%
			\index{####1}%
		}%

		\NewDocumentCommand{\ingredient}{ m O{} m }{%
			\hfuzz=1.5em% Suppress the overfull \hbox warning
			\begingroup%
			\hfuzz=13em%  Suppress the overfull \hbox warning
			\kafamily%
			\noindent%
			\settowidth{\spanwidth}{####1####3}%
			\ifthenelse{\lengthtest{\spanwidth>11em}}{%
				\ifthenelse{\isodd{\value{step}}}{%
					\\%
					\stepcounter{step}%
				}{%
				}%
			}{%
			}%
			\ingredientindex{####1}%
			\mbox{%
				\hspace{2em}%
				\makebox[9em][s]{%
					\mbox{####1####2}\hfil\mbox{\null####3}%
				}%
				\hspace{2em}%
			}%
			\stepcounter{step}%
			\ifthenelse{\lengthtest{\spanwidth>11em}}{%
				\mbox{\hspace{14em}}%
				\stepcounter{step}%
			}{%
			}%
			\endgroup%
			\hspace{.001pt minus .001pt}% Teeny-tiny hspace to fill the gap
			\ignorespaces%
		}%

		\newcommand{\preparation}{%
			\Needspace*{1.666666\baselineskip}%
			\division{制作方法}%
		}%

		% With one optional argument
		\newcommand{\step}[1][]{%
			\stepcounter{step}%
			\par\arabic{step}.\,%
			\ifthenelse{\equal{####1}{}}{%
			}{%
				{\sffamily####1}%
				\hspace{1em}%
			}%
			\ignorespaces%
		}%

		\newcommand{\suggestion}{%
			\Needspace*{1.666666\baselineskip}%
			\division{注意事项}%
		}%

		% Make command \hint as an alternative name of \step
		\let\hint=\step%

		\newcommand{\features}{%
			\Needspace*{1.666666\baselineskip}%
			\division{特点}%
		}%

		\newenvironment{subrecipe}[1]{%
			\renewcommand{\ingredients}{%
				\noindent（一）{\hbadness=10000\makebox[3.75em][s]{原料}}：%
				\nopagebreak%
			}%
			\renewcommand{\preparation}{%
				\noindent（二）制作方法：%
				\nopagebreak%
			}%
			\renewcommand{\ingredient}[2]{%
				\begingroup%
				\noindent%
				\ingredientindex{########1}%
				\mbox{%
					\hspace{2.210445em}%
					\makebox[9.375em][s]{%
						\mbox{########1}\hfil\mbox{########2}%
					}%
					\hspace{5.727055em}%
				}%
				\endgroup%
				\hspace{.001pt minus .001pt}% Teeny-tiny hspace
				\ignorespaces%
			}%
			\ingredientindex{####1}%
			####1%
			\nopagebreak%
		}{%
		}%

		% Create label for reference
		\newcommand{\makealabel}[1]{%
			\label{####1}%
		}

		% Reset the endnote counter
		\setcounter{endnote}{0}%
		% The height of the section title plus two lines
		\setlength{\spanheight}{3.428571\baselineskip}%

		% Suppress the underfull \vbox warning
		\vbadness=10000%

		\ifthenelse{\equal{##1}{}}{%
			\Needspace*{\spanheight}%
		}{%
			\addtolength{\spanheight}{1\baselineskip}%
			\Needspace*{1\spanheight}%
			\addtolength{\spanheight}{-1\baselineskip}%
		}
		\ifthenelse{\lengthtest{\cookbookbeforerecipeskip=0pt}}{%
		}{%
			\vspace*{\cookbookbeforerecipeskip}%
		}%
		\settowidth{\spanwidth}{##2}%
		\ifthenelse{\value{chapter}>999}{%
			\ifthenelse{\lengthtest{\spanwidth<5em}}{%
				\section[##2]{\hbadness=10000\makebox[5em][s]{##2##3}}%
			}{%
				\section[##2]{##2##3}%
			}%
		}{%
			\ifthenelse{\lengthtest{\spanwidth<5em}}{%
				% Use different text for the table of contents and bookmarks
				\section[%
					\texorpdfstring{\zhdigits{\arabic{section}}、##2}{##2}%
				]{\hbadness=10000\makebox[5em][s]{##2##3}}%
			}{%
				\section[%
					\texorpdfstring{\zhdigits{\arabic{section}}、##2}{##2}%
				]{##2##3}%
			}%
		}%
		\def\@currentlabelname{##2}%    Hack the current label name
		\makealabel{recipe:\arabic{section}}%
		\ifthenelse{\equal{##1}{}}{%
		}{%
			\noindent%
			\makebox[\textwidth][s]{\hfil\mbox{\sffamily（原##1）}\hfil}%
		}%
	}{%
		\ifthenelse{\equal{\value{endnote}}{0}}{%
		}{%
			\begingroup%
			\theendnotes%
			\endgroup%
		}%
		\makeatletter%
		\par \penalty-100%
		\begingroup%
		\setlength{\dimen@}{\spanheight}%
		\dimen@ii\pagegoal \advance\dimen@ii-\pagetotal%
		\ifdim \dimen@>\dimen@ii%
			% More than length
		\else%
			% Less than length
			\addtolength{\spanheight}{1\cookbookafterrecipeskip}%
			\setlength{\dimen@}{\spanheight}%
			\dimen@ii\pagegoal \advance\dimen@ii-\pagetotal%
			\ifdim \dimen@>\dimen@ii%
				% More than length
				\pagebreak%
			\else%
				% Less than length
				\vspace{\cookbookafterrecipeskip}%
			\fi%
		\fi%
		\endgroup%
		\makeatother%
	}%

	% A new counter used in the command \step
	\newcounter{step}[subsection]%

	% Customize the endnote
	\makeatletter%
	\renewcommand{\@makeenmark}{%
		\makebox{\rmfamily{\@theenmark}}%
	}%
	\makeatother%
	% "24EA             Circled Digit Zero
	% "2460 -> "2473    Circled Digit One - Circled Number Twenty
	% "3251 -> "325F    Circled Number Twenty One - Circled Number Thirty Five
	% "32B1 -> "32BF    Circled Number Thirty Six - Circled Number Fifty
	\newcommand{\circled}[1]{%
		\ifcase ##1 \symbol{"24EA}\or%
		\symbol{"2460}\or\symbol{"2461}\or\symbol{"2462}\or\symbol{"2463}\or%
		\symbol{"2464}\or\symbol{"2465}\or\symbol{"2466}\or\symbol{"2467}\or%
		\symbol{"2468}\or\symbol{"2469}\or\symbol{"246A}\or\symbol{"246B}\or%
		\symbol{"246C}\or\symbol{"246D}\or\symbol{"246E}\or\symbol{"246F}\or%
		\symbol{"2470}\or\symbol{"2471}\or\symbol{"2472}\or\symbol{"2473}\or%
		\symbol{"3251}\or\symbol{"3252}\or\symbol{"3253}\or\symbol{"3254}\or%
		\symbol{"3255}\or\symbol{"3256}\or\symbol{"3257}\or\symbol{"3258}\or%
		\symbol{"3259}\or\symbol{"325A}\or\symbol{"325B}\or\symbol{"325C}\or%
		\symbol{"325D}\or\symbol{"325E}\or\symbol{"325F}\or\symbol{"32B1}\or%
		\symbol{"32B2}\or\symbol{"32B3}\or\symbol{"32B4}\or\symbol{"32B5}\or%
		\symbol{"32B6}\or\symbol{"32B7}\or\symbol{"32B8}\or\symbol{"32B9}\or%
		\symbol{"32BA}\or\symbol{"32BB}\or\symbol{"32BC}\or\symbol{"32BD}\or%
		\symbol{"32BE}\or\symbol{"32BF}\else\@ctrerr\fi%
	}%
	\renewcommand{\theendnote}{%
		\circled{\value{endnote}}%
	}%

	% Redefine the endnote heading
	\makeatletter%
	\def\enoteheading{%
		% The \hrule is .4pt high
		\kern 5.05pt\hrule \@width 105pt \kern 5.05pt%
		\nopagebreak%
	}%
	\makeatother%
	% Redefine the enotesize
	\def\enotesize{\footnotesize}%

	% End note marker = superscripted number in circle
	\renewcommand\makeenmark{\textsuperscript{\theenmark}}%
	% In the endnotes, change it without `\textsuperscript`, adding a space
	\patchcmd{\theendnotes}%
	{\makeatletter}%
	{\makeatletter\renewcommand\makeenmark{\theenmark }}%
	{}{}%

	% Set the caption style
	\captionsetup{format=cookbook,labelsep=cookbook,labelformat=cookbook}%

	% Customize the head and foot
	\fancyhead{}% Clear all fields
	\fancyfoot{}% Clear all fields
	\fancyhead[LE,RO]{}%
	\fancyhead[CE,RE]{}%
	\fancyhead[LO,CO]{}%
	% Customize the page numbers
	\fancyfoot[LE,RO]{%
		\hspace{1.441em}%
		\lower.559em\hbox{\scalebox{2.236}[2.236]{\symbol{"2027}}}%
		\hspace{-.559em}%
		\makebox[2em][s]{\hfil\mbox{\thepage}\hfil}%
		\hspace{-.559em}%
		\lower.559em\hbox{\scalebox{2.236}[2.236]{\symbol{"2027}}}%
		\hspace{1.441em}%
	}%
	\fancyfoot[CE,RE]{}%
	\fancyfoot[LO,CO]{}%
	\renewcommand{\headrulewidth}{0pt}%
	\renewcommand{\footrulewidth}{0pt}%

	% Customize the table of contents
	\tocloftpagestyle{fancy}%
	\setlength{\cftbeforetoctitleskip}{1.625\baselineskip%
		plus .0625\baselineskip minus .0625\baselineskip}
	\setlength{\cftaftertoctitleskip}{0\baselineskip}%
	% Centering table of contents title by using \hfil
	\renewcommand{\cfttoctitlefont}{\hfil\Large\rmfamily\bfseries}%
	\renewcommand{\cftaftertoctitle}{\hfil}%
	\renewcommand{\cftdot}{…}%
	\renewcommand\cftdotsep{.2}%
	\cftsetpnumwidth{1.5em}%
	\cftsetrmarg{1.6em}%
	% Centering chapter titles by using \hfil
	\renewcommand{\cftchapfont}{\hfil\normalsize\sffamily}%
	\renewcommand{\cftchapafterpnum}{\hfil}%
	\setlength{\cftchapindent}{1.6em}%
	\setlength{\cftchapnumwidth}{0em}%
	\renewcommand{\cftsecfont}{\normalsize\rmfamily}%
	\renewcommand{\cftsecpagefont}{\normalsize\rmfamily}%
	\renewcommand{\cftsecpresnum}{}%
	\renewcommand{\cftsecaftersnum}{}%
	\setlength{\cftsecindent}{0em}%
	\setlength{\cftsecnumwidth}{0em}%
	\renewcommand{\thechapter}{}%
	\renewcommand{\thesection}{}%
	\renewcommand{\thesubsection}{}%
	\renewcommand\cftsecdotsep{\cftdotsep}%
	\renewcommand\contentsname{%
		% Use different text for the table of contents and bookmarks
		\texorpdfstring{%
			\makebox[\textwidth][s]{%
				\hfil{\hbadness=10000\makebox[5em][s]{目录}}\hfil%
			}%
		}{目录}%
	}%
	\setcounter{tocdepth}{1}%
	\addtocontents{toc}{\cftpagenumbersoff{chapter}}%
	\addtocontents{toc}{\cftpagenumberson{section}}%

	\newenvironment{tocminipageleft}{%
		\addtocontents{toc}{\protect\begin{minipage}[t]{.456\textwidth}}%
	}{%
		\addtocontents{toc}{\protect\end{minipage}}%
		\addtocontents{toc}{\protect\begin{minipage}[t]{.071\textwidth}}%
		\addtocontents{toc}{\protect\hfil}%
		\addtocontents{toc}{\protect\end{minipage}}%
	}%
	\newenvironment{tocminipageright}{%
		\addtocontents{toc}{\protect\begin{minipage}[t]{.456\textwidth}}%
	}{%
		\addtocontents{toc}{\protect\end{minipage}}%
		\addtocontents{toc}{\protect\vfil}%
	}%
	\newcommand{\tocclearpage}{%
		\addtocontents{toc}{\protect\clearpage}%
	}%

	% Reference to the recipe sequence number
	\newcommand{\recipenum}[1]{%
		\hyperref[recipe:##1]{\zhdigits{##1}}%
	}%

	% Reference to the recipe name
	\newcommand{\recipename}[1]{%
		\hyperref[recipe:##1]{\nameref{recipe:##1}}%
	}%

	% Refernce to the recipe sequence number with name
	\newcommand{\reciperef}[1]{%
		\hyperref[recipe:##1]{\zhdigits{##1}、\nameref{recipe:##1}}%
	}%

	% Refernce to the recipe page number and name
	\newcommand{\recipepage}[1]{%
		\hyperref[recipe:##1]{第\pageref{recipe:##1}页\nameref{recipe:##1}}%
	}%

	% Reference for multiple recipes
	\newcommand{\recipelist}[1]{%
		\foreach \r [count=\k] in {##1} {%
			\ifnum\k>1{、}\fi%
			\recipenum{\r}%
		}%
	}%

	\newcommand{\indextitle}[1]{%
		\begin{center}%
		{%
			\Large\rmfamily\bfseries%
			\hbadness=10000\makebox[5em][s]{##1}%
		}%
		\end{center}%
	}%

	% Set line spacing
	\onehalfspacing%
	% Set the indentation to be two Chinese characters size.
	\setlength{\parindent}{2em}%
	\setlength{\parskip}{0\baselineskip}%
	\setlength{\cookbookbeforerecipeskip}{0\baselineskip}%
	\setlength{\cookbookafterrecipeskip}{1\baselineskip}%
}{%
}%

% vim: filetype=tex noautoindent nojoinspaces
% vim: fileencoding=utf-8
% vim: textwidth=78 tabstop=4 shiftwidth=4 softtabstop=4
