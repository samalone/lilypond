\header{
title =         "Imellem Fjeldene. Ouverture";
composer =      "Niels W Gade";
enteredby =     "Mats Bengtsson";
latexheaders =  "\\input global";
copyright =	"Mats Bengtsson, 1999. Free circulation permitted and " + 
		"encouraged.\\\\ Typeset from handwritten parts at " +
		"Statens Musikbibliotek, Stockholm, Sweden";
}

\version "1.0.20";

\include "global.ly"
\include "wood.ly"
\include "brass.ly"
\include "strings.ly"

my_paper = \paper {
  textheight = 275.0 \mm;
  \translator {
    \OrchestralPartStaffContext
    textScriptPadding = 5.0;
  }
  \translator { 
    \ScoreContext
    skipBars = 1;
    markScriptPadding = "6.0";
    textstyle = "italic";
    textEmptyDimension = 1;
    oldTieBehavior = 1;
  }
  \translator { \VoiceContext
    oldTieBehavior = 1;
    textstyle = "italic";
    textEmptyDimension = 1;
  }
}

\score{
  \context Staff <
    \global
    \marks
    \flauto
    \flautohelp
  >
  \header{
    instrument = "Flauto";
  }
  \paper{
    \my_paper
    output = "flauto";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \global
    \marks
    \oboe
    \oboehelp
  >
  \header{
    instrument = "Oboe";
  }
  \paper{
    \my_paper
    output = "oboe";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \globalNoKey
    \marks
    \clarI
  >
  \header{
    instrument = "Clarinetto I in B\\textflat";
  }
  \paper{
    \my_paper
    output = "clarI";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \globalNoKey
    \marks
    \clarII
  >
  \header{
    instrument = "Clarinetto II in B\\textflat";
  }
  \paper{
    \my_paper
    output = "clarII";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \global
    \marks
    \fagotto
  >
  \header{
    instrument = "Fagotto";
  }
  \paper{
    \my_paper
    output = "fagotto";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \globalNoKey
    \marks
    \corI
    \corIhelp
  >
  \header{
    instrument = "Corno I in F";
  }
  \paper{
    \my_paper
    output = "corI";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \globalNoKey
    \marks
    \corII
    \corIIhelp
  >
  \header{
    instrument = "Corno II in F";
  }
  \paper{
    \my_paper
    output = "corII";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \globalNoKey
    \marks
    \trpI
    \trpIhelp
  >
  \header{
    instrument = "Tromba I in B\\textflat";
  }
  \paper{
    \my_paper
    output = "trpI";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \globalNoKey
    \marks
    \trpII
    \trpIIhelp
  >
  \header{
    instrument = "Tromba II in B\\textflat";
  }
  \paper{
    \my_paper
    output = "trpII";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \globalNoKey
    \marks
    \timpani
    \timphelp
  >
  \header{
    instrument = "Timpani \& Triangolo";
  }
  \paper{
    \my_paper
    output = "timpani";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \global
    \marks
    \viI
  >
  \header{
    instrument = "Violino I";
  }
  \paper{
    \my_paper
    output = "viI";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \global
    \marks
    \viII
  >
  \header{
    instrument = "Violino II";
  }
  \paper{
    \my_paper
    output = "viII";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \global
    \marks
    \notes{s2.*32 s2*142 \break}
    \vla
  >
  \header{
    instrument = "Viola";
  }
  \paper{
    \my_paper
    output = "viola";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \global
    \marks
    \vlc
  >
  \header{
    instrument = "Violoncello";
  }
  \paper{
    \my_paper
    output = "violoncello";
  }
  \midi {
    \tempo 4=120;
  }
}

\score{
  \context Staff <
    \global
    \marks
    \cb
  >
  \header{
    instrument = "Contrabasso";
  }
  \paper{
    \my_paper
    output = "cb";
  }
  \midi {
    \tempo 4=120;
  }
}
