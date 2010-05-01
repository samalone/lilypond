%% Do not edit this file; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.13.16"

\header {
  lsrtags = "fretted-strings"

%% Translation of GIT committish: 2b0dc29608d6c3f5a03ead4877ae514c647adb74
  texidoces = "
En este ejemplo se combinan las digitaciones de la mano izquierda,
indicaciones del número de cuerda y digitaciones de la mano
derecha.

"
  doctitlees = "Digitaciones - indicación del número de cuerda y digitaciones de mano derecha"

%% Translation of GIT committish: 0a868be38a775ecb1ef935b079000cebbc64de40
  texidocde = "
Dieses Beispiel kombiniert Fingersatz für die linke Hand, Saitennummern
und Fingersatz für die rechte Hand.

"
  doctitlede = "Fingersatz Saitennummern und Fingersatz für die rechte Hand"
%% Translation of GIT committish: ac6297e4fa174ac5759cc450ad085c2fac9ba00b

  texidocfr = "
L'exemple suivant illustre comment combiner des doigtés pour la main
gauche, des indications de corrde et des doigtés pour la main droite.

"
  doctitlefr = "Doigtés indications de cordeet doigtés main droite"


  texidoc = "
This example combines left-hand fingering, string indications, and
right-hand fingering.

"
  doctitle = "Fingerings string indications and right-hand fingerings"
} % begin verbatim

#(define RH rightHandFinger)

\relative c {
  \clef "treble_8"
  <c-3\5-\RH #1 >4
  <e-2\4-\RH #2 >4
  <g-0\3-\RH #3 >4
  <c-1\2-\RH #4 >4
}

