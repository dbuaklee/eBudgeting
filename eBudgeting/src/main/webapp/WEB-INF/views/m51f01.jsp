<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="headLine">
	
</div>

<div class="row">
	<div class="span12">

		<div id="modal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" id="closeBtn">ปิดหน้าต่าง</a>
				<a href="#" class="btn" id="saveBtn">บันทึกรายละเอียด</a>  
			</div>
		</div>


		<div class="control-group" id="mainCtr">
			
			<c:choose>
			<c:when test="${rootPage}">
				<table class="table table-bordered" id="mainTbl">
					<thead>
						<tr>
							<td>เลือกปีงบประมาณ</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${fiscalYears}" var="fiscalYear">
						<tr>
								<td> <a href="./${fiscalYear.fiscalYear}/" class="nextChildrenLnk">${fiscalYear.fiscalYear}<i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>			
			</c:when>
			</c:choose>	
		</div>


	</div>
</div>

<script id="mainCtrTemplate" type="text/x-handler-template">
<div class="controls" style="margin-bottom: 15px;">
	<a href="#" class="btn btn-mini btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มรายการ</a>
	<a href="#" class="btn btn-mini btn-primary menuEdit"><i class="icon icon-edit icon-white"></i> แก้ไข</a>
	<a href="#" class="btn btn-mini btn-danger menuDelete"><i class="icon icon-trash icon-white"></i> ลบ</a>
	<a href="#" class="btn btn-mini btn-success menuUnitLink"><i class="icon icon-random icon-white"></i> เลือกหน่วยนับ</a>  
</div>
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td style="width:20px;"></td>
			<td style="width:40px;">รหัส</td>
			<td>ชื่อ{{name}}</td>
			<td style="width:150px;">หน่วยนับ</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<div class="controls" style="margin-bottom: 15px;">
	<a href="#" class="btn btn-mini btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มรายการ</a>
	<a href="#" class="btn btn-mini btn-primary menuEdit"><i class="icon icon-edit icon-white"></i> แก้ไข</a>
	<a href="#" class="btn btn-mini btn-danger menuDelete"><i class="icon icon-trash icon-white"></i> ลบ</a>
	<a href="#" class="btn btn-mini btn-success menuUnitLink"><i class="icon icon-random icon-white"></i> เลือกหน่วยนับ</a>  
</div>
</script>
<script id="unitLinkSltTemplate" type="text/x-handler-template">
<select class="span2">
	<option value="0">กรุณาเลือกหน่วยนับ</option>
	{{#each this}}
	<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.name}}</option>
	{{/each}}
