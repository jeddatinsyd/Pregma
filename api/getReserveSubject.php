<?php

include 'config.php';

	//pdo fetch
	$dbhost = 'localhost';
    $dbname = 'akic_db';
    $dbuser = 'root';
    $dbpass = '';
    try {
        $con = new PDO("mysql:host={$dbhost};dbname={$dbname}", $dbuser, $dbpass);
        $con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    }
    catch( PDOException $excepiton ) {
        echo "Connection error :" . $excepiton->getMessage();
    }	


	$student_id =$_GET['student_id'];
	

    //display reserve subject
	$result = $conn->query("SELECT distinct c.subject_code,c.description,c.units,b.section,b.days,b.time_start,b.time_end,concat_ws(' ',e.f_name,null,e.l_name) as name,f.student_id,a.offered_subject_id,b.room
		from enrolled_subject a
		inner join offered_subject b on b.offered_subject_id=a.offered_subject_id
		inner join subject c on c.subject_id=b.subject_id
		inner join student f on f.student_id=a.student_id
		inner join user d on d.user_id=f.user_id
        inner join instructor e on e.instructor_id=b.instructor_id
		where d.username='$student_id' and a.status=0 	");
	
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	

?>