<?php

error_reporting(0);
include_once ("dbconnect.php");
header("Access-Control-Allow-Origin: *");

$dc = $_POST['dc'];
$new_data = $_POST['new_data'];

$sql = "UPDATE TASK SET COMPLETED = '$new_data' WHERE DATECREATED = '$dc'";

if ($conn->query($sql) === true)
{
    echo "success";
}
else
{
    echo "failed";
}

?>