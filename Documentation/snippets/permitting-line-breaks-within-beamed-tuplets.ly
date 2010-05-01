%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.16"

\header {
  lsrtags = "rhythms"

%% Translation of GIT committish: 2b0dc29608d6c3f5a03ead4877ae514c647adb74
 doctitlees = "Permitir saltos de línea dentro de grupos especiales con barra"
 texidoces = "
Este ejemplo artificial muestra cómo se pueden permitir tanto los
saltos de línea manuales como los automáticos dentro de un grupo de
valoración especial unido por una barra.  Observe que estos grupos
sincopados se deben barrar manualmente.

"

%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Dieses künstliche Beispiel zeigt, wie sowohl automatische als auch
manuelle Zeilenumbrüche innerhalb einer N-tole mit Balken erlaubt
werden können.  Diese unregelmäßige Bebalkung muss allerdings manuell
gesetzt werden.

"
  doctitlede = "Zeilenumbrüche bei N-tolen mit Balken erlauben"


%% Translation of GIT committish: 4da4307e396243a5a3bc33a0c2753acac92cb685
  texidocfr = "
Cet exemple peu académique démontre comment il est possible d'insérer un saut
de ligne dans un nolet portant une ligature.  Ces ligatures doivent toutefois
être explicites.

"
  doctitlefr = "Saut de ligne au milieu d'un nolet avec ligature"

  texidoc = "
This artificial example shows how both manual and automatic line breaks
may be permitted to within a beamed tuplet. Note that such off-beat
tuplets have to be beamed manually.

"
  doctitle = "Permitting line breaks within beamed tuplets"
} % begin verbatim

\layout {
  \context {
    \Voice
    % Permit line breaks within tuplets
    \remove "Forbid_line_break_engraver"
    % Allow beams to be broken at line breaks
    \override Beam #'breakable = ##t
  }
}
\relative c'' {
  a8
  \repeat unfold 5 { \times 2/3 { c[ b a] } }
  % Insert a manual line break within a tuplet
  \times 2/3 { c[ b \bar "" \break a] }
  \repeat unfold 5 { \times 2/3 { c[ b a] } }
  c8
}

