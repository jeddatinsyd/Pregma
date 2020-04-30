<?php

include 'config.php';
	

	
	$result = $conn->query("select a.offered_subject_id, a.time_start,a.time_end,a.section ,b.subject_code,b.description,a.days,b.units,concat_ws(' ',c.f_name,null,c.l_name) as name,a.subject_id
							from offered_subject a
							inner join subject b on a.subject_id=b.subject_id
							inner join instructor c on a.instructor_id=c.instructor_id");
	
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	
?>

