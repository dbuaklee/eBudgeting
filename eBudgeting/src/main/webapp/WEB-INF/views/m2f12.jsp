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
							<td><a href="./${fiscalYear.fiscalYear}/${fiscalYear.id}/" class="nextChildrenLnk">${fiscalYear.fiscalYear} <i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
						</c:forEach>
					</tr>
				</tbody>
			</table>			
		</c:when>
		</c:choose>
		</div>
		
	</div>
</div>

<script id="mainCtrTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="mainTbl" style="margin-bottom:0px; width:900px; table-layout:fixed;">
	<thead>
		<tr>
			<th stlye="width:400px;"><strong>แผนงาน/กิจกรรม ประจำปี {{this.0.fiscalYear}}</strong><br/>- ระดับ{{this.0.type.name}}</th>
			<th width="80">เป้าหมาย</th>
			<th width="80">ขอตั้งปี  {{this.0.fiscalYear}}</th>
			<th width="80">ประมาณการ  {{next this.0.fiscalYear 1}}</th>
			<th width="80">ประมาณการ  {{next this.0.fiscalYear 2}}</th>
			<th width="80">ประมาณการ  {{next this.0.fiscalYear 3}}</th>
		</tr>
	</thead>
</table>
<div style="height: 400px; overflow: auto; width:920px">
<table class="table table-bordered" id="mainTbl" style="width:900px; table-layout:fixed;">
	<tbody>
		
			{{{childrenNodeTpl this 0}}}
		
	</tbody>
</table>
</div>
</script>

