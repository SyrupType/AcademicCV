% super V EN http://career.ucsf.edu/sites/career.ucsf.edu/files/PDF/ResearcherResearchPackage1.pdf
% pb biber -> http://humtex.wordpress.com/2011/11/29/biber-first-aid-for-data-source-not-found/

% http://www.ppls.ed.ac.uk/staff/curriculum_vitae/CV_Jennifer_Foley2.pdf
% http://nitens.org/taraborelli/cvtex
% http://charlespence.net//www.isi.edu/~chiang/cv.html

%------------------------------------
% Dario Taraborelli
% Typesetting your academic CV in LaTeX
%
% URL: http://nitens.org/taraborelli/cvtex
% DISCLAIMER: This template is provided for free and without any guarantee
% that it will correctly compile on your system if you have a non-standard
% configuration.
% Some rights reserved: http://creativecommons.org/licenses/by-sa/3.0/
%------------------------------------

%!TEX TS-program = xelatex
%!TEX encoding = UTF-8 Unicode

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{academicCV}[LaTeX class for an academic CV]

\LoadClass[10pt,a4paper]{article}

\usepackage[T1]{fontenc} 
\usepackage[utf8]{inputenc}
\usepackage[french]{babel}
\usepackage{fontspec,marvosym,fontawesome,latexsym,nicefrac}  % adforn:ornaments, latexsym \rhd
\usepackage{enumitem}
\usepackage{microtype}
\usepackage{relsize}

%------------
% AUTHOR INFO
\RequirePackage{xkeyval}%

\def\firstName{Tony}%
\def\lastName{Stark}%

