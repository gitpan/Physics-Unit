use 5.005;
use ExtUtils::MakeMaker;
WriteMakefile(
    'dist'         => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    'NAME'         => 'Physics::Unit',
    'VERSION_FROM' => 'Unit.pm',
    'PREREQ_PM'    => {}, # Module::Name => 1.1
    ($] >= 5.005
        ? (ABSTRACT_FROM => 'Unit.pm',
           AUTHOR        => 'Christopher Maloney <dude@chrismaloney.com>')
        : ()),
);
