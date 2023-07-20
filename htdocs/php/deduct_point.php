<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}


if (isset($_POST['selectpoint'])) {
    $point = $_POST['selectpoint'];
    $userid = $_POST['userid'];
    $sqlupdate = "UPDATE tbl_users SET user_point =(user_point - $point) WHERE user_id = '$userid'"; 
    databaseUpdate($sqlupdate);
    die();
}

if (isset($_POST['userqty'])) {
	$userqty = $_POST['userqty'];
	$itemid = $_POST['itemid'];
	$sqlupdate = "UPDATE tbl_items SET item_qty =(item_qty - $userqty) WHERE item_id = '$itemid'"; 
    databaseUpdate($sqlupdate);
    die();
}
function databaseUpdate($sql){
    include_once("dbconnect.php");
    if ($conn->query($sql) === TRUE) {
        $response = array('status' => 'success', 'data' => null);
        sendJsonResponse($response);
    } else {
        $response = array('status' => 'failed', 'data' => null);
        sendJsonResponse($response);
    }
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}
?>