<?php

error_reporting(0);
include_once ("dbconnect.php");
header("Access-Control-Allow-Origin: *");

$owneremail = $_POST['owneremail'];
$title = $_POST['title'];
$category = $_POST['category'];
$duedate = $_POST['duedate'];
$completed = $_POST['completed'];

$sqlinsert = "INSERT INTO TASK(OWNEREMAIL, TITLE, CATEGORY, DUEDATE, COMPLETED) VALUES ('$owneremail', '$title', '$category', '$duedate', '$completed')";

if ($conn->query($sqlinsert) === TRUE){
    echo "success";
    
}else{
    echo "failed";
}

?>