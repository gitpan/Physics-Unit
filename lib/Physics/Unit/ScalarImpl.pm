=head1 Physics::Unit::Scalar Implementation

This page discusses implementation issues of the Physics/Unit/Scalar.pm
module.

=head1 Private Functions

=head2 InitSubtypes()

This is called during compilation, and creates classes for each of
the unit types defined in Physics::Unit.

If $debug is set, then it prints out the modules it creates to a
file called ScalarSubtypes.pm.

=head2 MyUnit($arg)

Returns a reference to the Unit object that is used to define the
quantity.  $arg can either be a class name or an object that derives
from Physics::Unit::Scalar.

=head2 GetMyUnit($class)

Get the class' MyUnit.

=head2 GetDefaultUnit($class)

Get the class' DefaultUnit.

=head2 ScalarResolve($hash)

This takes an unblessed reference to a hash as an argument.  The hash
should have a value member and a MyUnit member.

This determines the proper type of Scalar that the object should be
(based on MyUnit's type), 'normalizes' the Scalar, blesses it into
the proper subtype, and returns it.

This is used by ScalarFactory and several of the arithmetic functions
(whenever the arithmetic function actually changes the dimensionality
of the unit, and thus the type of scalar).
