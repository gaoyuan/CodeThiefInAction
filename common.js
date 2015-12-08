	/**
	***************************************************************
	* =Up button
	***************************************************************
	**/

	$(document, window).on('scroll', function() {
		if ($(this).scrollTop() > 100) {
			$('.up-btn').fadeIn();
		} else {
			$('.up-btn').fadeOut();
		}
	});

	$('.up-btn').on('click', function(e) {
		e.preventDefault();
		$('html, body').animate({scrollTop:0}, 1000);
	});

	// Up Button
	if ($(this).scrollTop() > 100)
	{
		$('.up-btn').fadeIn();
	}