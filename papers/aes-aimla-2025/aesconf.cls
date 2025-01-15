%% Template for AES conferences and conventions
%% This class uses several other well-made packages to redefine
%% the basic style of the standard article class into the AES format.
%%
%% Copyright (c) 2018 Tapani Pihlajakuja and Jussi Pekonen
%% All rights reserved
%% Template use rights are given to Audio Engineering Society, Inc.
%% for using the template for conferences and conventions, and thus
%% the authors in these conferences and conventions are free to use and
%% necessarily modify (but not rerelease) the template.

%% Packages required in this class
% latexrelease
% etoolbox (provides programming tools)
% graphicx (graphics)
% fontenc (font encodings)
% mathptmx (times font with math support)
% helvet (helvetica font)
% courier (courier font)
% abstract (formats abstract)
% titling (formats main title)
% authblk (formats author and affiliation) (seems not to be in MikTeX)
% titlesec (formats section titles)
% caption (formats captions)
\ProvidesClass{aesconf}[2024/01/24, Version 1.8]
\NeedsTeXFormat{LaTeX2e}

% Version history
% 1.0, initial release
% 1.1.1, adds support for engineering briefs
% 1.2 adds examples
% 1.3 adds conference prefix
% 1.4 adds shortened conference topic for the footer
% 1.5 engineering briefs as a paper category is deprecated and it is replaced by express paper category
% 1.6 reworked footer
% 1.7 minor tweaks to the express paper category
% 1.8 support for other conference types than "conference"


% This is done to ensure bugfixes in the latex kernel. This has to be supplied for the users of
% older latex kernels. The provided package should be updated.
\RequirePackage[2018/12/01]{latexrelease}

%% Define the conference info here
\def \AESConferenceNumber {}
\def \AESConferencePrefix {International }
\def \AESConferenceType {}
\def \AESConferenceTopic {Machine Learning and Artificial Intelligence for Audio}
\def \AESConferenceLocation {London, UK}
\def \AESConferenceDate {2025 September 8--10}


