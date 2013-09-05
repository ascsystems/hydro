var ambassadorLanding = function(){
	//touchCheck();
	//var anchorNavOffset = $('ambwrapper').cumulativeOffset().top;
	//anchorNav(anchorNavOffset);
	//anchorLink();
	ambassadorHover('amblandingthumb');
	//$(document).observe('scroll', function(event){
	//	anchorNav(anchorNavOffset);
	//});
}

var ambassadorHover = function(ambClass){
	var activeHover = '';
	$$('.' + ambClass).each(function(el){
		el.observe('mouseenter', function(e){
			el.addClassName('hover');
		});
		el.observe('mouseleave', function(e){
			el.removeClassName('hover');
		});
	});
	if($$('body.touch').length > 0){
		$$('.ambpop').each(function(el){
			var parentEl = el.up('.' + ambClass);
			el.observe('click', function(e){
				parentEl.removeClassName('hover');
				parentEl.removeClassName('open');
			});
		});
		$$('.' + ambClass + 'link').each(function(el){
			el.observe('click', function(e){
				var parentEl = el.up('.' + ambClass);
				if($(activeHover)){
					if(activeHover != parentEl.id){
						$(activeHover).removeClassName('open');
					}
				}
				var parentEl = el.up('.' + ambClass);
				if(!parentEl.hasClassName('open')){
					parentEl.addClassName('open');
					activeHover = parentEl.id;
					e.preventDefault();
				}
			});
		});
	} else {
		$$('.ambpop').each(function(el){
			el.observe('mouseenter', function(e){
				el.up('.' + ambClass).removeClassName('hover');
			});
		});
	}
}


var anchorLink = function(){
	$$('.anchorlink').each(function(el){
		var anchorLink = el.href;
		anchorLink = anchorLink.split('#');
		anchorLink = anchorLink.pop();
		$(el).observe('click', function(event) {
			Effect.ScrollTo(anchorLink, { duration:'1', offset:-46 });
			event.stop();
		});
	});
}

var anchorNav =  function(anchorNavOffset){
	var scrollTop = document.viewport.getScrollOffsets().top;
	if(scrollTop > anchorNavOffset){
		$('sportanchornav').className = 'fixed';
	} else {
		$('sportanchornav').className = '';
	}
}