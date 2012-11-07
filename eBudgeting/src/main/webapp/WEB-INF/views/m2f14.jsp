<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
	<div class="span12">
		
		<div id="modal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" id="cancelBtn">Close</a> 
				<a href="#"	class="btn btn-primary" id="saveBtn">Save changes</a>
			</div>
		</div>
	
		<div id="mainCtr">
			<c:choose>
			<c:when test="${rootPage}">
				<table class="table table-bordered" id="mainTbl">
					<thead>
						<tr>
							<td>เลือกปีงบประมาณ</td>
						</tr>
					</thead>
					<tbody>
						<tr>
							<c:forEach items="${fiscalYears}" var="fiscalYear">
								<td> <a href="./${fiscalYear.fiscalYear}/" class="nextChildrenLnk">${fiscalYear.fiscalYear}<i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
							</c:forEach>
						</tr>
					</tbody>
				</table>			
			</c:when>
			</c:choose>	
		</div>
		
		
	</div>
</div>

<script id="modalTemplate" type="text/x-handler-template">
<form>
	<label>ชื่อเป้าหมาย</label>
	<input type="text" id="nameTxt" value="{{name}}">
	<label class="checkbox">
		<input type="checkbox" id="isSumableCbx" {{#if isSumable}}checked="checked"{{/if}}>
		เป้าหมายชนิดบวกรวมได้
	</label>
	<label>หน่วยนับ</label>
	<select id="targetUnitSlt">
		<option value="0">กรุณาเลือก...</options>
		{{#each allSelection}}
			<option value="{{id}}" {{#if selected}}selected="selected"{{/if}}>{{name}}</option>
		{{/each}}
	</select>
</form>
</script>

<script id="mainCtrTemplate" type="text/x-handler-template">
<label class="control-label" for="mainTbl">ข้อมูลหน่วยนับสำหรับเป้าหมายปีงบประมาณ {{fiscalYear}}</label>
<div class="controls" style="margin-bottom: 15px;">
	<a href="#" class="btn btn-mini btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มรายการ</a>
	<a href="#" class="btn btn-mini btn-primary menuEdit"><i class="icon icon-edit icon-white"></i> แก้ไข</a>
	<a href="#" class="btn btn-mini btn-danger menuDelete"><i class="icon icon-trash icon-white"></i> ลบ</a> 
</div>
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td width="20"></td>
			<td width="50">id</td>
			<td width="50">ชนิด</td>
			<td>ชื่อเป้าหมาย</td>
			<td>ชื่อหน่วยนับ</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>
<script id="rowTemplate" type="text/x-handler-template">
{{#each this}}
<tr data-id={{id}}>
	<td><input type="radio" name="rowRdo" id="rdo_{{id}}" value="{{id}}"/></td>
	<td>{{id}}</td>	
	<td>{{#if isSumable}}นับรวม{{else}}ไม่นับรวม{{/if}}</td>
	
	<td>{{name}}</td>
	<td>{{unit.name}}</td>
</tr>
{{/each}}
</script>
	
<script type="text/javascript">
var fiscalYear = "${fiscalYear}";
var objectiveTargets = new ObjectiveTargetCollection();
var listTargetUnits = new TargetUnitCollection();
listTargetUnits.fetch({
	url: appUrl('/TargetUnit/')
});

$(document).ready(function() {
	
	var ModalView = Backbone.View.extend({
		initialize: function(){
		    
		},
		el: "#modal",
		objectiveTarget : null,
		modalTemplate: Handlebars.compile($("#modalTemplate").html()),
		
		events: {
			"click #cancelBtn" : "close",
			"click #saveBtn" : "save"
		},
		
		render: function() {
			if(this.currentObjectiveTarget != null) {
				
				this.$el.find('.modal-header span').html("เพิ่มรายการ");
				
				var json = this.currentObjectiveTarget.toJSON();
				json.allSelection = listTargetUnits.toJSON();
				if(this.currentObjectiveTarget.get('unit')!= null) {
					var tuId=this.currentObjectiveTarget.get('unit').get('id');
					//find json.allSelection with this id
					_.each(json.allSelection, function(unit) {
						if(unit.id == tuId) {
							unit.selected="selected";
						}
					});
				}
				
				var html = this.modalTemplate(json);
				this.$el.find('.modal-body').html(html);
	
				
				this.$el.modal({show: true, backdrop: 'static', keyboard: false});
				return this;
			}	
		},
		
		renderWith: function(objectiveTarget) {
			this.currentObjectiveTarget = objectiveTarget;
			this.render();
		},
		
		save: function(e) {
			// ok
			var newModel=false;
			if(this.currentObjectiveTarget.get('id') == null) {
				newModel = true;
			}
			var tu = TargetUnit.findOrCreate($('select#targetUnitSlt').val());
			
			this.currentObjectiveTarget.save({
				name: this.$el.find('input[id=nameTxt]').val(),
				fiscalYear: fiscalYear,
				isSumable :this.$el.find('input[id=isSumableCbx]').prop('checked'),
				unit: tu
			},{
				success : _.bind(function(model) {
					
					if(newModel) {
						objectiveTargets.add(model);
					}
					objectiveTargets.trigger('reset');
					this.$el.modal('hide');
				},this)
			});
		},
		
		close: function() {
			this.$el.modal('hide');
		}
		
	});
	
	var MainCtrView = Backbone.View.extend({
		initialize: function() {
			this.collection.bind('reset', this.render, this);
		},
		events: {
			"click .menuNew" : "newObjectiveTarget",
			"click .menuEdit" : "editObjectiveTarget",
			"click .menuDelete" : "deleteObjectiveTarget"
		},
		mainCtrTpl: Handlebars.compile($("#mainCtrTemplate").html()),
		rowTpl : Handlebars.compile($("#rowTemplate").html()),
		el: '#mainCtr',
		collection : objectiveTargets,
		
		modalView : new ModalView(),
		
		render: function() {
			this.$el.html(this.mainCtrTpl({fiscalYear: fiscalYear}));
			this.$el.find('tbody').html(this.rowTpl(this.collection.toJSON()));
		},
		
		newObjectiveTarget: function(e) {
			if(! $(e.currentTarget).hasClass('disabled') ) {
				var ot = new ObjectiveTarget();
				this.modalView.renderWith(ot);
			}
		},
		
		editObjectiveTarget: function(e) {
			var otId = this.$el.find('input[name=rowRdo]:checked').val();
			var objectiveTarget = ObjectiveTarget.findOrCreate(otId);
			this.modalView.renderWith(objectiveTarget);
		},
		
		deleteObjectiveTarget: function(e) {
			var tuId = this.$el.find('input[name=rowRdo]:checked').val();
			var objectiveTarget = ObjectiveTarget.findOrCreate(tuId);
			
			if(confirm('คุณต้องการลบเป้าหมาย \"'+ objectiveTarget.get('name') + '\"')==true) {
				objectiveTarget.destroy({
					success: function() {
						objectiveTargets.trigger('reset');
					}
				});
			}
			
		}
	});
	
	if(fiscalYear != "") {
	
		mainCtrView = new MainCtrView();
		
		objectiveTargets.fetch({
			url: appUrl('/ObjectiveTarget/fiscalYear/'+fiscalYear),
			success: function() {
				
				objectiveTargets.trigger('reset');
			}
		});
	}
	
});
</script>