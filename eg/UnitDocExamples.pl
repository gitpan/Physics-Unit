# %W%
# This test program contains all the examples from the documentation.

use Physics::Unit ':ALL';

if ($ARGV[0] eq '-d') {
    $debug = 1;
    $Physics::Unit::debug = 1;
}

# Define your own units
$ss = new Physics::Unit('furlong / fortnight', 'ff');

# Print the expanded representation of a unit
print $ss->expanded, "\n" if $debug;

# Convert from one to another
print "One ", $ss->name, " is ", $ss->convert('mph'), " miles per hour\n"
    if $debug;

# Get a Unit's conversion factor
print "Conversion factor of foot is ", GetUnit('foot')->factor, "\n"
    if $debug;

#---------------------

print "One mph is ", GetUnit('mph')->factor, " meters / sec\n" if $debug;

#---------------------

# Test the equivalence of several units
my $u = GetUnit('megaparsec');
die "not equal" if (! $u->equal(GetUnit('mega parsec')));
die "not equal" if (! $u->equal(GetUnit('kilo kilo parsec')));
die "not equal" if (! $u->equal(GetUnit('kilo**2 parsec')));
die "not equal" if (! $u->equal(GetUnit('square kilo parsec')));

#---------------------

InitBaseUnit('Beauty' => ['sarah', 'sarahs', 'smw']);
if (GetUnit('sarah')->type ne 'Beauty') {
    die "Wrong, Sarah *is* beautiful!";
}

#---------------------

InitPrefix('gonzo' => 1e100, 'piccolo' => 1e-100);
if (GetUnit('gonzo')->type ne 'prefix') {
    die "Splutter, flitzzz, zmub, ...";
}

$beauty_rate = new Physics::Unit('5 piccolosarah / hour');
if (defined $beauty_rate->type) { die "Huh?"; }
if ($beauty_rate->factor != 5 * 1e-100 / 3600) {
    die "wrong factor: ", $beauty_rate->factor;
}

#---------------------

InitUnit( ['chris', 'cfm'] => '3 piccolosarahs' );
print "One cfm is ", GetUnit('cfm')->expanded, "\n" if $debug;

#---------------------

InitUnit( ['mycron1'], '3600 sec' );
InitUnit( ['mycron2'], 'hour' );
$h = GetUnit('hour');  InitUnit( ['mycron3'], $h );

die "not equal" if ! Physics::Unit->equal('mycron1', 'mycron2');
die "not equal" if ! Physics::Unit->equal('mycron1', 'mycron3');

#---------------------

InitTypes( 'Aging' => 'chris / year' );
$uname = 'Sarah per week';
$u = GetUnit($uname);
if ($u->type ne 'Aging') {
    die "wrong type";
}
print "A '$uname' is of type '", $u->type, "'\n" if $debug;

#---------------------

# Create a new, anonymous unit:
$u = new Physics::Unit ('3 pi sarahs per s');

# Create a new, named unit:
$u = new Physics::Unit ('3 pi sarahs per s', 'bloom');

# Create a new unit with a list of names:
$u  = new Physics::Unit ('3 pi sarahs per s', 'b', 'blooms', 'blm');
die "uh-oh" if ($u->name ne 'b');

#---------------------

$u1 = new Physics::Unit('kg m^2/s^2');
$t = $u1->type;
if (($$t[0] ne 'Energy' || $$t[1] ne 'Torque') &&
    ($$t[1] ne 'Energy' || $$t[0] ne 'Torque')
   )
{
    die "bonk";
}


$u1->type('Energy');  #  This establishes the type once and for all
$t = $u1->type;
if ($t ne 'Energy') { die "bink"; }

# Now create another Unit object from the same definition
$u2 = new Physics::Unit('kg m^2/s^2');

# This is a brand-new object, so the explicit type is unknown, as before:
$t = $u2->type;    # $t == ['Energy', 'Torque']
if (($$t[0] ne 'Energy' || $$t[1] ne 'Torque') &&
    ($$t[1] ne 'Energy' || $$t[0] ne 'Torque')
   )
{
    die "bonk";
}

# But if we use a predefined, named unit, we get a single type:
$u3 = GetUnit('joule')->new;    # *not*  Physics::Unit->new('joule');
$t = $u3->type;
if ($t ne 'Energy') { die "bink"; }

#---------------------

if (GetUnit('calorie')->expanded ne '4184 m^2 gm s^-2') {
    die "gggrrr";
}

#---------------------

$u = new Physics::Unit('36 m^2');
$u->divide('3 meters');
die "nasty" if ($u->expanded ne '12 m');

$u->divide(3);
die "nasty" if ($u->expanded ne '4 m');

$u->divide( new Physics::Unit('.5 sec') );
die "nasty" if ($u->expanded ne '8 m s^-1');


use Physics::Unit ':ALL';

# define your own units
$Uforce = new Physics::Unit('3 pi kg*nanoparsecs / femtofortnight sec');
$Uaccl1 = new Physics::Unit('meters per second squared');
$Uaccl2 = new Physics::Unit('furlong / square score');

print $Uforce->name if $debug;

print "ok\n";
