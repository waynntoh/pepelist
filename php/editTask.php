<?php

error_reporting(0);
include_once ("dbconnect.php");
header("Access-Control-Allow-Origin: *");

$dc = $_POST['dc'];
$new_title = $_POST['new_title'];
$new_category = $_POST['new_category'];
$new_duedate = $_POST['new_duedate'];

$sql = "UPDATE TASK SET TITLE = '$new_title', CATEGORY = '$new_category', DUEDATE = '$new_duedate' WHERE DATECREATED = '$dc'";

if ($conn->query($sql) === true)
{
    echo "success";
}
else
{
    echo "failed";
}

?>