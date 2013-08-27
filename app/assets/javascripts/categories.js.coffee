# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$j = jQuery.noConflict();
$j ->
	$j("#category_select").on 'change', ->
		$j('html, body').animate({ scrollTop: $j($j("#category_select").val()).offset().top }, 2000)
	$j(".back_to_top a").on 'click', ->
		$j('html, body').animate({ scrollTop: $j("h2:first").offset().top }, 2000)
		return false