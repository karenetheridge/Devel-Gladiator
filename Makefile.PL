use strict;
use warnings;
use lib 'inc';
use ExtUtils::MakeMaker::Dist::Zilla::Develop;
WriteMakefile(
    NAME => 'Devel::Gladiator',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
);
