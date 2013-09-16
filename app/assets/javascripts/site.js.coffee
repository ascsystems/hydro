$j = jQuery.noConflict();
$j ->
	$j('#footer_email_box').on 'click', ->
		if($j(this).val() == 'Enter email address')
			$j(this).val('')
	$j('#footer_email_box').on 'blur', ->
		if($j(this).val() == '')
			$j(this).val('Enter email address')
	$j('#footer_search_box').on 'click', ->
		if($j(this).val() == 'Search')
			$j(this).val('')
	$j('#footer_search_box').on 'blur', ->
		if($j(this).val() == '')
			$j(this).val('Search')
	$j('.store_click').on 'click', ->
		storeClick($j(this).attr('lat'), $j(this).attr('lng'))
		return false
	$j('#tabs ul li div.tab').on 'mouseover', ->
		this_tab = $j(this).parent('li')
		if(!$j(this_tab).hasClass('active'))
			$j(this_tab).siblings().css({'visibility': 'hidden'})
			$j(this_tab).addClass 'active'
			$j(this_tab).children('div.tab_content').slideToggle 'slow'
	$j('#tabs ul li div.tab').on 'click', ->
		this_tab = $j(this).parent('li')
		if($j(this_tab).hasClass('active'))
			$j(this_tab).children('div.tab_content').slideToggle 'slow', ->
				$j(this_tab).siblings().css({'visibility': 'visible'});
				$j(this_tab).removeClass('active')