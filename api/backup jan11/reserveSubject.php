<?php

include 'config.php';
	

	$offered_subject_id = $_POST['offered_subject_id'];
	$student_id = $_POST['student_id'];
	$status=0;

	$today = date("Y-m-d");
	$plus = strtotime("+2 day", time());
	$estimate = date('Y-m-d', $plus);

	$conn->query("insert into enrolled_subject(offered_subject_id,student_id,status,reserve_date,expiry_date) values('$offered_subject_id' ,  '$student_id' , '$status','$today','$estimate' ) ");
		
?>
