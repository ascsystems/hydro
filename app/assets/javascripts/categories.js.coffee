# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$("#category_select").on 'change', ->
		$('html, body').animate({ scrollTop: $($("#category_select").val()).offset().top }, 2000)
	$(".back_to_top a").on 'click', ->
		$('html, body').animate({ scrollTop: $("h2:first").offset().top }, 2000)
		return false