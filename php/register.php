<?php

error_reporting(0);
include_once ("dbconnect.php");
header("Access-Control-Allow-Origin: *");

$name = $_POST['name'];
$email = $_POST['email'];
$password = sha1($_POST['password']);

$sqlinsert = "INSERT INTO USER(NAME, EMAIL, PASSWORD) VALUES ('$name','$email','$password')";

if ($conn->query($sqlinsert) === TRUE)
{
    echo "success";
}
else
{
    echo "failed";
}
?>