%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.1"

\header {
  lsrtags = "expressive-marks, tweaks-and-overrides"

%% Translation of GIT committish: dff50e8e1d3134657a6b6203b9c93826dc4cef65
  texidoces = "
Si la nota que da fin a un regulador cae sobre la primera parte de
un compás, el regulador se detiene en la línea divisoria
inmediatamente precedente.  Se puede controlar este comportamiento
sobreescribiendo la propiedad @code{to-barline}.

"
  doctitlees = "Establecer el comportamiento de los reguladores en las barras de compás"
  
%% Translation of GIT committish: 6ce7f350682dfa99af97929be1dec6b9f1cbc01a
texidocde = "
Wenn die Note, an welcher eine Crescendo-Klammer endet, die erste Note
eines Taktes ist, wird die Klammer an der vorhergehenden Tatklinie
beendet.  Dieses Verhalten kann auch mit der Eigenschaft
@code{'to-barline} geändert werden:
"
  doctitlede = "Das Verhalten von Crescendo-Klammern an Taktlinien beeinflussen"

  texidoc = "
If the note which ends a hairpin falls on a downbeat, the hairpin stops
at the bar line immediately preceding.  This behavior can be controlled
by overriding the @code{'to-barline} property.

"
  doctitle = "Setting hairpin behavior at bar lines"
} % begin verbatim

\relative c'' {
  e4\< e2.
  e1\!
  \override Hairpin #'to-barline = ##f
  e4\< e2.
  e1\!
}