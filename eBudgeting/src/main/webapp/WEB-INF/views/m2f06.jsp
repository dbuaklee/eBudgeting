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
	<td> {{#if this.children}}
			<a href="../{{id}}/" class="nextChildrenLnk">{{name}} <i class="icon icon-chevron-right"></i> </a>
		{{else}}
			{{name}}
			<button class="btn btn-mini addNextLevel">เพิ่มรายการย่อย</button>
			<button class="btn btn-mini detail">กำหนดรายละเอียด</button>
			<br>
				- {{budgetType.name}}
		{{/if}} 
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
	<td> <input type='text' placeholder='...' class='span7' value="{{name}}"></input> 
			<button indexHolder='{{index}}' class='btn btn-mini btn-info lineSave'>บันทึก</button>
			<button indexHolder='{{index}}' class='btn btn-mini btn-danger cancelLineSave'>ยกเลิก</button>
	</td>

</script>

<script id="modalTemplate" type="text/x-handlebars-template">
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
</div>
</script>

<script type="text/javascript">
<!--
var objectiveId = "${objective.id}";
var fiscalYear = "${fiscalYear}";

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
	
				e1 = this.objective.get('budgetType');
				
				if(this.objective.get('budgetType') == null) {
				
				    var rootBudgetType = BudgetType.findOrCreate({id:0});
				    rootBudgetType.fetch({success: _.bind(function(){
				    	this.budgetTypeSelection = new BudgetTypeSelectionView({model: rootBudgetType, el:'#budgetSelectionCtr'});
				    	this.budgetTypeSelection.render();
			    	},this)});
				
				} else {
					var currentBudgetType = this.objective.get('budgetType');
					this.btCollection = new Backbone.Collection();
					this.btCollection.bind('finishLoadParent', this.finishLoadParent, this);
					currentBudgetType.fetch({
						success:_.bind(function(model, response) {
							if(model.get('parent') != null) {
								model.loadParent(this.btCollection, response);
							}
														
						}, this)
					});
										
				}
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
			"click #saveBtn" : "save"
		},
		
		close: function(e) {
			this.$el.modal('hide');
		},
		
		save: function(e) {
			// try saving objective back to server!?
			if(this.objective != null) {
				// we have to get budgetType
				var budgetTypeSelected = this.budgetTypeSelection;
				while(budgetTypeSelected.nextBudgetTypeSelectionView != null) {
					// advance to the next selection 
					budgetTypeSelected = budgetTypeSelected.nextBudgetTypeSelectionView;
				}
				this.objective.url = appUrl('/Objective/'+this.objective.get('id'));				
				//OK we'll get budgetType id here
				this.objective.set('fiscalYear', fiscalYear);
				
				// now move out ObjectiveType children
				var objectiveTypeChildren = this.objective.get('type').get('children');
				this.objective.get('type').set('children', null);
				
				var budgetType = BudgetType.findOrCreate(budgetTypeSelected.model.id);
				
				this.objective.set('budgetType', budgetType);
				
				this.objective.save(null, {
					success: _.bind(function() {
						// put back children
						this.objective.get('type').set('children', objectiveTypeChildren);
						this.$el.modal('hide');
						this.objective.trigger('change', this.objective);
						
					},this)
				});

			}
					
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
			"click .detail" : "detailModal"
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
		
		saveLine: function(e) {
			
			 
			inputVal = $(e.currentTarget).prev('input').val();
			indexRow = parseInt($(e.currentTarget).attr('indexHolder'));
			if(this.collection.at(indexRow) == null) {
				
				this.collection.add(new Objective({name: inputVal, index: indexRow}));
			} else {
				var model  = this.collection.at(indexRow);
				model.set('name', inputVal);
			}
			
			this.$el.find('a.btn').toggleClass('disabled');
			
			this.collection.trigger("reset");
		
		},
		
		deleteRow: function(e) {
			if( (! $(e.currentTarget).hasClass('disabled')) && $('input[name=rowRdo]:checked').length == 1 ) {
				var indexToDelete = $('input[name=rowRdo]:checked').val();
				var modelToDelete = this.collection.at(indexToDelete);
				this.collection.remove(modelToDelete);
				
				// now we have to run through and reindex
				this.collection.each(function(model, index) {
					model.set('index', index);
				});
				
				this.collection.trigger('reset');
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
			
		},
		
		slideInChildren: function(e) {
			var id = $(e.target).parents('tr').attr('data-id');
			
				
			var f1 = function() {
				//once the animation is done
				// now load content and replace in div...
				this.collection.url='/eBudgeting/Objective/'+this.id+'/children';
				this.collection.fetch();
	
			};
			
			f1 = _.bind(f1, {collection: this.collection, id: id});
			
			// change the ul
			
			
			lastLiHtml = $('#headNav').children().last().html();
			prevLiHref = $('#headNav').find('a:last').attr('href');
			
			if(this.selectedObjective.get('parent') == null) {
				lastHref = prevLiHref + "2556/";
			} else {
				lastHref = prevLiHref + this.selectedObjective.get('id') + "/";	
			}
			
			// get selected id;
			this.selectedObjective = this.collection.get(id); 
			
			$('#headNav').children().last().html("<li><a href=" + lastHref +">"+ lastLiHtml +"</a> <span class='divider'>/</span></li>");
			
			var humanIndex = this.selectedObjective.get('index')+1;
			$('#headNav').append("<li class='active'>" + this.selectedObjective.get('type').get('name') + "ที่ " +
					humanIndex + "</li>");
			
			// now update currentPath with
			//history.pushState($('#mainTbl').html(),null,window.document.URL+id+"/");
			
			html = "<div style='height: 100px;display: table-cell; vertical-align: middle; text-align: center;'>Loading <br/><img src='/eBudgeting/resources/graphics/spinner_bar.gif'></img></div>";
			// slide In spinner
			this.$el.slideLeft(html,f1);
							
			//return false to not navigate to new page
			return false;
		}
		
	});
	
	

	if(objectiveId != null && objectiveId.length >0 ) {
		objectiveCollection = new ObjectiveCollection();
		objectiveCollection.url = appUrl("/Objective/"+ objectiveId +"/children");
		
		mainTblView = new MainTblView({collection: objectiveCollection});
		
		
		objectiveCollection.fetch();
	}


});

//-->
</script>