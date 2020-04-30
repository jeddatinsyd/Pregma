<?php

include 'config.php';
	

	$student_id =$_GET['student_id'];
	
	$result = $conn->query("select DISTINCT b.trimester,b.year from student_evaluation a
inner join trimester b on a.trimester_id=b.trimester_id
inner join user c on a.user_id=c.user_id
where c.username='$student_id'
order by b.year DESC
  ");
	
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	

?>