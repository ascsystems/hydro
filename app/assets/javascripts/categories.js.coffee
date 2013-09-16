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
	$j("#search_order").on 'change', ->
		$j("#search_form").submit()
	$j(".category_product .colors .color_circle").on 'mouseover', ->
		product_id = $j(this).closest("div.colors").attr("product_id")
		image = $j(this).closest("div.colors").siblings('div.image').children('a').children('img')
		update_category_image(product_id, $j(this).attr('option_id'), image)

update_category_image = (product_id, option_id, image) ->
	options = []
	options.push(option_id)
	$j.getJSON "/products/" + product_id + "/product_images/get_image", { data: '{ options: [' + options.join(",") + '], product:' + product_id + '}'}, (data) ->
		image_url = data[0].path + 'small/' + data[0].name
		$j(image).attr('src', image_url)