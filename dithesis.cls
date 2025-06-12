% Template for M. Sc. (Tech.) degree programmes at the
% Faculity of Information Technology and Electical Engineering
% at University of Oulu (CSE/BME/BA)
% 
% Authors: Mika Korhonen (original author), Pekka Pietikäinen,
% Christian Wieser, Teemu Tokola, Juha Kylmänen, Tuomas Holmberg and
% Tuomas Varanka
% If you make any improvements to this template, please use
% https://github.com/ouspg/cse-thesis
%
% Several inspirations come from from Aalto University
% aaltothesis.cls by Luis R.J. Costa

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{csethesis}[2025/06/09 Diploma Thesis Class]

% Load report class as the base
\LoadClass[12pt,a4paper,titlepage]{report}

% --- Core packages only (minimal set) ---
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{etoolbox}
\usepackage{ifthen}
\usepackage{xstring}

% --- Essential formatting packages needed for document structure ---
\usepackage[
  left=4.5cm, right=2.0cm, top=2.5cm, bottom=3.0cm
]{geometry}

\usepackage[noindentafter]{titlesec}
\usepackage{titlecaps}
\usepackage{chngcntr}
\usepackage[useregional=text, british]{datetime2}
\usepackage{appendix}
\usepackage{newfile}

% Footnotes in longtable require it to be loaded before pdfx, otherwise
% should be in .sty
\usepackage{longtable}
\usepackage[a-1b,latxmp, mathxmp]{pdfx}[2017/05/18]
\hypersetup{
  unicode=true,
  pdfencoding=auto,
  hidelinks
}

% --- Language option processing ---
\newcommand*{\MainLang}{}
\newcommand*{\OtherLangs}{}

\DeclareOption{english}{%
  \PassOptionsToPackage{main=english, finnish}{babel}%
  \renewcommand*{\MainLang}{english}%
  \renewcommand*{\OtherLangs}{finnish}%
}
\DeclareOption{finnish}{%
  \PassOptionsToPackage{main=finnish, english}{babel}%
  \renewcommand*{\MainLang}{finnish}%
  \renewcommand*{\OtherLangs}{english}%
}

\newcommand{\degreeprogrammeselection}{cse} % default to 'cse' (Tietotekniikka)
\newcommand{\thesistype}{Master} % default to 'Master' (Diplomityö)

\DeclareOption{cse}{\renewcommand{\degreeprogrammeselection}{cse}}
\DeclareOption{bme}{\renewcommand{\degreeprogrammeselection}{bme}}
\DeclareOption{ba}{\renewcommand{\degreeprogrammeselection}{ba}}
\ExecuteOptions{cse} % default

\DeclareOption{bachelor}{%
  \renewcommand{\thesistype}{bachelor}%
}
\DeclareOption{master}{%
  \renewcommand{\thesistype}{master}
}
\ExecuteOptions{master} % default to 'master' (Diplomi-insinööri)
\ProcessOptions\relax

