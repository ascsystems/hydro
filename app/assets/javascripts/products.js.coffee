# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$("#product #content_nav_list li").on 'click', ->
		$("#product #content_nav_list li").removeClass('selected')
		$(this).addClass('selected')
		active_div = $(this).attr('display')
		$('.content_div').hide()
		$('#' + active_div).show()
	$("#product #review_nav_list li").on 'click', ->
		active_div = $(this).attr('display')
		if(active_div != '')
			$("#product #content_nav_list li").removeClass('selected')
			if(active_div == 'reviews')
				$('#reviews_li').addClass('selected')
			else if(active_div == 'review_form')
				$('#write_review_li').addClass('selected')
			$('.content_div').hide()
			$('#' + active_div).show()