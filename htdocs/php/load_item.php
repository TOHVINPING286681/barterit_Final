<?php
if (!isset($_POST)) {
    $response = array('status' => 'failed', 'data' => null);
    sendJsonResponse($response);
    die();
}

include_once("dbconnect.php");

$results_per_page = 10;
if (isset($_POST['pageno'])){
	$pageno = (int)$_POST['pageno'];
}else{
	$pageno = 1;
}
$page_first_result = ($pageno - 1) * $results_per_page;

if (isset($_POST['cartuserid'])){
	$cartuserid = $_POST['cartuserid'];
}else{
	$cartuserid = '0';
}



if (isset($_POST['userid'])){
	$userid = $_POST['userid'];	
	$sqlloaditem = "SELECT * FROM `tbl_items` WHERE user_id = '$userid'";
	$sqlcart = "SELECT * FROM `tbl_carts` WHERE user_id = '$userid'";
}else if (isset($_POST['search'])){
	$search = $_POST['search'];
	$sqlloaditem = "SELECT * FROM `tbl_items` WHERE item_name LIKE '%$search%'";
	$sqlcart = "SELECT * FROM `tbl_carts` WHERE user_id = '$cartuserid'";
}else{
	$sqlloaditem = "SELECT * FROM `tbl_items`";
	$sqlcart = "SELECT * FROM `tbl_carts` WHERE user_id = '$cartuserid'";
}


if (isset($sqlcart)){
	$resultcart = $conn->query($sqlcart);
	$number_of_result_cart = $resultcart->num_rows;
	if ($number_of_result_cart > 0) {
		$totalcart = 0;
		while ($rowcart = $resultcart->fetch_assoc()) {
			$totalcart = $totalcart+ $rowcart['cart_qty'];
		}
	}else{
		$totalcart = 0;
	}
}else{
	$totalcart = 0;
}

$result = $conn->query($sqlloaditem);
$number_of_result = $result->num_rows;
$number_of_page = ceil($number_of_result / $results_per_page);
$sqlloaditem = $sqlloaditem . " LIMIT $page_first_result , $results_per_page";
$result = $conn->query($sqlloaditem);


if ($result->num_rows > 0) {
    $item["item"] = array();
	while ($row = $result->fetch_assoc()) {
        $itemlist = array();
        $itemlist['item_id'] = $row['item_id'];
        $itemlist['user_id'] = $row['user_id'];
        $itemlist['item_name'] = $row['item_name'];
        $itemlist['item_desc'] = $row['item_desc'];
		$itemlist['item_price'] = $row['item_price'];
        $itemlist['item_qty'] = $row['item_qty'];
        $itemlist['item_lat'] = $row['item_lat'];
        $itemlist['item_long'] = $row['item_long'];
        $itemlist['item_state'] = $row['item_state'];
        $itemlist['item_locality'] = $row['item_locality'];
		$itemlist['item_date'] = $row['item_date'];
        array_push($item["item"],$itemlist);
    }
    $response = array('status' => 'success', 'data' => $item, 'numofpage'=>"$number_of_page",'numberofresult'=>"$number_of_result",'cartqty'=> $totalcart);
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