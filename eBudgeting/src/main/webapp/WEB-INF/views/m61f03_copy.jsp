<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>การบันทึกงบประมาณ ระดับกิจกรรมหลัก <c:if test="${not empty fiscalYear}">ปีงบประมาณ ${fiscalYear}</c:if></h4> 
	<h4>หน่วยงาน: <sec:authentication property="principal.workAt.name"/></h4>
</div>

<div class="row">
	<div class="span11">
		
		<div id="modal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<a href="#" class="btn" id="saveBtn">บันทึกข้อมูล</a> 
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

<script id="loadingTemplate" type="text/x-handler-template">
	<div>Loading <img src="/eBudgeting/resources/graphics/spinner_bar.gif"/></div>
</script>

<script id="mainCtrBodyTemplate" type="text/x-handler-template">
<div id="form">
	<form id="objectiveSltFrm">
		<label>กรุณาเลือกกิจกรรมหลัก </label>
		<select class="span4 objectiveSlt">
			<option value="0">กรุณาเลือก ... </option>
			{{#each this}}
			<option value="{{id}}">[{{code}}] {{name}}</option>
			{{/each}}
		</select>
	</form>
</div>
<div id="resultTable">
</div>
</script>


<script id="resultTableTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="headerTbl" style="margin-bottom:0px; width:720px; table-layout:fixed;">
	<thead>
		<tr>
			<th style="width:20px;">#</th>
			<th style="width:260px;"><strong>แผนงาน/กิจกรรม ประจำปี {{this.0.fiscalYear}}</strong><br/>- ระดับ{{this.0.type.name}}</th>
			<th style="width:60px;">เป้าหมาย</th>
			<th style="width:60px;">หน่วยนับ</th>
			<th style="width:80px;">ขอตั้งปี  {{this.0.fiscalYear}}</th>
			<th style="width:80px;">ประมาณการ  {{next this.0.fiscalYear 1}}</th>
			<th style="width:80px;">ประมาณการ  {{next this.0.fiscalYear 2}}</th>
			<th style="width:80px;">ประมาณการ  {{next this.0.fiscalYear 3}}</th>
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
		</tr>
	</tbody>
</table>
<div style="height: 600px; overflow: auto; width:875px">
<table class="table table-bordered" id="mainTbl" style="width:720px; table-layout:fixed;">
	<tbody>
		
			{{{childrenNodeTpl this 0}}}
		
	</tbody>
</table>
</div>
</script>

<script id="childrenNodeTemplate" type="text/x-handler-template">
	<tr data-level="{{this.level}}" data-id="{{this.id}}" class="type-{{type.id}}" showChildren="true" parentPath="{{this.parentPath}}">
		<td style="width:20px;"></td>
		<td style="width:260px;" class="{{#if this.children}}disable{{/if}}">
			<div class="pull-left" style="margin-left:{{this.padding}}px; width:18px;">
					{{#if this.children}}
					<input class="checkbox_tree bullet" type="checkbox" id="bullet_{{this.id}}"/>
					<label class="expand" for="bullet_{{this.id}}"><icon class="label-caret icon-caret-down"></i></label>
					{{else}}					
						<icon class="icon-file-alt"></i>
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
		<td  style="width:60px;" class="{{#if this.children}}disable{{/if}}">
			<span>
				{{#each filterTargetValues}}{{#if ../this.isLeaf}}<a href="#" data-id="{{id}}" target-id="{{target.id}}" class="targetValueModal">{{/if}}
				{{#if requestedValue}}{{formatNumber requestedValue}}{{else}}{{#if ../../this.isLeaf}}เพิ่ม{{else}}-{{/if}}{{/if}}
				{{#if ../this.isLeaf}}</a>{{/if}}<br/>{{/each}}
			</span>
		</td>
		<td  style="width:60px; text-align:center" class="{{#if this.children}}disable{{/if}}">
			<span>
				<ul  style="list-style:none; margin: 0px;">{{#each filterTargetValues}}<li style="list-style:none; padding: 0px;">{{target.unit.name}} ({{#if target.isSumable}}นับ{{else}}ไม่นับ{{/if}})</li>{{/each}}</ul>
			</span>
		</td>
		<td style="width:80px;" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposal this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposal this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
		</td>

		<td style="width:80px;" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposalNext1Year this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposalNext1Year this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
		</td>
		<td style="width:80px;" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposalNext2Year this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposalNext2Year this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
		</td>
		<td style="width:80px;" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposalNext3Year this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposalNext3Year this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
		</td>
	</tr>
	{{{childrenNodeTpl this.children this.level}}}  
</script>

<script id="modalBodyTemplate" type="text/x-handlebars-template">
<form>
	ปี {{fiscalYear}} : <input type="text" id="amountRequest" value="{{amountRequest}}"/> บาท <br/>
	ประมาณการปี {{next1Year}}: <input type="text" id="amountRequestNext1Year" value="{{amountRequestNext1Year}}"/> บาท <br/>
	ประมาณการปี {{next2Year}}: <input type="text" id="amountRequestNext2Year" value="{{amountRequestNext2Year}}"/> บาท <br/>
	ประมาณการปี {{next3Year}}: <input type="text" id="amountRequestNext3Year" value="{{amountRequestNext3Year}}"/> บาท <br/>
</form>
</script>

<script type="text/javascript">
	var objectiveId = "${objective.id}";
	var fiscalYear = "${fiscalYear}";

	var pageUrl = "/page/m61f03/";
	var mainTblView = null;
	var objectiveCollection = new ObjectiveCollection();
	
	var mainBudgetType = new BudgetTypeCollection();

	
	
	var l = null;
	var e1;
	var e2;
	
	
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
					child["padding"] = (parseInt(level)) * 15;
					child["nameWidth"] = 260 - 18 - child["padding"];
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

	
	var ModalView = Backbone.View.extend({
		modalBodyTemplate: Handlebars.compile($("#modalBodyTemplate").html()),
		
		initialize: function(options) {
			
		},
		
		el: "#modal",
		
		events: {
			"click #cancelBtn" : "close",
			"click #saveBtn" : "save"
		},
		
		close : function() {
			this.$el.modal('hide');
		},
		save : function(e) {
			if(this.objectiveBudgetProposal == null) {
				this.objectiveBudgetProposal = new ObjectiveBudgetProposal;
				this.objectiveBudgetProposal.set('budgetType', this.budgetType);
				this.objectiveBudgetProposal.set('forObjective', this.objective);
			}
			
			this.objectiveBudgetProposal.save({
				amountRequest: this.$el.find('#amountRequest').val(),
				amountRequestNext1Year: this.$el.find('#amountRequestNext1Year').val(),
				amountRequestNext2Year: this.$el.find('#amountRequestNext2Year').val(),
				amountRequestNext3Year: this.$el.find('#amountRequestNext3Year').val(),
			}, {
				success: _.bind(function() {
					if(mainTblView.objectiveBudgetProposalCollection.get(this.objectiveBudgetProposal.get('id')) == null) {
						mainTblView.objectiveBudgetProposalCollection.add(this.objectiveBudgetProposal);
					}
					
					// rerender the td cell
					mainTblView.renderResultTable();
					
					this.$el.modal('hide');
				}, this)
			});
		},
		render: function() {
			
			this.$el.find('.modal-header span').html("บันทึกงบประมาณ " + this.budgetType.get('name'));
			
			var json = {};
			if(this.objectiveBudgetProposal != null) {
				json = this.objectiveBudgetProposal.toJSON();	
			}
			
			json.fiscalYear = fiscalYear;
			json.next1Year = parseInt(fiscalYear)+1;
			json.next2Year = parseInt(fiscalYear)+2;
			json.next3Year = parseInt(fiscalYear)+3;
			 
			var html = this.modalBodyTemplate(json);
			this.$el.find('.modal-body').html(html);
			
			
			this.$el.modal({show: true, backdrop: 'static', keyboard: false});
			return this;
			
		}
	});

	var MainTblView = Backbone.View.extend({
		initialize : function() {

		},
		modal : new ModalView(),
		mainCtrBodyTemplate : Handlebars.compile($("#mainCtrBodyTemplate").html()),
		resultTableTemplate : Handlebars.compile($("#resultTableTemplate").html()),

		el : "#mainCtr",
		
		render: function() {
			var json=objectiveCollection.toJSON();
			
			var html = this.mainCtrBodyTemplate(json);
			this.$el.html(html); 
			
		},
		
		events : {
			"change .objectiveSlt" : "changeObjective",
			"click .editBudget" : "clickEditBudget"
		},
		
		clickEditBudget: function(e) {
			var objectiveBudgetId = $(e.target).parents('tr').attr('data-id');
			var budgetTypeId = $(e.target).parents('td').attr('data-id');
			
			this.modal.budgetType = BudgetType.findOrCreate(budgetTypeId);
			this.modal.objective = this.objective;
			
			var obp = null;
			if(objectiveBudgetId.length > 0) {
				obp = ObjectiveBudgetProposal.findOrCreate(objectiveBudgetId);
				this.modal.objectiveBudgetProposal = obp;
			} else {
				this.modal.objectiveBudgetProposal = null;
			}
			
			this.modal.render();
			
		},
		
		changeObjective: function(e) {
			var targetObjectiveId = $(e.target).val();
			if(targetObjectiveId == 0) {
				return alert("กรุณาเลือกกิจกรรมหลักให้ถูกต้อง");
			}
			
			this.objective = Objective.findOrCreate(targetObjectiveId);
			
			
			// now we should load the table of this objective 
			this.objectiveCollection = new ObjectiveCollection();
			this.objectiveCollection.url = appUrl("/ObjectiveWithObjectiveBudgetProposal/" + fiscalYear+ "/" + this.objective.get('id') + "/flatDescendants");
			this.objectiveCollection.fetch({
				success: function() {
					this.renderTable();
				}
			});
			
		},
		
		renderTable: function() {
			
		},
		
		renderResultTable : function() {
			var json = mainBudgetType.toJSON();
			
			var sumAmountRequest = 0;
			var sumAmountRequestNext1Year = 0;
			var sumAmountRequestNext2Year = 0;
			var sumAmountRequestNext3Year = 0;
			
			for(var i=0; i<this.objectiveBudgetProposalCollection.length; i++) {
				var amountRequest = this.objectiveBudgetProposalCollection.at(i).get('amountRequest');
				var budgetType = this.objectiveBudgetProposalCollection.at(i).get('budgetType');
				
				
				var index = mainBudgetType.indexOf(budgetType);
				
				json[index].amountRequest = amountRequest;
				sumAmountRequest += amountRequest;
				
				json[index].amountRequestNext1Year = this.objectiveBudgetProposalCollection.at(i).get('amountRequestNext1Year');
				sumAmountRequestNext1Year += this.objectiveBudgetProposalCollection.at(i).get('amountRequestNext1Year');
				
				json[index].amountRequestNext2Year = this.objectiveBudgetProposalCollection.at(i).get('amountRequestNext2Year');
				sumAmountRequestNext2Year += this.objectiveBudgetProposalCollection.at(i).get('amountRequestNext2Year');
				
				json[index].amountRequestNext3Year = this.objectiveBudgetProposalCollection.at(i).get('amountRequestNext3Year');
				sumAmountRequestNext3Year += this.objectiveBudgetProposalCollection.at(i).get('amountRequestNext3Year');
				
				json[index].objectiveBudgetId =  this.objectiveBudgetProposalCollection.at(i).get('id');
				
			}
			
			json.fiscalYear = fiscalYear;
			json.next1Year = parseInt(fiscalYear)+1;
			json.next2Year = parseInt(fiscalYear)+2;
			json.next3Year = parseInt(fiscalYear)+3;
			
			json.sumAmountRequest = sumAmountRequest;
			json.sumAmountRequestNext1Year = sumAmountRequestNext1Year;
			json.sumAmountRequestNext2Year = sumAmountRequestNext2Year;
			json.sumAmountRequestNext3Year = sumAmountRequestNext3Year;
			
			var html = this.resultTableTemplate(json);
			this.$el.find('#resultTable').html(html);
			

		}
		
		
	});

	$(document).ready(function() {

		if(fiscalYear.length > 0) {
		
			mainBudgetType.fetch({
				url: appUrl('/BudgetType/fiscalYear/' +fiscalYear+ '/mainType')
			});
			
			objectiveCollection.fetch({
				url: appUrl('/Objective/' + fiscalYear + '/type/' + 103),
				success: function() {
					mainTblView = new MainTblView();
					mainTblView.render();
				}
			});

		}

	});
</script>
