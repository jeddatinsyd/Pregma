<?php

include 'config.php';
	
	$con2=mysqli_connect("localhost","root","","akic_db");

	$offered_subject_id = $_POST['offered_subject_id'];
	$student_id = $_POST['student_id'];
	$status=0;

	$today = date("Y-m-d");
	$plus = strtotime("+3 day", time());
	$estimate = date('Y-m-d', $plus);	

	$conn->query("insert ignore into enrolled_subject(offered_subject_id,student_id,status,reserve_date,expiry_date) 
					values('$offered_subject_id' ,  '$student_id' , '$status','$today','$estimate' )
		");

	// $conn->query("delete t1 from enrolled_subject t1 inner join enrolled_subject t2
	// 				where t1.enrolled_subject_id < t2.enrolled_subject_id and 
	// 				t1.offered_subject_id = t2.offered_subject_id
	// 				and t1.student_id=(select a.student_id from student a
	// 	inner join user b on b.user_id=a.user_id
	// 	where b.username='$student_id')");

	// $query = "delete t1 from enrolled_subject t1 inner join enrolled_subject t2
	// 				where t1.enrolled_subject_id < t2.enrolled_subject_id and 
	// 				t1.offered_subject_id = t2.offered_subject_id
	// 				and t1.student_id=(select a.student_id from student a
	// 	inner join user b on b.user_id=a.user_id
	// 	where b.username='".$student_id."')";

	$conn->query("delete t1 from enrolled_subject t1, enrolled_subject t2 
				  where t1.enrolled_subject_id > t2.enrolled_subject_id and 
				  t1.offered_subject_id=t2.offered_subject_id and 
				  t1.student_id = t2.student_id");

 //            $result = mysqli_query($con2,$query);
		
?>
