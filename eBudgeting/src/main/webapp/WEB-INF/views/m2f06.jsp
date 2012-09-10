<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
	<div class="span12">

	    <ul class="breadcrumb" id="headNav">
		    <li><a href="../">Root</a> <span class="divider">/</span></li>
		    <li><a href="../">ปี 2556</a> <span class="divider">/</span></li>
		    <li class="active">แผนงาน</li>
	    </ul>

		
		<div class="control-group" id="mainCtr">
		</div>


	</div>
</div>


<script id="mainCtrTemplate" type="text/x-handler-template">
<label class="control-label" for="mainTbl">{{name}}</label>
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
			<td>{{name}}</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>


<script id="tbodyTemplate" type="text/x-handlebars-template">
{{#each this}}
<tr><td><input type="radio" name="rowRdo" id="rdo_{{index}}" value="{{index}}"/></td>
	<td> {{index}} </td>
	<td> {{name}} <a href="#" class="nextChildrenLnk"><i class="icon icon-chevron-right"></i> </a></td>

</tr>
{{/each}}
</script>

<script id="newRowTemplate" type="text/x-handlebars-template">
<td></td>
	<td> {{index}} </td>
	<td> <input type='text' placeholder='...' class='span7' value="{{name}}"></input> <button indexHolder='{{index}}' class='btn btn-mini btn-info lineSave'>บันทึก</button></td>

</script>


<script type="text/javascript">
<!--
var mainTblView;

var objectiveType = {name: 'แผนงาน'};

var rowCol = new Backbone.Collection([
                  {index: "1", name: "บริหารจัดการน้ำอย่างบูรณาการ"},
                  {index: "2",name: "ส่งเสริมประสิทธิภาพการผลิตและสร้างมูลค่าภาคการเกษตร"},
                  {index: "3",name: "แก้ไขปัญหาและพัฒนาจังหวัดชายแดนภาคใต้"}
                ]);

var e1;


$(document).ready(function() {
	 

var MainTblView = Backbone.View.extend({
	initialize: function(){
	    this.collection.bind('reset', this.render, this);
	},

	el: "#mainCtr",
	
	newRowTemplate: Handlebars.compile($("#newRowTemplate").html()),
	mainCtrTemplate: Handlebars.compile($("#mainCtrTemplate").html()),
	tbodyTemplate: Handlebars.compile($("#tbodyTemplate").html()),
	
	collection: rowCol,
	
	render: function() {
		
		// first render the control
		var html = this.mainCtrTemplate(level);
		this.$el.html(html);
		
		// then the inside row
		html = this.tbodyTemplate(this.collection.toJSON());
		this.$el.find('tbody').html(html);
		
		
	},
	
	events: {
		"click .menuNew" : "newRow",
		"click .menuDelete" : "deleteRow",
		"click .menuEdit"	: "editRow",
		"click .menuLink"	: "linkRow",
		"click .lineSave" : "saveLine",
		"click .nextChildrenLnk" : "slideInChildren"
	},
	
	newRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			$('#planDepartmnetTbl tbody').append('<tr>'+this.newRowTemplate({index:planDepartmnetCol.length+1})+'</tr>');
			this.$el.find('a.btn').toggleClass('disabled');
		}
	},
	
	saveLine: function(e) {
		
		 
		inputVal = $(e.currentTarget).prev('input').val();
		indexRow = $(e.currentTarget).attr('indexHolder');
		if(this.collection.at(indexRow-1) == null) {
			this.collection.add({index: this.collection.length+1, name: inputVal});
		} else {
			var model  = this.collection.at(indexRow-1);
			model.set('name', inputVal);
		}
		
		this.$el.find('a.btn').toggleClass('disabled');
		
		this.collection.trigger("reset");
	
	},
	
	deleteRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			var indexToDelete = $('input[name=rowRdo]:checked').val() - 1;
			var modelToDelete = this.collection.at(indexToDelete);
			this.collection.remove(modelToDelete);
			
			// now we have to run through and reindex
			this.collection.each(function(model, index) {
				model.set('index', index+1);
			});
			
			this.collection.trigger('reset');
		}			
	},
	
	editRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			this.$el.find('a.btn').toggleClass('disabled');
			var index = $('input[name=rowRdo]:checked').val()-1;
			var model = this.collection.at(index);
			var html = this.newRowTemplate(model.toJSON());
			$('input[name=rowRdo]:checked').parents('tr').html(html);
		}
	},
	
	linkRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			this.$el.find('a.btn').toggleClass('disabled');
			// now get to the column
			
			var td = $('input[name=rowRdo]:checked').parent().siblings(':last');
			
			var template = Handlebars.compile($('#optionTemplate').html());
			var html = template(serviceTargetMinistryCol.toJSON());
			td.html(html);
			
		}
	},
	
	slideInChildren: function(e) {
		e1 = e;
		
		
		html = "<div style='height: 100px;display: table-cell; vertical-align: middle; text-align: center;'>Loading <br/><img src='../resources/graphics/spinner_bar.gif'></img></div>";
		
		// slide In spinner
		this.$el.slideLeft(html);
		
		// now load content and replace in div...
		
		
		
		
		
	}
	
});

mainTblView = new MainTblView();
rowCol.trigger('reset');

});

//-->
</script>
