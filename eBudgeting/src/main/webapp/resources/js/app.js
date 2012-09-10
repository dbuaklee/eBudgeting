$.fn.slideTo = function(data, right) {
	var currentDom = this;
	
	var width = parseInt(this.css('width'));

	var transfer = $('<div class="transfer"></div>').css({
		'width' : (2 * width) + 'px'
	});
	
	
	var current = $('<div class="current"></div>').css({
		'width' : width + 'px',
		'left' : '0',
		'float' : 'left'
	}).html(this.html());
	
	
	
	var next = $('<div class="next"></div>').css({
		'width' : width + 'px',
		'left' : width + 'px',
		'float' : 'left'
	}).html(data);
	
	var animateCss;
	
	if(right == true) {
		next.css({
			'left' : '0',
		});
		
		current.css({
			'left' : width + 'px',
		});

		transfer.css({
			'margin-left' : '-' + width + 'px'			
		});
		
		transfer.append(next).append(current);

		this.html('').append(transfer);
		animateCss={
			'margin-left' : '0'	
		};
	} else {
		transfer.append(current).append(next);
		this.html('').append(transfer);
		animateCss={
			'margin-left' : '-' + width + 'px'
		};
	}
	
	
	transfer.animate(animateCss, 4000, function() {
		currentDom.html(data);
	});
};