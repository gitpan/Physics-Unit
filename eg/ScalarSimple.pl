# This contains, among other things, the examples from the
# Physics::Unit::Scalar documentation.

BEGIN {
    if ($ARGV[0] eq '-d') {
        $Physics::Unit::Scalar::debug = 1;
        $debug = 1;
    }
}

use Physics::Unit::Scalar;

if ($debug) {
    $d = new Physics::Unit::Distance('98 mi');
    print "98 mi Physics::Unit::Distance is\n";
    for (sort keys %$d) {
        print "\t$_ => $$d{$_}\n";
    }
}

$d = new Physics::Unit::Distance('98 mi');
$s = $d->ToString;
print "$s\n" if $debug;
if ($s !~ /^157715\./) {
    die "Didn't print 98 mi correctly";
}

$d->add('10 km');
$s = $d->ToString;
print "Sum is $s\n" if $debug;
if ($s !~ /^167715\./) {
    die "Didn't print (98 mi + 10 km) correctly";
}

print $d->value, ' ', $d->default_unit->name, "\n" if $debug;
if ($d->value !~ /^167715\./) {
    die "Didn't get value correctly";
}
if ($d->default_unit->name ne "meter") {
    die "Didn't get default unit correctly";
}

$s = $d->ToString('mile');
print "$s\n" if $debug;
if ($s !~ /104\.213/) {
    die "Didn't print in miles correctly";
}

$s = $d->convert('mile');
print "$s mile\n" if $debug;
if ($s !~ /104\.213/) {
    die "Didn't convert to miles correctly";
}

$d2 = new Physics::Unit::Distance('2000');
if ($d2->ToString ne '2000 meter') {
    die "Didn't create distance correctly";
}

# Manipulate Times

$t = Physics::Unit::Time->new('36 years');
$s = $t->ToString;
print "$s\n" if $debug;
if ($s ne '1136073600 second') {
    die "Didn't store time correctly";
}

# Compute a Speed = Distance / Time
$speed = $d->div($t);
$s = $speed->ToString;
print "$s\n" if $debug;
if ($s !~ /^0.0001476275.* mps$/) {
    die "Didn't compute speed correctly";
}

# Try to create an object, with a bad definition string
eval q($d = new Physics::Unit::Time('3m'););    # this fails, correctly
die "Error: eval succeeded!" if ! $@;

# Construct a Generic object that has a Distance in it
$d = new Physics::Unit::Scalar('3m');

# Create a Scalar with an unknown dimensionality
$s = new Physics::Unit::Scalar('kg m s');
if ($s->ToString ne '1000 m gm s') {
    die "Didn't create random scalar correctly";
}

$f = $s->div('3000 s^3');   # $f is a Physics::Unit::Force
if ((ref $f ne 'Physics::Unit::Force') || $f->ToString !~ /newton$/) {
    #print "'", (ref $f), "', '", $f->ToString, "'\n";
    die "Blech!";
}
