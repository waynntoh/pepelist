<?php
$servername = "localhost";
$username   = "techvest_pepelist";
$password   = "Pepelist123";
$dbname     = "techvest_pepelist";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    echo "Connection Failed : " . $conn->connect_error;
}
?>