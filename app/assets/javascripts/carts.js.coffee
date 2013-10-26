# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$j = jQuery.noConflict();
$j ->
	$j("#cart_page #checkout").on 'click', ->
		window.location.href = '/orders/new'
	$j("#cart_page #calculate_shipping").on 'click', ->
		if($j('#shipping_zip').val() != '')
			$j.getJSON '/carts/get_shipping.json', 'shipping_zip=' + $j('#shipping_zip').val(), (data) ->
	 			items = []
					$j.each data, ( k, v ) ->
						items.push('<li>' + v.name + ' - $' + (v.price * 1).toFixed(2) + '&nbsp;&nbsp;&nbsp;<input type="radio" name="shipping" price="' + (v.price * 1).toFixed(2) + '" value="' + v.id + '" /></li>')
					$j("#cart_page #shipping").html('<p>Select your shipping option:</p>')
					$j( "<ul/>", { "class": "shipping-list", html: items.join( "" ) }).appendTo("#cart_page #shipping")
			return false
		else
			alert("Zip code field is blank.")
	$j(".quantity").on 'input', ->
		$j(".saved").remove()
		$j(this).siblings('div.update').html('<a href="#" class="update_link" >Update</a>');
	$j("#cart_table").on 'click', 'a.update_link', ->
		update = $j(this)
		qty = $j(this).parent('div.update').siblings('.quantity')
		price = $j(this).closest('tr').children('td.item_subtotal')
		quantity = $j(qty).val()
		item = $j(qty).attr('item')
		$j.getJSON '/carts/update_quantity.json', 'quantity=' + quantity + '&line_item_id=' + item, (data) ->
			$j(qty).val(data.quantity)
			$j(price).html('$' + data.item_total)
			$j("#cart_subtotal").html('$' + data.total)
			$j(update).parent('div.update').html('<span class="saved" style="color:green;">Saved</span>')
		return false
	$j("#shipping").on 'click', 'ul.shipping-list li input[type="radio"]', ->
		$j.get '/carts/update_shipping', 'id=' + $j(this).val() + '&price=' + $j(this).attr('price')
	$j("#cart_page #apply_promo").on 'click', ->
		if($j('#promo_code').val() == '')
			alert("Promo code field is blank.")
			return false