% Define required new commands for correspondence, lastnames and shorttitle.
% Idea for these is from the old AES convention template by Adam H. Lewenberg.
\newcommand*{\correspondence}[2]{%
  \gdef\AESCorrAuthor{#1}%
  \gdef\AESCorrEmail{#2}%
}%
\newcommand*{\lastnames}[1]{\gdef\AESLastnames{#1}}%
\newcommand*{\shorttitle}[1]{\gdef\AESShortTitle{#1}}%

% Require some additional programming tools
\RequirePackage{etoolbox}

% Set some conditionals
\newtoggle{convention}
\newtoggle{peer_reviewed}
\newtoggle{express_paper}
\newtoggle{blind_review}

% Declare class options
\DeclareOption{convention}{
	\toggletrue{convention}
}
\DeclareOption{conference}{
	\togglefalse{convention}
}
\DeclareOption{peer-reviewed}{
	\toggletrue{peer_reviewed}
}
\DeclareOption{express-paper}{
	\toggletrue{express_paper}
	\togglefalse{peer_reviewed}
}
\DeclareOption{e-brief}{
	\typeout{*** WARNING: Option e-brief is deprecated! Use express-paper instead. ***}
	\toggletrue{express_paper}
	\togglefalse{peer_reviewed}
}
\DeclareOption{blind-review}{
	\toggletrue{blind_review}
}

\ExecuteOptions{convention}
\ProcessOptions\relax

% New command for express paper number
\gdef\AESExpressPaperNumber{}
\newcommand*{\ebriefnumber}[1]{\typeout{*** WARNING: Command briefnumber is deprecated! Use expresspapernumber instead. ***}\gdef\AESExpressPaperNumber{#1}}%
\newcommand*{\expresspapernumber}[1]{\gdef\AESExpressPaperNumber{\iftoggle{blind_review}{}{#1}}}%

%% These are the AES legal stuff included

\iftoggle{express_paper}{
\def \AESLegalTextPrefix {This Express Paper was selected on the basis of a submitted synopsis that has been peer-reviewed by at least two qualified anonymous reviewers. The complete manuscript was not peer reviewed. This Express Paper has been reproduced from the author’s advance manuscript without editing, corrections, or consideration by the Review Board. The AES takes no responsibility for the contents.}}
{\iftoggle{peer_reviewed}{
\def \AESLegalTextPrefix {This paper was peer-reviewed as a complete manuscript for presentation at this \iftoggle{convention}{convention}{conference}.}}
{\def \AESLegalTextPrefix {This \iftoggle{convention}{convention}{conference} paper was selected based on a submitted abstract and 750-word precis that have been peer reviewed by at least two qualified anonymous reviewers. The complete manuscript was not peer reviewed. This \iftoggle{convention}{convention}{conference} paper has been reproduced from the author's advance manuscript without editing, corrections, or consideration by the Review Board. The AES takes no responsibility for the contents.}}}
\def\AESLegalText{This paper is available in the AES E-Library (http://www.aes.org/e-lib), all rights reserved. Reproduction of this paper, or any portion thereof, is not permitted without direct permission from the Journal of the Audio Engineering Society.}





% First load the normal article class as we only modify it
\LoadClass[a4paper,10pt,oneside,twocolumn]{article}

% Make sure graphics are available
\RequirePackage{graphicx}

% Set general geometry
\setlength{\parindent}{0pt}
\setlength{\parskip}{0.7em plus 0.8em minus 0.5em}
\setlength{\columnsep}{2em}

% Setting the fonts
\RequirePackage[T1]{fontenc}
\RequirePackage{mathptmx}
\RequirePackage[scaled=.92]{helvet}
\RequirePackage{courier}


% Create placeholder for the AES top title. This has to be defined in the main tex to work
% properly with user parameters.
\newsavebox{\AEStop}

% Redefine abstract for our purposes
\RequirePackage{abstract}
\renewcommand{\abstractnamefont}{\sffamily\normalsize\bfseries\MakeUppercase}
\renewcommand{\abstracttextfont}{\normalsize}
\renewcommand{\absnamepos}{flushleft}
\setlength{\absleftindent}{0pt}
\setlength{\absrightindent}{0pt}
\setlength{\absparindent}{0pt}
\setlength{\absparsep}{0.5em plus 0.2em minus 0.2em}
\setlength{\abstitleskip}{-1.5em}



% Redefine main title
\RequirePackage{titling}
\pretitle{\vspace{-1.5cm}\usebox{\AEStop}\begin{flushleft}\LARGE\sffamily\bfseries}
\posttitle{\end{flushleft}}
\preauthor{\begin{flushleft}}
\postauthor{\par \vspace{0.5em} \iftoggle{blind_review}{}{\normalfont Correspondence should be addressed to \AESCorrAuthor \space (\texttt{\AESCorrEmail})} \end{flushleft} \vspace{-4.6em}}
\date{}

% This package is used for authors and affiliations in the main document
\RequirePackage{authblk}

\renewcommand\Authfont{\rmfamily\normalsize}
\renewcommand\Affilfont{\rmfamily\itshape\small}
\iftoggle{blind_review}{%
\gdef\@author{\LARGE{\bf\textcolor{red}{This \iftoggle{convention}{Convention}{Conference} uses blind reviewing, do not put author names, leave this space blank. On acceptance you will receive a new template to add author information.}}}%
\renewcommand\affil[2][]{}%
}{}





% Redefine section titles
\RequirePackage[bf,sf,small,raggedright,compact,pagestyles]{titlesec}

% Redefine headers (using above included titlesec)
% First we clear the plain style so the first page is correct
\renewpagestyle{plain}{
	\sethead[][][] % even
			{}{}{} % odd
	\setfoot[][][] % even
			{}{}{} % odd
}
% Then we define AES style for the rest of the article
\RequirePackage{lastpage}
\newpagestyle{AES}[\normalsize\sffamily]{
	\headrule%
	\renewcommand{\makeheadrule}{\rule[-.4\baselineskip]{\textwidth}{1.5pt}}%
	%\setheadrule{1.0pt}%
	\sethead[\iftoggle{blind_review}{}{\AESLastnames}][][\AESShortTitle] % even
			{\iftoggle{blind_review}{}{\AESLastnames}}{}{\AESShortTitle} % odd
	\footrule%
	\renewcommand{\makefootrule}{\rule[.8\baselineskip]{\textwidth}{1.5pt}}%
	%\setfootrule{1.5pt}%
	\setfoot[][
		\begin{tabular}[t]{c}%
			AES \ifx\AESConferenceNumber\empty\else\AESConferenceNumber\fi\iftoggle{convention}{Convention}{\AESConferencePrefix\ifx\AESConferenceType\empty Conference\else\AESConferenceType\fi\ on \AESConferenceTopic}\ifx\AESConferenceLocation\empty\else, \AESConferenceLocation\fi\\\AESConferenceDate\\%
			Page \thepage\ of \pageref{LastPage}%
		\end{tabular}%
	][] % even
		{}{%
		  \begin{tabular}[t]{c}%
			AES \ifx\AESConferenceNumber\empty\else\AESConferenceNumber\fi\iftoggle{convention}{Convention}{\AESConferencePrefix\ifx\AESConferenceType\empty Conference\else\AESConferenceType\fi\ on \AESConferenceTopic}\ifx\AESConferenceLocation\empty\else, \AESConferenceLocation\fi\\\AESConferenceDate\\%
			Page \thepage\ of \pageref{LastPage}%
		\end{tabular}%
	}{} % odd
}

\pagestyle{AES}

% Redefine captions
\RequirePackage[bf,hang]{caption}
\captionsetup[figure]{name=Fig.}



% AES top title. A little bit volatile but should work for now.
\savebox{\AEStop}{%
	\begin{minipage}{\textwidth}%
		\rule{\textwidth}{1.5pt}\\%
		\\%
		\begin{minipage}[c][\iftoggle{convention}{3.2cm}{3.7cm}][t]{0\textwidth}%
			\includegraphics[width=20mm]{AESlogo}%
		\end{minipage}%
		\begin{minipage}{\textwidth}%
			\sffamily%
			\begin{center}%
				\LARGE Audio Engineering Society\\%
				\iftoggle{express_paper}{%
				\hspace{3mm}\fontsize{36}{38pt}\selectfont Convention Express\\Paper \AESExpressPaperNumber\\%
				}{%
				\iftoggle{convention}{%
				\fontsize{36}{38pt}\selectfont Convention Paper\\%
				}{%
				\fontsize{36}{38pt}\selectfont Conference Paper\\%
				}}%
				\vspace{0.2cm}%
				\large Presented at the AES \ifx\AESConferenceNumber\empty\else\AESConferenceNumber\fi\iftoggle{convention}{Convention\\}{\AESConferencePrefix\ifx\AESConferenceType\empty Conference\else\AESConferenceType\fi\ on\\}%
				\iftoggle{convention}{}{\AESConferenceTopic\\}%
				\AESConferenceDate\ifx\AESConferenceLocation\empty\else, \AESConferenceLocation\fi%
			\end{center}%
		\end{minipage}\\%
		\vspace{0.2cm}\\%
		\begin{minipage}{\textwidth}%
			\rmfamily\itshape\small	\AESLegalTextPrefix\ \AESLegalText%
		\end{minipage}\\%
		\\%
		\rule{\textwidth}{1.5pt}%
	\end{minipage}%
}


\endinput

