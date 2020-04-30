<?php

include 'config.php';
	

	$student_id =$_GET['student_id'];
	
// 	$result = $conn->query("select a.student_id,a.birthdate, a.f_name,a.l_name,a.civil_status,a.gender,a.current_address,a.home_address,a.contact_no,c.course_name ,d.username
// from student a
// inner join student_course b on a.student_id = b.student_id
// inner join course c on b.course_id = c.course_id
// inner join user d on a.user_id = d.user_id
//  WHERE d.username= '$student_id'  ");

	$result = $conn->query("select SUM(a.balance) as total
	from billing_details a
	inner join payment b on a.student_id=b.student_id and a.trimester_id=b.trimester_id
	inner join trimester c on a.trimester_id=c.trimester_id
	inner join student e on e.student_id=a.student_id
	inner join user d on d.user_id=e.user_id
	where d.username='$student_id' ");
	
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	

?>