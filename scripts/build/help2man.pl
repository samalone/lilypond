#!@PERL@ -w

# Generate a short man page from --help and --version output.
# Copyright (C) 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2009,
# 2010, 2011, 2012 Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.

# Written by Brendan O'Dea <bod@debian.org>
# Available from ftp://ftp.gnu.org/gnu/help2man/

use 5.008;
use strict;
use Getopt::Long;
use Text::Tabs qw(expand);
use POSIX qw(strftime setlocale LC_ALL);

my $this_program = 'help2man';
my $this_version = '1.40.12';

sub _ { $_[0] }
sub configure_locale
{
    my $locale = shift;
    die "$this_program: no locale support (Locale::gettext required)\n"
	unless $locale eq 'C';
}

sub dec { $_[0] }
sub enc { $_[0] }
sub enc_user { $_[0] }
sub kark { die +(sprintf shift, @_), "\n" }
sub N_ { $_[0] }

my $version_info = enc_user sprintf _(<<'EOT'), $this_program, $this_version;
GNU %s %s

Copyright (C) 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004, 2005, 2009, 2010,
2011, 2012 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Written by Brendan O'Dea <bod@debian.org>
EOT

my $help_info = enc_user sprintf _(<<'EOT'), $this_program, $this_program;
`%s' generates a man page out of `--help' and `--version' output.

Usage: %s [OPTION]... EXECUTABLE

 -n, --name=STRING       description for the NAME paragraph
 -s, --section=SECTION   section number for manual page (1, 6, 8)
 -m, --manual=TEXT       name of manual (User Commands, ...)
 -S, --source=TEXT       source of program (FSF, Debian, ...)
 -L, --locale=STRING     select locale (default "C")
 -i, --include=FILE      include material from `FILE'
 -I, --opt-include=FILE  include material from `FILE' if it exists
 -o, --output=FILE       send output to `FILE'
 -p, --info-page=TEXT    name of Texinfo manual
 -N, --no-info           suppress pointer to Texinfo manual
 -l, --libtool           exclude the `lt-' from the program name
     --help              print this help, then exit
     --version           print version number, then exit

EXECUTABLE should accept `--help' and `--version' options and produce output on
stdout although alternatives may be specified using:

 -h, --help-option=STRING     help option string
 -v, --version-option=STRING  version option string
 --version-string=STRING      version string
 --no-discard-stderr          include stderr when parsing option output

Report bugs to <bug-help2man@gnu.org>.
EOT

my $section = 1;
my $manual = '';
my $source = '';
my $help_option = '--help';
my $version_option = '--version';
my $discard_stderr = 1;
my ($opt_name, @opt_include, $opt_output, $opt_info, $opt_no_info, $opt_libtool,
    $version_text);

my %opt_def = (
    'n|name=s'		 => \$opt_name,
    's|section=s'	 => \$section,
    'm|manual=s'	 => \$manual,
    'S|source=s'	 => \$source,
    'L|locale=s'	 => sub { configure_locale pop },
    'i|include=s'	 => sub { push @opt_include, [ pop, 1 ] },
    'I|opt-include=s'	 => sub { push @opt_include, [ pop, 0 ] },
    'o|output=s'	 => \$opt_output,
    'p|info-page=s'	 => \$opt_info,
    'N|no-info'		 => \$opt_no_info,
    'l|libtool'		 => \$opt_libtool,
    'help'		 => sub { print $help_info; exit },
    'version'		 => sub { print $version_info; exit },
    'h|help-option=s'	 => \$help_option,
    'v|version-option=s' => \$version_option,
    'version-string=s'	 => \$version_text,
    'discard-stderr!'	 => \$discard_stderr,
);

# Parse options.
Getopt::Long::config('bundling');
die $help_info unless GetOptions %opt_def and @ARGV == 1;

my %include = ();
my %append = ();
my @include = (); # retain order given in include file

# Process include file (if given).  Format is:
#
#   [section name]
#   verbatim text
#
# or
#
#   /pattern/
#   verbatim text
#

