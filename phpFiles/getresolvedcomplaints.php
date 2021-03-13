<?php
header('Access-Control-Allow-Origin: *');

header('Access-Control-Allow-Methods: GET, POST');

header("Access-Control-Allow-Headers: X-Requested-With");
require_once("dbcon.php");
require_once("dbconncomp.php");
$email=$_POST["email"];
$query="SELECT id FROM users WHERE email LIKE '$email'";
$res=mysqli_query($con,$query);
$data=mysqli_fetch_assoc($res);
$id=$data['id'];
if(empty($data)){
            echo json_encode("false");

}else{
    $query="SELECT * FROM complaints WHERE adminresolve LIKE $id";
$res=mysqli_query($conn,$query);
$rows = array();

//retrieve and print every record
while($r = mysqli_fetch_assoc($res)){
     $rows[] = $r;

}

    if($res){
        echo json_encode($rows);
    }else{
        echo json_encode('empty');
    }

}
?>