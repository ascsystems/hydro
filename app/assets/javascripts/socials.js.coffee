# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$j = jQuery.noConflict()
$j ->
	$j("#add_content_dialog").dialog({ dialogClass: "no-close", autoOpen: false, width: 490 })
	$j("#add_content").on 'click', ->
	  $j("#add_content_dialog").dialog('open');
	$j(".cancel_button").on 'click', ->
		$j("#add_content_dialog").dialog('close');
		return false
	$j("#post_photo").on 'click', ->
		$j("#post_story").removeClass('selected')
		$j(this).addClass('selected')
		$j('#social_story_form').hide()
		$j('#social_form').show()
	$j("#post_story").on 'click', ->
		$j("#post_photo").removeClass('selected')
		$j(this).addClass('selected')
		$j('#social_form').hide()
		$j('#social_story_form').show()