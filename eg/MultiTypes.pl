# %W%
# This is a simple test program to list data from the Unit module

#BEGIN { $Physics::Unit::debug = 1; }

use Physics::Unit ':ALL';

for $n (ListUnits()) {
    $u = GetUnit($n);
    $t = $u->type;
    if (ref $t) {
        print "$n\n";
    }
}

