<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div id="headLine">
	
</div>

<div id="budgetRootSlt">
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

<script id="budgetSltTemplate" type="text/x-handler-template">
<select id="budgetTypeSlt">
	<option value="0">กรุณาเลือกหมวดงบประมาณ</option>
	{{#each this}}
	<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.name}}</option>
	{{/each}}
</select>
<div></div>
</script>

<script id="mainCtrTemplate" type="text/x-handler-template">
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
			<td width="50">รหัส</td>
			<td width="100">ระดับรายการ</td>
			<td>ชื่อรายการ</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>

<script id="formulaStrategyRowTemplate" type="text/x-handelbars-template">
<td><input type="radio" name="rowRdo" id="rdo_{{index}}" value="{{index}}"/></td>
	<td> {{indexHuman index}} </td>
	<td> {{code}} </td>
	<td> {{{parentBudgetType type}}} </td>
	<td> {{name}} = {{{formulaLine formulaColumns false}}} </td>
</script>

<script id="tbodyTemplate" type="text/x-handlebars-template">
{{#each this}}
<tr data-id="{{id}}">
</tr>
{{/each}}
</script>



<script id="newRowTemplate" type="text/x-handlebars-template">
<td></td>
	<td> {{indexHuman index}} </td>
	<td colspan="3">
		 <form class="form-inline">
			<div class="control-group">
				<label class="control-label" for="codeTxt"> <b>รหัส: </b> </label>
				<div class="controls">
					<input id="codeTxt" type='text' placeholder='...' class='span7' value="{{code}}"></input> <br/>
				</div>
			</div>
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
		formulaStrategyRowTemplate: Handlebars.compile($("#formulaStrategyRowTemplate").html()),
		
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
				this.renderFormulaStrategy(model);
			}, this);

			return this;
		},
		
		events: {
			"click .menuNew" : "newRow",
			"click .menuDelete" : "deleteRow",
			"click .menuEdit"	: "editRow",
			"click .lineSave" : "saveLine",
			"click .cancelLineSave" : "cancelSaveLine"
		},
		
		newRow: function(e) {
			if(! $(e.currentTarget).hasClass('disabled') ) {
				$('#mainTbl tbody').append('<tr>'+this.newRowTemplate({index:this.collection.length})+'</tr>');
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

			objectiveId = $(e.currentTarget).parents('tr').attr('data-id');
			
			inputNameVal = this.$el.find('#nameTxt').val();
			inputCodeVal = this.$el.find('#codeTxt').val();
			indexRow = parseInt($(e.currentTarget).attr('indexHolder'));
			
			if(this.collection.get(objectiveId) == null) {
				//var objType = pageObjective.get('type').get('children').at(0);
				var newObj =  new Objective({name: inputNameVal, code: inputCodeVal, index: indexRow});
				
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
		},
		
		renderFormulaStrategy: function(formulaStrategy) {
			var formulaStrategyEl = this.$el.find('tr[data-id='+ formulaStrategy.get('id') +']');
			
			var json = formulaStrategy.toJSON();
			
			formulaStrategyEl.html(this.formulaStrategyRowTemplate(json));
			
		}
		
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
					url: appUrl('/FormulaStrategy/search/' + fiscalYear + '/rootBudgetType/' + budgetTypeSelectedId),
					success: function() {
						
					}
				});
			}
		}
		
		
		
	});


	var headLineStr = '<h4> ทะเบียนรายการงบประมาณ ';
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