<script id="childrenNormalNodeTemplate" type="text/x-handler-template">
		<tr>
			<td stlye="width:400px;"><a href="../{{this.id}}/" class="nextChildrenLnk">{{this.name}} <i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
			<td width="80"></td>
			<td style="text-align:right" width="80">{{#if this.proposals}} {{formatNumber this.proposals.0.amountRequest}} {{else}}0.00{{/if}}</td>
			<td width="80"></td>
			<td width="80"></td>
			<td width="80"></td>
		</tr>
</script>

<script id="childrenNodeTemplate" type="text/x-handler-template">
	<tr data-level="{{this.level}}" data-id="{{this.id}}">
		<td style="padding-left:{{this.padding}}px;width:{{substract 405 this.padding}}px;" class="{{#if this.children}}disable{{/if}}">
			<span>
					{{#if this.children}}
					<input class="checkbox_tree bullet" type="checkbox" id="bullet_{{this.id}}"/>
					<label class="expand" for="bullet_{{this.id}}"><img width=12 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/></label>
					{{else}}					
						<img width=8 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/> - 
					{{/if}}
					<input class="checkbox_tree" type="checkbox" id="item_{{this.id}}"/>
					<label class="main" for="item_{{this.id}}"><b>{{this.type.name}}ที่ {{indexHuman this.index}}</b> {{this.name}}</label>
					{{#unless this.children}}
						<br/><img width=12 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/> &gt; {{this.budgetType.name}}
					{{/unless}}
			</span> 
		</td>
			<td  width="80" class="{{#if this.children}}disable{{/if}}"><span></span>
				 {{#unless this.children}}<br/><a col-id="1" href="#mainfrm" class="btn btn-mini">เพิ่ม/แก้ไข</a>{{/unless}}
			</td>
			<td width="80" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.proposals}}{{this.proposals.0.amountRequest}}{{else}}0.00{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.proposals}}{{this.proposals.0.amountRequest}}{{else}}0.00{{/if}}</a>
				{{/if}}
			</td>

			<td width="80" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>0.00</span>
				{{else}}
					<a href="#" id="editable3-{{this.id}} data-type="text" class="detail">0.00</a>
				{{/if}}
			</td>
			<td width="80" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>0.00</span>
				{{else}}
					<a href="#" id="editable4-{{this.id}} data-type="text" class="detail">0.00</a>
				{{/if}}
			</td>
			<td width="80" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>0.00</span>
				{{else}}
					<a href="#" id="editable5-{{this.id}} data-type="text" class="detail">0.00</a>
				{{/if}}
			</td>

	</tr>
	{{{childrenNodeTpl this.children this.level}}}
</script>

<script id="modalTemplate" type="text/x-handler-template">
	<h4>{{this.budgetType.name}}</h4>
	<select id="strategySlt">
		<option value="0">กรุณาเลือกรายการ</option>
		{{#each this.budgetType.strategies}}
			<option value="{{id}}">{{name}}</option>
		{{/each}}
	</select>

	<form id="input-form">
		
	</form>
</script>

<script id="inputModalTemplate"  type="text/x-handler-template">
	<table class="formula">
	<tr>
	{{#each this}}
		<td>
		{{columnName}} 
		</td>
		{{#if this.$last}}
			<td rowspan="3">
			=
			</td>
		{{else}}
			<td rowspan="3">
			X
			</td>
		{{/if}}
	{{/each}}
	<td>
		คิดเป็น
	</td>
	<td rowspan="3">
		<button class="btn btn-mini saveProposal">บันทึก</button>
	</td>
	</tr>
	<tr>
	{{#each this}}
		<td>
		{{#if isFixed}}
			<input id="formulaColumnId-{{id}}" type="text" class="span1"></input>
		{{else}}
			{{value}}
		{{/if}}
		
		</td>
	{{/each}}
	<td class="totalInputForm">
		
	</td>
	</tr>
	<tr>
	{{#each this}}
		<td>
		{{unitName}}
		</td>
	{{/each}}
	<td>บาท
	</td>
	</tr>
	</table>
</script>

<script id="proposalInputTemplate" type="text/x-handler-template">
<div id="proposalInputCtr">
<br/>
ระบุชื่อรายการ <input type="text"/> <br/>
ระบุจำนวนเงินงบประมาณ <input type="text"/> <br/>

<button class="btn btn-primary">บันทึก</button> <button class="btn btn-primary">ยกเลิก</button> 
</div>
</script>


<script id="mainfrmTemplate" type="text/x-handler-template">
<br/>
<hr/>
<h4>กรุณากรอกข้อมูลงบประมาณ</h4>
{{this.type.name}} - {{this.name}}
<div id="budgetSelectionCtr"></div>
</script>


<script id="selectionTemplate" type="text/x-handler-template">
<select id="budgetType_{{this.id}}">
	<option value="0">กรุณาเลือกรายการ</option>
	{{#each this.children}}
	<option value="{{this.id}}">{{this.name}}</option>
	{{/each}}
</select>
<div></div>
</script>


<script type="text/javascript">
var objectiveId = "${objective.id}";
var fiscalYear = "${fiscalYear}";

var pageUrl = "/page/m2f12/";
var mainTblView  = null;
var objectiveCollection = null;
var budgetTypeSelectionView = null;
var rootCollection;
var l = null;
var e1;

Handlebars.registerHelper('substract', function(a, b) {
	return a - b;
});

Handlebars.registerHelper('childrenNodeTpl', function(children, level) {
	  var out = '';
	  var childNodeTpl = Handlebars.compile($("#childrenNodeTemplate").html());
	  var childNormalNodeTpl = Handlebars.compile($("#childrenNormalNodeTemplate").html());
	  if(level==undefined) level=0;
	  if(children != null && children.length > 0) {
		 
		if(children[0].type.id > 0) {
			children.forEach(function(child){
		  		child["level"] = level+1;
		  		child["padding"] = (parseInt(level)+1) * 12;
		    	out = out + childNodeTpl(child);
		  	});
			
		} else {
			children.forEach(function(child){
				console.log(child);
				out =  out + childNormalNodeTpl(child);
			});
		}
	  }

	  return out;
});

Handlebars.registerHelper('next', function(val, next) {
	return val+next;
});

	var ModalView = Backbone.View.extend({
		initialize: function() {
			
		},
		
		el: "#modal",
		
		modalTemplate: Handlebars.compile($('#modalTemplate').html()),
		inputModalTemplate: Handlebars.compile($('#inputModalTemplate').html()),
		
		events: {
			"change #strategySlt" : "strategySelect",
			"click .saveProposal" : "saveProposal"
		},
		
		strategySelect: function(e) {
			var strategyId= e.target.value;
			var strategies = this.objective.get('budgetType').get('strategies');
			var strategy = strategies.get(strategyId);
			
			this.currentStrategy=strategy;
			
			var columns = 	strategy.get('formulaColumns');
			//now set the last column
			columns.at(columns.length-1).set("$last", true);
			
			// here we'll get the propose column
			
			var html = this.inputModalTemplate(strategy.get('formulaColumns').toJSON());
			// render strategy!
			this.$el.find('#input-form').html(html);
			
		},
		
		saveProposal: function(e) {
			if(this.currentStrategy != null) {
				// check if budgetProposal is null
				var budgetProposal;
				if(this.objective.get('proposals').length == 0) {
					// create new BudgetProposal
					budgetProposal = new BudgetProposal();
					budgetProposal.set('forObjective', {id:this.objective.get('id')});
					budgetProposal.set('budgetType', {id:this.objective.get('budgetType').get('id')});
					
					// now put this proposal into objective;
					this.objective.get('proposals').push(budgetProposal);
				} else {
					budgetProposal = this.objectvie.get('proposal').at(0);
				}
				
				// we will make a new ProposalStrategy
				
				var proposalStrategy = new ProposalStrategy();
				console.log(proposalStrategy);
				e1=proposalStrategy;
				
				proposalStrategy.set('formulaStrategy', {id: this.currentStrategy.get('id')});
				
				// loop through formulaColumns
				var i;
				var calculatedAmount = 0;
				var formulaColumns = this.currentStrategy.get('formulaColumns');
				for(i=0; i< formulaColumns.length; i++) {
					var fc = formulaColumns.at(i); 
					if(fc.get('isFixed')) {
						var requestColumn = new RequestColumn();
						requestColumn.set('amount', this.$el.find('#formulaColumnId-'+fc.get('id')).val());
						requestColumn.set('column', fc);
						requestColumn.set('proposalStrategy', proposalStrategy);
						
						proposalStrategy.get('requestColumns').add(requestColumn);
						proposalStrategy.set('proposal', {id: this.objective.get('proposals').at(0).get('id')});
						
						if(calculatedAmount == 0) {
							calculatedAmount = requestColumn.get('amount');
						} else {
							calculatedAmount = calculatedAmount * requestColumn.get('amount');
						}
						
					} else {
						if(calculatedAmount == 0) {
							calculatedAmount = fc.get('value');
						} else {
							calculatedAmount = calculatedAmount * fc.get('value');
						}
					}
				}
				proposalStrategy.set('totalCalculatedAmount', calculatedAmount);
				proposalStrategy.set('proposal', budgetProposal);
				
				// now ready to post back
				var json = this.objective.get('proposals').at(0).toJSON();
				json.forObjective = {id: json.forObjective.id};
				json.budgetType = {id: json.budgetType.id};

				$.ajax({
					type: 'POST',
					url: appUrl('/BudgetProposal'),
					data: JSON.stringify(json),
					contentType: 'application/json;charset=utf-8',
					dataType: "json",
					success: function(data) {
						console.log(data.id);
						budgetProposal.set('id', data.id);
					
						var json = proposalStrategy.toJSON();
						json.formulaStrategy = {id:json.formulaStrategy.id};
						json.proposal = {id:json.proposal.id};
						var i;
						for(i=0; i<json.requestColumns.length; i++) {
							json.requestColumns[i].column = {id:json.requestColumns[i].column.id};
						}
						
						$.ajax({
							type: 'POST',
							url: appUrl('/ProposalStrategy'),
							data: JSON.stringify(json),
							contentType: 'application/json;charset=utf-8',
							dataType: "json",
							success: function() {
								// do alert?
							}
						});
						
					}
				});
				
				
			}
		},
		
		render: function() {
			if(this.objective != null) {
				var html = this.modalTemplate(this.objective.toJSON());
				this.$el.find('.modal-header span').html(this.objective.get('name'));
				this.$el.find('.modal-body').html(html);
				
				
				
			}
			
			
			this.$el.modal({show: true, backdrop: 'static', keyboard: false});
			return this;
		},
		
		renderWith: function(currentObjective) {
			this.objective = currentObjective;
			this.render();
		}
	});


	var MainTblView = Backbone.View.extend({
		initialize: function(){
		    this.collection.bind('reset', this.render, this);
		    _.bindAll(this, 'detailModal');
		},
		
		el: "#mainCtr",
		mainTblTpl : Handlebars.compile($("#mainCtrTemplate").html()),
		modalView : new ModalView(),
		
		events:  {
			"click input[type=checkbox].bullet" : "toggle",
			"click .detail" : "detailModal"
		},
		
		detailModal: function(e) {
			var currentObjectiveId = $(e.target).parents('tr').attr('data-id');
			var currentObjective = Objective.findOrCreate(currentObjectiveId);
			
			// if this currentObjective has budgetType lockin
			if(currentObjective.get('budgetType') != null) {
				var budgetType = currentObjective.get('budgetType');
				
				var formulaStrategies = new FormulaStrategyCollection;
				
				formulaStrategies.fetch({
					url: appUrl('/FormulaStrategy/search/' + fiscalYear + "/" + budgetType.get('id')),
					success: _.bind(function(data) {
						budgetType.set('strategies', formulaStrategies);
			
						this.modalView.renderWith(currentObjective);
					}, this)
				});		
			}

			
			
		},
		render: function() {
			this.$el.html(this.mainTblTpl(this.collection.toJSON()));
			
		},
		
		toggle: function(e) {
			l=e;
			var clickLevel = $(l.target).parents('tr').attr('data-level');
			$(l.target).next('label').toggleClass("expand collapse");
			
			var currentTr = $(l.target).parents('tr');
			
			currentTr.nextUntil('tr[data-level='+clickLevel+']').toggle();
		}
		
	});
	
	
$(document).ready(function() {
	
	if(objectiveId != null && objectiveId.length >0 ) {
		objectiveCollection = new ObjectiveCollection();
		rootCollection = new ObjectiveCollection();
		
		objectiveCollection.url = appUrl("/ObjectiveWithBudgetProposal/"+ fiscalYear + "/" + objectiveId +"/flatDescendants");
		
		
		mainTblView = new MainTblView({collection: rootCollection});
		
		//load curent objective 
		parentObjective = new Objective({id: objectiveId});
		parentObjective.url=appUrl("/Objective/"+objectiveId);
		parentObjective.fetch({
			success: function() {

				objectiveCollection.fetch({
					success: function() {
						// we will now sorted out this mess!
						var i;
						for(i=0;i<objectiveCollection.length;i++){
							var o = objectiveCollection.at(i);
							if(o.get('parent') != null) {
								var parentId = o.get('parent').get('id');
								if(parentId == objectiveId) {
									rootCollection.add(o);
								}
								
								var parentObj = objectiveCollection.get(parentId);
								if(parentObj != null) {
									parentObj.get('children').add(o);	
								}
								
							}
						}
						
						rootCollection.trigger('reset');
						
					}
				});
			}
		});
	}
	
});
</script>