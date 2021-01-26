<?php

error_reporting(0);
include_once ("dbconnect.php");
header("Access-Control-Allow-Origin: *");

$email = $_POST['email'];
$password = $_POST['password'];
$passwordsha = sha1($password);
$sql = "SELECT * FROM USER WHERE EMAIL = '$email' AND PASSWORD = '$passwordsha'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo "success,".$row["NAME"].",".$row["EMAIL"];
    }
}else{
    echo "failed,null";
}

?>