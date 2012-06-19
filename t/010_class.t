#!/bin/perl
#===================================================================================================================
#    Script:            010_class.t
#    purpose:           N/A
#    date created:      06/08/2012
#    author:            Anthony (J) Lucas - anthony_lucas@discovery-europe.com
#    copyright:         Code and methodology copyright 2012 Discovery Networks Europe
#===================================================================================================================



package main;



use strict;
use warnings;



use Test::More;



BEGIN { use_ok( 'Config::YAARG' );}


#setup test
our ($ARG_NAME_MAP, $ARG_VALUE_TRANS);
BEGIN { $ARG_NAME_MAP = { Debug => 'debug', Opts => 'options' };}
BEGIN { $ARG_VALUE_TRANS = { Debug => sub{2} };}
my $test_values = { Debug => 1, Opts => {1..4} };
my $test_values_output = { Debug => 2, Opts => {1..4} };

my $obj;
ok( $obj = YAARG::Test::Class->new(%$test_values), 'create test class instance');


#perform test
my $failed = 0;
foreach (keys(%$test_values)) {

    is_deeply($obj->{$ARG_NAME_MAP->{$_}}, $test_values_output->{$_},
        "input matches expected output for: $_")
        or $failed++;
}
ok ($failed < 1, 'input arguments match expected output for all arguments');


done_testing();






#//TEST CLASS
package YAARG::Test::Class;
use parent -norequire, qw( Config::YAARG );


use strict;
use warnings;



use Config::YAARG qw( :class );





use constant ARG_NAME_LIST => [keys(%{$main::ARG_NAME_MAP})];
use constant ARG_NAME_MAP => {%{$main::ARG_NAME_MAP}};
use constant ARG_VALUE_TRANS => {%{$main::ARG_VALUE_TRANS}};



sub new {
    
    my ($class, %args) = @_;
    my $self = bless({}, $class);
    $self->process_args($self, %args);
    return $self;
}
