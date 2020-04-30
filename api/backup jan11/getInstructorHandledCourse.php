<?php

include 'config.php';
	

	$student_id =$_GET['student_id'];

	$result = $conn->query("select DISTINCT  b.subject_id,d.subject_code,b.days,b.time_start,b.time_end,b.section,d.units,f.user_id,e.instructor_id
from enrolled_subject a 
inner join offered_subject b 
inner join trimester c
inner join subject d on d.subject_id=b.subject_id
inner join instructor e on e.instructor_id=b.instructor_id
inner join user f on f.instructor_id=b.instructor_id
where f.username='$student_id'");
	
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	
?>