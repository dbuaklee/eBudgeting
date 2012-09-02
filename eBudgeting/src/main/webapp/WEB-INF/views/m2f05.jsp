<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
	<div class="span12">
	    <ul class="breadcrumb">
		    <li><a href="../">Home</a> <span class="divider">/</span></li>
		    <li class="active">m2f05: เป้าหมายบริการหน่วยงาน</li>
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
			<legend>เป้าหมายบริการหน่วยงาน</legend>
			
			<div class="control-group" id="serviceTargetDepartmentCtr">
				<label class="control-label" for="serviceTargetDepartmentTbl">เป้าหมายบริการหน่วยงาน</label>
				<div class="controls" style="margin-bottom: 15px;">
					<a href="#" class="btn btn-mini btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มรายการ</a>
					<a href="#" class="btn btn-mini btn-primary menuEdit"><i class="icon icon-edit icon-white"></i> แก้ไข</a>
					<a href="#" class="btn btn-mini btn-danger menuDelete"><i class="icon icon-trash icon-white"></i> ลบ</a> 
					<a href="#" class="btn btn-mini btn-success menuLink"><i class="icon icon-random icon-white"></i> เชื่อมโยงเป้าหมายบริการกระทรวงฯ</a>
				</div>
				<table class="table table-bordered" id="serviceTargetDepartmentTbl">
					<thead>
						<tr>
							<td width="20"></td>
							<td width="50">ลำดับที่</td>
							<td>เป้าหมายบริการหน่วยงาน</td>
							<td width="200">เชื่อมโยงเป้าหมายบริการกระทรวงฯ</td>
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
<tr><td><input type="radio" name="serviceTargetDepartmentRdo" id="Rdo_{{index}}" value="{{index}}"/></td>
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
var serviceTargetDepartmentTblView;

var serviceTargetMinistryCol = new Backbone.Collection([
                                                        {index: "1", name: "ขยายพื้นที่ชลประทานไม่น้อยกว่าปีละ 2 แสนไร่"},
                                                        {index: "2",name: "เกษตรกรในเขตพื้นที่จังหวัดชายแดนภาคใต้ได้รับการพัฒนาศักยภาพ"},
                                                        {index: "3",name: "มูลค่าผลิตภัณฑ์มวลรวมภาคการเกษตรเพิ่มขึ้น"}
                                                      ]);
                                                      
var serviceTargetDepartmentCol = new Backbone.Collection([
                  {index: "1", name: "มีเขตการใช้ที่ดินที่เหมาะสมเพื่อการผลิตในพื้นที่ทำการเกษตร"},
                  {index: "2",name: "เกษตรกรเข้าถึงบริการงานพัฒนาที่ดิน"},
                  {index: "3",name: "ทรัพยากรที่ดินและน้ำมีความอุดมสมบูรณ์ เพิ่มผลผลิต และใช้ประโยชน์อย่างยั่งยืน"},
                  {index: "4",name: "พัฒนาและฟื้นฟูพื้นที่ทางการเกษตรที่มีปัญหาในจังหวัดชายแดนภาคใต้"},
                  {index: "5",name: "พัฒนาพื้นที่ทำการเกษตรที่มีปัญหาแห้งแล้งซ้ำซากให้สามารถใช้ประโยชน์เป็นแหล่งผลิตของชุมชน"},
                  {index: "6",name: "เร่งรัดขยายการก่อสร้างแหล่งน้ำในไร่นานอกเขตชลประทาน เพื่อช่วยเหลือเกษตรกรในการแก้ไขปัญหาภัยแล้ง"}
                ]);

var e1;


$(document).ready(function() {
	 

var serviceTargetDepartmentTblview = Backbone.View.extend({
	initialize: function(){
	    this.collection.bind('reset', this.render, this);
	},

	el: "#serviceTargetDepartmentCtr",
	
	newRowTemplate: Handlebars.compile($("#newRowTemplate").html()),
	
	collection: serviceTargetDepartmentCol,
	
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
			$('#serviceTargetDepartmentTbl tbody').append('<tr>'+this.newRowTemplate({index:serviceTargetDepartmentCol.length+1})+'</tr>');
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
			var indexToDelete = $('input[name=serviceTargetDepartmentRdo]:checked').val() - 1;
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
			var index = $('input[name=serviceTargetDepartmentRdo]:checked').val()-1;
			var model = this.collection.at(index);
			var html = this.newRowTemplate(model.toJSON());
			$('input[name=serviceTargetDepartmentRdo]:checked').parents('tr').html(html);
		}
	},
	
	linkRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			this.$el.find('a.btn').toggleClass('disabled');
			// now get to the column
			
			var td = $('input[name=serviceTargetDepartmentRdo]:checked').parent().siblings(':last');
			
			var template = Handlebars.compile($('#optionTemplate').html());
			var html = template(serviceTargetMinistryCol.toJSON());
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

serviceTargetDepartmentTblView = new serviceTargetDepartmentTblview();
serviceTargetDepartmentCol.trigger('reset');

});

//-->
</script>
