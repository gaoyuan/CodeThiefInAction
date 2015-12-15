add_filter( 'wp_authenticate', 'wpsites_no_admin_user' );
function wpsites_no_admin_user($user){
	if($user == 'admin'){
		exit;
	}
}

add_filter('sanitize_user', 'wpsites_sanitize_user_no_admin',10,3);
function wpsites_sanitize_user_no_admin($username, $raw_username, $strict){
	if($raw_username == 'admin' || $username == 'admin'){
		exit;
	}
	return $username;
}