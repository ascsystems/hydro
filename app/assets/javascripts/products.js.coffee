# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

<<<<<<< HEAD
$ ->
	update_image()
	$("#product #content_nav_list li").on 'click', ->
		$("#product #content_nav_list li").removeClass('selected')
		$(this).addClass('selected')
		active_div = $(this).attr('display')
		$('.content_div').hide()
		$('#' + active_div).show()
	$("#product #review_nav_list li").on 'click', ->
		active_div = $(this).attr('display')
=======
# NOTE: This is only for use on the products/show page ! Do not include it other places
$j = jQuery.noConflict()
$j ->
	$j('.jqzoom').jqzoom({
    zoomType: 'standard',
    lens:true,
    preloadImages: true,
    zoomWidth: 600,
    zoomHeight: 600,
    alwaysOn:false
  })
	$j("#product #content_nav_list li").on 'click', ->
		$j("#product #content_nav_list li").removeClass('selected')
		$j(this).addClass('selected')
		active_div = $j(this).attr('display')
		$j('.content_div').hide()
		$j('#' + active_div).show()
	$j("#product #review_nav_list li").on 'click', ->
		active_div = $j(this).attr('display')
>>>>>>> e2c4492b9967997e5368a213c4dff8787ca628c5
		if(active_div != '')
			$j("#product #content_nav_list li").removeClass('selected')
			if(active_div == 'reviews')
				$j('#reviews_li').addClass('selected')
			else if(active_div == 'review_form')
<<<<<<< HEAD
				$('#write_review_li').addClass('selected')
			$('.content_div').hide()
			$('#' + active_div).show()
	$( "#quantity" ).spinner({ value: 1, min: 1, max:9999, stop: ->
		$("#quantity_text").html($("#quantity").val())
	})
	$( "#quantity" ).readOnly = true

	$("#product #cart").on 'click', ->
		$("#product_form").submit();
	$(".option").on 'click', ->
		$(this).siblings("input[type='hidden']").val($(this).attr('option_id'))
		update_image()
		$(this).siblings().removeClass('selected')
		$(this).addClass('selected')
		$(this).parent().siblings(".option_header").children(".option_text").html($(this).attr('title'))
		#$(this).sibling(".option_text").html($(this).attr('title'))
	$("#enlarge_link, #product_image").on 'click', ->
		$.fancybox({href: $('#product_image').attr('src') })
		return false
	$('#star').raty({starOn: '/assets/star-on.png', starOff: '/assets/star-off.png', hints: ['','','','','']})
	$("#reviews_button").on 'click', ->
		 $(this).parents('form:first').submit()
		 return false

update_image = () ->
	$("#loadingImage").fadeIn 600;
	options = [];
	$("input[type='hidden'].option_value").each (index, element) =>
		options.push($(element).val())
	$.getJSON "/products/" + $('#product_id').val() + "/product_images/get_image", { data: '{ options: [' + options.join(",") + '], product: ' + $("#product_id").val() + '}'}, (data) ->
		image_url = data[0].path + 'cropped/' + data[0].name
		$("#product_image").attr('src', image_url)
		.load ->
			$("#loadingImage").fadeOut 600
=======
				$j('#write_review_li').addClass('selected')
			$j('.content_div').hide()
			$j('#' + active_div).show()
	$j( "#quantity" ).spinner({ value: 1, min: 1, max: 9999, stop: ->
		$j("#quantity_text").html($j("#quantity").val())
		update_pricing()
		#$j("#price_value").html("$" + ($j("#quantity").val() * $j("#product_price").val()).toFixed(2))
	})
	$j( "#quantity" ).readOnly = true

	$j("#product #cart").on 'click', ->
		if(!$j(this).hasClass('disabled'))
			$j("#product_form").submit();
	$j(".option").on 'click', ->
		if(!$j(this).hasClass('multi'))
			$j("input[option_type_id='" + $j(this).attr('option_type_id') + "']").val($j(this).attr('option_id'))
			#$j(".option").removeClass('selected')
			$j(this).addClass('selected')
			update_image()
		else
			if(!$j(this).hasClass('disabled'))
				if($j(this).hasClass('selected'))
					$j(this).removeClass('selected')
					$j("input[product_id='" + $j(this).attr('option_id') + "']").val('')
				else
					$j("input[product_id='" + $j(this).attr('option_id') + "']").val($j(this).attr('option_id'))
					$j(this).addClass('selected')
			update_pricing()
		$j(this).parent().siblings(".option_header").children(".option_text").html($j(this).attr('title'))
		#$j(this).sibling(".option_text").html($j(this).attr('title'))
	$j("#enlarge_link, #product_image").on 'click', ->
		$j.fancybox({href: $j('#product_image').attr('src') })
		return false
	$j('#star').raty({starOn: 'https://s3.amazonaws.com/hydroflask/images/star-on.png', starOff: 'https://s3.amazonaws.com/hydroflask/images/star-off.png', hints: ['','','','','']})
	$j("#reviews_button").on 'click', ->
		 $j(this).parents('form:first').submit()
		 return false

update_pricing = () ->
	quantity = $j("#quantity").val()
	product_price = quantity * $j("#product_price").val()
	options_price = 0
	$j("#price_value").html("$" + product_price.toFixed(2))
	$j("#price_value").html("$" + ($j("#quantity").val() * $j("#product_price").val()).toFixed(2))
	$j("#optional_pricing").html('')
	$j("input[type='hidden'].option_value.multiselect").each (index, item)->
		if($j(item).val() != '')
			option_price = $j(item).attr('price') * quantity
			option_title = $j(item).attr('title')
			$j('<p><span class="option_price_text">' + option_title + ':</span><span class="option_price">+$' + option_price.toFixed(2) + '</span></p>').appendTo("#optional_pricing")
			options_price += option_price
	grand_total = product_price + options_price
	$j("#subtotal_value").html("$" + grand_total.toFixed(2))

update_image = () ->
	$j("#loadingImage").fadeIn 600
	options = []
	$j("input[type='hidden'].option_value.base").each (index, element) =>
		options.push($j(element).val())
	$j.getJSON "/products/" + $j('#product_id').val() + "/product_images/get_image", { data: '{ options: [' + options.join(",") + '], product: ' + $j("#product_id").val() + '}'}, (data) ->
		if(data.translation.quantity - data.translation.threshhold <= 0)
			$j("#cart").addClass('disabled')
			$j("#option_main_header").addClass('disabled').html('Out Of Stock')
		else
			$j("#cart").removeClass('disabled')
			$j("#option_main_header").removeClass('disabled').html('Select ' + $j("#option_main_header").attr('cat') + ': ' + $j(".option.selected:first").attr('title'))
		image_url = data.image.path + 'cropped/large/' + data.image.name
		big_image_url = data.image.path + 'cropped/original/' + data.image.name
		$j('.jqzoom').attr('href', big_image_url)
		$j("#product_image").attr('src', image_url)
		.load ->
			$j("#loadingImage").fadeOut 600
			$j('.jqzoom').removeData('jqzoom')
			$j('.jqzoom').jqzoom({
            zoomType: 'standard',
            lens:true,
            preloadImages: true,
            zoomWidth: 600,
            zoomHeight: 600,
            alwaysOn:false
        });
>>>>>>> e2c4492b9967997e5368a213c4dff8787ca628c5
		return
