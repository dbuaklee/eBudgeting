<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
	<div class="span12">

	    <ul class="breadcrumb" id="headNav">
		    <li><a href="/eBudgeting/page/m2f06">Root</a> <span class="divider">/</span></li>
		    <li class="active">ปี 2556</li>
	    </ul>

		
		<div class="control-group" id="mainCtr">
		</div>


	</div>
</div>


<script id="mainCtrTemplate" type="text/x-handler-template">
<label class="control-label" for="mainTbl">{{type.name}} {{indexHuman index}} {{name}}</label>
<div class="controls" style="margin-bottom: 15px;">
	<a href="#" class="btn btn-mini btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มรายการ</a>
	<a href="#" class="btn btn-mini btn-primary menuEdit"><i class="icon icon-edit icon-white"></i> แก้ไข</a>
	<a href="#" class="btn btn-mini btn-danger menuDelete"><i class="icon icon-trash icon-white"></i> ลบ</a> 
</div>
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td width="20"></td>
			<td width="50">ลำดับที่</td>
			<td>{{#each type.children}}{{name}} {{/each}}</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>


<script id="tbodyTemplate" type="text/x-handlebars-template">
{{#each this}}
<tr data-id="{{id}}"><td><input type="radio" name="rowRdo" id="rdo_{{index}}" value="{{index}}"/></td>
	<td> {{indexHuman index}} </td>
	<td> {{name}} <a href="#" class="nextChildrenLnk"><i class="icon icon-chevron-right"></i> </a></td>

</tr>
{{/each}}
</script>

<script id="newRowTemplate" type="text/x-handlebars-template">
<td></td>
	<td> {{indexHuman index}} </td>
	<td> <input type='text' placeholder='...' class='span7' value="{{name}}"></input> <button indexHolder='{{index}}' class='btn btn-mini btn-info lineSave'>บันทึก</button></td>

</script>


<script type="text/javascript">
<!--
var mainTblView;

var e1;
var objectiveCollection;


$(document).ready(function() {
	 

var MainTblView = Backbone.View.extend({
	initialize: function(){
	    this.collection.bind('reset', this.render, this);
	},

	el: "#mainCtr",
	selectedObjective: null,
	
	newRowTemplate: Handlebars.compile($("#newRowTemplate").html()),
	mainCtrTemplate: Handlebars.compile($("#mainCtrTemplate").html()),
	tbodyTemplate: Handlebars.compile($("#tbodyTemplate").html()),
	
	render: function() {
		// first render the control
		var html;
		
		if(this.selectedObjective != null) {
			html = this.mainCtrTemplate(this.selectedObjective.toJSON());
		} else {
			html = this.mainCtrTemplate({name: 'ปี 2556', type:{name: 'งบประมาณ', children: [{name:'แผนงาน'}]} });
		}
		this.$el.html(html);
		
		// then the inside row
		html = this.tbodyTemplate(this.collection.toJSON());
		this.$el.find('tbody').html(html);
		
		
	},
	
	events: {
		"click .menuNew" : "newRow",
		"click .menuDelete" : "deleteRow",
		"click .menuEdit"	: "editRow",
		"click .lineSave" : "saveLine",
		"click .nextChildrenLnk" : "slideInChildren"
	},
	
	newRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			$('#mainTbl tbody').append('<tr>'+this.newRowTemplate({index:this.collection.length})+'</tr>');
			this.$el.find('a.btn').toggleClass('disabled');
		}
	},
	
	saveLine: function(e) {
		
		 
		inputVal = $(e.currentTarget).prev('input').val();
		indexRow = parseInt($(e.currentTarget).attr('indexHolder'));
		if(this.collection.at(indexRow) == null) {
			
			this.collection.add(new Objective({name: inputVal, index: indexRow}));
		} else {
			var model  = this.collection.at(indexRow);
			model.set('name', inputVal);
		}
		
		this.$el.find('a.btn').toggleClass('disabled');
		
		this.collection.trigger("reset");
	
	},
	
	deleteRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			var indexToDelete = $('input[name=rowRdo]:checked').val();
			var modelToDelete = this.collection.at(indexToDelete);
			this.collection.remove(modelToDelete);
			
			// now we have to run through and reindex
			this.collection.each(function(model, index) {
				model.set('index', index);
			});
			
			this.collection.trigger('reset');
		}			
	},
	
	editRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			this.$el.find('a.btn').toggleClass('disabled');
			var index = $('input[name=rowRdo]:checked').val();
			var model = this.collection.at(index);
			var html = this.newRowTemplate(model.toJSON());
			$('input[name=rowRdo]:checked').parents('tr').html(html);
		}
	},
	
	slideInChildren: function(e) {
		e1 = e;
		
		// get id;
		var id = $(e.target).parents('tr').attr('data-id');
		this.selectedObjective = this.collection.get(id); 
			
		var f1 = function() {
			//once the animation is done
			// now load content and replace in div...
			this.collection.url='/eBudgeting/Objective/'+this.id+'/children';
			this.collection.fetch();

		};
		
		f1 = _.bind(f1, {collection: this.collection, id: id});
		
		// change the ul
		
		
		lastLiHtml = $('#headNav').children().last().html();
		prevLiHref = $('#headNav').find('a:last').attr('href');
		
		if(this.selectedObjective.get('parent') == null) {
			lastHref = prevLiHref + "/2556";
		} else {
			lastHref = prevLiHref + "/" + this.selectedObjective.get('id');	
		}
		
		$('#headNav').children().last().html("<li><a href=" + lastHref +">"+ lastLiHtml +"</a> <span class='divider'>/</span></li>");
		
		var humanIndex = this.selectedObjective.get('index')+1;
		$('#headNav').append("<li class='active'>" + this.selectedObjective.get('type').get('name') + "ที่ " +
				humanIndex + "</li>");
		
		html = "<div style='height: 100px;display: table-cell; vertical-align: middle; text-align: center;'>Loading <br/><img src='/eBudgeting/resources/graphics/spinner_bar.gif'></img></div>";
		// slide In spinner
		this.$el.slideLeft(html,f1);
						
	}
	
});


//rowCol.trigger('reset');

//experimental
objectiveCollection = new ObjectiveCollection();



// now we can create a view
mainTblView = new MainTblView({
	collection: objectiveCollection
});

lastObjectiveId="${lastObjectiveId}";
if(!isNaN(parseInt(lastObjectiveId))) {
	var objective = new Objective();
	objective.url = "/eBudgeting/Objective/" + lastObjectiveId;
	objective.fetch();
	mainTblView.selectedObjective = objective;
}

objectiveCollection.url = "${url}";
objectiveCollection.fetch();


});

//-->
</script>