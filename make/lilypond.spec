Name: lilypond
Version: 0.0.55
Release: 1
Copyright: GPL
Group: Applications/Publishing
Source0: pcnov095.win.tue.nl:/pub/lilypond/lilypond-0.0.55.tar.gz
Summary: A preprocessor to make TeX typeset music.
URL: http://www.stack.nl/~hanwen/lilypond
Packager: Han-Wen Nienhuys <hanwen@stack.nl>
Icon: lelie_icon.gif
Buildroot: /tmp/lilypond_build

%description
LilyPond is a program which converts a music-script (mudela) into
TeX output, or MIDI to produce multi-staff scores. Features include multiple
meters, clefs, keys, lyrics, versatile input-language, cadenzas
beams, slurs, triplets, multiple voices.

%prep
%setup
%build
configure --enable-checking --disable-debugging --enable-printing --prefix=/usr --enable-optimise --enable-shared
make all
%install
strip bin/lilypond bin/mi2mu
make prefix="$RPM_BUILD_ROOT/usr" install
%files
%doc Documentation/out/AUTHORS.text Documentation/out/CodingStyle.text Documentation/out/INSTALL.text Documentation/out/MANIFESTO.text Documentation/out/convert-mudela.text Documentation/out/error.text Documentation/out/examples.text Documentation/out/faq.text Documentation/out/index.text Documentation/out/language.text Documentation/out/lilygut.text Documentation/out/lilypond.text Documentation/out/mudela.text input/cadenza.ly input/collisions.ly input/coriolan-alto.ly input/error.ly input/fugue1.midi.ly input/kortjakje.ly input/maartje.ly input/martien.ly input/martien.tex input/mlalt.ly input/mlcello.ly input/mlvio1.ly input/mlvio2.ly input/plet.ly input/pre1.midi.ly input/rhythm.ly input/scales.ly input/scsii-menuetto.ly input/scsii-menuetto.tex input/standchen.ly input/standchen.tex input/twinkle.ly input/wohltemperirt.ly Documentation/lelie_logo.gif
/usr/bin/convert-mudela
/usr/bin/lilypond
/usr/lib/libflower.so
/usr/bin/mi2mu
/usr/man/man1/lilypond.1
/usr/man/man5/mudela.5
/usr/man/man1/convert-mudela.1
/usr/lib/texmf/texmf/tex/lilypond/
/usr/lib/texmf/texmf/fonts/source/lilypond/
/usr/share/lilypond/

%post
texhash
%post
texhash

