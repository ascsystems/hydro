# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$('#footer_email_box').on 'click', ->
		if($(this).val() == 'Enter email address')
			$(this).val('')
	$('#footer_email_box').on 'blur', ->
		if($(this).val() == '')
			$(this).val('Enter email address')
	$('#footer_search_box').on 'click', ->
		if($(this).val() == 'Search')
			$(this).val('')
	$('#footer_search_box').on 'blur', ->
		if($(this).val() == '')
			$(this).val('Search')		