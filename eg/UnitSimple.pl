# %W%

BEGIN {
    if ($ARGV[0] eq '-d') {
        $debug = 1;
        $Physics::Unit::debug = 1;
    }
}

use Physics::Unit ':ALL';

$mile = GetUnit('mile');
$foot = GetUnit('foot');
$c = $mile->convert($foot);     # $c == 5280
print "A mile is $c feet\n" if $debug;
if ($c != 5280) { die "test failed"; }

# Test that case is not significant in expressions
$ss = new Physics::Unit('FuRlOnG / fOrTnIgHt', 'SiLlY_SpEeD');
print "one ", $ss->name, " is ", $ss->convert('mph'), " miles per hour\n"
    if $debug;

print "ok\n";
