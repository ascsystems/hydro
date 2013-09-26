# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$j = jQuery.noConflict();
$j ->
	$j("#cart_page #checkout").on 'click', ->
		shipping_value = $j('[name="shipping"]:checked').val()
		if shipping_value == undefined
			alert "Please select the shipping method"
		else
			window.location.href = '/orders/new?sm='+shipping_value
	$j("#cart_page #calculate_shipping").on 'click', ->
		$j.getJSON '/carts/get_shipping.json', 'shipping_zip=' + $j('#shipping_zip').val(), (data) ->
 			items = []
				$j.each data, ( k, v ) ->
					items.push('<li>' + v.name + ' - $' + (v.price * .01).toFixed(2) + '&nbsp;&nbsp;&nbsp;<input type="radio" name="shipping" value="" /></li>')
				$j("#cart_page #shipping").html('<p>Select your shipping option:</p>')
				$j( "<ul/>", { "class": "shipping-list", html: items.join( "" ) }).appendTo("#cart_page #shipping")
		return false