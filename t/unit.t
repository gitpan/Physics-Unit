use Test::More tests => 39;

BEGIN { use_ok('Physics::Unit', (':ALL')) };


my $mile = GetUnit('mile');
ok(defined $mile,   "GetUnit('mile')");

my $foot = GetUnit('foot');
my $c = $mile->convert($foot);     # $c == 5280
is($c, 5280, 'a mile is 5280 feet');


# Test that case is not significant in expressions

$ss = new Physics::Unit('FuRlOnG / fOrTnIgHt', 'SiLlY_SpEeD');
is($ss->name, 'silly_speed', 'silly_speed unit');

my $mph = $ss->convert('mph');
is($mph, 0.000372023809524, 'silly_speed to mph');



# Test all the examples from the Physics::Unit documentation.

# Define your own units
$ss = new Physics::Unit('furlong / fortnight', 'ff');

# test the expanded representation of a unit
is($ss->expanded, '0.00016630952381 m s^-1', '$ss->expanded');

#---------------------

# Convert from one to another
is($ss->convert('mph'), 0.000372023809524, '$ss->convert(mph)');

# Get a Unit's conversion factor
is(GetUnit('foot')->factor, 0.3048, 'GetUnit(foot)->factor');

is(GetUnit('mph')->factor, 0.44704, 'GetUnit(mph)->factor');

#---------------------

# Test the equivalence of several units
my $u = GetUnit('megaparsec');

ok($u->equal(GetUnit('mega parsec')));
ok($u->equal(GetUnit('kilo kilo parsec')));
ok($u->equal(GetUnit('kilo**2 parsec')));
ok($u->equal(GetUnit('square kilo parsec')));


#---------------------

InitBaseUnit('Beauty' => ['sarah', 'sarahs', 'smw']);
is(GetUnit('sarah')->type, 'Beauty', 'Sarah is beautiful');

#---------------------

InitPrefix('gonzo' => 1e100, 'piccolo' => 1e-100);
is(GetUnit('gonzo')->type, 'prefix', 'Gonzo');

$beauty_rate = new Physics::Unit('5 piccolosarah / hour');
ok(!defined $beauty_rate->type, 'beauty_rate type');

is($beauty_rate->factor, 5 * 1e-100 / 3600, 'beauty_rate->factor');

#---------------------

InitUnit( ['chris', 'cfm'] => '3 piccolosarahs' );
is(GetUnit('cfm')->expanded, '3.e-100 smw', 'not so beautiful');

#---------------------

InitUnit( ['mycron1'], '3600 sec' );
InitUnit( ['mycron2'], 'hour' );
$h = GetUnit('hour');
InitUnit( ['mycron3'], $h );

ok(Physics::Unit->equal('mycron1', 'mycron2'), 'mycron1 == mycron2');
ok(Physics::Unit->equal('mycron1', 'mycron3'), 'mycron1 == mycron3');

#---------------------

InitTypes( 'Aging' => 'chris / year' );
$uname = 'Sarah per week';
$u = GetUnit($uname);
is($u->type, 'Aging', 'Aging');

#---------------------

# Create a new, anonymous unit:
$u = new Physics::Unit ('3 pi sarahs per s');
ok(!defined $u->name, 'no name');

# Create a new, named unit:
$u = new Physics::Unit ('3 pi sarahs per s', 'bloom');
is($u->name, 'bloom', 'bloom');

# Create a new unit with a list of names:
$u  = new Physics::Unit ('3 pi sarahs per s', 'b', 'blooms', 'blm');
is($u->name, 'b', 'primary name');

#---------------------

is(GetUnit('rod')->type, 'Distance', 'rod type');

#---------------------

$u1 = new Physics::Unit('kg m^2/s^2');
$t = $u1->type;
@types = sort @$t;
is($types[0], 'Energy', 'Energy');
is($types[1], 'Torque', 'Torque');


$u1->type('Energy');  #  This establishes the type once and for all
$t = $u1->type;
is($t, 'Energy', 'type fixed as Energy');

# . . .

# But if we use a predefined, named unit, we get a single type:
$u3 = GetUnit('joule')->new;    # *not*  Physics::Unit->new('joule');
is($u3->type, 'Energy', 'joule is Energy');

#---------------------

is(GetUnit('calorie')->expanded, '4184 m^2 gm s^-2', 'stuff');

#---------------------

$u = new Physics::Unit('36 m^2');
$u->divide('3 meters');
is($u->expanded, '12 m', '12 m');

$u->divide(3);
is($u->expanded, '4 m', '4 m');

$u->divide( new Physics::Unit('.5 sec') );
is($u->expanded, '8 m s^-1', '8 m s^-1');


# define your own units
$Uforce = new Physics::Unit('3 pi kg*nanoparsecs / femtofortnight sec');
ok(!defined $Uforce->name, '$Uforce->name');
is($Uforce->expanded, '2.40216521602612e+20 m gm s^-2', '$Uforce->expanded');

$Uaccl1 = new Physics::Unit('meters per second squared');
ok(!defined $Uaccl1->name, '$Uforce->name');
is($Uaccl1->expanded, 'm s^-2', '$Uaccl1->expanded');

$Uaccl2 = new Physics::Unit('furlong / square score');
ok(!defined $Uaccl2->name, '$Uforce->name');
is($Uaccl2->expanded, '5.04999528589989e-16 m s^-2', '$Uaccl2->expanded');

