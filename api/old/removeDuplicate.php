<?php

include 'config.php';
	
	

	
	$offered_subject_id = $_POST['offered_subject_id'];
	$student_id = $_POST['student_id'];
	$status=0;

	$student_id =$_GET['student_id'];
	
	// $conn->query("  delete t1 from enrolled_subject t1 
	// 				inner join enrolled_subject t2
	// 				where t1.enrolled_subject_id < t2.enrolled_subject_id 
	// 				and t1.offered_subject_id = t2.offered_subject_id
	// 				and t1.student_id = t2.student_id
	// 				");

	$conn->query("delete t1 from enrolled_subject t1, enrolled_subject t2 
				  where t1.enrolled_subject_id > t2.enrolled_subject_id and 
				  t1.offered_subject_id=t2.offered_subject_id and 
				  t1.student_id = t2.student_id");

	//DELETE n1 FROM names n1, names n2 
	//WHERE n1.id > n2.id AND n1.name = n2.name

?>

