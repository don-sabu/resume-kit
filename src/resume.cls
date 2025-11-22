\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2025/01/01 Custom Resume Class]

% Base class
\LoadClass[10pt, a4paper]{article}

% -----------------------------------------------------------
%                      PACKAGE SETUP
% -----------------------------------------------------------

% Page geometry
\RequirePackage[
    ignoreheadfoot,
    top=2cm,
    bottom=2cm,
    left=2cm,
    right=2cm,
    footskip=1cm,
]{geometry}

% Section formatting
\RequirePackage{titlesec}

% Tables and alignment
\RequirePackage{tabularx}
\RequirePackage{array}

% Colors
\RequirePackage[dvipsnames]{xcolor}
\definecolor{primaryColor}{RGB}{0,0,0}

% Lists
\RequirePackage{enumitem}

% Icons
\RequirePackage{fontawesome5}

% Math
\RequirePackage{amsmath}

% Layout utilities
\RequirePackage[pscoord]{eso-pic}
\RequirePackage{calc}
\RequirePackage{bookmark}
\RequirePackage{lastpage}
\RequirePackage{changepage}
\RequirePackage{paracol}
\RequirePackage{ifthen}
\RequirePackage{needspace}
\RequirePackage{iftex}

% PDF/ATS readability
\ifPDFTeX
    \input{glyphtounicode}
    \pdfgentounicode=1
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage{lmodern}
\fi

% Font
\RequirePackage{charter}


\RequirePackage{hyperref}

% -----------------------------------------------------------
%                  GLOBAL DOCUMENT SETTINGS
% -----------------------------------------------------------

\newcommand{\ResumeTitle}{Resume}
\newcommand{\ResumeAuthor}{Anonymous}
\newcommand{\ResumeKeywords}{resume, cv}

\AtBeginDocument{
    \hypersetup{
        pdftitle={\ResumeTitle},
        pdfauthor={\ResumeAuthor},
        pdfcreator={LaTeX},
        pdfsubject={Resume},
        pdfkeywords={\ResumeKeywords},
        colorlinks=true,
        urlcolor=primaryColor,
        pdfproducer={Resume Kit by Don Sabu — github.com/don-sabu/resume-kit}
    }
}

\raggedright
\AtBeginEnvironment{adjustwidth}{\partopsep0pt}
\pagestyle{empty}
\setcounter{secnumdepth}{0}
\setlength{\parindent}{0pt}
\setlength{\topskip}{0pt}
\setlength{\columnsep}{0.15cm}
\pagenumbering{gobble}

% -----------------------------------------------------------
%                  SECTION TITLE STYLING
% -----------------------------------------------------------

\titleformat{\section}
  {\needspace{4\baselineskip}\bfseries\large}
  {}
  {0pt}
  {}
  [\vspace{1pt}\titlerule]

\titlespacing{\section}{-1pt}{0.5cm}{0.3cm}

% -----------------------------------------------------------
%                  BULLET STYLES
% -----------------------------------------------------------

\renewcommand\labelitemi{$\vcenter{\hbox{\small$\bullet$}}$}

% -----------------------------------------------------------
%                  ENVIRONMENTS
% -----------------------------------------------------------

\newenvironment{highlights}{
    \begin{itemize}[topsep=0.10cm, parsep=0.10cm, partopsep=0pt, itemsep=0pt, leftmargin=10pt]
}{
    \end{itemize}
}

\newenvironment{highlightsforbulletentries}{
    \begin{itemize}[topsep=0.10cm, parsep=0.10cm, partopsep=0pt, itemsep=0pt, leftmargin=10pt]
}{
    \end{itemize}
}

\newenvironment{onecolentry}{
    \begin{adjustwidth}{0cm}{0cm}
}{
    \end{adjustwidth}
}

\newenvironment{twocolentry}[2][]{
    \onecolentry
    \def\secondColumn{#2}
    \setcolumnwidth{\fill, 7cm}
    \begin{paracol}{2}
}{
    \switchcolumn \raggedleft \secondColumn
    \end{paracol}
    \endonecolentry
}

\newenvironment{threecolentry}[3][]{
    \onecolentry
    \def\thirdColumn{#3}
    \setcolumnwidth{, \fill, 4.5cm}
    \begin{paracol}{3}
    {\raggedright #2} \switchcolumn
}{
    \switchcolumn \raggedleft \thirdColumn
    \end{paracol}
    \endonecolentry
}

% header environment
\newenvironment{header}{
    \setlength{\topsep}{0pt}\par\kern\topsep\centering\linespread{1.5}
}{
    \par\kern\topsep
}

% -----------------------------------------------------------
%               VERTICAL BAR SEPARATOR (\AND)
% -----------------------------------------------------------

\newsavebox\ANDbox
\sbox\ANDbox{$|$}

\newcommand{\AND}{%
    \unskip
    \cleaders\copy\ANDbox\hskip\wd\ANDbox
    \ignorespaces
}

% Keep original \href behaviour
\let\hrefWithoutArrow\href
