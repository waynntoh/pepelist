<?php

error_reporting(0);
include_once ("dbconnect.php");
header("Access-Control-Allow-Origin: *");

$owneremail = $_POST['owneremail'];

$sql = "SELECT * FROM TASK WHERE OWNEREMAIL = '$owneremail'";
$result = $conn->query($sql);
if ($result->num_rows > 0) {
    $response["tasks"] = array();
    while ($row = $result->fetch_assoc())
    {
        $taskslist = array();
        $taskslist["title"] = $row["TITLE"];
        $taskslist["category"] = $row["CATEGORY"];
        $taskslist["datecreated"] = $row["DATECREATED"];
        $taskslist["duedate"] = $row["DUEDATE"];
        $taskslist["completed"] = $row["COMPLETED"];
        array_push($response["tasks"], $taskslist);
    }
    echo json_encode($response);
}else{
    echo "failed";
}

?>