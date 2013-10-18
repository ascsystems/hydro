# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$j = jQuery.noConflict()
$j ->
	$j("#add_content_dialog").dialog({ dialogClass: "no-close", autoOpen: false })
	$j("#add_content").on 'click', ->
	  $j("#add_content_dialog").dialog('open');