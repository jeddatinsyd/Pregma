<?php

include 'config.php';
	

	$student_id =$_GET['student_id'];

	$result = $conn->query("select b.grade_name,e.subject_code,e.description,e.units,g.username from student_grade a
inner join grade b on b.grade_id=a.grade_id
inner join enrolled_subject c on c.enrolled_subject_id=a.enrolled_subject_id
inner join offered_subject d on d.offered_subject_id=c.offered_subject_id
inner join subject e on e.subject_id=d.subject_id
inner join student f on f.student_id=c.student_id
inner join user g on g.user_id=f.user_id
where g.username='$student_id'
ORDER BY e.subject_code ASC");
	
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	
?>

<!-- 
$result = $conn->query("select b.grade_name,c.subject_code,c.description,c.units,d.username
from student_evaluation a
inner join grade b on b.grade_id = a.grade_id
inner join subject c on c.subject_id = a.subject_id
inner join user d on d.user_id = a.user_id
where d.username = '$student_id' and b.grade_name!=''
ORDER BY c.subject_code ASC"); -->