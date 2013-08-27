# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$j = jQuery.noConflict();
$j ->
	$j('#footer_email_box').on 'click', ->
		if($j(this).val() == 'Enter email address')
			$j(this).val('')
	$j('#footer_email_box').on 'blur', ->
		if($j(this).val() == '')
			$j(this).val('Enter email address')
	$j('#footer_search_box').on 'click', ->
		if($j(this).val() == 'Search')
			$j(this).val('')
	$j('#footer_search_box').on 'blur', ->
		if($j(this).val() == '')
			$j(this).val('Search')		