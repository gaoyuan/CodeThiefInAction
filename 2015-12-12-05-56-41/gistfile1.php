<?php
$max_file_size = 5*1024*1024; //5MB
$path = "admin/upload/"; // Upload directory
//$count = 0; // nr.successfully uploaded files

$valid_formats = array("rar","zip","7z","pdf","xlsx","xls","docx","doc","txt");

$valid_formats_server = array(
	"application/pdf",
	"application/octet-stream",
	"application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
	"application/vnd.openxmlformats-officedocument.wordprocessingml.document",
	"application/msword",
	"application/vnd.ms-excel",
	"text/plain"
);

//prevent uploading from wrong file types(server secure)
foreach ($_FILES['files']['type'] as $t => $tName) {
	if(!in_array($_FILES['files']['type'][$t], $valid_formats_server)){
		echo "wrong FILE TYPE";
		return;
	}
}

// Loop $_FILES to exeicute all files
foreach ($_FILES['files']['name'] as $f => $name) {

	if ($_FILES['files']['error'][$f] == 4) {
			continue; // Skip file if any error found
	}
	if ($_FILES['files']['error'][$f] == 0) {
			if ($_FILES['files']['size'][$f] > $max_file_size) {
				echo $message[] = "$name is too large!";
				continue; // Skip large files
			}
			elseif(!in_array(pathinfo($name, PATHINFO_EXTENSION), $valid_formats)){
				echo $message[] = "$name is not a valid format";
				continue; // Skip invalid file formats
			}
			else{ // No error found! Move uploaded files
				//if(move_uploaded_file($_FILES["files"]["tmp_name"][$f], $path.$name))
					move_uploaded_file($_FILES["files"]["tmp_name"][$f], $path.$name);
					//$count++; // counting successful uploadings
			}
	}
}