<?php

include 'config.php';
	

	$student_id =$_GET['student_id'];

	$result = $conn->query("select a.instructor_id,a.birthdate, a.f_name,a.l_name,a.civil_status,a.gender,a.address,a.contact_no ,d.username,a.civil_status
from instructor a
inner join user d on a.instructor_id = d.instructor_id
 WHERE d.username= '$student_id'");
	
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	
?>