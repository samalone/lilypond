%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.16"

\header {
  lsrtags = "staff-notation, contexts-and-engravers"

%% Translation of GIT committish: 2b0dc29608d6c3f5a03ead4877ae514c647adb74
  texidoces = "
Se puede usar el delimitador de comienzo de un sistema
@code{SystemStartSquare} estableciéndolo explícitamente dentro de
un contexto @code{StaffGroup} o @code{ChoirStaffGroup}.

"
  doctitlees = "Uso del corchete recto al comienzo de un grupo de pentagramas"

%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Die Klammer zu Beginn von Systemgruppen kann auch in eine eckige Klammer
(@code{SystemStartSquare}) umgewandelt werden, wenn man sie explizit
im @code{StaffGroup}- oder @code{ChoirStaffGroup}-Kontext setzt.

"
  doctitlede = "Eine eckige Klammer zu Beginn von Systemgruppen benutzen"
%% Translation of GIT committish: 99dc90bbc369722cf4d3bb9f30b7288762f2167f6
  texidocfr = "
Un regroupement de portées sera indiqué par un simple rectangle
-- @code{SystemStartSquare} -- en début de ligne dès lors que vous le
mentionnerez explicitement au sein d'un contexte @code{StaffGroup} ou
@code{ChoirStaffGroup}. 

"
  doctitlefr = "Indication de regroupement de portées par un rectangle"


  texidoc = "
The system start delimiter @code{SystemStartSquare} can be used by
setting it explicitly in a @code{StaffGroup} or @code{ChoirStaffGroup}
context.

"
  doctitle = "Use square bracket at the start of a staff group"
} % begin verbatim

\score {
  \new StaffGroup { <<
  \set StaffGroup.systemStartDelimiter = #'SystemStartSquare
    \new Staff { c'4 d' e' f' }
    \new Staff { c'4 d' e' f' }
  >> }
}

