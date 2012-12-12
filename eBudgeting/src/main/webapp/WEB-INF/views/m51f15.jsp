<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>ทะเบียนรายการกลาง</h4> 
</div>

<div class="row">
	<div class="span11">
		
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
</div>

<script id="modalTemplate" type="text/x-handler-template">
<form>
	<label>ชื่อรายการกลาง</label>
	<input type="text" id="nameTxt" value="{{name}}">
</form>
</script>

<script id="mainCtrTemplate" type="text/x-handler-template">
<div class="controls" style="margin-bottom: 15px;">
	<a href="#" class="btn btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มทะเบียน</a>
	<a href="#" class="btn btn-primary menuEdit"><i class="icon icon-edit icon-white"></i> แก้ไข</a>
	<a href="#" class="btn btn-danger menuDelete"><i class="icon icon-trash icon-white"></i> ลบ</a> 
</div>
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td width="20"></td>
			<td>ชื่อรายการกลาง</td>
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
				<label class="control-label" for="nameTxt"> <b>ชื่อรายการกลาง: </b> </label>
				<div class="controls">
					<input id="nameTxt" type='text' placeholder='...' class='span7' value="{{name}}" ></input> <br/>
				</div>
			</div>
		</form>

		<button class='btn btn-mini btn-info lineSave'>บันทึกข้อมูล</button>
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
var budgetCommonTypeCollection = new BudgetCommonTypeCollection();
var fiscalYear = "${fiscalYear}";


$(document).ready(function() {
	
	var ModalView = Backbone.View.extend({
		initialize: function(){
		    
		},
		el: "#modal",
		budgetCommonType : null,
		modalTemplate: Handlebars.compile($("#modalTemplate").html()),
		
		events: {
			"click #cancelBtn" : "close",
			"click #saveBtn" : "save"
		},
		
		render: function() {
			if(this.currentBudgetCommonType != null) {
				
				this.$el.find('.modal-header span').html("เพิ่มรายการ");
				
				var html = this.modalTemplate(this.currentBudgetCommonType.toJSON());
				this.$el.find('.modal-body').html(html);
	
				
				this.$el.modal({show: true, backdrop: 'static', keyboard: false});
				return this;
			}	
		},
		
		renderWith: function(BudgetCommonType) {
			this.currentBudgetCommonType = BudgetCommonType;
			this.render();
		},
		
		save: function(e) {
			// ok
			var newModel=false;
			if(this.currentBudgetCommonType.get('id') == null) {
				newModel = true;
				this.currentBudgetCommonType.set('fiscalYear', fiscalYear);
			}
			this.currentBudgetCommonType.save({
				name: this.$el.find('input[id=nameTxt]').val()
				
			},{
				success : _.bind(function(model) {
					
					if(newModel) {
						budgetCommonTypeCollection.add(model);
					}
					budgetCommonTypeCollection.trigger('reset');
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
			"click .menuNew" : "newBudgetCommonType",
			"click .menuEdit" : "editBudgetCommonType",
			"click .menuDelete" : "deleteBudgetCommonType",
			"click .lineSave" : "saveLine",
			"click .cancelLineSave" : "cancelSaveLine"
		},
		mainCtrTpl: Handlebars.compile($("#mainCtrTemplate").html()),
		newRowTpl : Handlebars.compile($('#newRowTemplate').html()),
		rowTpl : Handlebars.compile($("#rowTemplate").html()),
		el: '#mainCtr',
		collection : budgetCommonTypeCollection,
		
		modalView : new ModalView(),
		
		render: function() {
			this.$el.html(this.mainCtrTpl());
			this.$el.find('tbody').html(this.rowTpl(this.collection.toJSON()));
		},
		
		newBudgetCommonType: function(e) {
			if(! $(e.currentTarget).hasClass('disabled') ) {
				
				var html = this.newRowTpl({name:null});
				
				$('#mainCtr tbody').append('<tr>'+html+'</tr>');
				
				
				this.$el.find('a.btn').toggleClass('disabled');
				
				this.currentBudgetCommonType = new BudgetCommonType();
			}
		},
		
		saveLine: function(e) {
			// ok
			var newModel=false;
			if(this.currentBudgetCommonType.get('id') == null) {
				newModel = true;
			}
			this.currentBudgetCommonType.save({
				name: this.$el.find('input[id=nameTxt]').val(),
				fiscalYear: fiscalYear
			},{
				success : _.bind(function(model) {
					
					if(newModel) {
						budgetCommonTypeCollection.add(model);
					}
					budgetCommonTypeCollection.trigger('reset');
				},this)
			});
		},
		
		cancelSaveLine: function(e) {
			this.collection.trigger('reset');
		},
		
		editBudgetCommonType: function(e) {
			var tuId = this.$el.find('input[name=rowRdo]:checked').val();
			var budgetCommonType = BudgetCommonType.findOrCreate(tuId);
			
			this.currentBudgetCommonType=budgetCommonType;
			var html = this.newRowTpl(budgetCommonType.toJSON());
			console.log(html);
			this.$el.find('tr[data-id='+ tuId + ']').html(html);
		},
		
		deleteBudgetCommonType: function(e) {
			var tuId = this.$el.find('input[name=rowRdo]:checked').val();
			var budgetCommonType = BudgetCommonType.findOrCreate(tuId);
			
			if(confirm('คุณต้องการลบรายการกลาง \"'+ budgetCommonType.get('name') + '\"')==true) {
				budgetCommonType.destroy({
					success: function() {
						budgetCommonTypeCollection.trigger('reset');
					}
				});
			}
			
		}
	});
	
	mainCtrView = new MainCtrView();
	
	budgetCommonTypeCollection.fetch({
		url: appUrl('/BudgetCommonType/fiscalYear/' + fiscalYear + '/'),
		success: function() {
			
			budgetCommonTypeCollection.trigger('reset');
		}
	});
	
});
</script>