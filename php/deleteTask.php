<?php

error_reporting(0);
include_once ("dbconnect.php");
header("Access-Control-Allow-Origin: *");

$dc = $_POST['dc'];

$sql = "DELETE FROM TASK WHERE DATECREATED = '$dc'";

if ($conn->query($sql) === true)
{
    echo "success";
}
else
{
    echo "failed";
}

?>