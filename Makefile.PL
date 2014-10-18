use 5.008;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME              => 'Devel::Gladiator',
    VERSION_FROM      => 'lib/Devel/Gladiator.pm',
    PREREQ_PM         => {},
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/Devel/Gladiator.pm',
       AUTHOR         => 'Artur Bergman <sky@apple.com>') : ()),
    LIBS              => [''],
    DEFINE            => '',
    INC               => '-I.',

    META_MERGE => {
        resources => {
            repository => 'https://github.com/doy/devel-gladiator.git',
        },
    },

);
