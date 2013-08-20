# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
	$("#cart_page #checkout").on 'click', ->
		shipping_value = $('[name="shipping"]:checked').val()
		if shipping_value == undefined
			alert "Please select the shipping method"
		else
			window.location.href = '/orders/new?sm='+shipping_value
