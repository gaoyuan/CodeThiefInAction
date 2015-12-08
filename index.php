<?php
$source_url = "http://facebook.com/".$facebook_username;
$url = "http://api.facebook.com/restserver.php?method=links.getStats&urls=".urlencode($source_url);
$xml = file_get_contents($url);
$xml = simplexml_load_string($xml);
$shares =  $xml->link_stat->share_count;
$likes =  $xml->link_stat->like_count;
$comments = $xml->link_stat->comment_count;
$total = $xml->link_stat->total_count;
$max = max($shares,$likes,$comments);
?>