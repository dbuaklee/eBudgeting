<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>การปรับลดงบประมาณครั้งที่1 ระดับรายการ</h4> 
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
		
		<div id="targetValueModal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<a href="#" class="btn" id="cancelBtn">Close</a> <a href="#"
					class="btn btn-primary" id="saveBtn">Save changes</a>
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
						
							<td><a href="./${fiscalYear.fiscalYear}/${fiscalYear.id}/" class="nextChildrenLnk">${fiscalYear.fiscalYear} <i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
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
<select id="strategySlt" {{#if editStrategy}} disabled {{/if}}>
	<option value="0">กรุณาเลือกรายการ</option>
	{{#each this}}
	<option value="{{id}}" {{#if selected}}selected='selected'{{/if}}>{{name}}</option>
	{{/each}}
</select>
<div><form id="input-form">
		
	</form></div>
</script>

<script id="mainCtrTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="mainTbl" style="margin-bottom:0px; width:720px; table-layout:fixed;">
	<thead>
		<tr>
			<th style="width:410px;"><strong>แผนงาน/กิจกรรม ประจำปี {{this.0.fiscalYear}}</strong><br/>- ระดับ{{this.0.type.name}}</th>
			<th style="width:60px;">เป้าหมายขอตั้ง</th>
			<th style="width:60px;">ปรับลดครั้งที่ 1 (เป้าหมาย)</th>
			<th style="width:120px;">ขอตั้งปี  {{this.0.fiscalYear}}</th>
			<th style="width:120px;">ปรับลดครั้งที่ 1 (เหลือ)</th>
		</tr>
	<tbody>
		<tr>
			<td style="width:410px;text-align:right; padding-right: 20px;"><strong>รวมทั้งสิ้น</strong></td>
			<td style="width:60px;"></td>
			<td style="width:60px;"></td>
			<td style="width:120px;"><strong>{{sumProposal allProposal}}</td>
			<td style="width:120px;"><strong>{{sumAllocatedRecord allAllocationRecordsR1}}</strong></td>
		</tr>
	</tbody>
	</thead>
</table>
<div style="height: 600px; overflow: auto; width:875px">
<table class="table table-bordered" id="mainTbl" style="width:720px; table-layout:fixed;">
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
		</tr>
</script>

<script id="childrenNodeTemplate" type="text/x-handler-template">
	<tr data-level="{{this.level}}" data-id="{{this.id}}"  class="type-{{type.id}}">
		<td  style="width:410px;" class="{{#if this.children}}disable{{/if}}">
			<span  style="padding-left:{{this.padding}}px;width:{{substract 409 this.padding}}px;">
					{{#if this.children}}
					<input class="checkbox_tree bullet" type="checkbox" id="bullet_{{this.id}}"/>
					<label class="expand" for="bullet_{{this.id}}"><img width=12 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/></label>
					{{else}}					
						<img width=8 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/> - 
					{{/if}}
					<input class="checkbox_tree" type="checkbox" id="item_{{this.id}}"/>
					<label class="main" for="item_{{this.id}}"><b>{{this.type.name}}</b> [{{this.code}}] {{this.name}}</label>
					{{#unless this.children}}
						<img width=12 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/>
						<ul>
						{{#each this.sumBudgetTypeProposals}}
							 <li> {{budgetType.name}}</li>
						{{/each}}
						</ul>
					{{/unless}}
			</span> 
		</td>
			<td  style="width:60px;"  class="{{#if this.children}}disable{{/if}}">
				 <span>{{{sumTargetValue this.targetValueAllocationRecordsR1 this.targetValues}}}</span>
				 {{#unless this.children}}<br/>{{/unless}}
			</td>
			<td  style="width:60px;"  class="{{#if this.children}}disable{{/if}}">
				<span>{{#each this.targetValueAllocationRecordsR1}} {{#if ../this.isLeaf}}<a href="#" target-id="{{target.id}}" data-id="{{id}}" class="targetValueModal">{{/if}} 
					{{formatNumber amountAllocated}} {{target.unit.name}} {{#if ../this.isLeaf}}</a>{{/if}} <br/> {{/each}}</span>
				 
			</td>
			<td style="width:120px;"style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.sumBudgetTypeProposals}}{{{sumProposal this.sumBudgetTypeProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<ul class="right-align">
					<li>
					<u>{{#if this.sumBudgetTypeProposals}}{{{sumProposal this.sumBudgetTypeProposals}}}{{/if}}</u>
					</li>
					{{#each this.sumBudgetTypeProposals}}
							 <li> {{{formatNumber amountRequest}}}</li>
					{{/each}}
					</ul>
				{{/if}}
			</td>

			<td style="width:120px;" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.allocationRecordsR1}} {{{sumAllocatedRecord this.allocationRecordsR1}}} {{else}} - {{/if}}</span>
				{{else}}
					<ul class="right-align">					
						<li><u>{{#if this.allocationRecordsR1}}{{{sumAllocatedRecord this.allocationRecordsR1}}}{{else}}-{{/if}}</u>
					
						{{#each this.allocationRecordsR1}}
					 		<li> <a href="#" data-id="{{id}}" class="detail"> {{{formatNumber amountAllocated}}}</a></li>
						{{/each}}
					</ul>
				{{/if}}
			</td>
	</tr>
	{{{childrenNodeTpl this.children this.level}}}
</script>

<script id="modalTemplate" type="text/x-handler-template">
<div><u>รายการขอตั้งประมาณหมวด{{budgetType.name}}</u></div>
	<ul id="budgetProposeLst">	
	{{#each this}}
		<li>{{owner.abbr}} ขอตั้ง = {{formatNumber amountRequest}} บาท </li>
	{{/each}}
	</ul>
</div>
<div id="amountAllocatedForm"></div>

</script>

<script id="targetValueModalTemplate" type="text/x-handler-template">
<form>
	<label>ระบุเป้าหมาย</label>
	<input type="text" value="{{amountAllocated}}"/> {{target.unit.name}}
</form>
</script>

<script id="inputModalTemplate"  type="text/x-handler-template">
	<form>
		เสนอปรับลดครับที่ 1 : <input data-id="{{id}}" type="text" id="amountAllocated" value="{{amountAllocated}}"/> บาท
	</form>
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
var e2;

Handlebars.registerHelper("sumTargetValue", function(allocated, values) {
	retStr = "";
	if(allocated!=null) {
		for(var i=0; i<allocated.length; i++) {
			var targetId = allocated[i].target.id;
			var sum=0;
			
			for(var j=0; j<values.length; j++) {
			
				if(values[j].target.id==targetId) {
					
					sum = sum+ values[j].requestedValue;
				}
			}
			
			retStr += addCommas(sum) + " " + allocated[i].target.unit.name + "</br>";
		}

	
	}
	return retStr;
});

Handlebars.registerHelper("sumProposal", function(proposals) {
	var amount = 0;
	for(var i=0; i<proposals.length; i++ ){
		amount += proposals[i].amountRequest;
	}
	return addCommas(amount);
	
});
Handlebars.registerHelper("sumAllocatedRecord", function(records) {
	var amount = 0;
	for(var i=0; i<records.length; i++ ){
		amount += records[i].amountAllocated;
	}
	return addCommas(amount);
	
});
Handlebars.registerHelper("sumProposalNext1Year", function(proposals) {
	var amount = 0;
	for(var i=0; i<proposals.length; i++ ){
		amount += proposals[i].amountRequestNext1Year;
	}
	return addCommas(amount);
	
});
Handlebars.registerHelper("sumProposalNext2Year", function(proposals) {
	var amount = 0;
	for(var i=0; i<proposals.length; i++ ){
		amount += proposals[i].amountRequestNext2Year;
	}
	return addCommas(amount);
	
});
Handlebars.registerHelper("sumProposalNext3Year", function(proposals) {
	var amount = 0;
	for(var i=0; i<proposals.length; i++ ){
		amount += proposals[i].amountRequestNext3Year;
	}
	return addCommas(amount);
	
});

Handlebars.registerHelper("sumProposalStrategy", function(proposalsStrategies) {
	var amount = 0;
	for(var i=0; i<proposalsStrategies.length; i++ ){
		amount += proposalsStrategies[i].totalCalculatedAmount;
	}
	return addCommas(amount);
	
});

Handlebars.registerHelper("formulaLine", function(strategy){
	
	var s = "";
	
	if(strategy.formulaStrategy != null) {
		var formulaColumns = strategy.formulaStrategy.formulaColumns;
		for(var i=0; i < formulaColumns.length; i++) {
			
			if(i>0) { 
				s = s + " X "; 
			}
			
			s = s + formulaColumns[i].columnName;
			if(formulaColumns[i].isFixed) {
				// now we'll go through requestColumns
				var j;
				for(j=0; j<strategy.requestColumns.length;j++) {
					if(strategy.requestColumns[j].column == formulaColumns[i].id) {
						s = s + "(" + addCommas(strategy.requestColumns[j].amount) + formulaColumns[i].unitName  + ")";
					}
				}
				
			} else {
				s = s + "("+ addCommas(formulaColumns[i].value) + " " + formulaColumns[i].unitName  + ")";
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
		modalFormTemplate: Handlebars.compile($('#inputModalTemplate').html()),
		
		events: {
			"click #cancelBtn" : "cancelModal",
			"click #saveBtn" : "saveModal"
		},
		
		cancelModal: function(e) {
			  window.location.reload();
		},
		
		saveModal: function(e) {
			var amountAllocated = $('#amountAllocated').val();
			var allocationRecordId = $('#amountAllocated').attr('data-id');
			
			var record = AllocationRecord.findOrCreate(allocationRecordId);
			
			var newAmount = parseInt(amountAllocated);
			
			record.set('amountAllocated', newAmount);
			
			if(record == null) {
				// Post a new allocation Record
				record = new AllocationRecord();
				record.set('amountAllocated', amountAllocated);
				record.set('budgetType', budgetType);
				record.set('forObjective', this.objectvie);
			} else {
			
				// now try to save this..
				$.ajax({
					type: 'PUT',
					url: appUrl('/AllocationRecord/'+record.get('id')),
					contentType: 'application/json;charset=utf-8',
					dataType: "json",
					data: JSON.stringify(record.toJSON()),
					success: function() {
						window.location.reload();
					}
				});
			}
			
		},
		
		
		render: function() {
			if(this.objective != null) {
				
				this.$el.find('.modal-header span').html(this.objective.get('name'));
				
				var json =this.budgetProposalCollection.toJSON();
				json.budgetType = this.budgetType.toJSON();
				
				
				var html = this.modalTemplate(json);
				this.$el.find('.modal-body').html(html);
				
				html = this.modalFormTemplate(this.allocationRecord.toJSON());
				this.$el.find('.modal-body').append(html);
							
			}
			
			
			this.$el.modal({show: true, backdrop: 'static', keyboard: false});
			return this;
		},
		
		renderWith: function(currentObjective, currentAllocationRecord, currentBudgetType, budgetProposalCollection) {
			this.objective = currentObjective;
			this.allocationRecord = currentAllocationRecord;
			this.budgetType = currentBudgetType;
			this.budgetProposalCollection = budgetProposalCollection;
			this.render();
		}
	});

	var TargetValueModalView=Backbone.View.extend({
		initialize: function() {
			
		},
		
		el: "#targetValueModal",
		
		events : {
			"click #saveBtn" : "saveTargetValue",
			"click #cancelBtn" : "cancelTargetValue",
		},
		
		targetValueModalTpl : Handlebars.compile($("#targetValueModalTemplate").html()),
		render: function() {
			
			
			this.$el.find('.modal-header span').html(this.objectiveTarget.get('name'));
			
			var html = this.targetValueModalTpl(this.targetValue.toJSON());
			this.$el.find('.modal-body').html(html);

			
			
			this.$el.modal({
				show : true,
				backdrop : 'static',
				keyboard : false
			});
			return this;
		},
		cancelTargetValue: function() {
			this.$el.modal('hide');
		},
		saveTargetValue: function() {
			// we'll try to save
			var input = parseInt(this.$el.find('input').val());
			
			this.targetValue.save({
				 amountAllocated: input
			}, {
				success: function(){
					window.location.reload();
				}
			});
			
			
			
		},
		
		renderWith: function(objective, targetId, valueId) {
			this.objective = objective;
			this.objectiveTarget=ObjectiveTarget.findOrCreate(targetId);
			this.targetValue=TargetValueAllocationRecord.findOrCreate(valueId);
			if(this.targetValue == null) {
				this.targetValue = new TargetValue();
				this.targetValue.set('forObjective', objective);
				this.targetValue.set('target', this.objectiveTarget);
			}
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
		targetValueModalView : new TargetValueModalView(),
		
		events:  {
			"click input[type=checkbox].bullet" : "toggle",
			"click .detail" : "detailModal",
			"click .targetValueModal" : "targetValueModal"
		},
		
		targetValueModal: function(e) {
			var currentObjectiveId = $(e.target).parents('tr').attr('data-id');
			var currentObjective = Objective.findOrCreate(currentObjectiveId);
			
			var targetId = $(e.target).attr('target-id');
			var valueId = $(e.target).attr('data-id');
			
			this.targetValueModalView.renderWith(currentObjective, targetId, valueId);
		},
		
		detailModal: function(e) {
			var currentObjectiveId = $(e.target).parents('tr').attr('data-id');
			var currentObjective = Objective.findOrCreate(currentObjectiveId);
			
			var currentAllocationRecordId = $(e.target).attr('data-id');
			var currentAllocationRecord = AllocationRecord.findOrCreate(currentAllocationRecordId);
			
			var currentBudgetTypeId = currentAllocationRecord.get('budgetType').get('id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			
			var budgetProposalCollection = new BudgetProposalCollection();
			budgetProposalCollection.fetch({
				url: appUrl('/BudgetProposal/find/' + fiscalYear +'/'+ currentObjective.get('id') + '/' + currentBudgetTypeId),
				success: _.bind(function() {
					this.modalView.renderWith(currentObjective,  currentAllocationRecord, currentBudgetType, budgetProposalCollection);		
				},this)
			});
			
			
		},
		render: function() {
			var json= this.collection.toJSON();
			
			var allProposal = new BudgetProposalCollection(); 
			_.each(rootCollection.pluck('sumBudgetTypeProposals'), function(bpCollection) {
				if(bpCollection.length > 0) {
					bpCollection.each(function(bp) {
						allProposal.add(bp);
					});
				}
			});
			
			
			var allAllocationRecordsR1 = new AllocationRecordCollection(); 
			_.each(rootCollection.pluck('allocationRecordsR1'), function(ar1Collection) {
				if(ar1Collection.length > 0) {
					ar1Collection.each(function(ar) {
						ar1Collection.add(ar);
					});
				}
			});
			
			json.allProposal = allProposal.toJSON();
			json.allAllocationRecordsR1 = allAllocationRecordsR1.toJSON();
			
			this.$el.html(this.mainTblTpl(json));
			
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
		
		objectiveCollection.url = appUrl("/ObjectiveWithBudgetProposalAndAllocation/"+ fiscalYear + "/" + objectiveId +"/flatDescendants");
		
		
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
								

								var records = o.get('allocationRecords');
								
								o.set('allocationRecordsR1', records.where({index: 0}));
								o.set('allocationRecordsR2', records.where({index: 1}));
								o.set('allocationRecordsR3', records.where({index: 2}));
								
								var tvRecords = o.get('targetValueAllocationRecords');
								o.set('targetValueAllocationRecordsR1', tvRecords.where({index: 0}));
								o.set('targetValueAllocationRecordsR2', tvRecords.where({index: 1}));
								o.set('targetValueAllocationRecordsR3', tvRecords.where({index: 2}));
								
								
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