while (@opt_include)
{
    my ($inc, $required) = @{shift @opt_include};

    next unless -f $inc or $required;
    kark N_("%s: can't open `%s' (%s)"), $this_program, $inc, $!
	unless open INC, $inc;

    my $key;
    my $hash = \%include;

    while (<INC>)
    {
	# Convert input to internal Perl format, so that multibyte
	# sequences are treated as single characters.
	$_ = dec $_;

	# [section]
	if (/^\[([^]]+)\]\s*$/)
	{
	    $key = uc $1;
	    $key =~ s/^\s+//;
	    $key =~ s/\s+$//;
	    $hash = \%include;
	    push @include, $key unless $include{$key};
	    next;
	}

	# /pattern/
	if (m!^/(.*)/([ims]*)\s*$!)
	{
	    my $pat = $2 ? "(?$2)$1" : $1;

	    # Check pattern.
	    eval { $key = qr($pat) };
	    if ($@)
	    {
		$@ =~ s/ at .*? line \d.*//;
		die "$inc:$.:$@";
	    }

	    $hash = \%append;
	    next;
	}

	# Check for options before the first section--anything else is
	# silently ignored, allowing the first for comments and
	# revision info.
	unless ($key)
	{
	    # handle options
	    if (/^-/)
	    {
		local @ARGV = split;
		GetOptions %opt_def;
	    }

	    next;
	}

	$hash->{$key} ||= '';
	$hash->{$key} .= $_;
    }

    close INC;

    kark N_("%s: no valid information found in `%s'"), $this_program, $inc
	unless $key;
}

# Compress trailing blank lines.
for my $hash (\(%include, %append))
{
    for (keys %$hash) { $hash->{$_} =~ s/\n+$/\n/ }
}

sub get_option_value;

# Grab help and version info from executable.
my $help_text   = get_option_value $ARGV[0], $help_option;
$version_text ||= get_option_value $ARGV[0], $version_option;

# Translators: the following message is a strftime(3) format string, which in
# the English version expands to the month as a word and the full year.  It
# is used on the footer of the generated manual pages.  If in doubt, you may
# just use %x as the value (which should be the full locale-specific date).
my $date = enc strftime _("%B %Y"), localtime;
(my $program = $ARGV[0]) =~ s!.*/!!;
my $package = $program;
my $version;

if ($opt_output)
{
    unlink $opt_output or kark N_("%s: can't unlink %s (%s)"),
	$this_program, $opt_output, $! if -e $opt_output;

    open STDOUT, ">$opt_output"
	or kark N_("%s: can't create %s (%s)"), $this_program, $opt_output, $!;
}

# The first line of the --version information is assumed to be in one
# of the following formats:
#
#   <version>
#   <program> <version>
#   {GNU,Free} <program> <version>
#   <program> ({GNU,Free} <package>) <version>
#   <program> - {GNU,Free} <package> <version>
#
# and separated from any copyright/author details by a blank line.

($_, $version_text) = ((split /\n+/, $version_text, 2), '');

if (/^(\S+) +\(((?:GNU|Free) +[^)]+)\) +(.*)/ or
    /^(\S+) +- *((?:GNU|Free) +\S+) +(.*)/)
{
    $program = $1;
    $package = $2;
    $version = $3;
}
elsif (/^((?:GNU|Free) +)?(\S+) +(.*)/)
{
    $program = $2;
    $package = $1 ? "$1$2" : $2;
    $version = $3;
}
else
{
    $version = $_;
}

$program =~ s!.*/!!;

# No info for `info' itself.
$opt_no_info = 1 if $program eq 'info';

# Translators: "NAME", "SYNOPSIS" and other one or two word strings in all
# upper case are manual page section headings.  The man(1) manual page in your
# language, if available should provide the conventional translations.
for ($include{_('NAME')})
{
    if ($opt_name) # --name overrides --include contents.
    {
	$_ = "$program \\- $opt_name\n";
    }
    elsif ($_) # Use first name given as $program
    {
	$program = $1 if /^([^\s,]+)(?:,?\s*[^\s,\\-]+)*\s+\\?-/;
    }
    else # Set a default (useless) NAME paragraph.
    {
	$_ = sprintf _("%s \\- manual page for %s %s") . "\n", $program,
	    $program, $version;
    }
}

