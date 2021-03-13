<?php
header('Access-Control-Allow-Origin: *');

header('Access-Control-Allow-Methods: GET, POST');

header("Access-Control-Allow-Headers: X-Requested-With");
require_once("dbcon.php");
require_once("dbconncomp.php");
$email=$_POST["email"];
$status=$_POST["status"];
$cid=$_POST["compid"];
$query="SELECT id FROM users WHERE email LIKE '$email'";
$res=mysqli_query($con,$query);
$data=mysqli_fetch_assoc($res);
$id=$data['id'];
if(empty($data)){
            echo json_encode("false");

}else{
    $query="UPDATE `complaints` SET `status` = '$status', `resolvedate` = CURRENT_TIMESTAMP, `adminresolve` = $id WHERE `complaints`.`id` like $cid";
$res=mysqli_query($conn,$query);


    if($res){
        echo json_encode('true');
    }else{
        echo json_encode('false'. $conn -> error);
    }

}
?>