<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
	<div class="span12">
	    <ul class="breadcrumb">
		    <li><a href="../">Home</a> <span class="divider">/</span></li>
		    <li class="active">m2f07: ผลผลิต/โครงการ</li>
	    </ul>

		<form class="form-inline pull-right">
			 <label>เปลี่ยนปีงบประมาณ</label>
			 <select class="span2">
			 	<option value="2555">2555</option>
			 	<option value="2556" selected="selected">2556</option>
			 	<option value="2557">2557</option>
			 </select> 
		</form>

		<h3>ปีงบประมาณ 2556</h3>
		
		<form>
			<legend>ผลผลิต/โครงการ</legend>
			
			<div class="control-group" id="outcomeProductDepartmentCtr">
				<label class="control-label" for="outcomeProductDepartmentTbl">ผลผลิต/โครงการ</label>
				<div class="controls" style="margin-bottom: 15px;">
					<a href="#" class="btn btn-mini btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มรายการ</a>
					<a href="#" class="btn btn-mini btn-primary menuEdit"><i class="icon icon-edit icon-white"></i> แก้ไข</a>
					<a href="#" class="btn btn-mini btn-danger menuDelete"><i class="icon icon-trash icon-white"></i> ลบ</a> 
					<a href="#" class="btn btn-mini btn-success menuLink"><i class="icon icon-random icon-white"></i> เชื่อมโยงแผนงาน</a>
				</div>
				<table class="table table-bordered" id="outcomeProductDepartmentTbl">
					<thead>
						<tr>
							<td width="20"></td>
							<td width="50">ลำดับที่</td>
							<td>ผลผลิต/โครงการ</td>
							<td width="200">เชื่อมโยงแผนงาน</td>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			<hr/>
			<button type="submit" class="btn">Save</button> <button type="submit" class="btn">Cancel</button>
		</form>
	</div>
</div>


<script id="tbodyTemplate" type="text/x-handlebars-template">
{{#each this}}
<tr><td><input type="radio" name="outcomeProductDepartmentRdo" id="Rdo_{{index}}" value="{{index}}"/></td>
	<td> {{index}} </td>
	<td> {{name}}</td>
	<td></td>
</tr>
{{/each}}
</script>

<script id="newRowTemplate" type="text/x-handlebars-template">
<td></td>
	<td> {{index}} </td>
	<td> <input type='text' placeholder='...' class='span7' value="{{name}}"></input> <button indexHolder='{{index}}' class='btn btn-mini btn-info lineSave'>บันทึก</button></td>
	<td> </td>
</script>

<script id="optionTemplate" type="text/x-handlebars-template">
<select id="linkSlt">
	<option value="noselected" selected="selected">กรุณาเลือก...</option>
	{{#each this}}
	<option value="{{name}}">{{name}}</option>
	{{/each}}
</select>
</script>

<script type="text/javascript">
<!--
var outcomeProductDepartmentTblView;

var planDepartment = new Backbone.Collection([
                                              {index: "1", name: "บริหารจัดการน้ำอย่างบูรณาการ"},
                                              {index: "2",name: "ส่งเสริมประสิทธิภาพการผลิตและสร้างมูลค่าภาคการเกษตร"},
                                              {index: "3",name: "แก้ไขปัญหาและพัฒนาจังหวัดชายแดนภาคใต้"}
                                            ]);
                                                      
var outcomeProductDepartmentCol = new Backbone.Collection([
                  {index: "1", name: "ผลผลิต:โครงการพัฒนาแหล่งน้ำชุมชน"},
                  {index: "2",name: "ผลผลิต:โครงการก่อสร้างแหล่งน้ำในไร่นานอกเขตชลประทาน"},
                  {index: "3",name: "ผลผลิต:โครงการส่งเสริมอาชีพด้านการเกษตรในจังหวัดชายแดนภาคใต้"},
                  {index: "4",name: "ผลผลิต:เขตการใช้ที่ดินเพื่อการเกษตร"},
                  {index: "5",name: "ผลผลิต:เกษตรกรได้รับการส่งเสริมและพัฒนาศักยภาพด้านการพัฒนาที่ดิน"},
                  {index: "6",name: "ผลผลิต:ทรัพยากรที่ดินและน้ำได้รับการพัฒนา"}
                ]);

var e1;


$(document).ready(function() {
	 

var outcomeProductDepartmentTblview = Backbone.View.extend({
	initialize: function(){
	    this.collection.bind('reset', this.render, this);
	},

	el: "#outcomeProductDepartmentCtr",
	
	newRowTemplate: Handlebars.compile($("#newRowTemplate").html()),
	
	collection: outcomeProductDepartmentCol,
	
	render: function() {
		 var template = Handlebars.compile($("#tbodyTemplate").html());
		 var html = template(this.collection.toJSON());
		 
		 this.$el.find('tbody').html(html);
	},
	
	events: {
		"click .menuNew" : "newRow",
		"click .menuDelete" : "deleteRow",
		"click .menuEdit"	: "editRow",
		"click .menuLink"	: "linkRow",
		"click .lineSave" : "saveLine",
		"change #linkSlt"	: "saveLink"
	},
	
	newRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			$('#outcomeProductDepartmentTbl tbody').append('<tr>'+this.newRowTemplate({index:outcomeProductDepartmentCol.length+1})+'</tr>');
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
		
		this.collection.trigger("reset");	
		this.$el.find('a.btn').toggleClass('disabled');
	
	},
	
	deleteRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			var indexToDelete = $('input[name=outcomeProductDepartmentRdo]:checked').val() - 1;
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
			var index = $('input[name=outcomeProductDepartmentRdo]:checked').val()-1;
			var model = this.collection.at(index);
			var html = this.newRowTemplate(model.toJSON());
			$('input[name=outcomeProductDepartmentRdo]:checked').parents('tr').html(html);
		}
	},
	
	linkRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			this.$el.find('a.btn').toggleClass('disabled');
			// now get to the column
			
			var td = $('input[name=outcomeProductDepartmentRdo]:checked').parent().siblings(':last');
			
			var template = Handlebars.compile($('#optionTemplate').html());
			var html = template(planDepartment.toJSON());
			td.html(html);
			
		}
	},
	
	saveLink: function(e) {
		e1 = e;
		var input = $(e1.currentTarget).val();
		$(e1.currentTarget).parent().html(input);
		this.$el.find('a.btn').toggleClass('disabled');
	}
	
});

outcomeProductDepartmentTblView = new outcomeProductDepartmentTblview();
outcomeProductDepartmentCol.trigger('reset');

});

//-->
</script>
