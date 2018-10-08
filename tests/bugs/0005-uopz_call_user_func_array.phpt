--TEST--
call uopz_call_user_func_array while passing a parameter by reference
--SKIPIF--
<?php include("skipif.inc") ?>
--FILE--
<?php

function myfunction( &$anobject ) { 
    return 'success'; 
}

function callmyfunction( $args ) { 
    var_dump( call_user_func_array( 'myfunction', $args ) .'2' ); // fails!
    var_dump( call_user_func_array( 'myfunction', array( &$args[0] ) ) .'3'); //circumvention
}

class MyClass 
{
    function __construct() {
        var_dump( call_user_func_array( 'myfunction', array( &$this ) ) .'1' ); //works
        callmyfunction( array( &$this ) ); // loses array-embedded reference!
    }
}
$myobject = new MyClass;

?>
--EXPECT--
string(8) "success1"
string(8) "success2"
string(8) "success3"