\define@key{academicCV.cls}{firstName}[Tony]{%
  \def\firstName{#1}%
}

\define@key{academicCV.cls}{lastName}[Stark]{%
  \def\lastName{#1}%
}

\ExecuteOptionsX{firstName, lastName}
\ProcessOptionsX%


%----------------------------------------------------------------------------------------------------
% BIBLIOGRAPHY
% defernumbers pour faire un reset entre chaque catégorie http://tex.stackexchange.com/a/128961

% voir également http://tex.stackexchange.com/questions/329262/reverse-numbering-biblatex-3-3-with-labelprefix-and-need-for-citation?atw=1

\usepackage{csquotes}
\usepackage[defernumbers=true, % needed for resetnumbers in publis
					style=numeric,
					sorting=ydnt,
					giveninits,
					maxnames=20,
					language=french,
	]{biblatex}

\DeclareLanguageMapping{french}{french-apa}

%  urlfrom = {Disponible à},
%  retrieved = {disponible},
% n'arrivant pas à modifier "retrieved" dans french-apa, j'ai copié french-apa.dtx dans le rép courant.
\DefineBibliographyStrings{french}{%
  forthcoming = {à paraître},
}

% 2016-08-08 numérotation antichronologique
% reprend des éléments de http://tex.stackexchange.com/a/37850
% sans pouvoir reproduire tel quel (SE présente des solutions avec une ancienne version de biber, voir mwe)
\DeclareFieldFormat{labelnumber}{\mkbibdesc{#1}}
\newrobustcmd*{\mkbibdesc}[1]{\number\numexpr\strfield{userc}+1-#1\relax}

%\DeclareFieldFormat{addendum}{\small{#1}}

% Keep Day, Month for newspapers...
% http://tex.stackexchange.com/a/172453
\AtEveryBibitem{%
  \ifboolexpr{not test {\iffieldequalstr{entrysubtype}{newspaper}}}
    {\clearfield{month}%
     \clearfield{day}}
    {}%
}

%\AtEveryBibitem{\clearfield{month}}
\AtEveryBibitem{\clearfield{isbn}}
\AtEveryBibitem{\ifentrytype{article}{\clearfield{userb}}{}}
\AtEveryBibitem{\ifentrytype{incollection}{\clearfield{userb}}{}}

\usepackage{ifthen}
\usepackage{xstring}
\newcommand{\hrefElmt}[1]{
	\StrCut{#1}{|}{\hrefType}{\hrefUrl}
	[\href{\hrefUrl}{\textsc{\hrefType}}]%
}

\makeatletter
\AtEveryBibitem{\csappto{blx@bbx@\thefield{entrytype}}{%
	\ifthenelse{\equal{\thefield{usera}}{}}{}{ \thefield{usera}.}
	\ifthenelse{\equal{\thefield{userb}}{}}{}{\thefield{userb}}
	\ifthenelse{\equal{\thefield{file}}{}}{}
	{%
		\StrCut{\thefield{file}}{ }{\firstUrl}{\rest}
		\whiledo{\not\equal{\rest}{}}{%
			\hrefElmt{\firstUrl}%
			\StrCut{\rest}{,}{\firstUrl}{\rest}%
		}%
		\hrefElmt{\firstUrl}%
	}
}}
\makeatother

% http://tex.stackexchange.com/questions/18664/underline-my-name-in-the-bibliography
% GC 12-MAR-2016 Suite à une évolution de biblatex 01-MAR-2016,
%                ai renommé "name:first-last" en "name:given-family"
%                et bougé le code lié à biblatex présent dans le présent fichier en haut
% GC 13-JUN-2016 Suite nouveau texlive, ai modifié le contenu en adaptant à partir de
%                /usr/local/texlive/2016/texmf-dist/tex/latex/biblatex/biblatex.def
\renewbibmacro*{name:given-family}[4]{%
  \usebibmacro{name:delim}{#2#3#1}%
  \usebibmacro{name:hook}{#2#3#1}%
  \ifthenelse{\equal{#1}{\lastName}}% matches last name against YourLastName%
  {%
     \textsc{\uline{% wrapped with \uline
	  \ifdefvoid{#2}{}{\mkbibnamegiven{#2}\isdot\bibnamedelimd}%
	  \ifdefvoid{#3}{}{%
	    \mkbibnameprefix{#3}\isdot
	    \ifprefchar
	      {}
	      {\ifuseprefix{\bibnamedelimc}{\bibnamedelimd}}}%
	  \mkbibnamefamily{#1}\isdot
	  \ifdefvoid{#4}{}{\bibnamedelimd\mkbibnamesuffix{#4}\isdot}}}
  }
  {% original
	  \ifdefvoid{#2}{}{\mkbibnamegiven{#2}\isdot\bibnamedelimd}%
	  \ifdefvoid{#3}{}{%

	    \mkbibnameprefix{#3}\isdot
	    \ifprefchar
	      {}
	      {\ifuseprefix{\bibnamedelimc}{\bibnamedelimd}}}%
	  \mkbibnamefamily{#1}\isdot
	  \ifdefvoid{#4}{}{\bibnamedelimd\mkbibnamesuffix{#4}\isdot}
  }
}

\renewbibmacro{in:}{}

\newcommand{\publis}[4]{%
  \begin{refcontext}[labelprefix={#3}]
    \nocite{#4}
    \NoAutoSpacing % enlève les espaces automatiquement ajoutés avant les signes doubles en FR
    \printbibliography[keyword={#1}, title={$\rhd$ #2}, heading=subbibliography, resetnumbers=true]
  \end{refcontext}
}

%----------------------------------------------------------------------------------------------------

% DOCUMENT LAYOUT
\usepackage{geometry}
\geometry{a4paper, margin = 3cm,marginparsep=7pt, marginparwidth=.6in}
\setlength\parindent{0in}

% FONTS
\usepackage[usenames,dvipsnames]{xcolor}
\usepackage{xunicode}
\usepackage{xltxtra}
\defaultfontfeatures{Mapping=tex-text}
\setromanfont[Ligatures={Common}, Variant=01]{Linux Libertine O}
\setmonofont[Scale=0.8]{Monaco}

% Guillaume's packages
\usepackage{soul,hieroglf}
\usepackage[autolanguage]{numprint}
\usepackage{underscore} % pour inclusion DOI

% ---- CUSTOM COMMANDS
\chardef\&="E050
\newcommand{\html}[1]{\href{#1}{\scriptsize\textsc{[html]}}}
\newcommand{\pdf}[1]{\href{#1}{\scriptsize\textsc{[pdf]}}}
\newcommand{\doi}[1]{\href{#1}{\scriptsize\textsc{[doi]}}}
% ---- MARGIN YEARS
\usepackage{marginnote}
\newcommand{\amper{}}{\chardef\amper="E0BD }
\newcommand{\years}[1]{\marginnote{\footnotesize #1}}
\renewcommand*{\raggedleftmarginnote}{}
\setlength{\marginparsep}{7pt}
\reversemarginpar

% HEADINGS
\usepackage[normalem]{ulem}
\usepackage{titlesec}
\titleformat{\section}{\mdseries\bf\upshape\Large}{}{0pt}{}{}
\titleformat{\subsection}{\mdseries\upshape\large}{}{0pt}{}{}
\titleformat{\subsubsection}{\itshape}{}{0pt}{$\rhd$~}{\vspace{-8pt}}

% PDF SETUP
\usepackage[bookmarks=false,colorlinks,
					breaklinks,
					pdfpagelayout=TwoColumnLeft,
					pdfnewwindow=true,
					unicode=true,
%					pdftitle={\firstName{} \lastName{} - Curriculum Vitæ},
%					pdfauthor={\firstName{} \lastName{}},
					pdfproducer={http://nitens.org/taraborelli/cvtex}
]{hyperref}
\hypersetup{linkcolor=MidnightBlue,citecolor=MidnightBlue,filecolor=black,urlcolor=MidnightBlue}


\usepackage{lastpage}
\usepackage{fancyhdr}
\fancypagestyle{plain}{
  \renewcommand{\headrulewidth}{0pt}
  \fancyhf{}
  \fancyfoot[C]{\footnotesize \thepage{} sur \pageref{LastPage}}
}
\pagestyle{plain}

% LISTS
\newcommand{\sep}{\hspace{3mm}•\hspace{3mm}}
\newcommand{\inlineList}[1]{
	\StrCut{#1}{,}{\before}{\after}
	\whiledo{\not\equal{\after}{}}{%
		\before\sep%
		\StrCut{\after}{,}{\before}{\after}%
	}%
	\before
}
\newcommand{\lang}[1]{
	\StrCut{#1}{ : }{\langName}{\langLvl}
	\ifx\langLvl\empty\StrCut{#1}{:}{\langName}{\langLvl}\fi
	\langName~:~\emph{\langLvl}
}
\newcommand{\langs}[1]{
	\StrCut{#1}{,}{\before}{\after}
	\whiledo{\not\equal{\after}{}}{%
		\lang{\before}\sep%
		\StrCut{\after}{,}{\before}{\after}%
	}%
	\lang{\before}
}

% FOOTER
\newcommand{\footer}[2]{
	\vfill{}
	\begin{center}
		\scriptsize  Version du \today\- •\-
		% ---- PLEASE LEAVE THIS BACKLINK FOR ATTRIBUTION AS PER CC-LICENSE
		Composé avec \href{http://nitens.org/taraborelli/cvtex}{
		\fontspec{Times New Roman}\XeTeX }\\
		% ---- FILL IN THE FULL URL TO YOUR CV HERE
		\href{#1}{\nolinkurl{#1}}
	\end{center}
}

% HEADER
\newcommand{\header}[9]{
	{\LARGE \firstName{} \textsc{\lastName}\\[.3cm]}

	\begin{minipage}{0.55\textwidth}
		\href{#2}{#1}\\
		\href{#4}{#3}\\
		#5
	\end{minipage}
	\hfill
	\begin{minipage}{0.4\textwidth}
		\begin{tabular}{@{}c@{\hspace{2mm}}l}
			\faHome	& \href{#6}{\nolinkurl{#6}}\\
			\Letter		& \href{mailto:#7}{\nolinkurl{#7}}\\
			\faTwitter	& \href{http://twitter.com/#8}{@\nolinkurl{#8}}\\
			\faMobile	& \texttt{#9}\\
		\end{tabular}
	\end{minipage}
	\vspace{5mm}
}

% CORPS
\usepackage{setspace}
\newcommand{\entry}[2]{
	\years{#1} #2\\[-8pt]
}
\newcommand{\details}[1]{
	~\\[-2mm]% Fix
	\hspace*{4mm}
	\begin{minipage}[t]{0.95\textwidth}
		\setstretch{1.05}
		\footnotesize
		#1
	\end{minipage}\\
}

\newcommand{\md}{$\cdot{}$}

% MISC
\usepackage{todonotes}
\newcommand{\tdi}[1]{\todo[inline]{#1}}
\newcommand{\n}[1]{\numprint{#1}}