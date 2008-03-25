% property-init.ly

\version "2.11.38"

stemUp = \override Stem  #'direction = #UP
stemDown = \override Stem  #'direction = #DOWN 
stemNeutral= \revert Stem #'direction

slurUp = \override Slur  #'direction = #UP
slurDown = \override Slur  #'direction = #DOWN
slurNeutral = \revert Slur #'direction

%% There's also dash, but setting dash period/length should be fixed.
slurDashed = {
  \override Slur #'dash-period = #0.75
  \override Slur #'dash-fraction = #0.4
}
slurDotted = {
  \override Slur  #'dash-period = #0.75
  \override Slur #'dash-fraction = #0.1
}
slurSolid = {
  \revert Slur #'dash-period
  \revert Slur #'dash-fraction
}


phrasingSlurUp = \override PhrasingSlur  #'direction = #UP
phrasingSlurDown = \override PhrasingSlur  #'direction = #DOWN
phrasingSlurNeutral = \revert PhrasingSlur #'direction

shiftOn = \override NoteColumn  #'horizontal-shift = #1
shiftOnn = \override NoteColumn  #'horizontal-shift = #2
shiftOnnn = \override NoteColumn  #'horizontal-shift = #3
shiftOff = \revert NoteColumn #'horizontal-shift

tieUp = \override Tie  #'direction = #UP
tieDown = \override Tie  #'direction = #DOWN
tieNeutral = \revert Tie #'direction

tieDashed = {
  \override Tie #'dash-period = #0.75
  \override Tie #'dash-fraction = #0.4
}
tieDotted = {
  \override Tie #'dash-period = #0.75
  \override Tie #'dash-fraction = #0.1
}
tieSolid = {
  \revert Tie #'dash-period
  \revert Tie #'dash-fraction
}

easyHeadsOn = {
  \override NoteHead  #'stencil = #ly:note-head::brew-ez-stencil
  \override NoteHead #'font-size = #-7
  \override NoteHead #'font-family = #'sans
  \override NoteHead #'font-series = #'bold
}

easyHeadsOff = {
  \revert NoteHead #'stencil
  \revert NoteHead #'font-size
  \revert NoteHead #'font-family
  \revert NoteHead #'font-series
}

aikenHeads = \set shapeNoteStyles = ##(do re mi fa #f la ti)

sacredHarpHeads =
  \set shapeNoteStyles = ##(fa #f la fa #f la mi)

dynamicUp = {
  \override DynamicText  #'direction = #UP
  \override DynamicLineSpanner  #'direction = #UP
}

dynamicDown = {
  \override DynamicText  #'direction = #DOWN
  \override DynamicLineSpanner  #'direction = #DOWN
}

dynamicNeutral = {
  \revert DynamicText #'direction
  \revert DynamicLineSpanner #'direction
}


dotsUp = \override Dots  #'direction = #UP
dotsDown = \override Dots  #'direction = #DOWN
dotsNeutral = \revert Dots #'direction 

tupletUp = \override TupletBracket  #'direction = #UP
tupletDown = \override TupletBracket  #'direction = #DOWN
tupletNeutral = \revert TupletBracket #'direction

cadenzaOn = \set Timing.timing = ##f
cadenzaOff = {
  \set Timing.timing = ##t
  \set Timing.measurePosition = #ZERO-MOMENT
}

% dynamic ly:dir?  text script, articulation script ly:dir?	
oneVoice = #(context-spec-music (make-voice-props-revert) 'Voice)
voiceOne = #(context-spec-music (make-voice-props-set 0) 'Voice)
voiceTwo = #(context-spec-music (make-voice-props-set 1) 'Voice)
voiceThree =#(context-spec-music (make-voice-props-set 2) 'Voice)
voiceFour = #(context-spec-music (make-voice-props-set 3) 'Voice)

voiceOneStyle = {
  \override NoteHead #'style = #'diamond
  \override NoteHead #'color = #red
  \override Stem #'color = #red
  \override Beam #'color = #red
}
voiceTwoStyle = {
  \override NoteHead #'style = #'triangle
  \override NoteHead #'color = #blue
  \override Stem #'color = #blue
  \override Beam #'color = #blue
}
voiceThreeStyle = {
  \override NoteHead #'style = #'xcircle
  \override NoteHead #'color = #green
  \override Stem #'color = #green
  \override Beam #'color = #green
}
voiceFourStyle = {
  \override NoteHead #'style = #'cross
  \override NoteHead #'color = #magenta
  \override Stem #'color = #magenta
  \override Beam #'color = #magenta
}
voiceNeutralStyle = {
  \revert NoteHead #'style
  \revert NoteHead #'color
  \revert Stem #'color
  \revert Beam #'color
}

	
tiny = {
  \set fontSize = #-2
}

