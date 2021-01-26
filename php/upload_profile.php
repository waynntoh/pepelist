<?php

error_reporting(0);
include_once ("dbconnect.php");
header("Access-Control-Allow-Origin: *");

$email = $_POST['email'];
$encoded_string = $_POST["encoded_string"];
$decoded_string = base64_decode($encoded_string);

$path = '../images/'.$email.'.jpg';

if (file_put_contents($path, $decoded_string)){
    echo 'Upload Successful';
}else{
    echo 'Upload Failed';
}

?>