<?php

include 'config.php';
	
	$username = $_POST['username'];
	$password = $_POST['password'];

	$result = $conn->query("SELECT * FROM user WHERE username='".$username."'  and password= '".$password."' ");

	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()){
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);

?>