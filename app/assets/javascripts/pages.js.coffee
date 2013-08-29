# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$j = jQuery.noConflict();
$j ->
	$j('.charity_link').on 'click', ->
		$j.fancybox({ type: 'ajax', href: '/charities/charity_detail/' + $j(this).attr('charity_id') })
		return false