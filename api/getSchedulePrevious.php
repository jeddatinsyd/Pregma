<?php

include 'config.php';
	

	$student_id =$_GET['student_id'];

	$result = $conn->query("select c.subject_code,c.description,c.units,d.username,a.time_start,a.time_end,a.days,a.section,e.trimester,e.year,b.grade_name
from student_evaluation a
inner join grade b on b.grade_id = a.grade_id
inner join subject c on c.subject_id = a.subject_id
inner join user d on d.user_id = a.user_id
inner join trimester e on a.trimester_id=e.trimester_id
where d.username = '$student_id' and b.grade_name!=''
ORDER BY c.subject_code ASC");
	
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	
?>