<?php

include 'config.php';
	

	$student_id =$_GET['student_id'];
	$subject_code = $_GET['subject_code'];
	

	$result = $conn->query("select DISTINCT g.course_name,g.major, f.username,c.f_name,c.m_name,c.l_name,e.subject_code,c.home_address,c.gender,c.birthdate
FROM enrolled_subject a
inner join offered_subject b on b.offered_subject_id=a.offered_subject_id
inner join student c on c.student_id=a.student_id
inner join instructor d on d.instructor_id=b.instructor_id
inner join subject e on e.subject_id=b.subject_id
inner join user f on f.instructor_id=b.instructor_id
inner join student_course h on h.student_id=c.student_id
inner join course g on g.course_id=h.course_id
where f.username= '$student_id' and e.subject_code='$subject_code' ");
	
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	
?>