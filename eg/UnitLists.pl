# %W%
# This is a simple test program to list data from the Unit
# module

$debug = 1 if (@ARGV[0] eq '-d');

use Physics::Unit ':ALL';

@units = ListUnits;
print "Units:\n" if $debug;
for $n (@units) {
    $u = GetUnit($n);
    @name = $u->names;

    NAME: for (@name) {
        $matched = 1, last NAME if ($_ eq $n);
    }

    die "Huh?" if !$matched;
    printf("%25s: %30s %35s %20s\n", $n, $u->def, $u->expanded, $u->type)
        if $debug;
}

@types = ListTypes;
print "Types are:\n" if $debug;
print "  ", join ",\n  ", ListTypes() if $debug;
print "\n\n" if $debug;

for $t (@types) {
    $u = GetTypeUnit($t);
    die "Huh?" if ($u->type ne $t);
}

print "ok\n";
