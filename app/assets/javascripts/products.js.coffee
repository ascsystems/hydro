# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

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
		if(active_div != '')
			$("#product #content_nav_list li").removeClass('selected')
			if(active_div == 'reviews')
				$('#reviews_li').addClass('selected')
			else if(active_div == 'review_form')
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
	$("#enlarge_link").on 'click', ->
		$.fancybox({href: $('#product_image').attr('src') })
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
		return