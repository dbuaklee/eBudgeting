//Globally register console
if (typeof console === 'undefined') {
    console = { log: function() {} };
}


$.fn.slideTo = function(data, callBack, right) {
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
			'left' : '0'
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
	
	
	transfer.animate(animateCss, 200, function() {
		currentDom.html(data);
		callBack();
	});
};

$.fn.slideLeft = function(data, callBack) {
	this.slideTo(data, callBack);
};

$.fn.slideRight = function(data, callBack) {
	this.slideTo(data, callBack, true);
};

Handlebars.registerHelper('indexHuman', function(index) {
	if(isNaN(index) || index == null) {
		return ""; 
	} else {
		var output = index + 1;
		return output + ".";
	}
});

Handlebars.registerHelper('formatNumber', function(number) {
	return addCommas(number);
});

Handlebars.registerHelper('formatTimeDetail', function(timeStamp){
	if(timeStamp !=null) {
		var time = moment(timeStamp);
		return time.format("DD/MM/YYYY HH:mm:ssน.");
		
	} else {
		return "";
	}
});


function addCommas(nStr)
{
	nStr += '';
	x = nStr.split('.');
	x1 = x[0];
	x2 = x.length > 1 ? '.' + x[1] : '';
	var rgx = /(\d+)(\d{3})/;
	while (rgx.test(x1)) {
		x1 = x1.replace(rgx, '$1' + ',' + '$2');
	}
	return x1 + x2;
}

function changeCurrentRootFY(sel) {
	var value = sel.options[sel.selectedIndex].value;
	
	$.ajax({
		type: 'GET',
		url: appUrl('/Session/changeCurrentRootFY'),
		data: {
			newFiscalYear: value
		},
		success: function(response) {
			alert("success!");
		}
	
	});	
}

function saveModel(model, success, error) {
	
	$.ajax({
		type: 'POST', 
		dataType: 'json',
		url: model.url(),
		contentType : 'application/json',
		data: JSON.stringify(model.toJSON()),
		success: success,
		error: error
	});
}