# Man pages traditionally have the page title in caps.
my $PROGRAM = uc $program;

# Set default page head/footers
$source ||= "$program $version";
unless ($manual)
{
    for ($section)
    {
	if (/^(1[Mm]|8)/) { $manual = enc _('System Administration Utilities') }
	elsif (/^6/)	  { $manual = enc _('Games') }
	else		  { $manual = enc _('User Commands') }
    }
}

# Extract usage clause(s) [if any] for SYNOPSIS.
# Translators: "Usage" and "or" here are patterns (regular expressions) which
# are used to match the usage synopsis in program output.  An example from cp
# (GNU coreutils) which contains both strings:
#  Usage: cp [OPTION]... [-T] SOURCE DEST
#    or:  cp [OPTION]... SOURCE... DIRECTORY
#    or:  cp [OPTION]... -t DIRECTORY SOURCE...
my $PAT_USAGE = _('Usage');
my $PAT_USAGE_CONT = _('or');
if ($help_text =~ s/^($PAT_USAGE):( +(\S+))(.*)((?:\n(?: {6}\1| *($PAT_USAGE_CONT): +\S).*)*)//om)
{
    my @syn = $3 . $4;

    if ($_ = $5)
    {
	s/^\n//;
	for (split /\n/) { s/^ *(($PAT_USAGE_CONT): +)?//o; push @syn, $_ }
    }

    my $synopsis = '';
    for (@syn)
    {
	$synopsis .= ".br\n" if $synopsis;
	s!^\S*/!!;
	s/^lt-// if $opt_libtool;
	s/^(\S+) *//;
	$synopsis .= ".B $1\n";
	s/\s+$//;
	s/(([][]|\.\.+)+)/\\fR$1\\fI/g;
	s/^/\\fI/ unless s/^\\fR//;
	$_ .= '\fR';
	s/(\\fI)( *)/$2$1/g;
	s/\\fI\\fR//g;
	s/^\\fR//;
	s/\\fI$//;
	s/^\./\\&./;

	$synopsis .= "$_\n";
    }

    $include{_('SYNOPSIS')} ||= $synopsis;
}

# Process text, initial section is DESCRIPTION.
my $sect = _('DESCRIPTION');
$_ = "$help_text\n\n$version_text";

# Normalise paragraph breaks.
s/^\n+//;
s/\n*$/\n/;
s/\n\n+/\n\n/g;

# Join hyphenated lines.
s/([A-Za-z])-\n *([A-Za-z])/$1$2/g;

# Temporarily exchange leading dots, apostrophes and backslashes for
# tokens.
s/^\./\x80/mg;
s/^'/\x81/mg;
s/\\/\x82/g;

# Translators: patterns are used to match common program output. In the source
# these strings are all of the form of "my $PAT_something = _('...');" and are
# regular expressions.  If there is more than one commonly used string, you
# may separate alternatives with "|".  Spaces in these expressions are written
# as " +" to indicate that more than one space may be matched.  The string
# "(?:[\\w-]+ +)?" in the bug reporting pattern is used to indicate an
# optional word, so that either "Report bugs" or "Report _program_ bugs" will
# be matched.
my $PAT_BUGS		= _('Report +(?:[\w-]+ +)?bugs|Email +bug +reports +to');
my $PAT_AUTHOR		= _('Written +by');
my $PAT_OPTIONS		= _('Options');
my $PAT_ENVIRONMENT	= _('Environment');
my $PAT_FILES		= _('Files');
my $PAT_EXAMPLES	= _('Examples');
my $PAT_FREE_SOFTWARE	= _('This +is +free +software');

# Start a new paragraph (if required) for these.
s/([^\n])\n($PAT_BUGS|$PAT_AUTHOR) /$1\n\n$2 /og;

# Convert iso-8859-1 copyright symbol or (c) to nroff
# character.
s/^Copyright +(?:\xa9|\([Cc]\))/Copyright \\(co/mg;

sub convert_option;

while (length)
{
    # Convert some standard paragraph names.
    if (s/^($PAT_OPTIONS): *\n//o)
    {
	$sect = _('OPTIONS');
	next;
    }
    if (s/^($PAT_ENVIRONMENT): *\n//o)
    {
	$sect = _('ENVIRONMENT');
	next;
    }
    if (s/^($PAT_FILES): *\n//o)
    {
	$sect = _('FILES');
	next;
    }
    elsif (s/^($PAT_EXAMPLES): *\n//o)
    {
	$sect = _('EXAMPLES');
	next;
    }

    # Copyright section
    if (/^Copyright /)
    {
	$sect = _('COPYRIGHT');
    }

    # Bug reporting section.
    elsif (/^($PAT_BUGS) /o)
    {
	$sect = _('REPORTING BUGS');
    }

    # Author section.
    elsif (/^($PAT_AUTHOR)/o)
    {
	$sect = _('AUTHOR');
    }

    # Examples, indicated by an indented leading $, % or > are
    # rendered in a constant width font.
    if (/^( +)([\$\%>] )\S/)
    {
	my $indent = $1;
	my $prefix = $2;
	my $break = '.IP';
	$include{$sect} ||= '';
	while (s/^$indent\Q$prefix\E(\S.*)\n*//)
	{
	    $include{$sect} .= "$break\n\\f(CW$prefix$1\\fR\n";
	    $break = '.br';
	}

	next;
    }

    my $matched = '';
    $include{$sect} ||= '';

    # Sub-sections have a trailing colon and the second line indented.
    if (s/^(\S.*:) *\n / /)
    {
	$matched .= $& if %append;
	$include{$sect} .= qq(.SS "$1"\n);
    }

    my $indent = 0;
    my $content = '';

    # Option with description.
    if (s/^( {1,10}([+-]\S.*?))(?:(  +(?!-))|\n( {20,}))(\S.*)\n//)
    {
	$matched .= $& if %append;
	$indent = length ($4 || "$1$3");
	$content = ".TP\n\x84$2\n\x84$5\n";
	unless ($4)
	{
	    # Indent may be different on second line.
	    $indent = length $& if /^ {20,}/;
	}
    }

    # Option without description.
    elsif (s/^ {1,10}([+-]\S.*)\n//)
    {
	$matched .= $& if %append;
	$content = ".HP\n\x84$1\n";
	$indent = 80; # not continued
    }

    # Indented paragraph with tag.
    elsif (s/^( +(\S.*?)  +)(\S.*)\n//)
    {
	$matched .= $& if %append;
	$indent = length $1;
	$content = ".TP\n\x84$2\n\x84$3\n";
    }

    # Indented paragraph.
    elsif (s/^( +)(\S.*)\n//)
    {
	$matched .= $& if %append;
	$indent = length $1;
	$content = ".IP\n\x84$2\n";
    }

    # Left justified paragraph.
    else
    {
	s/(.*)\n//;
	$matched .= $& if %append;
	$content = ".PP\n" if $include{$sect};
	$content .= "$1\n";
    }

    # Append continuations.
    while ($indent ? s/^ {$indent}(\S.*)\n// : s/^(\S.*)\n//)
    {
	$matched .= $& if %append;
	$content .= "\x84$1\n";
    }

    # Move to next paragraph.
    s/^\n+//;

    for ($content)
    {
	# Leading dot and apostrophe protection.
	s/\x84\./\x80/g;
	s/\x84'/\x81/g;
	s/\x84//g;

	# Convert options.
	s/(^| |\()(-[][\w=-]+)/$1 . convert_option $2/mge;

	# Escape remaining hyphens
	s/-/\x83/g;

	if ($sect eq 'COPYRIGHT')
	{
	    # Insert line breaks before additional copyright messages
	    # and the disclaimer.
	    s/\n(Copyright |$PAT_FREE_SOFTWARE)/\n.br\n$1/og;
	}
	elsif ($sect eq 'REPORTING BUGS')
	{
	    # Handle multi-line bug reporting sections of the form:
	    #
	    #   Report <program> bugs to <addr>
	    #   GNU <package> home page: <url>
	    #   ...
	    s/\n([[:upper:]])/\n.br\n$1/g;
	}
    }

    # Check if matched paragraph contains /pat/.
    if (%append)
    {
	for my $pat (keys %append)
	{
	    if ($matched =~ $pat)
	    {
		$content .= ".PP\n" unless $append{$pat} =~ /^\./;
		$content .= $append{$pat};
	    }
	}
    }

    $include{$sect} .= $content;
}

# Refer to the real documentation.
unless ($opt_no_info)
{
    my $info_page = $opt_info || $program;

    $sect = _('SEE ALSO');
    $include{$sect} ||= '';
    $include{$sect} .= ".PP\n" if $include{$sect};
    $include{$sect} .= sprintf _(<<'EOT'), $program, $program, $info_page;
The full documentation for
.B %s
is maintained as a Texinfo manual.  If the
.B info
and
.B %s
programs are properly installed at your site, the command
.IP
.B info %s
.PP
should give you access to the complete manual.
EOT
}

# Output header.
print <<EOT;
.\\" DO NOT MODIFY THIS FILE!  It was generated by $this_program $this_version.
.TH $PROGRAM "$section" "$date" "$source" "$manual"
EOT

# Section ordering.
my @pre = (_('NAME'), _('SYNOPSIS'), _('DESCRIPTION'), _('OPTIONS'),
    _('ENVIRONMENT'), _('FILES'), _('EXAMPLES'));

my @post = (_('AUTHOR'), _('REPORTING BUGS'), _('COPYRIGHT'), _('SEE ALSO'));
my $filter = join '|', @pre, @post;

# Output content.
for my $sect (@pre, (grep ! /^($filter)$/o, @include), @post)
{
    if ($include{$sect})
    {
	my $quote = $sect =~ /\W/ ? '"' : '';
	print enc ".SH $quote$sect$quote\n";

	for ($include{$sect})
	{
	    # Replace leading dot, apostrophe, backslash and hyphen
	    # tokens.
	    s/\x80/\\&./g;
	    s/\x81/\\&'/g;
	    s/\x82/\\e/g;
	    s/\x83/\\-/g;

	    # Convert some latin1 chars to troff equivalents
	    s/\xa0/\\ /g; # non-breaking space

	    print enc $_;
	}
    }
}

close STDOUT or kark N_("%s: error writing to %s (%s)"), $this_program,
    $opt_output || 'stdout', $!;

exit;

# Call program with given option and return results.
sub get_option_value
{
    my ($prog, $opt) = @_;
    my $stderr = $discard_stderr ? '/dev/null' : '&1';
    my $value = join '',
	map { s/ +$//; expand $_ }
	map { dec $_ }
	`$prog $opt 2>$stderr`;

    unless ($value)
    {
	my $err = N_("%s: can't get `%s' info from %s%s");
	my $extra = $discard_stderr
	    ? "\n" . N_("Try `--no-discard-stderr' if option outputs to stderr")
	    : '';

	kark $err, $this_program, $opt, $prog, $extra;
    }

    return $value;
}

# Convert option dashes to \- to stop nroff from hyphenating 'em, and
# embolden.  Option arguments get italicised.
sub convert_option
{
    local $_ = '\fB' . shift;

    s/-/\x83/g;
    unless (s/\[=(.*)\]$/\\fR[=\\fI$1\\fR]/)
    {
	s/=(.)/\\fR=\\fI$1/;
	s/ (.)/ \\fI$1/;
	$_ .= '\fR';
    }

    $_;
}
