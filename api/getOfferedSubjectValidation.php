<?php

include 'config.php';
	
	$student_id =$_POST['student_id'];
	$time_start = $_POST['time_start'];
	$time_end = $_POST['time_end'];
	$days = $_POST['days'];

	//$result = $conn->query("SELECT * FROM user WHERE username='".$username."'  and password= '".$password."' ");

	$result = $conn->query("select  b.time_start,b.time_end,b.days from enrolled_subject a
							inner join offered_subject b on b.offered_subject_id=a.offered_subject_id
							inner join student c on c.student_id=a.student_id
							inner join user d on d.user_id=c.user_id
                            where c.student_id='".$student_id."' and b.time_start='".$time_start."' and b.time_end='".$time_end."' and b.days='".$days."' ");

	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);

?>