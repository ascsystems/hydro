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