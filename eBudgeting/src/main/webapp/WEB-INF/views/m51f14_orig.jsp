<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>ทะเบียนรายการและระดับรายการ</h4>	
</div>

<div id="budgetRootSlt">
</div>

<div class="row">
	<div class="span11">

		<div id="formulaLineModal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<a href="#"	class="btn btn-primary" id="backBtn">กลับหน้าหลัก</a>
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

<script id="budgetSltTemplate" type="text/x-handler-template">
<b>หมวดรายจ่ายหลัก</b>
<select id="budgetTypeSlt" class="type">
	<option value="0">กรุณาเลือกหมวดงบประมาณ</option>
	{{#each this}}
	<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.name}}</option>
	{{/each}}
</select>
<div></div>
</script>
<script id="formulaLineModalTemplate" type="text/x-handlebars-template">
<div><b>การคำนวณ</b>
</div>
<div id="formulaBox">
	{{this.name}} = <span id="formulaLine"></span>
</div>
<div id="formulaColumnFormCtr"></div>
</script>

<script id="formulaColumnFormTemplate"
	type="text/x-handlebars-template">
<form id="addFormulaForm" {{#unless columnName}}newForm="true"{{/unless}}
	{{#if id}}data-id="{{id}}"{{/if}}>
		<label>ชื่อรายการ</label>
		<input type="text" name="columnName" value="{{columnName}}"/>
		<label class="checkbox">หน่วยขอตั้งเป็นผู้ระบุจำนวน/งบประมาณ
		<input type="checkbox" name="isFixed" {{#if isFixed}}checked="checked"{{/if}}/></label>
		<input type="text" name="value" {{#if isFixed}}disabled="disabled"{{/if}} value="{{value}}"/>
		<label>หน่วยนับ</label>
		<input type="text" name="unitName" value="{{unitName}}"/>
		<br/>
		<button class="btn btn-mini cancelFormulaColumnBtn">ยกเลิก</button>
		{{#if columnName}}<button class="btn btn-mini deleteFormulaColumnBtn">ลบรายการ</button>{{/if}}
		<button class="btn btn-mini btn-primary addFormulaColumnBtn">{{#if columnName}}แก้ไขรายการ{{else}}เพิ่มชื่อทะเบียน{{/if}}</button>
</form>
</script>

<script id="formulaLineTemplate" type="text/x-handlebars-template">
{{{formulaLine this true}}} 
</script>
<script id="formulaInLinEditTemplate" type="text/x-handlebars-template">
	<div style="margin-top:4px; margin-bottom:4px;">
		<input type="text" data-id="{{id}}" value="{{name}}"/> 
		<button class="btn btn-mini updateFormulaStrategy"><i class="icon-ok" icon-white"/> แก้ไข</button>
		<button class="btn btn-mini cancelUpdateFormulaStrategy"><i class="icon-remove" icon-white"/> ยกเลิก</button>
	</div>
</script>
<script id="formulaTemplate" type="text/x-handlebars-template">
{{#each this}}
	<li data-id={{id}} style="list-style-type: none; padding: 0;"> <input type="radio" data-id="{{../id}}" name="formulaSlt-{{../id}}" id="formulaSlt-{{../id}}" value="{{id}}"> {{name}} = {{{formulaLine formulaColumns false}}} </input> 
	</li>
{{/each}}
</script>

<script id="mainCtrTemplate" type="text/x-handler-template">
<div class="controls" style="margin-bottom: 15px;">
	<a href="#" class="btn btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มชื่อทะเบียน</a>
	<a href="#" class="btn btn-primary menuEdit"><i class="icon icon-edit icon-white"></i> แก้ไข</a>
	<a href="#" class="btn btn-danger menuDelete"><i class="icon icon-trash icon-white"></i> ลบ</a> 
</div>
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td style="width:20px;"></td>
			<td style="width:120px;">หมวดหลัก</td>
			<td style="width:120px;">หมวดย่อย</td>
			<td style="width:120px;">รายการหลัก</td>
			<td >รายการย่อย</td>		

			<td style="width:60px;">หน่วยนับ</td>
			<td style="width:60px;">รายการกลาง</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>

<script id="formulaStrategyRowTemplate" type="text/x-handelbars-template">
<td><input type="radio" name="rowRdo" id="rdo_{{index}}" value="{{index}}"/></td>
	<td> {{type.parent.name}}</td>

	<td> {{{parentBudgetType type}}} </td>
	<td> {{name}} = {{{formulaLine formulaColumns false}}} </td>
	<td> {{unit.name}} </td>
	<td> {{commonType.name}} </td>
</script>

<script id="tbodyTemplate" type="text/x-handlebars-template">
{{#each this}}
<tr data-id="{{id}}" budgetType-id="{{type.id}}">
</tr>
{{/each}}
</script>



<script id="newRowTemplate" type="text/x-handlebars-template">
<td></td>
	<td colspan="5">
		 <form class="form-inline">
			<div class="control-group">
				<div class="controls  budgetTypeSlt">
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="nameTxt"> <b>ชื่อรายการ:</b> </label>
				<div class="controls">
					<input id="nameTxt" type='text' placeholder='...' class='span7' value="{{name}}"></input> <br/>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="unit"> <b>หน่วยนับ:</b> </label>
				<div class="controls">
					<select id="unitSlt">
						<option value="0">กรุณาเลือก</option>
						{{#each unitList}}
							<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.name}}</option>
						{{/each}}
					</select>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="unit"> <b>รายการกลาง:</b> </label>
				<div class="controls">
					<select id="commonTypeSlt">
						<option value="0">กรุณาเลือก</option>
						{{#each commonTypeList}}
							<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.name}}</option>
						{{/each}}
					</select>
				</div>
			</div>
		</form>

		<button indexHolder='{{index}}' class='btn btn-mini btn-info lineSave'>บันทึกข้อมูล</button>
		<button indexHolder='{{index}}' class='btn btn-mini btn-danger cancelLineSave'>ยกเลิก</button>
	</td>

</script>



<script type="text/javascript">
Handlebars.registerHelper("parentBudgetType", function(type){
	return type.name;
});

Handlebars.registerHelper("formulaLine", function(formulaColumns, editForm){
	var s = "";
	if(editForm == false) {
		s = s+ "<a class='editSpan editFormulaLineBtn' href='#'>";
		
		if(formulaColumns == null || formulaColumns.length == 0) {
			s =	s+"เพิ่มรายการคำนวณ";
		}
	}
	
	if(formulaColumns != null) {
		for(var i=0; i < formulaColumns.length; i++) {
			
			if(i>0) { 
				s = s + " X "; 
			}
			
			if(editForm == true) {
				s = s + "<a class='editSpan' href='#' data-id="+ formulaColumns[i].id +">"; 
			}
			s = s + formulaColumns[i].columnName;
			if(formulaColumns[i].isFixed) {
				s = s + "(??? " + formulaColumns[i].unitName  + ")";
			} else {
				s = s + "("+ addCommas(formulaColumns[i].value) + " " + formulaColumns[i].unitName  + ")";
			}
			if(editForm == true) {
				s = s + "</a>";
			}
		}
	} 
	if(editForm == true) {
		if(formulaColumns.length > 0) {
			s = s + " X ";
		}
		s = s + "<a href='#' class='editSpan'>New</a>";
	}else {
		s += "</a>";	
	}
	
	
	return s;
});

<!--
var fiscalYear = "${fiscalYear}";
var typeId;

var pageUrl = "/page/m51f09/";

var mainTblView;
var budgetTypeSltView;
var rootBudgetType = new BudgetType({id: 0});

var e1;

var formulaStrategyCollection = new FormulaStrategyCollection();
var budgetTypeRootCollection = new BudgetTypeCollection();



var listTargetUnits = new TargetUnitCollection();
listTargetUnits.fetch({
	url: appUrl('/TargetUnit/')
});

var listBudgetCommonType = new BudgetCommonTypeCollection();
listBudgetCommonType.fetch({
	url: appUrl('/BudgetCommonType/fiscalYear/'+fiscalYear + "/")
});

$(document).ready(function() {

	var FormularLineModalView = Backbone.View.extend({
		initialize: function() {
			_.bindAll(this,'back');
			_.bindAll(this,'isFixedChanged');
			_.bindAll(this,'addFormulaColumn');
			_.bindAll(this,'editFormulaColumn');
			_.bindAll(this,'deleteFormulaColumn');
			_.bindAll(this,'renderFormulaLineWith');
			
			
		},
		el: "#formulaLineModal",
		model: null,
		modalTemplate: Handlebars.compile($("#formulaLineModalTemplate").html()),
		formulaLineTemplate: Handlebars.compile($("#formulaLineTemplate").html()),
		formulaColumnFormTemplate: Handlebars.compile($("#formulaColumnFormTemplate").html()),
		
		collection: new FormulaColumnCollection(),
		
		events: {
			
			"click #backBtn" : "back",
			"change input[name=isFixed]" : "isFixedChanged",
			"click .addFormulaColumnBtn" : "addFormulaColumn",
			"click .cancelFormulaColumnBtn" : "cancelFormulaColumn",
			"click .deleteFormulaColumnBtn" : "deleteFormulaColumn",
			"click .editSpan" : "editFormulaColumn"
		},
		
		render: function() {
			this.$el.find('.modal-header span').html(this.currentStrategy.get('name'));
			
			var html = this.modalTemplate(this.currentStrategy.toJSON());
			var formularLinehtml = this.formulaLineTemplate(this.collection.toJSON());
			this.$el.find('.modal-body').html(html);
			this.$el.find('.modal-body #formulaLine').html(formularLinehtml);
			this.$el.modal({show: true, backdrop: 'static', keyboard: false});
		},
		
		renderFormulaLineWith: function(formulaStrategy, budgetType){
			if(formulaStrategy != null) {
				this.currentStrategy = formulaStrategy;
				this.currentBudgetType = budgetType;
				if(this.currentStrategy.get('formulaColumns') != null) {
					this.collection = this.currentStrategy.get('formulaColumns');
				};
				
				this.collection.bind('add', this.addNewFormulaColumn, this);
				this.render();
			}
		},
		
		back: function(e) {
			if(this.currentStrategy.get('formulaColumns') == null) {
				this.currentStrategy.set('formulaColumns', this.collection);
			}
			
			
			this.currentStrategy.trigger('changeFormula', this.currentStrategy);
			
			// nothing to recover just hide!
			this.$el.modal('hide');
		},
		
		isFixedChanged: function(e) {
			var inputValue = this.$el.find('input[name=value]');
			if($(e.target).attr('checked') == 'checked') {
				inputValue.attr('disabled', 'disabled');
			} else {
				inputValue.removeAttr('disabled');
			}
			
		},
		
		deleteFormulaColumn: function(e) {
			var form = this.$el.find('form');
			var formulaColumnId = form.attr('data-id');
			var formulaColumn = this.collection.get(formulaColumnId);
			
			
			//now we'll go to destroy it!
			this.collection.remove(formulaColumn);
			formulaColumn.destroy();
			
			this.render();
			// reindexing!?
			return false;
		},
		
		addFormulaColumn : function(e) {
			// add this new Formula into formulaStrategy
			var form = this.$el.find('form');
			var newForm = form.attr("newForm");
			if(newForm) {
				var formulaColumn = new FormulaColumn({
					columnName: form.find('input[name=columnName]').val(),
					isFixed: form.find('input[name=isFixed]').attr('checked')=='checked'?true:false,
					value: form.find('input[name=value]').val(),
					unitName: form.find('input[name=unitName]').val()
				});
				
				//formulaColumn.set('cid', formulaColumn.cid);
				// now try to add this to the database
				formulaColumn.set('index', this.collection.length);
				formulaColumn.set('strategy', {id: this.currentStrategy.get('id')});
				
				formulaColumn.save(null, {
					success: _.bind(function(model, response) {
						this.collection.add(model);
						
						this.render();
						
					},this)
				});
			} else {
				var formulaColumnId = form.attr('data-id');
				var formulaColumn = this.collection.get(formulaColumnId);
				
				formulaColumn.set('columnName', form.find('input[name=columnName]').val());
				formulaColumn.set('isFixed', form.find('input[name=isFixed]').attr('checked')=='checked'?true:false);
				formulaColumn.set('value', form.find('input[name=value]').val());
				formulaColumn.set('unitName',form.find('input[name=unitName]').val());
				
				//temporarily fixed the relation isuue
				// no need to set formulaStrategy?
				formulaColumn.set('strategy', null);
				//formulaColumn.set('strategy', this.currentStrategy.toJSON());
				
				formulaColumn.save(null, {
					success: _.bind(function(model, response) {
						
						//put back strategy 
						formulaColumn.set('strategy', this.currentStrategy.get('id'));
						
						this.render();
					},this)
				});
			}
			return false;
			
		},
		addNewFormulaColumn: function(options) {
			this.render();
		},
		
		cancelFormulaColumn : function(e) {
			this.render();
		},
		
		editFormulaColumn : function(e) {
			var formulaColumnId = $(e.target).attr('data-id');
			if(formulaColumnId == null) {
				//new Column!
				var formHtml = this.formulaColumnFormTemplate(new FormulaColumn());
				this.$el.find('#formulaColumnFormCtr').html(formHtml);
			} else {
				// now find the model 
				var formulaColumn = this.collection.get(formulaColumnId);
				
				// now we should have formulColumn to be update!
				var formHtml = this.formulaColumnFormTemplate(formulaColumn.toJSON());
				this.$el.find('#formulaColumnFormCtr').html(formHtml);
				
			}
			
		}
		
	});
	
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
		formulaStrategyRowTemplate: Handlebars.compile($("#formulaStrategyRowTemplate").html()),
		
		formulaInLineEditTpl : Handlebars.compile($("#formulaInLinEditTemplate").html()),
		formularLineModalView : new FormularLineModalView(),
		
		render: function() {
			// first render the control
			
			var html = this.mainCtrTemplate();
			
			this.$el.html(html);
			
			// then the inside row
			json=this.collection.toJSON();
			
			html = this.tbodyTemplate(json);
			this.$el.find('tbody').html(html);

			// bind all cell
			this.collection.each(function(model){

				model.bind('change', this.renderObjective, this);
				model.bind('changeFormula', this.renderChild, this);
				this.renderFormulaStrategy(model);
			}, this);

			return this;
		},
		
		events: {
			"click .menuNew" : "newRow",
			"click .menuDelete" : "deleteRow",
			"click .menuEdit"	: "editRow",
			"click .lineSave" : "saveLine",
			"click .editFormulaLineBtn" : "editFormulaLine",
			"click .cancelLineSave" : "cancelSaveLine"
		},
		
		editFormulaLine : function(e) {
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('budgetType-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			
			var currentFormulaId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentFormula = FormulaStrategy.findOrCreate(currentFormulaId);

			this.formularLineModalView.renderFormulaLineWith(currentFormula, currentBudgetType);
		},
		
		newRow: function(e) {
			if(! $(e.currentTarget).hasClass('disabled') ) {
				var json = {};
				json.index = this.collection.length;
				
				json.unitList = listTargetUnits.toJSON();
				
				json.commonTypeList = listBudgetCommonType.toJSON();
				
				
				$('#mainTbl tbody').append('<tr>'+this.newRowTemplate(json)+'</tr>');
				var currentBudgetTypeId = $('select#budgetTypeSlt').val();
				
				//now populate the budgetTypeSlt
			    var budgetTypeSlt = BudgetType.findOrCreate({id: currentBudgetTypeId});
			    budgetTypeSlt.fetch({success: _.bind(function(){
			    	if(budgetTypeSlt.get('children').length > 0) {
			    		this.budgetTypeSelection = new BudgetTypeSelectionView({
			    			model: budgetTypeSlt, el:'.budgetTypeSlt', mainTblView: this});
			    		this.budgetTypeSelection.render();
			    	}
		    	},this)});
				
				
				this.$el.find('a.btn').toggleClass('disabled');
			}
		},
		
		
		cancelSaveLine: function(e) {
			//now put back the value
			// well do nothing just reset the collection
			
			this.$el.find('a.btn').toggleClass('disabled');
			this.collection.trigger("reset");
			
		},
		
		saveLine: function(e) {

			var formulaStrategyId = $(e.currentTarget).parents('tr').attr('data-id');
			
			var inputNameVal = this.$el.find('#nameTxt').val();
			var unitId = this.$el.find('select#unitSlt').val();
			var commonTypeId = this.$el.find('select#commonTypeSlt').val();
			
			if(this.collection.get(formulaStrategyId) == null) {
				//var objType = pageObjective.get('type').get('children').at(0);
				var newObj =  new FormulaStrategy({name: inputNameVal});
				
				var typeId = this.$el.find('select.type:last').val();
				
				console.log(typeId);
				var selectedType = BudgetType.findOrCreate(typeId);
				
				newObj.set('type', selectedType);
				newObj.set('isStandardItem', false);
				newObj.set('fiscalYear', fiscalYear);
				newObj.set('unit', TargetUnit.findOrCreate(unitId));
				newObj.set('commonType', BudgetCommonType.findOrCreate(commonTypeId));
				
				newObj.save(null, {success: _.bind(function(data){
					newObj.set('id', data.id);
					
					this.collection.add(newObj);
					
					this.collection.trigger('reset');
				},this)});
				
				
			} else {
				var fs = this.collection.get(formulaStrategyId);
				fs.set('unit', TargetUnit.findOrCreate(unitId));
				fs.set('commonType', BudgetCommonType.findOrCreate(commonTypeId));
				fs.save({
					name: inputNameVal
				}, {
					success: function() {
						fs.trigger('changeFormula', fs);
					}
				});
				
			}
			
			this.$el.find('a.btn').toggleClass('disabled');
			this.collection.trigger("reset");
		
		},
		
		deleteRow: function(e) {
			var fsId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
			
			if( (! $(e.currentTarget).hasClass('disabled')) && $('input[name=rowRdo]:checked').length == 1 ) {
				
				var modelToDelete = this.collection.get(fsId);
				
				
					if(confirm("คุณต้องการลบรายการ " + modelToDelete.get('name'))) {
					
						modelToDelete.destroy({
							success: _.bind(function() {					
								this.collection.remove(modelToDelete);
							
								this.collection.trigger('reset');
							},this)
						});
					
					
					this.collection.trigger('reset');
				} else{
					alert('คุณต้องเข้าไปลบรายการจากรายการย่อยสุดเท่านั้น');
				}
			} else {
				alert('กรุณาเลือกรายการที่ต้องการลบ');
			}
		},
		
		editRow: function(e) {
			var fsId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
			
			if((! $(e.currentTarget).hasClass('disabled') ) && $('input[name=rowRdo]:checked').length == 1) {
				this.$el.find('a.btn').toggleClass('disabled');
				var model = this.collection.get(fsId);
				
				var json = model.toJSON();
					
				json.unitList = listTargetUnits.toJSON();
				if(model.get('unit') != null) {
					for(var i=0; i<json.unitList.length; i++) {
						if(json.unitList[i].id == model.get('unit').get('id')) {}
						json.unitList[i].selected = 'selected';
					}
				}
				
				
				json.commonTypeList = listBudgetCommonType.toJSON();
				if(model.get('commonType') != null) {
					for(var i=0; i<json.commonTypeList.length; i++) {
						if(json.commonTypeList[i].id == model.get('commonType').get('id')) {}
						json.commonTypeList[i].selected = 'selected';
					}
				}
				
				e1=json;
				
				var html = this.newRowTemplate(json);
				$('input[name=rowRdo]:checked').parents('tr').html(html);
			} else {
				alert('กรุณาเลือกรายการที่ต้องการแก้ไข');
			}
		},
		
		renderFormulaStrategy: function(formulaStrategy) {
			var formulaStrategyEl = this.$el.find('tr[data-id='+ formulaStrategy.get('id') +']');
			
			var json = formulaStrategy.toJSON();
			
			formulaStrategyEl.html(this.formulaStrategyRowTemplate(json));
			
		},
		
		renderChild: function(caller) {
			console.log('hey');
			this.renderFormulaStrategy(caller);
		},
		
		
	});
	
	var BudgetSltView = Backbone.View.extend({
		budgetSltTemplate :  Handlebars.compile($("#budgetSltTemplate").html()),
		mainTblView: new MainTblView({collection: formulaStrategyCollection}),
		initialize: function(options){
			
		    this.collection.bind('reset', this.render, this);
		    this.render();
		},
		
		events: {
			"change #budgetTypeSlt" : "changeSlt"
		},
	
		el: "#budgetRootSlt",
		selectedBudget: null,
		render: function() {
			if(this.collection != null) {
				
				var json = this.collection.toJSON();
				var html = this.budgetSltTemplate(json);
				
				this.$el.html(html);
				
			}
		},
		
		changeSlt: function(e) {
			var budgetTypeSelectedId = $('select#budgetTypeSlt').val();
			if(budgetTypeSelectedId != 0) {
				this.mainTblView.collection.fetch({
					//FormulaStrategy/search/{fiscalYear}/rootBudgetType/{budgetTypeId}
					url: appUrl('/FormulaStrategy/searchIsNotStandardItem/' + fiscalYear + '/rootBudgetType/' + budgetTypeSelectedId),
					success: function() {
						
					}
				});
			}
		}
		
		
		
	});


	var BudgetTypeSelectionView = Backbone.View.extend({
		initialize: function(options){
			if(options != null) {
				this.el = options.el;
				this.model = options.model;

			} 
			
		},
		el: "#budgetSelectionCtr",
		selectionTpl : Handlebars.compile($("#budgetSltTemplate").html()),
		
		render: function(){
			// first clear the siblings select
			this.$el.nextAll('div').remove();
			this.$el.empty();
			this.$el.html(this.selectionTpl(this.model.get('children').toJSON()));
		},
		
		events: {
			"change select:first" : "selectionChange" // only the first one
		},
		
		selectionChange: function(e) {
			var selectedBudgetTypeId = $(e.target).val();
			// now try to get this model
			var budgetType = BudgetType.findOrCreate(selectedBudgetTypeId);
			e1 = budgetType;
			budgetType.fetch({success: _.bind(function(model, response){
				var fetchedBudgetType = response;
				if(fetchedBudgetType.children != null && fetchedBudgetType.children.length > 0) {
					
					var nextEl = this.$el.selector + " select + div";
					this.nextBudgetTypeSelectionView = new BudgetTypeSelectionView({model: budgetType, el: nextEl, mainTblView: this.mainTblView});
					this.nextBudgetTypeSelectionView.render();
					
				} else {
					
					 
				}

			}, this)});
			
			// ok we'll have to set back to this!?
			
		}
	});

	
	
	var headLineStr = '<h4> ทะเบียนรายการและรายการย่อย';
	if(fiscalYear!= null && fiscalYear.length > 0 ) {
		headLineStr += 	' ปีงบประมาณ ' + fiscalYear;
	
		rootBudgetType.fetch({
			success: function() {
				budgetTypeRootCollection = rootBudgetType.get('children');
				budgetTypeSltView = new BudgetSltView({collection: budgetTypeRootCollection});
			}
		});
	
	}
	
	$('#headLine').html(headLineStr);
	headLineStr += '</h4>';

});

//-->
</script>