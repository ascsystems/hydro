$ ->
	$('#footer_email_box').on 'click', ->
		if($(this).val() == 'Enter email address')
			$(this).val('')
	$('#footer_email_box').on 'blur', ->
		if($(this).val() == '')
			$(this).val('Enter email address')
	$('#footer_search_box').on 'click', ->
		if($(this).val() == 'Search')
			$(this).val('')
	$('#footer_search_box').on 'blur', ->
		if($(this).val() == '')
			$(this).val('Search')