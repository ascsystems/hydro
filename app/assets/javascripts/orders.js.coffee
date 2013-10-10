# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$j = jQuery.noConflict();
$j ->
  $j("a#form_handle").on 'click', (e) ->
    e.preventDefault()
    $j("#billing_address_fields").slideDown()
    $j('form#new_order').submit()

  $j("a#complete_order").on 'click', ->
    $j('form#final_order').submit()
    return false

  $j('#billing_same_as_shipping').on 'click', ->
  	if($j(this).is(':checked'))
  		$j("#order_billing_address").val($j("#order_address").val())
  		$j("#order_billing_address2").val($j("#order_address2").val())
  		$j("#order_billing_city").val($j("#order_city").val())
  		$j("#order_billing_state").val($j("#order_state").val())
  		$j("#order_billing_zip").val($j("#order_zip").val())
  		$j("#billing_address_fields").slideUp()
  	else
  		$j("#billing_address_fields").slideDown()

  $j("#payment_panel").on 'click', 'ul.shipping-list li input[type="radio"]', ->
    $j.get '/carts/update_shipping', 'id=' + $j(this).val() + '&price=' + $j(this).attr('price')
    total = ($j(this).attr('price') * 1) + ($j("#grand_total_value").val() * 1)
    $j("#grand_total").html('$' + total.toFixed(2))