<?php
header('Access-Control-Allow-Origin: *');

header('Access-Control-Allow-Methods: GET, POST');

header("Access-Control-Allow-Headers: X-Requested-With");
require_once("dbcon.php");
$email=$_POST["email"];
$name=$_POST["name"];
$pass=$_POST["pass"];
$address=$_POST["address"];
$phone=$_POST["phone"];
$query="SELECT * FROM users WHERE email LIKE '$email'";
$res=mysqli_query($con,$query);
$data=mysqli_fetch_assoc($res);
if(!empty($data)){
            echo json_encode("Account Already Exists");

}else{
    $query="INSERT INTO users (id,name,email,pass,address,type,phone) VALUES (null,'$name','$email','$pass','$address','0','$phone')";
    $res=mysqli_query($con,$query);
    if($res){
        echo json_encode('true');
    }else{
        echo json_encode('false');
    }

}
?>