<div class="relatedposts">
<h3>Related posts</h3>
<?php
    $orig_post = $post;
    global $post;
    $tags = wp_get_post_tags($post->ID);
     
    if ($tags) {
    $tag_ids = array();
    foreach($tags as $individual_tag) $tag_ids[] = $individual_tag->term_id;
    $args=array(
    'tag__in' => $tag_ids,
    'post__not_in' => array($post->ID),
    'posts_per_page'=>4, // Number of related posts to display.
    'caller_get_posts'=>1
    );
     
    $my_query = new wp_query( $args );
 
    while( $my_query->have_posts() ) {
    $my_query->the_post();
    ?>
     
    <div class="relatedthumb">
        <a rel="external" href="<? the_permalink()?>"><?php the_post_thumbnail(array(150,100)); ?><br />
        <?php the_title(); ?>
        </a>
    </div>
     
    <? }
    }
    $post = $orig_post;
    wp_reset_query();
    ?>
</div>