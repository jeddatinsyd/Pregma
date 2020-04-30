<?php

include 'config.php';
	
$student_id =$_GET['student_id'];
	
	$result = $conn->query("select a.offered_subject_id,a.room, a.time_start,a.time_end,a.section ,b.subject_code,b.description,a.days,b.units,concat_ws(' ',c.f_name,null,c.l_name) as name,a.subject_id
							from offered_subject a
							inner join subject b on a.subject_id=b.subject_id
							inner join instructor c on a.instructor_id=c.instructor_id
                            inner join department d on d.department_id=b.department_id
                            inner join course e on e.department_id=d.department_id
                            inner join student_course f on f.course_id=e.course_id
                            inner join student g on g.student_id=f.student_id
                            inner join user h on h.user_id=g.user_id
                            where h.username='$student_id'
                            and a.offered_subject_id not in (
                            	select offered_subject_id from enrolled_subject where student_id=g.student_id
                            )
                            ");
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()){
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	
?>