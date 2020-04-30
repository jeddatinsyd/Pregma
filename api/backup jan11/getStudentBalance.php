<?php

include 'config.php';
	

	$student_id =$_GET['student_id'];
	
	$result = $conn->query("select a.student_id,a.billing_amount,a.trimester_id,c.trimester,d.username,c.year,b.status
from billing_details a
inner join payment b on a.student_id=b.student_id and a.trimester_id=b.trimester_id
inner join trimester c on a.trimester_id=c.trimester_id
inner join user d on a.student_id=d.student_id
where d.username='$student_id'
  ");
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	

?>