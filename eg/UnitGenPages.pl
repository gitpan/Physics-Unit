# %W%
# This test program generates the unit_by_name.html and
# unit_by_type.html pages.

use Physics::Unit ':ALL';

GenerateUnitsPages();
print "ok\n";

#-----------------------------------------------------------
# used for sorting an array of unit names by type.
# Note: 'unknown' is first, 'prefix' next
sub by_type {
    my $ua = GetUnit($a);
    my $ub = GetUnit($b);
    my $ta = $ua->type();
    my $tb = $ub->type();

    if ($ta eq 'unknown') { $ta = 0; }
    if ($tb eq 'unknown') { $tb = 0; }
    if ($ta eq 'prefix') { $ta = 1; }
    if ($tb eq 'prefix') { $tb = 1; }

    my $fa = $ua->factor;
    my $fb = $ub->factor;
    $r = ($ta cmp $tb) || ($fa <=> $fb) || ($a cmp $b);
    return $r;
}

#-----------------------------------------------------------
sub GenerateUnitsPages {

$html_header = <<END_HEAD;
<html>
  <head>
    <title>Units %s</title>
  </head>
  <body background="bg-paper.gif">

    <h2>Units %s</h2>
    <ul>
END_HEAD

$html_table_header = <<END_TABLE_HEAD;
      <table border=1 cellpadding=2>
        <tr>
          <th><b>Unit</b></th>
          <th><b>Type</b></th>
          <th><b>Value</b></th>
          <th><b>Expanded</b></th>
        </tr>
END_TABLE_HEAD

$html_trailer = <<END_TAIL;
      </table>
    </ul>
  </body>
</html>
END_TAIL

    # Generate Units by Name

    open NAMES, ">units_by_name.html";
    printf NAMES ($html_header, "by Name", "by Name");
    printf NAMES ($html_table_header);

    for $name (ListUnits()) {
        $n = GetUnit($name);
        printrow("<a name=\"$name\">$name</a>",
                 $n->type(), $n->def(), $n->expanded());
    }

    print NAMES $html_trailer;
    close NAMES;


    # Generate Units by Type

    open NAMES, ">units_by_type.html";
    printf NAMES ($html_header, "by Type", "by Type");

    @n = ListUnits();
    @n = sort by_type @n;

    # First pass: get the first unit of each type

    $t = '';
    for $name (@n) {
        $n = GetUnit($name);
        if ($n->type ne $t) {
            $t = $n->type;
            $target{$t} = $name;
        }
    }

    # Print out the "Table of Contents"

    print NAMES "\n";
    print NAMES "      <a href=\"#yocto\">prefix</a>,\n";
    @t = ListTypes();
    while ($t = shift @t) {
        print NAMES "      <a href=\"#$target{$t}\">$t</a>";
        if (@t) {
            print NAMES ",";
        }
        print NAMES "\n";
    }
    print NAMES "      <p>\n";

    printf NAMES ($html_table_header);

    # Second pass: print out the table

    for $name (@n) {
        $n = GetUnit($name);
        printrow("<a name=\"$name\">$name</a>",
                 $n->type(), $n->def(), $n->expanded());
    }

    print NAMES $html_trailer;
    close NAMES;
}

sub printrow {
    my ($d1, $d2, $d3, $d4) = @_;
    print NAMES "        <tr>\n" .
                "          <td>$d1</td>\n" .
                "          <td>" . ($d2 ? $d2 : '?') . "</td>\n" .
                "          <td>$d3</td>\n" .
                "          <td>$d4</td>\n" .
                "        </tr>\n";
}
