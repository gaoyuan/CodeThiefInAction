			 <?php if(is_category()){
					single_cat_title();
			 }elseif (is_tag()){
				 single_tag_title();
			 }elseif(is_author()){
				 the_post(); 
				 echo 'Author :' .get_the_author();
			 }elseif(is_day()){
				 echo 'Daily Archives : ' .get_the_date();
			 }elseif(is_month()){
				 echo 'Monthly Archives : ' .get_the_date('F Y');
			 }elseif(is_year()){
				 echo 'Yearly Archives : ' .get_the_date('Y');
			 }else{
				 echo 'Archives';
			 }
			;?>			