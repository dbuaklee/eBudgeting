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

		</div>
		
		
	</div>
</div>

<script id="modalTemplate" type="text/x-handler-template">
<form>
	<label>ชื่อหน่วยนับ</label>
	<input type="text" id="nameTxt" value="{{name}}">
</form>
</script>

<script id="mainCtrTemplate" type="text/x-handler-template">
<label class="control-label" for="mainTbl">ข้อมูลพื้นฐานหน่วยนับ</label>
<div class="controls" style="margin-bottom: 15px;">
	<a href="#" class="btn btn-mini btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มรายการ</a>
	<a href="#" class="btn btn-mini btn-primary menuEdit"><i class="icon icon-edit icon-white"></i> แก้ไข</a>
	<a href="#" class="btn btn-mini btn-danger menuDelete"><i class="icon icon-trash icon-white"></i> ลบ</a> 
</div>
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td width="20"></td>
			<td>ชื่อหน่วยนับ</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>

<script id="newRowTemplate" type="text/x-handlebars-template">
	<td>  </td>
	<td>
		 <form class="form-inline">
			<div class="control-group">
				<label class="control-label" for="nameTxt"> <b>ชื่อหน่วยนับ: </b> </label>
				<div class="controls">
					<input id="nameTxt" type='text' placeholder='...' class='span7' value="{{name}}" ></input> <br/>
				</div>
			</div>
		</form>

		<button class='btn btn-mini btn-info lineSave'>บันทึก</button>
		<button class='btn btn-mini btn-danger cancelLineSave'>ยกเลิก</button>
	</td>

</script>
<script id="rowTemplate" type="text/x-handler-template">
{{#each this}}
<tr data-id={{id}}>
	<td><input type="radio" name="rowRdo" id="rdo_{{id}}" value="{{id}}"/></td>
	<td>{{name}}</td>
</tr>
{{/each}}
</script>
	
<script type="text/javascript">
var targetUnits = new TargetUnitCollection();

$(document).ready(function() {
	
	var ModalView = Backbone.View.extend({
		initialize: function(){
		    
		},
		el: "#modal",
		targetUnit : null,
		modalTemplate: Handlebars.compile($("#modalTemplate").html()),
		
		events: {
			"click #cancelBtn" : "close",
			"click #saveBtn" : "save"
		},
		
		render: function() {
			if(this.currentTargetUnit != null) {
				
				this.$el.find('.modal-header span').html("เพิ่มรายการ");
				
				var html = this.modalTemplate(this.currentTargetUnit.toJSON());
				this.$el.find('.modal-body').html(html);
	
				
				this.$el.modal({show: true, backdrop: 'static', keyboard: false});
				return this;
			}	
		},
		
		renderWith: function(targetUnit) {
			this.currentTargetUnit = targetUnit;
			this.render();
		},
		
		save: function(e) {
			// ok
			var newModel=false;
			if(this.currentTargetUnit.get('id') == null) {
				newModel = true;
			}
			this.currentTargetUnit.save({
				name: this.$el.find('input[id=nameTxt]').val()
			},{
				success : _.bind(function(model) {
					
					if(newModel) {
						targetUnits.add(model);
					}
					targetUnits.trigger('reset');
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
			"click .menuNew" : "newTargetUnit",
			"click .menuEdit" : "editTargetUnit",
			"click .menuDelete" : "deleteTargetUnit",
			"click .lineSave" : "saveLine",
			"click .cancelLineSave" : "cancelSaveLine"
		},
		mainCtrTpl: Handlebars.compile($("#mainCtrTemplate").html()),
		newRowTpl : Handlebars.compile($('#newRowTemplate').html()),
		rowTpl : Handlebars.compile($("#rowTemplate").html()),
		el: '#mainCtr',
		collection : targetUnits,
		
		modalView : new ModalView(),
		
		render: function() {
			this.$el.html(this.mainCtrTpl());
			this.$el.find('tbody').html(this.rowTpl(this.collection.toJSON()));
		},
		
		newTargetUnit: function(e) {
			if(! $(e.currentTarget).hasClass('disabled') ) {
				
				var html = this.newRowTpl({name:null});
				
				$('#mainCtr tbody').append('<tr>'+html+'</tr>');
				
				
				this.$el.find('a.btn').toggleClass('disabled');
				
				this.currentTargetUnit = new TargetUnit();
			}
		},
		
		saveLine: function(e) {
			// ok
			var newModel=false;
			if(this.currentTargetUnit.get('id') == null) {
				newModel = true;
			}
			this.currentTargetUnit.save({
				name: this.$el.find('input[id=nameTxt]').val()
			},{
				success : _.bind(function(model) {
					
					if(newModel) {
						targetUnits.add(model);
					}
					targetUnits.trigger('reset');
				},this)
			});
		},
		
		cancelSaveLine: function(e) {
			this.collection.trigger('reset');
		},
		
		editTargetUnit: function(e) {
			var tuId = this.$el.find('input[name=rowRdo]:checked').val();
			var targetUnit = TargetUnit.findOrCreate(tuId);
			
			this.currentTargetUnit=targetUnit;
			var html = this.newRowTpl(targetUnit.toJSON());
			console.log(html);
			this.$el.find('tr[data-id='+ tuId + ']').html(html);
		},
		
		deleteTargetUnit: function(e) {
			var tuId = this.$el.find('input[name=rowRdo]:checked').val();
			var targetUnit = TargetUnit.findOrCreate(tuId);
			
			if(confirm('คุณต้องการลบหน่วยนับ \"'+ targetUnit.get('name') + '\"')==true) {
				targetUnit.destroy({
					success: function() {
						targetUnits.trigger('reset');
					}
				});
			}
			
		}
	});
	
	mainCtrView = new MainCtrView();
	
	targetUnits.fetch({
		url: appUrl('/TargetUnit/'),
		success: function() {
			
			targetUnits.trigger('reset');
		}
	});
	
});
</script>