\newcommand*{\IfEng}[3]{\ifdefstring{#1}{english}{#2}{#3}}%
\newcommand*{\IfFin}[3]{\ifdefstring{#1}{finnish}{#2}{#3}}%
\newcommand{\IfLang}[4]{%
  \ifdefstring{#1}{#2}{#3}{#4}%
}

\newcounter{NAllPages}
\newcounter{NMainTxtPages}
\newcounter{NAppdxPages}
\newcommand*{\stor@maintxtpag@number}{%
  \immediate\write\@auxout{\string\setcounter{NMainTxtPages}{\thepage-1}}%
}

\newcommand{\startappendix}{%
  \stor@maintxtpag@number%
%  \renewcommand{\thechapter}{Appendix \arabic{chapter}}  % Custom numbering
  \renewcommand{\appendixname}{Appendix}
}

\AtEndDocument{%
  \immediate\write\@auxout{\string\setcounter{NAllPages}{\thepage}}%
}

\newcommand*{\shownumberofpages}{%
  \arabic{NAllPages}
}

\newcommand*{\shownumberofpageswithappendix}{%
  \ifnumequal{\value{NMainTxtPages}}{0}{\arabic{NAllPages}}%
  {\arabic{NMainTxtPages}+\arabic{NAppdxPages}}%
}%

% --- Miscellaneous ---

\newtoggle{writexmpdatafile}

\toggletrue{writexmpdatafile}

\newcommand{\CopyrightText}{}% variable; used for printing on page
\newcommand{\MetaCopyrightText}{}%
\newcommand{\pdfCopyrightURL}{}%
\newcommand{\copyrighttext}[2]{%
  \renewcommand{\MetaCopyrightText}{#1}%
  \renewcommand{\CopyrightText}{#2}%
  \ifdef{\doclicenseURL}{\renewcommand{\pdfCopyrightURL}{\doclicenseURL}}{}%
}%

\newcommand*{\spc}{\noexpand\sep}%

\newcommand{\makemetadata}{%
  \iftoggle{writexmpdatafile}{%
    % Write the metadata into file .xmpdata, which is included in the PDF/A file
	\newoutputstream{xmpdata}%
	\openoutputfile{\jobname.xmpdata}{xmpdata}%
	\addtostream{xmpdata}{\noexpand\Title {\maintitle}}%
	\addtostream{xmpdata}{\noexpand\Author {\getauthorsmetadata}}%
  \addtostream{xmpdata}{\noexpand\Copyright {\MetaCopyrightText}}%%
 	\addtostream{xmpdata}{\noexpand\CopyrightURL {\pdfCopyrightURL}}
		\IfFin{\MainLang}{%
          \addtostream{xmpdata}{\noexpand\Subject {\tiivistelmametadata}}%
          \addtostream{xmpdata}{\noexpand\Keywords[fi] {\avainsanatmetadata%
              \noexpand\sep[en] \keywordsmetadata}}%
        }{%
          \addtostream{xmpdata}{\noexpand\Subject {\abstractmetadata}}%
          \addtostream{xmpdata}{\noexpand\Keywords[en] {\keywordsmetadata%
              \noexpand\sep[fi] \avainsanatmetadata}}%
        }%
  \closeoutputstream{xmpdata}%
  }{%
    % Write the metadata directly into the pdf file via hyperref keywords
	%\renewcommand*{\spc}{; }%
	%\hypersetup{%
	%  pdftitle={\maintitle},%
	%  pdfauthor={\ThesisAuthor},%
	%  pdfsubject={\abstracttext},%
	%  pdfcopyright={\MetaCopyrightText},%
	%  pdfkeywords={\keywords}%
	%}%
  }%
}%
%
\AtBeginDocument{%
  \makemetadata%
}%
%



\newcommand{\firstname}[1]{\gdef\@firstname{#1}}
\newcommand{\lastname}[1]{\gdef\@lastname{#1}}
\newcommand{\firstnametwo}[1]{\gdef\@firstnametwo{#1}}
\newcommand{\lastnametwo}[1]{\gdef\@lastnametwo{#1}}
\newcommand{\firstnamethree}[1]{\gdef\@firstnamethree{#1}}
\newcommand{\lastnamethree}[1]{\gdef\@lastnamethree{#1}}
\newcommand{\otsikko}[1]{\gdef\@otsikko{#1}}

\newcommand{\getfirstname}{\@firstname}
\newcommand{\getlastname}{\@lastname}
\newcommand{\getfirstnametwo}{\@firstnametwo}
\newcommand{\getlastnametwo}{\@lastnametwo}
\newcommand{\getfirstnamethree}{\@firstnamethree}
\newcommand{\getlastnamethree}{\@lastnamethree}
\newcommand{\getotsikko}{\@otsikko}
\newcommand{\gettitle}{\@title}

\newcommand{\headertitlecap}{
  \IfLang{\MainLang}{english}{
    \let\oldsection\section
    \let\oldsubsection\subsection
    \renewcommand{\section}[1]{\oldsection{\texorpdfstring{\titlecap{##1}}{##1}}}
    \renewcommand{\subsection}[1]{\oldsubsection{\texorpdfstring{\titlecap{##1}}{##1}}}
  }{}
}

\newcommand{\keywordsmetadata}{}%
\newcommand{\keywords}[1]{\renewcommand*{\keywordsmetadata}{#1}}

\newcommand{\avainsanatmetadata}{}%
\newcommand{\avainsanat}[1]{\renewcommand*{\avainsanatmetadata}{#1}}

% Define abstract content storage
\long\def\abstractmetadata{}
\long\def\tiivistelmametadata{}
% User-facing macros for defining abstract text
\long\def\abstract#1{\long\def\abstractmetadata{#1}}
\long\def\tiivistelma#1{\long\def\tiivistelmametadata{#1}}

% Add macros for thesis type in English and Finnish
\newcommand{\facultyname}{}
\newcommand{\degreeprogramme}{}
\newcommand{\degreeprogrammetitle}{}
\newcommand{\getauthorsabstract}{}
\newcommand{\thesistypetitle}{}
\newcommand{\maintitle}{}
\newcommand{\universityname}{}
\newcommand{\universitynameieee}{}
\newcommand{\pagelabel}{}
\newcommand{\abstracttitle}{}
\newcommand{\headerforeword}{}
\newcommand{\headerabbreviations}{}
\newcommand{\tocname}{}
\newcommand{\mybibname}{}
\newcommand{\cityname}{}
\newcommand{\countryname}{}
\newcommand{\keywordsline}{}
\newcommand{\universitylogo}{Figures/logo-en.png}

% --- End centralized definitions ---

%Title page
% Commentary: The title page is generated by \maketitlepage. Ensure correct faculty, degree, and title.
\newcommand{\maketitlepage}{
  \sloppy
 
  \selectlanguage{\MainLang}
  
  \begin{titlepage}
    \centering
    \includegraphics*[width=0.22\textwidth]{\universitylogo}\\
    {\sffamily\fontsize{8}{10pt}\selectfont \facultyname\\}
    \vspace{70 mm}
    {\textbf{\fontsize{16}{19pt}\selectfont \getauthorstitle}\\}
    \vspace{12 mm}
    {\textbf{\fontsize{18}{22pt}\selectfont \MakeUppercase{\maintitle} \\}}
    \vfill
    {\fontsize{14}{17}\selectfont \thesistypetitle
    \\ \degreeprogrammetitle \\ \DTMToday \\}
    \vspace{1cm}
  \end{titlepage}
  \cleardoublepage
  \pagenumbering{gobble}
}

\newcommand{\makecopyrightpage}{%
  \newpage
  \thispagestyle{empty}%
    \makeatletter\input{doclicense-\MainLang.ldf}
    \makeatother
  \noindent
  \CopyrightText\par%
  \cleardoublepage
}%

\addtocontents{toc}{\protect\thispagestyle{empty}}
%Table of contents
% Commentary: Use \contents to generate the table of contents. Only chapters from Introduction onwards are numbered.
\newcommand{\contents}{
  \newpage
  \renewcommand{\contentsname}{\tocname}%
  \addtocontents{toc}{\protect\contentsline{chapter}{\tocname}{}{page.\thepage}
  }
  \newlength{\temp}
  \setlength{\temp}{\parskip}
  \setlength{\parskip}{0mm}
  \tableofcontents
  \setlength{\parskip}{\temp}
}


\newcommand{\abstractauthors}{%
  {\textbf{\getauthorsabstractacta\ (\the\year) \titlecap{\@title}}. \universityname, \degreeprogramme, \shownumberofpages~p.}
}

\newcommand{\abstractauthorsieee}{%
  {\getauthorsabstractieee, ``\titlecap{\@title},'' \thesistypetitle, \degreeprogramme, \universitynameieee, Oulu, \countryname, \the\year.}
}

\newenvironment{thesisabstract}[1]{%
  \selectlanguage{#1}%
  \setcounter{NAppdxPages}{\value{NAllPages}-\value{NMainTxtPages}}%
  \renewcommand*{\spc}{, }

  \cleardoublepage
  \noindent\abstractauthors
  \par\vspace{2\baselineskip}%

  {\centering\bfseries\fontsize{14}{17}\selectfont\MakeUppercase{\abstracttitle}\par}%
  \addtocontents{toc}{\protect\contentsline{chapter}{\abstracttitle}{}{page.\thepage}}
  \vspace{1\baselineskip}
  \@afterindentfalse\@afterheading
  \begingroup
  \bfseries
  }{%
  \endgroup
  \par
  \vspace{1\baselineskip}\noindent
  \textbf{\keywordsline}
}

%chapters without page numbering
\newcommand{\header}[1]{
  \chapter*{#1}
  \addtocontents{toc}{\protect\contentsline{chapter}{#1}{}{page.\thepage} }}



%page numbering
\pagestyle{empty}

\newcommand{\pagenumbers}{
  \pagestyle{myheadings}
  \makeatletter
  \def\ps@plain{\ps@myheadings} % plain pages like chapters also top right
  \makeatother
} 

%get authors for the title page
\newcommand{\getauthorstitle}{
  \begin{tabular}[t]{c}
  \getauthors{\\}%   
  \end{tabular}
}


\newcommand{\getauthorsmetadata}{
  \getauthors{\spc }%
}

\newcommand{\getauthorslist}{
  \getauthors{, }%
}

% Helper macro to get first initial from a name
\newcommand{\getfirstinitial}[1]{\StrChar{#1}{1}.}

% Returns the list of authors, separated by \sep
\newcommand{\getauthors}[1]{%
  \@ifempty{\@firstnametwo}{%
    \getfirstname\ \getlastname%
  }{%
    \@ifempty{\@firstnamethree}{%
      \getfirstname\ \getlastname#1\getfirstnametwo\ \getlastnametwo%
    }{%
      \getfirstname\ \getlastname#1\getfirstnametwo\ \getlastnametwo#1\getfirstnamethree\ \getlastnamethree%
    }%
  }%
}

%get authors for the abstract (Acta style: Surname F.)
\newcommand{\getauthorsabstractacta}{%
  \ifthenelse{\equal{\@firstnametwo}{}}%
    {\@lastname\ \getfirstinitial{\@firstname}}%
    {\ifthenelse{\equal{\@firstnamethree}{}}%
      {\@lastname\ \getfirstinitial{\@firstname},\ %
        \@lastnametwo\ \getfirstinitial{\@firstnametwo}}%
      {\@lastname\ \getfirstinitial{\@firstname},\ %
        \@lastnametwo\ \getfirstinitial{\@firstnametwo},\ %
        \@lastnamethree\ \getfirstinitial{\@firstnamethree}}%
    }%
}

%get authors for the abstract (IEEE style: F. Lastname)
\newcommand{\getauthorsabstractieee}{%
  \ifthenelse{\equal{\@firstnametwo}{}}%
    {\getfirstinitial{\@firstname}\ \@lastname}%
    {\ifthenelse{\equal{\@firstnamethree}{}}%
      {\getfirstinitial{\@firstname}\ \@lastname,\ %
        \getfirstinitial{\@firstnametwo}\ \@lastnametwo}%
      {\getfirstinitial{\@firstname}\ \@lastname,\ %
        \getfirstinitial{\@firstnametwo}\ \@lastnametwo,\ %
        \getfirstinitial{\@firstnamethree}\ \@lastnamethree}%
    }%
}

%signature at the bottom of foreword
\newcommand{\signature}{
  \DTMlangsetup[en-GB]{monthyearsep={,\space}}
  \par \vspace{1\baselineskip} \noindent
  \begin{flushleft} \cityname \DTMToday
  \end{flushleft}
  \par \noindent
  \begin{flushleft}
    \getauthors{\\}
  \end{flushleft}
}

\AtEndOfClass{%
  \RequirePackage{dithesis}%
}
