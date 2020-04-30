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
	

	// //validation to remove reserve subject if days>3
	
	//  $stmt1=$con->prepare("SELECT distinct a.enrolled_subject_id,a.reserve_date,a.expiry_date,c.subject_code,d.student_id,a.offered_subject_id
	// 	from enrolled_subject a
	// 	inner join offered_subject b on b.offered_subject_id=a.offered_subject_id
	// 	inner join subject c on c.subject_id=b.subject_id
	// 	inner join user d on d.student_id=a.student_id
	// 	inner join instructor e on e.instructor_id=b.instructor_id
	// 	where d.username=? ");
	//     $stmt1->execute([$student_id]);
	//     $newbid=$stmt1->fetch();


	//     $eid = $newbid['enrolled_subject_id'];
	//     $today = date("Y-m-d");
	//     $date_estimated= $newbid['expiry_date'];
	//     // if($today>$date_estimated)
	//     // {
	// 		 $sql5 = "delete from enrolled_subject a where '$today' > '$date_estimated' where a.enrolled_subject_id= '$eid'    ";
 //             $stmt = $con->prepare($sql5);
 //             $stmt->execute();   			        	
 //        // }


    //display reserve subject
	$result = $conn->query("SELECT distinct c.subject_code,c.description,c.units,b.section,b.days,b.time_start,b.time_end,concat_ws(' ',e.f_name,null,e.l_name) as name,d.student_id,a.offered_subject_id
		from enrolled_subject a
		inner join offered_subject b on b.offered_subject_id=a.offered_subject_id
		inner join subject c on c.subject_id=b.subject_id
		inner join user d on d.student_id=a.student_id
		inner join instructor e on e.instructor_id=b.instructor_id
		where d.username='$student_id'");
	
	$arrayResult=array();
	while ($fetch = $result->fetch_assoc()) {
		$arrayResult[] = $fetch;
	}
	echo json_encode($arrayResult);	

?>