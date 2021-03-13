<?php
header('Access-Control-Allow-Origin: *');

header('Access-Control-Allow-Methods: GET, POST');

header("Access-Control-Allow-Headers: X-Requested-With");
require_once("dbcon.php");
$email=$_POST["email"];
$query="SELECT name,phone,email,address FROM users WHERE email LIKE '$email'";
$res=mysqli_query($con,$query);
$data=mysqli_fetch_assoc($res);
if(!empty($data)){
            echo json_encode($data);

}else{
        echo json_encode('An Error Occured');
    }

?>