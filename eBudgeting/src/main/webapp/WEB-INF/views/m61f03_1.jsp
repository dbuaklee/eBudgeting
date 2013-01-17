<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="hero-unit white">
<div id="headLine">
	<h4>การบันทึกงบประมาณ ระดับรายการ</h4> 
</div>

<div class="row">
	<div class="span11">
		
		<div id="modal" class="modal wideModal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<a href="#" class="btn" id="cancelBtn">กลับหน้าหลัก</a> 
			</div>
		</div>

		<div id="targetValueModal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<a href="#" class="btn" id="saveBtn">บันทึกข้อมูล</a>  
				<a href="#" class="btn" id="cancelBtn">ยกเลิก</a>
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
							<c:forEach items="${fiscalYears}" var="fiscalYear">
							<tr>
								
									<td><a href="./${fiscalYear.fiscalYear}/${fiscalYear.id}/"
										class="nextChildrenLnk">${fiscalYear.fiscalYear} <i
											class="icon icon-chevron-right nextChildrenLnk"></i>
									</a></td>
							
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


<script id="mainSelectionTemplate" type="text/x-handler-template">
<form class="form-horizontal">
<div class="control-group" style="margin-bottom:5px;">
	<label class="control-label">แผนงาน :</label> 
	<div class="controls">
		<select id="type101Slt" class="span5">
			<option>กรุณาเลือก...</option>
			{{#each this}}<option value={{id}}>[{{code}}] {{name}}</option>{{/each}}
		</select>
	</div>
</div>
	<div id="type102Div">
		<div class="control-group"  style="margin-bottom:5px;">
			<label class="control-label">ผลผลิต/โครงการ :</label>
			<div class="controls">
				<select class="span5" disabled="disabled">
					<option>กรุณาเลือก...</option>
				</select>
			</div> 
		</div>	
	</div>
	<div id="type103Div">
		<div class="control-group"  style="margin-bottom:5px;">
			<label class="control-label">กิจกรรมหลัก :</label>
			<div class="controls">
				<select class="span5" disabled="disabled">
					<option>กรุณาเลือก...</option>
				</select>
			</div> 
		</div>

	</div>
</form>
</script>

<script id="selectionTemplate" type="text/x-handler-template">
<div class="control-group"  style="margin-bottom:5px;">
	<label class="control-label">{{type.name}} :</label>
	<div class="controls">
		<select id="type{{type.id}}Slt" class="span5">
			<option>กรุณาเลือก...</option>
			{{#each this}}<option value={{id}}>[{{code}}] {{name}}</option>{{/each}}
		</select>
	</div> 
</div>
</script>

<script id="type102DisabledSelection" type="text/x-handler-template">
		<div class="control-group"  style="margin-bottom:5px;">
			<label class="control-label">ผลผลิต/โครงการ :</label>
			<div class="controls">
				<select class="span5" disabled="disabled">
					<option>กรุณาเลือก...</option>
				</select>
			</div> 
		</div>
</script>


<script id="type103DisabledSelection" type="text/x-handler-template">
		<div class="control-group"  style="margin-bottom:5px;">
			<label class="control-label">กิจกรรมหลัก :</label>
			<div class="controls">
				<select class="span5" disabled="disabled">
					<option>กรุณาเลือก...</option>
				</select>
			</div> 
		</div>
</script>


<script id="loadingTemplate" type="text/x-handler-template">
	<div>Loading <img src="/eBudgeting/resources/graphics/spinner_bar.gif"/></div>
</script>

<script id="selectionTemplate" type="text/x-handler-template">
<select id="budgetType_{{this.id}}" multiple="multiple" style="height: 100px;" class="span2">
	{{#if this}}
	{{#each this.children}}
		<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.name}}</option>
	{{/each}}
{{else}} {{/if}}
</select>
</script>

<script id="budgetTypeSelectionTemplate" type="text/x-handler-template">
{{#if editStrategy}}<b>แก้ไขจำนวนเงิน</b>{{else}}<b>เลือกงบประมาณ</b>{{/if}}
<select id="budgetTypeSlt" {{#if editStrategy}} disabled {{/if}}>
	<option value="0">กรุณาเลือกรายการ</option>
	{{#each this}}
	<option value="{{id}}" {{#if selected}}selected='selected'{{/if}}>{{name}}</option>
	{{/each}}
</select>
<div id="strategySelectionDiv"></div>
</script>

<script id="strategySelectionTemplate" type="text/x-handler-template">
<select id="strategySlt" multiple="multiple" style="height: 100px;" class="span2" >
	{{#each this}}
	<option value="{{id}}" {{#if selected}}selected='selected'{{/if}}>{{name}}</option>
	{{/each}}
</select>
</script>

<script id="mainCtrTemplate" type="text/x-handler-template">
<div id="mainSelection">
</div>
<div id="mainTbl">
</div>
</script>
<script id="mainTblTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="headerTbl" style="margin-bottom:0px; width:875px; table-layout:fixed;">
	<thead>
		<tr>
			<td style="width:20px;">#</td>
			<td style="width:246px;"><strong>แผนงาน/กิจกรรม ประจำปี {{this.0.fiscalYear}}</strong></td>
			<td style="width:60px;">เป้าหมาย</td>
			<td style="width:60px;">หน่วยนับ</td>
			<td style="width:80px;">งบประมาณปี  {{this.0.fiscalYear}}</td>
			<td style="width:80px;">ปี  {{next this.0.fiscalYear 1}}</td>
			<td style="width:80px;">ปี  {{next this.0.fiscalYear 2}}</td>
			<td style="width:80px;">ปี  {{next this.0.fiscalYear 3}}</td>
			<td style="width:15px;padding:0px;">&nbsp;</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td></td>
			<td style="text-align:right; padding-right: 20px;"><strong>รวมทั้งสิ้น</strong></td>
			<td></td>
			<td></td>
			<td><strong>{{sumProposal allProposal}}</td>
			<td><strong>{{sumProposalNext1Year allProposal}}</strong></td>
			<td><strong>{{sumProposalNext2Year allProposal}}</strong></td>
			<td><strong>{{sumProposalNext3Year allProposal}}</strong></td>
			<td style="width:15px;padding:0px;">&nbsp;</td>
		</tr>
	</tbody>
</table>
<div class="inRow" style="height: 600px;overflow-y: scroll; width:860px; border-left:1px solid #DDDDDD;">
<table class="table table-bordered" id="mainTbl" style="width:720px; table-layout:fixed; margin: 0px; border-radius: 0px;">
	<tbody>
			{{{childrenNodeTpl this 0}}}
	</tbody>
</table>
</div>
<table class="table table-bordered" id="headerTbl" style="margin-bottom:0px; width:875px; table-layout:fixed;">
	<thead>
		<tr>
			<td>รายการ</td>
		</tr>
	</thead>
</table>

</script>
<script id="childrenNodeTemplate" type="text/x-handler-template">
	<tr data-level="{{this.level}}" data-id="{{this.id}}" class="type-{{type.id}}" showChildren="true" parentPath="{{this.parentPath}}">
		<td style="width:20px;"></td>
		<td style="width:246px;" class="{{#if this.children}}disable{{/if}}">
			<div class="pull-left" style="margin-left:{{this.padding}}px; width:18px;">
					{{#if this.children}}
					<input class="checkbox_tree bullet" type="checkbox" id="bullet_{{this.id}}"/>
					<label class="expand" for="bullet_{{this.id}}"><icon class="label-caret icon-caret-down"></icon></label>
					{{else}}		
						<label class="expand">			
							<icon class="icon-file-alt"></icon>
						<label>
					{{/if}}					
			</div>
			<div class="pull-left" style="width:{{nameWidth}}px;">
					<input class="checkbox_tree" type="checkbox" id="item_{{this.id}}"/>
					<label class="main" for="item_{{this.id}}">
						{{#unless this.children}}<a href="#" class="detail">{{/unless}}
						<b>{{this.type.name}}</b> [{{this.code}}] {{this.name}}
						{{#unless this.children}}</a>{{/unless}}
					</label>
			</div>
{{#unless this.children}}
			<div class="clearfix">	{{{listProposals this.filterProposals}}}</div>
{{/unless}}
			
		</td>
		<td  style="width:60px;" class="{{#if this.children}}disable{{/if}} centerAlign">
			<span>
				{{#each filterTargetValues}}
				{{#if requestedValue}}{{formatNumber requestedValue}}{{else}}0{{/if}}<br/>
				{{/each}}
			</span>
		</td>
		<td  style="width:60px;" class="{{#if this.children}}disable{{/if}} centerAlign">
			<span>
				<ul  style="list-style:none; margin: 0px;">{{#each filterTargetValues}}<li style="list-style:none; padding: 0px;">{{target.unit.name}} ({{#if target.isSumable}}นับ{{else}}ไม่นับ{{/if}})</li>{{/each}}</ul>
			</span>
		</td>
		<td style="width:80px;" class="{{#if this.children}}disable{{/if}} rightAlign">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposal this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposal this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
		</td>

		<td style="width:80px;" class="{{#if this.children}}disable{{/if}} rightAlign">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposalNext1Year this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposalNext1Year this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
		</td>
		<td style="width:80px;" class="{{#if this.children}}disable{{/if}} rightAlign">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposalNext2Year this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposalNext2Year this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
		</td>
		<td style="width:80px;" class="{{#if this.children}}disable{{/if}} rightAlign">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposalNext3Year this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposalNext3Year this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
		</td>
	</tr>
	{{{childrenNodeTpl this.children this.level}}}  
</script>

<script id="modalTemplate" type="text/x-handler-template">
<div class="menu"><button id="addBudget" class="btn">เพื่มรายการงบประมาณ</button>
<div><u>รายการงบประมาณลงข้อมูลไว้แล้ว</u></div>
	{{{listProposalStrategies filterProposals}}}
</div>
</script>

<script id="inputAllDivTemplate" type="text/x-handler-template">
<div id="inputAll">
	<div class="row">
		<div class="span2" id="budgetTypeSelectionDivL1">หมวดงบประมาณ<div></div></div>
	</div>
	<div id="inputDiv" class="span10">
		<form id="input-form" style="margin-bottom:0px;" data-id="{{id}}">
			<div id="formulaBox">
				<div>
					<div style="height:35px;">
						จำนวนขอตั้ง:
					</div>
				</div>
				<div>
					<div style="height:35px;" id="totalInputForm">
						<div class="input-append"><input type="text" id="totalInputTxt" style="width:120px;" value="{{amountRequest}}"></input><span class="add-on">บาท</span></div>
					</div>
				</div>
			</div>
	
			<div class="clearfix"></div>
			<div id="formulaBox">
				<div>
					<div style="margin-top:11px;"> <button class="btn copytoNextYear">คัดลอกไปประมาณการ 3 ปี</button></div>
				</div>
				<div style="margin: 0px 8px;">
					<div><b>ปี: {{next1Year}}</b></div><div class="input-append"><input style="width:120px;" type="text" id="amountRequestNext1Year" value="{{next1YearValue}}"/><span class="add-on">บาท</span></div>
				</div>
				<div style="margin: 0px 8px;">
					<div><b>ปี : {{next2Year}}</b></div><div class="input-append"><input style="width:120px;" type="text" id="amountRequestNext2Year" value="{{next1YearValue}}"/><span class="add-on">บาท</span></div>
				</div>
				<div style="margin: 0px 8px;">
					<div><b>ปี: {{next3Year}}</b></div><div class="input-append"><input style="width:120px;" type="text" id="amountRequestNext3Year" value="{{next1YearValue}}"/><span class="add-on">บาท</span></div>
				</div>
			</div>
			<div class="clearfix"></div>
		</form>
	</div>
</div>
<button class="btn btn-mini btn-primary saveProposal">บันทึก</button> <button class="btn btn-mini backToProposal">ย้อนกลับ</button>
</script>


<script id="objectiveBudgetProposalListTemplate" type="text/x-handler-template">
<ul>
{{#each this}}
	<li>{{budgetType.name}}: {{formatNumber amountRequest}} บาท</li>
{{/each}}
</ul>
</script>

<script type="text/javascript">
	var fiscalYear = parseInt("${fiscalYear}");
	
	var mainCtrView = null;
	var objectiveCollection = null;
	var budgetTypeSelectionView = null;
	var rootCollection;
	var mainBudgetTypeCollection = null;
	var topBudgetList = ["งบบุคลากร","งบดำเนินงาน","งบลงทุน","งบอุดหนุน","งบรายจ่ายอื่น"];
	var l = null;
	var e1;

	var proposalListTemplate = Handlebars.compile($('#proposalListTemplate').html());
	var proposalStrategyListTemplate = Handlebars.compile($('#proposalStrategyListTemplate').html());
	
	Handlebars.registerHelper("listProposalStrategies", function(proposals) {
		if(proposals == null || proposals.length == 0) return "";
		
		var budgetTypeList = [];
		var proposalList=[];
		
		for(var i=0; i< proposals.length; i++) {
 			if(budgetTypeList[proposals[i].budgetType.topParentName] == null) budgetTypeList[proposals[i].budgetType.topParentName] = 0;
 			if(proposalList[proposals[i].budgetType.topParentName] == null) proposalList[proposals[i].budgetType.topParentName] = [];
 			
 			budgetTypeList[proposals[i].budgetType.topParentName] += parseInt(proposals[i].amountRequest);
 			proposalList[proposals[i].budgetType.topParentName].push(proposals[i]);
 		}
 		
 		var json=[];
 		for(var i=0; i< topBudgetList.length; i++) {
 			if(budgetTypeList[topBudgetList[i]] != null && budgetTypeList[topBudgetList[i]] > 0) {
 				json.push({name: topBudgetList[i], total: budgetTypeList[topBudgetList[i]], proposals: proposalList[topBudgetList[i]]});
 				
 			}
 		}
		
		
		return proposalStrategyListTemplate(json);
	});
	
	
	Handlebars.registerHelper("listProposals", function(proposals) {
		if(proposals == null || proposals.length == 0) return "";
		
		var budgetTypeList = [];
		
		for(var i=0; i< proposals.length; i++) {
 			if(budgetTypeList[proposals[i].budgetType.topParentName] == null) budgetTypeList[proposals[i].budgetType.topParentName] = 0;

 			budgetTypeList[proposals[i].budgetType.topParentName] += proposals[i].amountRequest;
 		}
 		
 		var json=[];
 		for(var i=0; i< topBudgetList.length; i++) {
 			if(budgetTypeList[topBudgetList[i]] != null && budgetTypeList[topBudgetList[i]] > 0) {
 				json.push({name: topBudgetList[i], total: budgetTypeList[topBudgetList[i]]});
 			}
 		}
 		 		
 		return proposalListTemplate(json);
		
	});
	
	Handlebars.registerHelper("sumProposal", function(proposals) {
		var amount = 0;
		for ( var i = 0; i < proposals.length; i++) {
			amount += proposals[i].amountRequest;
		}
		return addCommas(amount);

	});
	Handlebars.registerHelper("sumProposalNext1Year", function(proposals) {
		var amount = 0;
		for ( var i = 0; i < proposals.length; i++) {
			amount += proposals[i].amountRequestNext1Year;
		}
		return addCommas(amount);

	});
	Handlebars.registerHelper("sumProposalNext2Year", function(proposals) {
		var amount = 0;
		for ( var i = 0; i < proposals.length; i++) {
			amount += proposals[i].amountRequestNext2Year;
		}
		return addCommas(amount);

	});
	Handlebars.registerHelper("sumProposalNext3Year", function(proposals) {
		var amount = 0;
		for ( var i = 0; i < proposals.length; i++) {
			amount += proposals[i].amountRequestNext3Year;
		}
		return addCommas(amount);

	});

	Handlebars.registerHelper("formulaLine", function(strategy) {
		console.log(strategy);
		var s = addCommas(strategy.formulaStrategy.standardPrice) + " บาท ";

		if (strategy.formulaStrategy != null) {
			var formulaColumns = strategy.formulaStrategy.formulaColumns;
			for ( var i = 0; i < formulaColumns.length; i++) {
				
				s = s + " &times; ";
				if (formulaColumns[i].isFixed) {
					// now we'll go through requestColumns
					var j;
					for (j = 0; j < strategy.requestColumns.length; j++) {
						if (strategy.requestColumns[j].column.id == formulaColumns[i].id) {
							s = s + addCommas(strategy.requestColumns[j].amount)
								+ " " + formulaColumns[i].unitName;
						}
					}

				} else {
					s = s +  addCommas(formulaColumns[i].value)
						+ " " + formulaColumns[i].unitName;
				}

			}
		}

		return s;
	});

	Handlebars.registerHelper('substract', function(a, b) {
		return a - b;
	});

	Handlebars.registerHelper('childrenNodeTpl', function(children, level) {
		var out = '';
		var childNodeTpl = Handlebars
				.compile($("#childrenNodeTemplate").html());
		var childNormalNodeTpl = Handlebars.compile($(
				"#childrenNormalNodeTemplate").html());
		if (level == undefined)
			level = 0;
		if (children != null && children.length > 0) {

			if (children[0].type.id > 0) {
				children.forEach(function(child) {
					child["level"] = level + 1;
					
					
					child["padding"] = parseInt(level) * 20;
					
					child["nameWidth"] = 246 - 18 - child["padding"];
					out = out + childNodeTpl(child);
				});

			} else {
				children.forEach(function(child) {
					out = out + childNormalNodeTpl(child);
				});
			}
		}

		return out;
	});

	Handlebars.registerHelper('next', function(val, next) {
		return val + next;
	});

	var BudgetTypeAllSelectionView = Backbone.View.extend({
		initialize: function(options){
			if(options != null) {
				this.level = options.level;
				this.parentModal = options.parentModal;
			} 
		},
		budgetInputSelectionTemplate : Handlebars.compile($("#budgetInputSelectionTemplate").html()),
		
		render: function(){
			// first clear the siblings select
			
			this.$el.empty();
			if(this.collection != null) {
				this.$el.html(this.budgetInputSelectionTemplate(this.collection.toJSON()));
			} else {
				this.$el.html(this.budgetInputSelectionTemplate({}));
			}
			
			
		},
		
		setCollection: function(collection) {
			this.collection =  collection;
			
		}
	});

	var ModalView = Backbone.View.extend({
		initialize : function() {
			
		},

		el : "#modal",
	
		currentBudgetTypeSelection: [],
		currentFormulaStrategySelection: null,
		
		modalTemplate : Handlebars.compile($('#modalTemplate').html()),
		inputAllDivTemplate : Handlebars.compile($('#inputAllDivTemplate').html()),
		
		inputEditProposalTemplate: Handlebars.compile($('#inputEditProposalTemplate').html()), 
		defaultInputTemplate : Handlebars.compile($('#defaultInputTemplate').html()),
		inputModalTemplate : Handlebars.compile($('#inputModalTemplate').html()),
		
		events : {
			"click .removeProposal" : "removeProposal",
			"click .saveProposal" : "saveProposal",
			"click .editProposal" : "editProposal",
			"click #cancelBtn" : "cancelModal",
			"click .close" : "cancelModal",
			"click .backToProposal" : "backToProposal",
			"click #addBudget" : "renderInputALL"

		},
		backToProposal: function(e) {
			this.render();
		},
		cancelModal : function(e) {
			this.$el.modal('hide');
			mainCtrView.renderMainTbl();
		},
		
		saveProposal: function(e) {
			this.$el.find('button.saveProposal').html('<icon class="icon-refresh icon-spin"></icon> กำลังบันทึกข้อมูล...');
			
			var obpId = this.$el.find('form#input-form').attr('id');
			var obp = ObjectiveBudgetProposal.findOrCreate(obpId);
			
			var budgetTypeId = this.$el.find('#type101Slt').val();
			var budgetType = BudetType.findOrCreate(budgetTypeId);
			
			if(obp == null ){
				obp = new ObjectiveBudgetProposal();
			}
			
			// now get the input
			odp.set('amountRequest', this.$el.find('input#totalInputTxt').val());
			odp.set('amountRequestNext1Year', this.$el.find('input#amountRequestNext1Year').val());
			odp.set('amountRequestNext2Year', this.$el.find('input#amountRequestNext2Year').val());
			odp.set('amountRequestNext3Year', this.$el.find('input#amountRequestNext3Year').val());
			
			odp.set('forObjective', this.objective);
			odb.set('budgetType', budgetType);
			
			//now ready for save
			odb.save(null, {
				success: _.bind(function() {
					this.objective.get('filterObjectiveBudgetProposal').add(odb);
					this.render();
				}, this)
			});
			
		},
		editProposal : function(e) {
			var proposalStrategyId = $(e.target).parents('li').attr('data-id');
			var budgetProposalId = $(e.target).parents('li').attr('proposal-id');

			// now get this one
			var budgetProposal = this.objective.get('filterProposals').get(budgetProposalId);
			var proposalStrategy = budgetProposal.get('proposalStrategies').get(proposalStrategyId);

			// we'll begin by render the budgetTypeSelectionView
			this.renderEditProposal(budgetProposal, proposalStrategy);

		},

		removeProposal : function(e) {
			var proposalStrategyId = $(e.target).parents('li').attr('data-id');
			var budgetProposalId = $(e.target).parents('li').attr('proposal-id');

			// now get this one
			var budgetProposal = this.objective.get('filterProposals').get(budgetProposalId);
			var proposalStrategy = budgetProposal.get('proposalStrategies').get(proposalStrategyId);

			if (proposalStrategy != null) {
				// we can start deleting it now.. 

				var r = confirm("คุณต้องการนำรายการนี้ออก?");
				if (r == true) {
					$.ajax({
						type : 'DELETE',
						url : appUrl('/ProposalStrategy/' + proposalStrategyId),
						success : _.bind(function() {
								budgetProposal.get('proposalStrategies').remove(proposalStrategy);
								var newAmount = budgetProposal.get('amountRequest') - proposalStrategy.get('totalCalculatedAmount');
								budgetProposal.set('amountRequest', newAmount);

								// now we'll have to trigger change all the way up ward

								this.objective.trigger('change',this.objective);
								this.render();
							}, this)
						});

				}
				return false;

			}
		},
		
		renderEditProposal: function(budgetProposal, proposalStrategy) {
			this.$el.find('.modal-body').html(this.inputEditProposalTemplate());
			
			this.startegySelectionView = new StrategySelectionView({el: '#inputAll', parentModal: this});
			this.startegySelectionView.setCurrentBudgetTypeAndStrategy(budgetProposal.get('budgetType'), proposalStrategy.get('formulaStrategy'));
			
			var json;
			if(proposalStrategy.get('formulaStrategy') == null) {
				var budgetType = budgetProposal.get('budgetType');
				json = proposalStrategy.toJSON();
				json.budgetTypeName = budgetType.get('name');
				
				if(proposalStrategy.get('targetUnit') != null) {
					
					if(proposalStrategy.get('targetUnit') instanceof Backbone.Model) {
						json.budgetTypeUnitName = proposalStrategy.get('targetUnit').get('name');
						json.targetUnitId = proposalStrategy.get('targetUnit').get('id');	
					} else {
						var t = TargetUnit.findOrCreate(proposalStrategy.get('targetUnit'));
						if(t!=null) {
							json.budgetTypeUnitName = t.get('name');
							json.targetUnitId = t.get('id');
						}
					}
					
					
				}
				
				json.next1Year = fiscalYear + 1;
				json.next1YearValue = proposalStrategy.get('amountRequestNext1Year');
	
				json.next2Year = fiscalYear + 2;
				json.next2YearValue = proposalStrategy.get('amountRequestNext2Year');
	
				json.next3Year = fiscalYear + 3;
				json.next3YearValue = proposalStrategy.get('amountRequestNext3Year');
				json.proposalStrategyId = proposalStrategy.get('id');
				
				this.$el.find('#input-form').html(this.defaultInputTemplate(json));
			} else {
				json = proposalStrategy.get('formulaStrategy').toJSON();
				json.targetValue = proposalStrategy.get('targetValue');
				if(proposalStrategy.get('targetUnit') instanceof Backbone.Model) {
					json.budgetTypeUnitName = proposalStrategy.get('targetUnit').get('name');
					json.targetUnitId = proposalStrategy.get('targetUnit').get('id');	
				} else {
					var t = TargetUnit.findOrCreate(proposalStrategy.get('targetUnit'));
					if(t!=null) {
						json.budgetTypeUnitName = t.get('name');
						json.targetUnitId = t.get('id');
					}
				}
				
				json.total = proposalStrategy.get('totalCalculatedAmount');
				
				json.proposalStrategyId = proposalStrategy.get('id');
				json.next1Year = fiscalYear + 1;
				json.next1YearValue = proposalStrategy.get('amountRequestNext1Year');
	
				json.next2Year = fiscalYear + 2;
				json.next2YearValue = proposalStrategy.get('amountRequestNext2Year');
	
				json.next3Year = fiscalYear + 3;
				json.next3YearValue = proposalStrategy.get('amountRequestNext3Year');
				
				// now fill in value from request columns
				for(var i=0; i< json.formulaColumns.length; i++) {
					var fcId = json.formulaColumns[i].id;
					for(var j=0; j<proposalStrategy.get('requestColumns').length; j++) {
						if(proposalStrategy.get('requestColumns').at(j).get('column').get('id') == fcId) {
							json.formulaColumns[i].value = proposalStrategy.get('requestColumns').at(j).get('amount');
						}
					}
					
				}
				
				console.log(json);
				this.$el.find('#input-form').html(this.inputModalTemplate(json));
			}
			
			
		},

		renderInputALL : function() {
			
			var json ={};
			this.$el.find('.modal-body').html(this.inputAllDivTemplate(json));
			
			this.budgetTypeSelectionViewL1 =  new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL1 > div', level: 1, parentModal: this});
			this.budgetTypeSelectionViewL1.$el = $('#budgetTypeSelectionDivL1 > div');
		    this.budgetTypeSelectionViewL1.setCollection(mainBudgetTypeCollection);
		    this.budgetTypeSelectionViewL1.render();
		    			
		},
		
		render : function() {
			if (this.objective != null) {
				var html = this.modalTemplate({});
				this.$el.find('.modal-header span').html(this.objective.get('name'));
				this.$el.find('.modal-body').html(html);
			}

			
			this.$el.modal({
				show : true,
				backdrop : 'static',
				keyboard : false
			});
			return this;
		},

		renderWith : function(currentObjective) {
			this.objective = currentObjective;
			this.render();
		}
	});
	
	var MainSelectionView = Backbone.View.extend({
		mainSelectionTemplate : Handlebars.compile($("#mainSelectionTemplate").html()),
		selectionTemplate : Handlebars.compile($("#selectionTemplate").html()),
		type102DisabledSelectionTemplate : Handlebars.compile($("#type102DisabledSelection").html()),
		type103DisabledSelectionTemplate : Handlebars.compile($("#type103DisabledSelection").html()),
		
		initialize: function() {
			
			this.type102Collection = new ObjectiveCollection();
			this.type103Collection = new ObjectiveCollection();
			
			_.bindAll(this, 'renderInitialWith');
			_.bindAll(this, 'renderType102');
			_.bindAll(this, 'renderType103');
			this.type102Collection.bind('reset', this.renderType102);
			this.type103Collection.bind('reset', this.renderType103);
		},
		events: {
			"change select#type101Slt" : "type101SltChange",
			"change select#type102Slt" : "type102SltChange",
			"change select#type103Slt" : "type103SltChange"
		},
		type101SltChange : function(e) {
			var type101Id = $(e.target).val();
			if(type101Id != 0) {
				this.type102Collection.fetch({
					url: appUrl('/Objective/' + type101Id + '/children'),
					success: _.bind(function() {
						this.type102Collection.trigger('reset');
					}, this)
				});
			}
			
			mainCtrView.emptyTbl();
			
		},
		type102SltChange : function(e) {
			var type102Id = $(e.target).val();
			if(type102Id != 0) {
				this.type103Collection.fetch({
					url: appUrl('/Objective/' + type102Id + '/children'),
					success: _.bind(function() {
						this.type103Collection.trigger('reset');
					}, this)
				});
			}
			
			this.$el.find('#type103Div').empty();
			this.$el.find('#type103Div').html(this.type103DisabledSelectionTemplate());
			
			mainCtrView.emptyTbl();
		},
		
		type103SltChange : function(e) {
			var type103Id = $(e.target).val();
			if(type103Id != 0) {
				var obj = Objective.findOrCreate(type103Id);
				mainCtrView.renderMainTblWithParent(obj);
				
			} else {
				mainCtrView.emptyTbl();
			}
		
		},
		
		renderType102: function(e) {
			var json = this.type102Collection.toJSON();
			json.type =  {};
			json.type.name = "ผลผลิต/โครงการ";
			json.type.id = "102";
			var html = this.selectionTemplate(json);
			
			// now render 
			this.$el.find('#type102Div').empty();
			this.$el.find('#type102Div').html(html);
			
			this.$el.find('#type103Div').empty();
			this.$el.find('#type103Div').html(this.type103DisabledSelectionTemplate());
			
			
		},
		
		renderType103: function(e) {
			var json = this.type103Collection.toJSON();
			json.type =  {};
			json.type.name = "กิจกรรมหลัก";
			json.type.id = "103";
			var html = this.selectionTemplate(json);
			
			// now render 
			this.$el.find('#type103Div').empty();
			this.$el.find('#type103Div').html(html);
			
			
		},
		
		render: function() {
			
			if(this.rootChildrenObjectiveCollection != null) {
				var json = this.rootChildrenObjectiveCollection.toJSON();
				
				var html = this.mainSelectionTemplate(json);
				this.$el.html(html);
			}
		}, 
		renderInitialWith: function(objective) {
			
			this.rootObjective = objective;
			
			// now get this rootObjective Children
			this.rootChildrenObjectiveCollection = new ObjectiveCollection();
			
			this.rootChildrenObjectiveCollection.fetch({
				url: appUrl('/Objective/' + this.rootObjective.get('id') + '/children'),
				success : _.bind(function() {
					
					this.render();
				},this)
			});
			
		}
		
	});
	

	var MainCtrView = Backbone.View.extend({
		initialize : function() {
			//this.collection.bind('reset', this.render, this);
			_.bindAll(this, 'detailModal');
			
			// puting loading sign
			this.$el.html(this.loadingTpl());
		},

		el : "#mainCtr",
		loadingTpl : Handlebars.compile($("#loadingTemplate").html()),
		mainCtrTemplate : Handlebars.compile($("#mainCtrTemplate").html()),
		mainTblTpl : Handlebars.compile($("#mainTblTemplate").html()),
		nodeRowTpl : Handlebars.compile($("#nodeRowTemplate").html()),
		mainTbl1Tpl : Handlebars.compile($("#mainCtr1Template").html()),
		modalView : new ModalView(),

		events : {
			"click input[type=checkbox].bullet" : "toggle",
			"click .detail" : "detailModal"
		},

		detailModal : function(e) {
			var currentObjectiveId = $(e.target).parents('tr').attr('data-id');
			var currentObjective = Objective.findOrCreate(currentObjectiveId);
			this.modalView.renderWith(currentObjective);
		
		},
		render : function() {
			this.$el.html(this.mainCtrTemplate());
			this.mainSelectionView = new MainSelectionView({el: "#mainCtr #mainSelection"});

			this.rootObjective = new Objective(); 
			this.rootObjective.fetch({
				url: appUrl('/Objective/ROOT/'+fiscalYear),
				success : _.bind(function() {
					this.mainSelectionView.renderInitialWith(this.rootObjective);
				},this)
			});
		},
		renderInputAll: function() {
			
		},
		renderMainTblWithParent: function(parentObjective){
			this.currentParentObjective = parentObjective;
			this.renderMainTbl();
		},
		renderMainTbl :function() {
			if(this.currentParentObjective!=null)	{
				this.$el.find('#mainTbl').html(this.loadingTpl());
				// getRootCollection
				objectiveCollection = new ObjectiveCollection();
				this.collection = new ObjectiveCollection();
				
				objectiveCollection.url = appUrl("/ObjectiveWithObjectiveBudgetProposal/" + fiscalYear+ "/" + this.currentParentObjective.get('id') + "/flatDescendants");
				
				objectiveCollection.fetch({
					success : _.bind( function() {
						// we will now sorted out this mess!
						var i;
						for (i = 0; i < objectiveCollection.length; i++) {
							var o = objectiveCollection.at(i);
							if (o.get('parent') != null) {
								var parentId = o.get('parent').get('id');
	
								var parentObj = objectiveCollection.get(parentId);
								if (parentObj != null) {
									parentObj.get('children').add(o);
								}
							}
						}
						
						this.collection.add(objectiveCollection.where({parent: this.currentParentObjective}));
						
						var allProposal = new ObjectiveBudgetProposalCollection(); 
						_.each(this.collection.pluck('filterProposals'), function(bpCollection) {
							if(bpCollection.length > 0) {
								bpCollection.each(function(bp) {
									allProposal.add(bp);
								});
							}
						});
						
						var json = this.collection.toJSON();
						json.allProposal = allProposal.toJSON();
					
						this.$el.find('#mainTbl').html(this.mainTblTpl(json));
						
						this.$el.find('#mainTbl tbody td:first-child', this).each(function(i){
					        $(this).html((i+1) + ".");
					    });
					
					}, this)
				});
			}
		},
			
		emptyTbl: function(e) {
			this.$el.find('#mainTbl').empty();
		},

		toggle : function(e) {
			var l = e;
			var id = $(l.target).parents('tr').attr('data-id');
			var showChildren = $(l.target).parents('tr').attr('showChildren');
			if(showChildren == "true") {
				$(l.target).parents('tr').attr('showChildren', "false");
			} else {
				$(l.target).parents('tr').attr('showChildren', "true");
			}
			$(l.target).next('label').find('icon.label-caret').toggleClass("icon-caret-right icon-caret-down");

			var currentTr = $(l.target).parents('tr');
			
			currentTr.nextAll('[parentPath*=".' + id + '."]').each(function(el) {
				var $el = $(this);
				
				if(showChildren == "true") {
					// this is hide
						$el.hide();
				} else {
					// this is show
						$el.show();
				}
				
			}); 
		}

	});

	$(document).ready(function() {

		mainBudgetTypeCollection = new BudgetTypeCollection();
		mainBudgetTypeCollection.url=appUrl("/BudgetType/fiscalYear/" + fiscalYear +"/mainType");
		mainBudgetTypeCollection.fetch();
		
		mainCtrView = new MainCtrView();
		mainCtrView.render();
	});
</script>
