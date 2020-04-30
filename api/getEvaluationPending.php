<?php

include 'config.php';
	

	$student_id =$_GET['student_id'];

	$result = $conn->query("select a.subject_code,a.description,a.units 
							from subject a
							inner join department b on b.department_id=a.department_id
							inner join course c on c.department_id=b.department_id
							inner join student_course d on d.course_id=c.course_id
							inner join student e on e.student_id=d.student_id
							inner join user f on f.user_id=e.user_id
							where f.username='$student_id'
							and subject_code not in (
														select e.subject_code from student_grade a
														inner join grade b on b.grade_id=a.grade_id
														inner join enrolled_subject c on c.enrolled_subject_id=a.enrolled_subject_id
														inner join offered_subject d on d.offered_subject_id=c.offered_subject_id
														inner join subject e on e.subject_id=d.subject_id
														inner join student f on f.student_id=c.student_id
														inner join user g on g.user_id=f.user_id
							                            inner join department h on h.department_id=e.department_id
							                            inner join course i on i.department_id=h.department_id
							                            inner join student_course j on j.course_id=i.course_id
														where g.username='$student_id'
														ORDER BY e.subject_code ASC)");
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	
?>


<!-- 
	$result = $conn->query("select subject_code,description,units from subject where subject_code not in (select e.subject_code from student_grade a
inner join grade b on b.grade_id=a.grade_id
inner join enrolled_subject c on c.enrolled_subject_id=a.enrolled_subject_id
inner join offered_subject d on d.offered_subject_id=c.offered_subject_id
inner join subject e on e.subject_id=d.subject_id
inner join student f on f.student_id=c.student_id
inner join user g on g.user_id=f.user_id
where g.username='$student_id'
ORDER BY e.subject_code ASC)"); -->