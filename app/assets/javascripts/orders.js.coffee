# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$j = jQuery.noConflict();
$j ->
  $j("a#form_handle").on 'click', (e) ->
    e.preventDefault()
    $j("#billing_address_fields").slideDown()
    $j('form#new_order').submit()

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