small = {
  \set fontSize = #-1
}

normalsize = {
  \set fontSize = #0
}

large = {
  \set fontSize = #1
}

huge = {
  \set fontSize = #2
}

%% End the incipit and print a ``normal line start''.
endincipit =  \context Staff {
  \partial 16 s16  % Hack to handle e.g. \bar ".|" \endincipit
  \once \override Staff.Clef  #'full-size-change = ##t
  \once \override Staff.Clef  #'non-default = ##t
  \bar ""
}

autoBeamOff = \set autoBeaming = ##f
autoBeamOn = \set autoBeaming = ##t

textLengthOn = {
  \override TextScript  #'extra-spacing-width = #'(0 . 0)
  \override TextScript  #'infinite-spacing-height = ##t
}

textLengthOff = {
  \override TextScript  #'extra-spacing-width = #'(+inf.0 . -inf.0)
  \override TextScript  #'infinite-spacing-height = ##f
}

showStaffSwitch = \set followVoice = ##t
hideStaffSwitch = \set followVoice = ##f

expandFullBarRests = {
  \set Score.skipBars = ##f
}

compressFullBarRests = {
  \set Score.skipBars = ##t
}

numericTimeSignature = {
  \override Staff.TimeSignature #'style = #'()
}


% For drawing vertical chord brackets with \arpeggio
% This is a shorthand for the value of the print-function property 
% of either Staff.Arpeggio or PianoStaff.Arpeggio, depending whether 
% cross-staff brackets are desired. 

arpeggio = #(make-music 'ArpeggioEvent)

arpeggioUp = \sequential {
  \revert Arpeggio  #'stencil
  \override Arpeggio  #'arpeggio-direction = #UP
}
arpeggioDown = \sequential {
  \revert Arpeggio #'stencil
  \override Arpeggio  #'arpeggio-direction = #DOWN
}
arpeggioNeutral = \sequential {
  \revert Arpeggio #'stencil
  \revert Arpeggio  #'arpeggio-direction
}
arpeggioBracket = \sequential {
  \override Arpeggio #'stencil = #ly:arpeggio::brew-chord-bracket
}

glissando = #(make-music 'GlissandoEvent)

fermataMarkup = \markup { \musicglyph #"scripts.ufermata" } 

hideNotes =\sequential {
  % hide notes, accidentals, etc.
  \override Dots  #'transparent = ##t
  \override NoteHead  #'transparent = ##t
  \override NoteHead  #'no-ledgers = ##t
  \override Stem  #'transparent = ##t
  \override Beam  #'transparent = ##t
  \override Accidental  #'transparent = ##t
}


unHideNotes = \sequential {
  \revert Accidental #'transparent
  \revert Beam #'transparent
  \revert Stem #'transparent
  \revert NoteHead #'transparent
  \revert NoteHead #'no-ledgers
  \revert Dots #'transparent 
}

germanChords = {
    \set chordRootNamer = #(chord-name->german-markup #t)
    \set chordNoteNamer = #note-name->german-markup
}
semiGermanChords = {
    \set chordRootNamer = #(chord-name->german-markup #f)
    \set chordNoteNamer = #note-name->german-markup
}

frenchChords = {
    \set chordRootNamer = #(chord-name->italian-markup #t)
    \set chordPrefixSpacer = #0.4
}

italianChords = {
    \set chordRootNamer = #(chord-name->italian-markup #f)
    \set chordPrefixSpacer = #0.4
}

improvisationOn =  {
    \set squashedPosition = #0
    \override NoteHead  #'style = #'slash
    \override Accidental #'stencil = ##f
}

improvisationOff =  {
    \unset squashedPosition 
    \revert NoteHead #'style
    \revert Accidental #'stencil
}

textSpannerUp = \override TextSpanner #'direction = #UP
textSpannerDown = \override TextSpanner #'direction = #DOWN
textSpannerNeutral = \revert TextSpanner #'direction


