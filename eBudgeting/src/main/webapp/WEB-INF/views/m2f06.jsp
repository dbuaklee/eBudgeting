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

		

		<div id="modal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" id="closeBtn">Close</a> 
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
								<td> <a href="./${fiscalYear.fiscalYear}/${fiscalYear.id}/" class="nextChildrenLnk">${fiscalYear.fiscalYear}<i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
							</c:forEach>
						</tr>
					</tbody>
				</table>			
			</c:when>
			</c:choose>	
		</div>


	</div>
</div>

<script id="rootMainCtrTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td>เลือกปีงบประมาณ</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>{{this}} <a href="./{{this}}/" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
		</tr>
	</tbody>
</table>
</script>

<script id="mainCtrTemplate" type="text/x-handler-template">
<label class="control-label" for="mainTbl">{{type.name}} {{indexHuman index}} {{name}}</label>
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
			<td>{{#each type.children}}{{name}} {{/each}}</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>

<script id="objectiveRowTemplate" type="text/x-handelbars-template">
<td><input type="radio" name="rowRdo" id="rdo_{{index}}" value="{{index}}"/></td>
	<td> {{indexHuman index}} </td>
	<td> {{#unless this.isLeaf}}
			<a href="../{{id}}/" class="nextChildrenLnk">[{{code}}] {{name}} <i class="icon icon-chevron-right"></i> </a>
		{{else}}
			[{{code}}] {{name}}
			{{#unless budgetTypes}} <button class="btn btn-mini addNextLevel">เพิ่มรายการย่อย</button> {{/unless}}
			<button class="btn btn-mini detail">กำหนดรายละเอียด</button>
			<div><u>หมวดงบประมาณที่เลือกไว้</u>
				<ul>
					{{#each budgetTypes}}
						<li>{{name}}</li>
					{{/each}}
				</ul>				

			</div>
		{{/unless}} 
</td>
</script>

<script id="tbodyTemplate" type="text/x-handlebars-template">
{{#each this}}
<tr data-id="{{id}}">
</tr>
{{/each}}
</script>

<script id="budgetTypeSelectionTemplate" type="text/x-handler-template">

</script>


<script id="newRowTemplate" type="text/x-handlebars-template">
<td></td>
	<td> {{indexHuman index}} </td>
	<td> <input id="codeTxt" type='text' placeholder='...' class='span7' value="{{code}}"></input> <br/>
		<input id="nameTxt" type='text' placeholder='...' class='span7' value="{{name}}"></input>

			<button indexHolder='{{index}}' class='btn btn-mini btn-info lineSave'>บันทึก</button>
			<button indexHolder='{{index}}' class='btn btn-mini btn-danger cancelLineSave'>ยกเลิก</button>
	</td>

</script>

<script id="modalTemplate" type="text/x-handlebars-template">
<div id="kpiListingDiv">
</div>
<div><u>หมวดงบประมาณที่เลือกไว้</u>
	<ul id="budgetTypeLst">
	{{#each budgetTypes}}
		<li data-id="{{id}}"><span class="label label-important"><a href="#" class="removeBudgetType"><i class="icon icon-trash icon-white removeBudgetType"></i></a></span> {{name}}</li>
	{{/each}}
	</ul>				
</div>
<form>
	<label>ตัวชี้วัด</label>
	<input type="text" placeholder="Type something">

	<label>หมวดงบประมาณ</label>
	<div id="budgetSelectionCtr"></div>

</form>
</script>

<script id="selectionTemplate" type="text/x-handler-template">
<select id="budgetType_{{this.id}}">
	<option value="0">กรุณาเลือกรายการ</option>
	{{#each this.children}}
	<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.name}}</option>
	{{/each}}
</select>
<div></div>
</script>

<script id="proposalInputTemplate" type="text/x-handler-template">
<div id="proposalInputCtr">
<label>ระบุชื่อรายการงบประมาณ</label>
<input type="text"/> <br/>
</div>
</script>

<script id="formulaTemplate" type="text/x-handlebars-template">
<div id="formulaLine">
<ol>
{{#each this}}
	<li data-id={{id}}> <button class='btn btn-mini deleteFormula'>ลบ</button>{{name}} = {{{formulaLine formulaColumns false}}} 
	</li>
{{/each}}
</ol>
<button class="btn btn-mini" type="button" id="addBtn">add</button>
</div>
</script>

<script type="text/javascript">
<!--
var objectiveId = "${objective.id}";
var fiscalYear = "${fiscalYear}";
var pageObjective;

var pageUrl = "/page/m2f06/";

var mainTblView;

var e1;
var objectiveCollection;

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

	
	var BudgetProposalView = Backbone.View.extend({
		initialize: function(options){
			if(options != null) {
				this.el = options.el;
				this.model = options.model;
			} 
			_.bindAll(this, 'render');
			_.bindAll(this, 'fetchFormulaLine');
			
		},
		
		el: "#budgetSelectionCtr",
		formulaLineTpl : Handlebars.compile($("#formulaTemplate").html()),
		formulaStrategyCollection: null,
		
		render: function(){
			// first clear the siblings select
			this.$el.nextAll('div').remove();
			this.$el.empty();
			this.$el.html(this.formulaLineTpl(this.formulaStrategyCollection.toJSON()));
		},
		
		fetchFormulaLine : function(budgetTypeId) {
			this.formulaStrategyCollection = new FormulaStrategyCollection();
			this.formulaStrategyCollection.bind('change', this.render, this);
			
			this.formulaStrategyCollection.fetch({
				url: appUrl('/FormulaStrategy/search/' + fiscalYear + "/" + budgetTypeId),
				success: _.bind(function(data) {
					this.formulaStrategyCollection.trigger('change');
				}, this)
			});			
		}
		
		
	});
	
	var ModalView = Backbone.View.extend({
		initialize: function(){
		    
		},
		el: "#modal",
		objective : null,
		modalTemplate: Handlebars.compile($("#modalTemplate").html()),
		
		render: function() {
			
			if(this.objective != null) {
			
				
				var html = this.modalTemplate(this.objective.toJSON());
				this.$el.find('.modal-header span').html(this.objective.get('name'));
				this.$el.find('.modal-body').html(html);
	
				
				
					
			    var rootBudgetType = BudgetType.findOrCreate({id:0});
			    rootBudgetType.fetch({success: _.bind(function(){
			    	this.budgetTypeSelection = new BudgetTypeSelectionView({model: rootBudgetType, el:'#budgetSelectionCtr'});
			    	this.budgetTypeSelection.render();
		    	},this)});
				
				this.$el.modal({show: true, backdrop: 'static', keyboard: false});
				return this;
			}
		},
		
		finishLoadParent: function(budgetTypeCollection) {
			// here we will have to build the budgetTypeSelectionView;
			var budgetType = budgetTypeCollection.pop();
			var btEl = '#budgetSelectionCtr';
			var i = 0;
			var currentBudgetTypeSelectionView;
			while(budgetType != null) {
				var budgetTypeSelectionView = new BudgetTypeSelectionView({model:budgetType, el: btEl});
				budgetTypeSelectionView.render();
				if(i==0) {
					this.budgetTypeSelection = budgetTypeSelectionView;
				} else {
					currentBudgetTypeSelectionView.nextBudgetTypeSelectionView =  budgetTypeSelectionView;
				}
				currentBudgetTypeSelectionView = budgetTypeSelectionView;
				btEl  = btEl + " select + div";
				budgetType = budgetTypeCollection.pop();
				i = i+1;
				
			}
			
		},
		
		events: {
			"click #closeBtn" : "close",
			"click #addBtn" : "add",
			"click .removeBudgetType" : "removeBudgetType"
 		},
		
		close: function(e) {
			this.$el.modal('hide');
		},
		
		add: function(e) {
			if(this.objective !=null) {
				// we have to get budgetType
				var budgetTypeSelected = this.budgetTypeSelection;
				while(budgetTypeSelected.nextBudgetTypeSelectionView != null) {
					// advance to the next selection 
					budgetTypeSelected = budgetTypeSelected.nextBudgetTypeSelectionView;
				}
				var budgetType = BudgetType.findOrCreate(budgetTypeSelected.model.id);
				
				$.ajax({
					type: 'POST',
					
					url: appUrl('/Objective/'+this.objective.get('id')+'/addBudgetType/'),
					data: {
						budgetTypeId: budgetType.get('id')
					},
					success: _.bind(function(){
						console.log('save!');
						this.objective.get('budgetTypes').push(budgetType);
						this.objective.trigger('change', this.objective);
						this.render();
					},this)
				});
			}
			return false;
		},
		
		
		removeBudgetType: function(e) {
			var budgetTypeId = $(e.target).parents('li').attr('data-id');
			var budgetType = BudgetType.findOrCreate(budgetTypeId);
			
			// we can call for confirmation
			var r=confirm("คุณต้องการนำรายการนี้ออก?");
			if (r==true) {
				$.ajax({
					type: 'POST',
					url: appUrl('/Objective/'+this.objective.get('id')+'/removeBudgetType/'),
					data: {
						budgetTypeId: budgetTypeId
					},
					success: _.bind(function(){
						console.log('save!');
						this.objective.get('budgetTypes').remove(budgetType);
						this.objective.trigger('change', this.objective);
						this.render();
					},this)
				});
				
			} 
			return false;
		},
		renderWith: function(objective) {
			this.setObjective(objective);
			this.render();
			return this;
		},
		
		setObjective: function(objective) {
			this.objective = objective;
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
		selectionTpl : Handlebars.compile($("#selectionTemplate").html()),
		
		render: function(){
			// first clear the siblings select
			this.$el.nextAll('div').remove();
			this.$el.empty();
			this.$el.html(this.selectionTpl(this.model.toJSON()));
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
					this.nextBudgetTypeSelectionView = new BudgetTypeSelectionView({model: budgetType, el: nextEl});
					this.nextBudgetTypeSelectionView.render();
				} else {
					
					// then we should now filling in the proposed budget
					var nextEl = this.$el.selector + " select + div";
					this.nextBudgetTypeSelectionView = new BudgetProposalView({model: fetchedBudgetType, el: nextEl});
					
					this.nextBudgetTypeSelectionView.fetchFormulaLine(fetchedBudgetType.id);
				}
			}, this)});
			
			// ok we'll have to set back to this!?
			
		}
	});

	var MainTblView = Backbone.View.extend({
		initialize: function(){
		    this.collection.bind('reset', this.render, this);
		},
	
		el: "#mainCtr",
		selectedObjective: null,
		currentLineVal: null,
		modalView: new ModalView(),
		
		newRowTemplate: Handlebars.compile($("#newRowTemplate").html()),
		mainCtrTemplate: Handlebars.compile($("#mainCtrTemplate").html()),
		tbodyTemplate: Handlebars.compile($("#tbodyTemplate").html()),
		objectiveRowTemplate: Handlebars.compile($("#objectiveRowTemplate").html()),
		
		render: function() {
			// first render the control
			var html;
			
			if(this.selectedObjective != null) {
				html = this.mainCtrTemplate(this.selectedObjective.toJSON());
			} else {
				html = this.mainCtrTemplate({name: 'ปี 2556', type:{name: 'งบประมาณ', children: [{name:'แผนงาน'}]} });
			}
			this.$el.html(html);
			
			// then the inside row
			html = this.tbodyTemplate(this.collection.toJSON());
			this.$el.find('tbody').html(html);

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
			"click .detail" : "detailModal",
			"click .addNextLevel" : "goToNextLevel"
		},
		
		newRow: function(e) {
			if(! $(e.currentTarget).hasClass('disabled') ) {
				$('#mainTbl tbody').append('<tr>'+this.newRowTemplate({index:this.collection.length})+'</tr>');
				this.$el.find('a.btn').toggleClass('disabled');
			}
		},
		
		renderObjective: function(objective) {
			var objectiveEl = this.$el.find('tr[data-id='+ objective.get('id') +']');
			objectiveEl.html(this.objectiveRowTemplate(objective.toJSON()));
			
		},
		
		cancelSaveLine: function(e) {
			//now put back the value
			// well do nothing just reset the collection
			
			this.$el.find('a.btn').toggleClass('disabled');
			this.collection.trigger("reset");
			
		},
		
		goToNextLevel: function(e) {
			window.location.href = "../" + $(e.target).parents('tr').attr('data-id');
		},
		
		saveLine: function(e) {
			
			objectiveId = $(e.currentTarget).parents('tr').attr('data-id');
			
			inputNameVal = $(e.currentTarget).prevAll('#nameTxt').val();
			inputCodeVal = $(e.currentTarget).prevAll('#codeTxt').val();
			indexRow = parseInt($(e.currentTarget).attr('indexHolder'));
			
			if(this.collection.at(indexRow) == null) {
				var objType = pageObjective.get('type').get('children').at(0);
				var newObj =  new Objective({name: inputNameVal, code: inputCodeVal, index: indexRow});
				newObj.set('parent', pageObjective);
				newObj.set('type', objType);
				newObj.set('isLeaf', true);
				
				$.ajax({
					type: 'POST',
					url: appUrl('/Objective/newObjectiveWithParam'),
					data: {
						name: inputNameVal,
						code: inputCodeVal,
						parentId: pageObjective.get('id'),
						typeId: objType.get('id')
					},
					success: _.bind(function(data){
						newObj.set('id', data.id);
						newObj.set('index', this.collection.length);
						
						this.collection.add(newObj);
						
						this.collection.trigger('reset');
					},this)
				});
				
				
			} else {
				var model  = this.collection.at(indexRow);
				model.set('name', inputNameVal);
				model.set('code', inputCodeVal);
				
				$.ajax({
					type: 'POST',
					url: appUrl('/Objective/'+objectiveId+'/updateFields/'),
					data: {
						name: inputNameVal,
						code: inputCodeVal
					},
					success: _.bind(function(){
						
					},this)
				});
			}
			
			this.$el.find('a.btn').toggleClass('disabled');
			this.collection.trigger("reset");
		
		},
		
		deleteRow: function(e) {
			if( (! $(e.currentTarget).hasClass('disabled')) && $('input[name=rowRdo]:checked').length == 1 ) {
				var indexToDelete = $('input[name=rowRdo]:checked').val();
				var modelToDelete = this.collection.at(indexToDelete);
				if(modelToDelete.get('isLeaf') == true) {
				
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
					
					this.collection.trigger('reset');
				} else{
					alert('คุณต้องเข้าไปลบรายการจากรายการย่อยสุดเท่านั้น');
				}
			} else {
				alert('กรุณาเลือกรายการที่ต้องการลบ');
			}
		},
		
		editRow: function(e) {
			if((! $(e.currentTarget).hasClass('disabled') ) && $('input[name=rowRdo]:checked').length == 1) {
				this.$el.find('a.btn').toggleClass('disabled');
				var index = $('input[name=rowRdo]:checked').val();
				var model = this.collection.at(index);
				// now save current line Value 
				this.currentLineVal = this.collection.at(index).get('name');
				
				var html = this.newRowTemplate(model.toJSON());
				$('input[name=rowRdo]:checked').parents('tr').html(html);
			} else {
				alert('กรุณาเลือกรายการที่ต้องการแก้ไข');
			}
		},
		
		detailModal: function(e) {
			// now prepare information for modal
			var objectiveId = $(e.currentTarget).parents('tr').attr('data-id');
			var objective = this.collection.get(objectiveId);
			
			this.modalView.budgetTypeSelection =  this.modalView.renderWith(objective);
			
		}
		
	});
	
	

	if(objectiveId != null && objectiveId.length >0 ) {
		pageObjective = new Objective({id: objectiveId});
		pageObjective.fetch();
		
		
		objectiveCollection = new ObjectiveCollection();
		objectiveCollection.url = appUrl("/Objective/"+ objectiveId +"/children");
		
		mainTblView = new MainTblView({collection: objectiveCollection});
		
		
		objectiveCollection.fetch();
	}


});

//-->
</script>