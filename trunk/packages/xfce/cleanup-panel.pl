#!/usr/bin/perl
use strict;
use warnings;

local $/;
open(FH, "<$ARGV[0]");
my $content = <FH>;
close FH;
$content =~ s,<Popup>.*?</Popup>,<Popup/>,sg;
$content =~ s,popup="1",popup="0",g;
$content =~ s,Mozilla,Firefox,g;
$content =~ s,mozilla -mail,thunderbird,g;
$content =~ s,mozilla,firefox,g;

# Hack. Works for now, but may break in the future. Check with:
# for a in contents.xml* ; do grep --count Group $a ; done
# Should print the same number for all files.

$content =~ s,<Group>[^G]*?xfprint4.*?</Group>\s*,,sg;
$content =~ s,<Group>[^G]*?xmms.*?</Group>\s*,,sg;

# End of hack

open(FH, ">$ARGV[0]");
print FH $content;
close FH;
