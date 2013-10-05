# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$j = jQuery.noConflict();
$j ->
	$j('.charity_link').on 'click', ->
		$j.fancybox({ type: 'ajax', href: '/charities/charity_detail/' + $j(this).attr('charity_id') })
		return false
	$j('h2.question').on 'click', ->
		$j(this).next('div.answer').slideToggle()
	$j('div.answer').on 'click', ->
		$j(this).slideToggle()
	$j('div.tech_number').hover(
		->
			slide = $j(this).attr('slide')
			$j("#" + $j(this).attr('slide')).stop().fadeIn("slow");
			if(slide == 'number_1')
				$j("#tech_circle").css('background-image','url(/assets/tech-circle-1.png)');
			else if(slide == 'number_2')
				$j("#tech_circle").css('background-image','url(/assets/tech-circle-2.png)');
			else if(slide == 'number_3')
				$j("#tech_circle").css('background-image','url(/assets/tech-circle-3.png)');
			else if(slide == 'number_5' || slide == 'number_6')
				$j(".main_content").css('background-image', 'url("/assets/tech-overlay-5.png"), url("/assets/tech-flask.png"), url("/assets/tech-water.jpg")');
				$j(".main_content").css('background-position', '310px -26px, 310px -26px, left 76px');
		->
			slide = $j(this).attr('slide')
			$j("#" + $j(this).attr('slide')).stop().hide();
			$j("#tech_circle").css('background-image','url(/assets/tech-circle.png)');
			if(slide == 'number_4' || slide == 'number_5' || slide == 'number_6')
				$j(".main_content").css('background-image', 'url("/assets/tech-flask.png"), url("/assets/tech-water.jpg")');
				$j(".main_content").css('background-position', '310px -26px, left 76px');
	)
	if(window.location.pathname == '/pages/hydro-flask-technology')
		$j(['/assets/tech-circle-3.png','/assets/tech-circle-2.png','/assets/tech-circle-1.png','/assets/tech-overlay-5.png']).preload();