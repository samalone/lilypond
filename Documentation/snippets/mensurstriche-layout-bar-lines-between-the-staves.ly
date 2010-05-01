%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.16"

\header {
  lsrtags = "staff-notation, ancient-notation, contexts-and-engravers, tweaks-and-overrides"

%% Translation of GIT committish: 2b0dc29608d6c3f5a03ead4877ae514c647adb74
  texidoces = "
La disposición «mensurstriche» en que las líneas divisorias no
están dibujadas sobre los pentagramas, sino entre ellos, se puede
conseguir con un @code{StaffGroup} en vez de un @code{ChoirStaff}.
La línea divisoria sobre los pentagramas se borra estableciendo la
propiedad @code{transparent}.

"

  doctitlees = "Disposición Mensurstriche (líneas divisorias entre pentagramas)"

%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Das Mensurstiche-Layout, in welchem die Taktlinien nicht auf den Systemen,
sondern zwischen den Systemen gesetzt werden, kann mit einer @code{StaffGroup}
anstelle von @code{ChoirStaff} erreicht werden.  Die Taktlinien auf den
Systemen werden mit der the @code{transparent}-Eigenschaft ausgelöscht.

"
  doctitlede = "Mensurstriche-Layout (Taktstriche zwischen den Systemen"
%% Translation of GIT committish: 99dc90bbc369722cf4d3bb9f30b7288762f2167f6
  texidocfr = "
En musique mensurale, les barres de mesure ne traversent pas les
portées.  Pour obtenir ce résultat avec un @code{StaffGroup} plutôt
qu'en utilisant un @code{ChoirStaff}, il faudra rendre « transparentes »
les portions de barre qui recouvrent les portées.

"
  doctitlefr = "Présentation à l'ancienne (barres de mesure entre les portées)"


  texidoc = "
The mensurstriche-layout where the bar lines do not show on the staves
but between staves can be achieved with a @code{StaffGroup} instead of
a @code{ChoirStaff}.  The bar line on staves is blanked out by setting
the @code{transparent} property.

"
  doctitle = "Mensurstriche layout (bar lines between the staves)"
} % begin verbatim

global = {
  \override Staff.BarLine #'transparent = ##t
  s1 s
  % the final bar line is not interrupted
  \revert Staff.BarLine #'transparent
  \bar "|."
}
\new StaffGroup \relative c'' {
  <<
    \new Staff { << \global { c1 c } >> }
    \new Staff { << \global { c c } >> }
  >>
}