</select><br/>
<button class="btn btn-mini updateUnitLink"><i class="icon-ok" icon-white"/> บันทึก</button>
<button class="btn btn-mini cancelLink"><i class="icon-remove" icon-white"/> ยกเลิก</button>
</script>
<script id="objectiveRowTemplate" type="text/x-handelbars-template">
<td><input type="radio" name="rowRdo" id="rdo_{{id}}" value="{id}}"/></td>
	<td> {{code}} </td>
	<td> {{name}} </td>
	<td class="unitLink"> <ul class="noBullet">{{#each units}}</li>{{name}}<li>{{/each}}</ul></td>
</script>

<script id="tbodyTemplate" type="text/x-handlebars-template">
{{#each this}}
<tr data-id="{{id}}">
</tr>
{{/each}}
</script>



<script id="newRowTemplate" type="text/x-handlebars-template">
<td></td>
	<td colspan="3">
		 <form class="form-inline">
			<div class="control-group">
				<label class="control-label" for="nameTxt"> <b>ชื่อ:</b> </label>
				<div class="controls">
					<input id="nameTxt" type='text' placeholder='...' class='span7' value="{{name}}"></input> <br/>
				</div>
			</div>
		</form>

		<button indexHolder='{{index}}' class='btn btn-mini btn-info lineSave'>บันทึก</button>
		<button indexHolder='{{index}}' class='btn btn-mini btn-danger cancelLineSave'>ยกเลิก</button>
	</td>

</script>



<script type="text/javascript">
<!--
var objectiveId = "${objective.id}";
var fiscalYear = "${fiscalYear}";
var typeId = "${typeId}";

var pageUrl = "/page/m51f04/";

var mainTblView;

var e1;
var objectiveCollection = new ObjectiveCollection();
var objectiveType;
var listTargetUnits = new TargetUnitCollection();
listTargetUnits.fetch({
	url: appUrl('/TargetUnit/')
});

$(document).ready(function() {

	var MainTblView = Backbone.View.extend({
		initialize: function(options){
		    this.collection.bind('reset', this.render, this);
		},
	
		el: "#mainCtr",
		selectedObjective: null,
		currentLineVal: null,
		
		newRowTemplate: Handlebars.compile($("#newRowTemplate").html()),
		mainCtrTemplate: Handlebars.compile($("#mainCtrTemplate").html()),
		tbodyTemplate: Handlebars.compile($("#tbodyTemplate").html()),
		objectiveRowTemplate: Handlebars.compile($("#objectiveRowTemplate").html()),
		unitLinkSltTemplate: Handlebars.compile($("#unitLinkSltTemplate").html()),
		
		render: function() {
			// first render the control
			
			var html = this.mainCtrTemplate(objectiveType.toJSON());
			
			this.$el.html(html);
			
			if(this.collection.length>0) {
				// then the inside row
				json=this.collection.toJSON();
				
				html = this.tbodyTemplate(json);
				this.$el.find('tbody').html(html);
			}

			// bind all cell
			this.collection.each(function(model){
				model.bind('change', this.renderObjective, this);
				this.renderObjective(model);
			}, this);

			return this;
		},
		
		events: {
			"click .menuNew" : "newRow",
			"click .menuDelete" : "deleteRow",
			"click .menuEdit"	: "editRow",
			"click .lineSave" : "saveLine",
			"click .cancelLineSave" : "cancelSaveLine",
			"click .menuUnitLink" : "linkUnit",
			"click .updateUnitLink" : "updateUnitLink",
			"click .cancelLink" : "cancelLink"
		},
		
		newRow: function(e) {
			if(! $(e.currentTarget).hasClass('disabled') ) {
				$('#mainTbl tbody').append('<tr>'+this.newRowTemplate({index:this.collection.length})+'</tr>');
				this.$el.find('a.btn').toggleClass('disabled');
			}
		},
		
		linkUnit: function(e) {
			if((! $(e.currentTarget).hasClass('disabled') ) && $('input[name=rowRdo]:checked').length == 1) {
				this.$el.find('a.btn').toggleClass('disabled');
				var id = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
				var model = objectiveCollection.get(id);
				this.currentSelectedModel = model;
				if(listTargetUnits != null) {
					
					var tdEl = $('input[name=rowRdo]:checked').parents('tr').find('td.unitLink');
					
					var json = listTargetUnits.toJSON();
					
					if(model.get('units') != null) {
						
						if(model.get('units').length > 0) {
							for(var i=0; i< json.length; i++) {
								console.log(json[i].id + " == " + model.get('units').at(0).get('id'));
								
								if(json[i].id == model.get('units').at(0).get('id')) {
									json[i].selected = true;
								}
							}
						}
					}
					
					
					var html = this.unitLinkSltTemplate(json);
					tdEl.html(html);
				}
				
			} else {
				alert('กรุณาเลือกรายการที่ต้องการแก้ไข');
			}
			
		},
		
		cancelLink: function(e) {
			this.$el.find('a.btn').toggleClass('disabled');
			if(this.currentSelectedModel != null) {
				this.renderObjective(this.currentSelectedModel);
			}
		},
		
		updateUnitLink: function(e) {
			var id = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
			var o = Objective.findOrCreate(id);
			var unitId = $('input[name=rowRdo]:checked').parents('tr').find('select').val();
			var unit = TargetUnit.findOrCreate(unitId);
			
			if(unitId > 0) {
				// we should go about update this parent
				o.get('units').pop();
				$.ajax({
					type: 'PUT',
					url: appUrl('/Objective/'+ id +'/addReplaceUnit/' + unitId),
					success: _.bind(function(data){
						o.get('units').add(unit);
						this.renderObjective(o);
					},this)
				});
			}
			
			this.$el.find('a.btn').toggleClass('disabled');
		},
		
		renderObjective: function(objective) {
			var objectiveEl = this.$el.find('tr[data-id='+ objective.get('id') +']');
			
			var json = objective.toJSON();
			
			objectiveEl.html(this.objectiveRowTemplate(json));
			
		},
		
		cancelSaveLine: function(e) {
			//now put back the value
			// well do nothing just reset the collection
			
			this.$el.find('a.btn').toggleClass('disabled');
			this.collection.trigger("reset");
			
		},
		
		saveLine: function(e) {

			var objectiveId = $(e.currentTarget).parents('tr').attr('data-id');
			
			inputNameVal = this.$el.find('#nameTxt').val();
			indexRow = parseInt($(e.currentTarget).attr('indexHolder'));
			
			if(this.collection.get(objectiveId) == null) {
				//var objType = pageObjective.get('type').get('children').at(0);
				var newObj =  new Objective({name: inputNameVal});
				
				newObj.set('type', objectiveType);
				newObj.set('fiscalYear', fiscalYear);
				newObj.set('isLeaf', true);
				
				newObj.save(null, {success: _.bind(function(data){
					newObj.set('id', data.id);
					newObj.set('index', this.collection.length);
					
					this.collection.add(newObj);
					
					
					this.collection.trigger('reset');
				},this)});
				
				
			} else {
				var model  = this.collection.get(objectiveId);
				model.set('name', inputNameVal);
				
				$.ajax({
					type: 'POST',
					url: appUrl('/Objective/'+objectiveId+'/updateFields/'),
					data: {
						name: inputNameVal,
					},
					success: _.bind(function(){
						
					},this)
				});
			}
			
			this.$el.find('a.btn').toggleClass('disabled');
			this.collection.trigger("reset");
		
		},
		
		deleteRow: function(e) {
			var objectiveId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
			
			if( (! $(e.currentTarget).hasClass('disabled')) && $('input[name=rowRdo]:checked').length == 1 ) {
				
				var modelToDelete = this.collection.get(objectiveId);
				
				if(modelToDelete.get('isLeaf') == true) {
					if(confirm("คุณต้องการลบรายการ " + modelToDelete.get('name'))) {
					
						modelToDelete.destroy({
							success: _.bind(function() {					
								this.collection.remove(modelToDelete);
							
								// now we have to run through and reindex
								this.collection.each(function(model, index) {
									model.set('index', index);
								});
								
								this.collection.trigger('reset');
							},this)
						});
					}
					
					this.collection.trigger('reset');
				} else{
					alert('คุณต้องเข้าไปลบรายการจากรายการย่อยสุดเท่านั้น');
				}
			} else {
				alert('กรุณาเลือกรายการที่ต้องการลบ');
			}
		},
		
		editRow: function(e) {
			var objectiveId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
			
			if((! $(e.currentTarget).hasClass('disabled') ) && $('input[name=rowRdo]:checked').length == 1) {
				this.$el.find('a.btn').toggleClass('disabled');
				var model = this.collection.get(objectiveId);
	
				var html = this.newRowTemplate(model.toJSON());
				$('input[name=rowRdo]:checked').parents('tr').html(html);
			} else {
				alert('กรุณาเลือกรายการที่ต้องการแก้ไข');
			}
		}
		
	});
	
	mainTblView = new MainTblView({collection: objectiveCollection});

	objectiveType = new ObjectiveType({id: parseInt(typeId)});
	objectiveType.fetch({
		success: function(){
			
			var headLineStr = '<h4> ทะเบียน' + objectiveType.get('name');
			if(fiscalYear!= null && fiscalYear.length > 0 ) {
				headLineStr += 	' ปีงบประมาณ ' + fiscalYear;
			}
			headLineStr += '</h4>';
			$('#headLine').html(headLineStr);
			
			if(fiscalYear != null && fiscalYear.length > 0 ) {
				objectiveCollection.fetch({
					url: appUrl('/Objective/'+fiscalYear+'/type/'+typeId)
				});
			}
		}
	});
	
	
	



});

//-->
</script>