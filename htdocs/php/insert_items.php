<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$userid = $_POST['userid'];
$item_name = $_POST['itemname'];
$item_desc = $_POST['itemdesc'];
$item_price = $_POST['itemprice'];
$item_qty = $_POST['itemqty'];
$latitude = $_POST['latitude'];
$longitude = $_POST['longitude'];
$state = $_POST['state'];
$locality = $_POST['locality'];
$image1 = $_POST['image1'];
$image2 = $_POST['image2'];
$image3 = $_POST['image3'];


$sqlinsert = "INSERT INTO `tbl_items`(`user_id`,`item_name`, `item_desc`, `item_price`,`item_qty`, `item_lat`, `item_long`, `item_state`, `item_locality`) VALUES ('$userid','$item_name','$item_desc','$item_price','$item_qty','$latitude','$longitude','$state','$locality')";


if ($conn->query($sqlinsert) === TRUE) {
	
	$response = array('status' => 'success', 'data' => null);
	
	
	for ($i = 1; $i <= 3; $i++) {
	$filename = mysqli_insert_id($conn);
	
	if($i == 1){
		$decoded_string = base64_decode($image1);
	}
	if($i == 2){
		$decoded_string = base64_decode($image2);
	}
	if($i == 3){
		$decoded_string = base64_decode($image3);
	}
	$Path = '../assets/items/' .$filename.'.'.$i.'.png';
    
    file_put_contents($Path, $decoded_string);
}
	
	
    sendJsonResponse($response);
}else{
	$response = array('status' => 'failed', 'data' => null);
	sendJsonResponse($response);
}

function sendJsonResponse($sentArray)
{
    header('Content-Type: application/json');
    echo json_encode($sentArray);
}

?>