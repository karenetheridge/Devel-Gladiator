use strict;
use warnings;
use lib 'inc';
use ExtUtils::MakeMaker::Dist::Zilla::Develop;
WriteMakefile(
    NAME => 'Devel::Gladiator',
    VERSION_FROM => 'lib/Devel/Gladiator.pm',
    INSTALLMAN1DIR => 'none',
    INSTALLMAN3DIR => 'none',
    NORECURS => 1,
);
