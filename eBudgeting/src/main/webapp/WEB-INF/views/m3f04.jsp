<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
	<div class="span12">
	    <ul class="breadcrumb">
		    <li><a href="../">Home</a> <span class="divider">/</span></li>
		    <li class="active">m3f04: วิสัยทัศน์-พันธกิจ หน่วยงาน</li>
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
			<legend>วิสัยทัศน์/พันธกิจหน่วยงาน</legend>
			<div class="control-group">
				<label class="control-label" for="inputVision">วิสัยทัศน์</label>
				<div class="controls">
					<textarea id="visionTxa" rows="4" placeholder="" class="span12">
พัฒนาที่ดินให้สมบูรณ์ เพิ่มพูนผลิต ในทุิศทางใช้ประโยชน์อย่างยั่งยืน บนพื้นฐานการมีส่วนร่วม
					</textarea>
				</div>
			</div>
			<div class="control-group" id="missionCtr">
				<label class="control-label" for="missionTbl">พันธกิจ</label>
				<div class="controls" style="margin-bottom: 15px;">
					<a href="#" class="btn btn-mini btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มรายการ</a>
					<a href="#" class="btn btn-mini btn-primary menuEdit"><i class="icon icon-edit icon-white"></i> แก้ไข</a>
					<a href="#" class="btn btn-mini btn-danger menuDelete"><i class="icon icon-trash icon-white"></i> ลบ</a> 
				</div>
				<table class="table table-bordered" id="missionTbl">
					<thead>
						<tr>
							<td width="20"></td>
							<td width="50">ลำดับที่</td>
							<td>พันธกิจ</td>
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
<tr><td><input type="radio" name="missionRdo" id="Rdo_{{index}}" value="{{index}}"/></td>
	<td> {{index}} </td>
	<td> {{name}}</td>
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
var missionTblView;
var missionCol = new Backbone.Collection([
                  {index: "1", name: "สนับสนุนงานโครงการอันเนื่องมาจากพระราชดำริ"},
                  {index: "2",name: "วิจัย พัฒนา ให้บริการ และถ่ายทอดเทคโนโลยีการพัฒนาที่ดิน พร้อมทั้งกำหนดเชตการใช้ที่ดินที่เหมาะสมเพื่อการผลิต และให้บริการข้อมูลเชิงพื้นที่ด้านต่างๆ ที่ถูกต้องทันสมัย"},
                  {index: "3",name: "พัฒนาโครงสร้างพื้นฐานด้านการพัฒนาที่ดินและน้ำ โดยการอนุรักษ์ดินและน้ำ การฟื้นฟูปรับบำรุงดิน เพื่อเพิ่มผลผลิตทางการเกษตร และการใช้ประโยชน์ที่ดินอย่างยั่งยืน ภายใต้่กระบวนการที่ชุมชนมีส่วนร่วม"},
                  {index: "4",name: "พัฒนาหมอดินอาสา ยุวหมอดิน เกษตรกร และกลุ่มเกษตกรให้มีความรู้ความเข้าใจการพัฒนาเพื่อเป็นรากฐานการดำเนินชีวิตอย่างพอเพียง"},
                  {index: "5",name: "ปฏิบัติงานตาม พ.ร.บ. พัฒนาที่ดิน"}
                ]);

var e1;


$(document).ready(function() {
	 

var MissionTblview = Backbone.View.extend({
	initialize: function(){
	    this.collection.bind('reset', this.render, this);
	},

	el: "#missionCtr",
	
	newRowTemplate: Handlebars.compile($("#newRowTemplate").html()),
	
	collection: missionCol,
	
	render: function() {
		 var template = Handlebars.compile($("#tbodyTemplate").html());
		 var html = template(this.collection.toJSON());
		 
		 this.$el.find('tbody').html(html);
	},
	
	events: {
		"click .menuNew" : "newRow",
		"click .menuDelete" : "deleteRow",
		"click .menuEdit"	: "editRow",
		"click .lineSave" : "saveLine"
	},
	
	newRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			$('#missionTbl tbody').append('<tr>'+this.newRowTemplate({index:missionCol.length+1})+'</tr>');
			this.$el.find('a.btn').toggleClass('disabled');
		}
	},
	
	saveLine: function(e) {
		
		e1 = e; 
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
			var indexToDelete = $('input[name=missionRdo]:checked').val() - 1;
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
			var index = $('input[name=missionRdo]:checked').val()-1;
			var model = this.collection.at(index);
			var html = this.newRowTemplate(model.toJSON());
			$('input[name=missionRdo]:checked').parents('tr').html(html);
		}
	}
	
});

missionTblView = new MissionTblview();
missionCol.trigger('reset');

});

//-->
</script>
