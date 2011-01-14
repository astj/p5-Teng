use t::Utils;
use Mock::Basic;
use Test::More;

my $dbh = t::Utils->setup_dbh;
my $db = Mock::Basic->new({dbh => $dbh});
$db->setup_test_db;

subtest 'insert mock_basic data/ insert method' => sub {
    my $row = $db->insert('mock_basic',{
        id   => 1,
        name => 'perl',
    });
    isa_ok $row, 'Teng::Row';
    is $row->name, 'perl';
};

subtest 'insert with suppress_row_objects off' => sub {
    $db->suppress_row_objects(1);
    my $row = $db->insert('mock_basic',{
        id   => 2,
        name => 'xs',
    });
    isa_ok $row, 'HASH';
    is $row->{name}, 'xs';
};

done_testing;
