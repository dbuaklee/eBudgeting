<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
	<div class="span12">
		
		<c:if test="${rootPage == false}">
		    <ul class="breadcrumb" id="headNav">
		    	<c:forEach items="${breadcrumb}" var="link" varStatus="status">
		    		<c:choose>
						<c:when test="${status.last}">
							<li class="active">${link.value}</li>
						</c:when>
						<c:otherwise>
						
							<li><a href="<c:url value='${link.url}'></c:url>">${link.value}</a> <span class="divider">/</span></li>
							
						</c:otherwise>
					</c:choose>
		    	</c:forEach>
		    </ul>
	    </c:if>

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
					<tr>
						<c:forEach items="${fiscalYears}" var="fiscalYear">
							<td><a href="./${fiscalYear.fiscalYear}/0/" class="nextChildrenLnk"> ${fiscalYear.fiscalYear} <i class="icon icon-chevron-right nextChildrenLnk"></i></a></td>
						</c:forEach>
					</tr>
				</tbody>
			</table>			
		</c:when>
		</c:choose>
		</div>


	</div>
</div>


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
		<button class="btn btn-mini btn-primary addFormulaColumnBtn">{{#if columnName}}แก้ไขรายการ{{else}}เพิ่มรายการ{{/if}}</button>
</form>
</script>

<script id="formulaLineTemplate" type="text/x-handlebars-template">
{{{formulaLine this true}}} 
</script>

<script id="modalTemplate" type="text/x-handlebars-template">
<b>ตัวเลือกงบประมาณ</b>
<form id="addFormulaForm">
	<label>	ชื่อรายการ
	</label>
	<input id="name" type="text"/>
</form>
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
</div>
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td width="50">ลำดับที่</td>
			<td>หมวดรายจ่าย</td>
		</tr>
	</thead>
	<tbody>
		{{#each children}}
		<tr data-id={{id}}>
			<td> {{indexHuman index}} </td>
			<td>  
				{{#if this.children}}
					<a href="../{{id}}/" class="nextChildrenLnk">{{name}} <i class="icon icon-chevron-right"></i> </a>
				{{else}}
					{{name}}
					<div class="formulaCtr smallTxt">
						<b>ตัวเลือกงบประมาณ</b> 
						<span class="controls" style="margin-bottom: 15px;">
							<a href="#" class="btn btn-mini btn-info addFormulaStrategy"><i class="icon icon-file icon-white"></i> เพิ่มรายการ</a>
							<a href="#" class="btn btn-mini btn-primary editFormulaStrategy"><i class="icon icon-edit icon-white"></i> แก้ไข</a>
							<a href="#" class="btn btn-mini btn-danger deleteFormulaStrategy"><i class="icon icon-trash icon-white"></i> ลบ</a> 
						</span>
						<div class="formulaDetail">
							<ol></ol>
						</div>
					</div>
				{{/if}} 
			</td>
		</tr>
		{{/each}}
	</tbody>
</table>
</script>

<script type="text/javascript">
var budgetTypeId = "${budgetTypeId}";
var fiscalYear = "${fiscalYear}";
var e1;
Handlebars.registerPartial("formulaTpl", $("#formulaTemplate").html());


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
			
			
			this.currentBudgetType.trigger('changeFormula', this.currentBudgetType);
			
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
	
	var ModalView = Backbone.View.extend({
		initialize: function() {
			_.bindAll(this,'cancel');
			//this.model.bind('reset', this.render, this);
		},
		el: "#modal",
		model: null,
		modalTemplate: Handlebars.compile($("#modalTemplate").html()),
		
		events: {
			"click #saveBtn" : "save",
			"click #cancelBtn" : "cancel",
		},

		
		renderAddFormulaWith: function(budgetType) {
			if(budgetType != null) {
				this.budgetType = budgetType;
				
				
				this.$el.find('.modal-header span').html(this.budgetType.get('name'));
				
				
				var html = this.modalTemplate(budgetType.toJSON());
				this.$el.find('.modal-body').html(html);	
				
				this.$el.modal({show: true, backdrop: 'static', keyboard: false});
			}
				
		},
		
		cancel: function() {
			// nothing to recover just hide!
			this.$el.modal('hide');
		},
		
		save: function() {
			var formulaStrategy = new FormulaStrategy();
			var formEl = this.$el.find('form');
			formulaStrategy.set('name', $(formEl).find('#name').val());
			formulaStrategy.set('type', {id: this.budgetType.get('id')});
			formulaStrategy.set('fiscalYear', fiscalYear);
			formulaStrategy.set('numberColumns', 0);
			formulaStrategy.set('isStandardItem', false);
			formulaStrategy.set('index', this.budgetType.get('formulaStrategy').length);
			
			
			formulaStrategy.save(null, {
				success:_.bind(function(data){
					
					//now put back budgetType
					formulaStrategy.set('budgetType', this.budgetType.get('id'));
					
					// and initialize collection;
					formulaStrategy.set('formulaColumns', new FormulaColumnCollection());		
					
					this.budgetType.get('formulaStrategy').add(formulaStrategy);
					this.budgetType.trigger('changeFormula', this.budgetType);
					this.$el.modal('hide');
				},this)
			});
			
		}
		
	});
	
	var MainCtrView = Backbone.View.extend({
		initialize: function(options) {
			this.model = options.model;
			this.model.bind('reset', this.render, this);
			this.model.get('children').bind('changeFormula', this.renderChild, this);
		},
		
		el: "#mainCtr",
		mainCtrTpl: Handlebars.compile($("#mainCtrTemplate").html()),
		formulaTpl : Handlebars.compile($("#formulaTemplate").html()),
		formulaInLineEditTpl : Handlebars.compile($("#formulaInLinEditTemplate").html()),
		
		modalView: new ModalView(),
		formularLineModalView : new FormularLineModalView(),
		
		render: function() {
			
			this.$el.html(this.mainCtrTpl(this.model.toJSON()));
		},
		
		renderChild: function(caller) {
			
			//console.log(caller.toJSON());
			
			var callerFormulaEl = "tr[data-id="+ caller.get('id') +"] .formulaDetail ol";
			
			var json = caller.get('formulaStrategy').toJSON();
			json.id = caller.get('id');
			var html = this.formulaTpl(json);
			$(callerFormulaEl).html(html);
		},
		
		events: {
			"click .addFormulaStrategy" : "addFormulaStrategy",
			"click .deleteFormulaStrategy" : "deleteFormulaStrategy",
			"click .editFormulaStrategy" : "editFormulaStrategy",
			"click .editFormulaLineBtn" : "editFormulaLine",
			"click .updateFormulaStrategy" : "updateFormulaStrategy",
			"click .cancelUpdateFormulaStrategy" : "cancelUpdateFormulaStrategy"
		},
		
		addFormulaStrategy: function(e) {
			// now prepare information for modal
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			
			this.modalView.renderAddFormulaWith(currentBudgetType);
			
		},
		
		editFormulaLine : function(e) {
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			
			var currentFormulaId = $(e.currentTarget).parents('li').attr('data-id');
			var currentFormula = FormulaStrategy.findOrCreate(currentFormulaId);

			this.formularLineModalView.renderFormulaLineWith(currentFormula, currentBudgetType);
		},
		
		deleteFormulaStrategy: function(e) {
			// now prepare information for modal
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			
			
			var currentFormulaId = $("#formulaSlt-"+currentBudgetTypeId+":checked").val();
			var currentFormula = FormulaStrategy.findOrCreate(currentFormulaId);
			if(currentFormula != null) {
			
				var ret = confirm("คุณต้องการจะลบรายการ " + currentFormula.get('name'));
	
				if(ret) {
				
					currentBudgetType.get('formulaStrategy').remove(currentFormula);
					currentFormula.destroy();
				
					currentBudgetType.trigger('changeFormula', currentBudgetType);
				}
			} else {
				alert('กรุณาเลือกรายการที่ต้องการลบ');
			}
		},
		
		editFormulaStrategy: function(e) {
			// now prepare information for modal
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			
			var currentFormulaId = $("#formulaSlt-"+currentBudgetTypeId+":checked").val();
			var currentFormula = FormulaStrategy.findOrCreate(currentFormulaId);
			
			if(currentFormula != null) {
				// now disable the button
				this.$el.find('tr[data-id='+ currentBudgetTypeId +'] .btn').toggleClass('disabled');
				
				// we turn this into edit
				var formulaEl = "tr[data-id="+ currentBudgetTypeId +"] .formulaDetail ol li[data-id="+currentFormulaId+"]";
				
				var json = currentFormula.toJSON();
				
				var html = this.formulaInLineEditTpl(json);
				$(formulaEl).html(html);
				
				
			} else {
				alert('กรุณาเลือกรายการที่ต้องการแก้ไข');
			}
			
		},
		
		updateFormulaStrategy : function(e) {
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			
			var currentFormulaId = $(e.currentTarget).prev().attr("data-id");
			var currentFormula = FormulaStrategy.findOrCreate(currentFormulaId);
			
			currentFormula.set('name', $(e.currentTarget).prev().val());
			
			// we can save now !
			var json = currentFormula.toJSON();
			
			$.ajax({
				type: 'PUT',
				url: appUrl('/FormulaStrategy/' + currentFormula.get('id')),
				data: JSON.stringify(json),
				contentType: 'application/json;charset=utf-8',
				dataType: "json",
				success: _.bind(function(data) {
					this.renderChild(currentBudgetType);
					this.$el.find('tr[data-id='+ currentBudgetTypeId +'] .btn').toggleClass('disabled');
					
				}, this)
			});
			
			
		},
		
		cancelUpdateFormulaStrategy : function(e) {
			// now prepare information for modal
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			this.renderChild(currentBudgetType);
			this.$el.find('tr[data-id='+ currentBudgetTypeId +'] .btn').toggleClass('disabled');
			
		}
	});
	

	if(budgetTypeId != null && budgetTypeId.length > 0) {
	
		budgetType = new BudgetType({id: budgetTypeId});
		
		
		
		budgetType.fetch({success: function() {
		
			mainCtrView = new MainCtrView({model: budgetType});
			
			
			budgetType.trigger('reset');
			
			budgetType.get('children').forEach(function(child) {
				// now find BudgetFormula
				var strategyCollection = new FormulaStrategyCollection();
				strategyCollection.fetch({
					url: appUrl('/FormulaStrategy/search/' + fiscalYear + "/" + child.get('id')),
					success: function(data) {
						
						
						
						child.set('formulaStrategy',strategyCollection);
						//console.log(child.toJSON());
						
						child.trigger('changeFormula', child);
					}
				});
			
			});
			
		}});
		
	}
	
});
</script>
