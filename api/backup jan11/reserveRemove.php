<?php

include 'config.php';
	

	$offered_subject_id = $_POST['offered_subject_id'];
	$student_id = $_POST['student_id'];
	$status=0;
	$conn->query("delete from enrolled_subject where offered_subject_id='$offered_subject_id' and student_id='$student_id' and status='$status' ");
?>
