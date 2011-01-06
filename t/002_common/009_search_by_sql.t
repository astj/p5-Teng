use t::Utils;
use Mock::Basic;
use Test::More;

my $dbh = t::Utils->setup_dbh;
my $db = Mock::Basic->new({dbh => $dbh});
$db->setup_test_db;
$db->insert('mock_basic',{
    id   => 1,
    name => 'perl',
});

subtest 'search_by_sql' => sub {
    my $itr = $db->search_by_sql(q{SELECT * FROM mock_basic WHERE id = ?}, [1]);
    isa_ok $itr, 'DBIx::Skin::Iterator';

    my $row = $itr->first;
    isa_ok $row, 'DBIx::Skin::Row';
    is $row->id , 1;
    is $row->name, 'perl';
};

done_testing;

