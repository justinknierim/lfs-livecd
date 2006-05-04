#!/usr/bin/perl
use strict;
use warnings;

local $/;
open(FH, "<$ARGV[0]");
my $content = <FH>;
close FH;

# Remove popup menus related to Konqueror etc.
$content =~ s,<Popup>.*?</Popup>,<Popup/>,sg;
$content =~ s,popup="1",popup="0",g;

# Use Seamonkey for web and mail
$content =~ s,Mozilla,Seamonkey,g;
$content =~ s,mozilla,/bin/sh -c 'mozilla-xremote-client "xfeDoCommand(openBrowser)" 2>/dev/null || mozilla',g;

# Hide the non-functional "Lock Screen" button
$content =~ s,button1=".",button1="1",g;
$content =~ s,button2=".",button2="0",g;
$content =~ s,showtwo=".",showtwo="0",g;

# Remove non-functional buttons related to multimedia and printing.
# Hack. Works for now, but may break in the future. Check with:
# for a in contents.xml* ; do grep --count Group $a ; done
# Should print the same number for all files.

$content =~ s,<Group>[^G]*?xfprint4.*?</Group>\s*,,sg;
$content =~ s,<Group>[^G]*?xmms.*?</Group>\s*,,sg;

# Hide the mail icon because of the profile locking problem,
# and because its text isn't looked up for translations
$content =~ s,<Group>[^G]*?libmailcheck.*?</Group>\s*,,sg;

# End of hack

open(FH, ">$ARGV[0]");
print FH $content;
close FH;
