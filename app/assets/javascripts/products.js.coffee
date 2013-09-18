# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# NOTE: This is only for use on the products/show page ! Do not include it other places
$j = jQuery.noConflict();
$j ->
	update_image()
	$j("#product #content_nav_list li").on 'click', ->
		$j("#product #content_nav_list li").removeClass('selected')
		$j(this).addClass('selected')
		active_div = $j(this).attr('display')
		$j('.content_div').hide()
		$j('#' + active_div).show()
	$j("#product #review_nav_list li").on 'click', ->
		active_div = $j(this).attr('display')
		if(active_div != '')
			$j("#product #content_nav_list li").removeClass('selected')
			if(active_div == 'reviews')
				$j('#reviews_li').addClass('selected')
			else if(active_div == 'review_form')
				$j('#write_review_li').addClass('selected')
			$j('.content_div').hide()
			$j('#' + active_div).show()
	$j( "#quantity" ).spinner({ value: 1, min: 1, max:9999, stop: ->
		$j("#quantity_text").html($j("#quantity").val())
		$j("#price").html("$" + ($j("#quantity").val() * $j("#product_price").val()).toFixed(2))
	})
	$j( "#quantity" ).readOnly = true

	$j("#product #cart").on 'click', ->
		$j("#product_form").submit();
	$j(".option").on 'click', ->
		$j(this).siblings("input[type='hidden']").val($j(this).attr('option_id'))
		update_image()
		$j(this).siblings().removeClass('selected')
		$j(this).addClass('selected')
		$j(this).parent().siblings(".option_header").children(".option_text").html($j(this).attr('title'))
		#$j(this).sibling(".option_text").html($j(this).attr('title'))
	$j("#enlarge_link, #product_image").on 'click', ->
		$j.fancybox({href: $j('#product_image').attr('src') })
		return false
	$j('#star').raty({starOn: '/assets/star-on.png', starOff: '/assets/star-off.png', hints: ['','','','','']})
	$j("#reviews_button").on 'click', ->
		 $j(this).parents('form:first').submit()
		 return false

update_image = () ->
	$j("#loadingImage").fadeIn 600
	options = []
	$j("input[type='hidden'].option_value").each (index, element) =>
		options.push($j(element).val())
	$j.getJSON "/products/" + $j('#product_id').val() + "/product_images/get_image", { data: '{ options: [' + options.join(",") + '], product: ' + $j("#product_id").val() + '}'}, (data) ->
		image_url = data[0].path + 'cropped/large/' + data[0].name
		$j("#product_image").attr('src', image_url)
		.load ->
			$j("#loadingImage").fadeOut 600
		return
