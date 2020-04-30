<?php

include 'config.php';
	

	$student_id =$_GET['student_id'];

	$result = $conn->query("select a.instructor_id,a.birthdate, a.f_name,a.l_name,a.civil_status,a.gender,a.address,a.contact_no ,d.username,a.civil_status ,b.department_name
from instructor a
inner join user d on a.user_id = d.user_id
inner join department b on a.deptid=b.department_id
 WHERE d.username= '$student_id'");
	
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	
?>