<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>การปรับลดงบประมาณครั้งที่1 ระดับรายการ</h4> 
</div>

<div class="row">
	<div class="span11">
		
		<div id="detailModal" class="modal wideModal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" id="cancelBtn">กลับหน้าหลัก</a> 
				
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

<script id="mainCtrTemplate" type="text/x-handler-template">
<div id="mainSelection">
</div>
<div id="mainTbl" class="x-border-box">
</div>
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

<script id="mainTblTemplate" type="text/x-handler-template">
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

<script id="detailAllocationRecordTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="detailAllocationRecordTbl" data-id="{{id}}">
	<thead>
		<tr>
			<td>รายการงบประมาณ</td>
			<td>ปรับลดครั้งที่1</td>
		</tr>
	</thead>
	<tbody>
		{{#each allocationRecordStrategies}}
		<tr>
			{{#if strategy}}
			<td><a href="#" data-allocationStrategyId="{{id}}" class="detailAllocationStrategy">{{strategy.name}}</a></td>
			{{else}}
			<td><a href="#" data-allocationStrategyId="{{id}}" class="detailAllocationStrategy">default</a></td>
			{{/if}}
			<td>{{formatNumber totalCalculatedAmount}}</td>
		</tr>
		{{/each}}
	</tbody>
</table>
</script>

<script id="detailAllocationRecordBasicTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="detailAllocationRecordTbl" data-id="{{id}}">
	<thead>
		<tr>
			<td>รายการงบประมาณ</td>
			<td>ปรับลดครั้งที่1</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td><a href="#" data-allocationId="{{id}}" class="detailBasicAllocation">{{budgetType.name}}</a></td>
			<td>{{formatNumber amountAllocated}}</td>
		</tr>
	</tbody>
</table>
</script>

<script id="detailAllocationRecordStrategyTemplate" type="text/x-handler-template">
	<div id="allocRecStrgy" data-id="{{allocStrategyId}}">
				รายการ: <strong> {{type.name}} / {{name}} </strong>
	</div>
	<div id="formulaBox">
		<div>
			<div style="height:35px;margin-bottom:10px;">
				เรื่อง: 
			</div>
			<div style="height:35px;">
				จำนวน:
			</div>
		</div>
		<div>
			<div style="height:35px;margin-bottom:10px;">
				<input type="text" style="width:70px;" value="ราคา (บาท)" disabled="disabled"/>
			</div>
			<div style="height:35px;">
				<input type="text" id="standardPriceTxt" style="width:70px;" disabled="disabled" value="{{allocationStandardPriceMap.0.standardPrice}}"></input> &times;
			</div>
		</div>
		{{#each formulaColumns}}
		<div>
			<div style="height:35px;margin-bottom:10px;">
				<input type="text" style="width:70px;" value="{{unitName}}" disabled="disabled"/>
			</div>
			<div style="height:35px;">
				<input type="text" class="formulaColumnInput" id="formulaColumnId-{{id}}" style="width:70px;"  value="{{allocatedFormulaColumnValueMap.0.allocatedValue}}"></input> {{#if $last}}={{else}}&times;{{/if}}
			</div>
		</div>
		{{/each}}
		<div>
			<div style="height:35px;margin-bottom:5px;padding-top:5px;text-align:center;padding-right:30px;">
				
			</div>
			<div style="height:35px;" id="totalInputForm">
				<div class="input-append"><input type="text" id="totalInputTxt" style="width:120px;"  disabled="disabled" value="{{total}}"></input><span class="add-on">บาท</span></div>
			</div>
		</div>
	</div>
	
<div class="clearfix"></div>
{{#if budgetTypeUnitName}}
<div id="formulaBox">
	<div>
		<div style="vertical-align:middle"> <strong>ระบุค่าเป้าหมาย:</strong></div>
	</div>
	<div style="margin: 0px 8px;">
		<div class="input-append"><input style="width:80px;" type="text" id="targetValue" data-unitId="{{targetUnitId}}" value="{{targetValue}}"/><span class="add-on">{{budgetTypeUnitName}}</span></div>
	</div>
</div>
{{/if}}
<div class="clearfix"></div>
</script>
<script id="detailViewTableTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="detailViewTbl">
	<thead>
		<tr>
			<td>รายการงบประมาณ</td>
			<td>ขอตั้ง</td>
			<td>ปรับลดครั้งที่1</td>
		</tr>
	</thead>
	<tbody>
		{{#each sumBudgetTypeProposals}}
		<tr>
			<td><a href="#" data-allocationId={{allocationId}} class="detailAllocation">{{budgetType.name}}</a></td>
			<td>{{formatNumber amountRequest}}</td>
			<td>{{formatNumber amountAllocated}}</td>
		</tr>
		{{/each}}
	</tbody>
</table>
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

<script id="detailModalTemplate" type="text/x-handler-template">
<div><u>รายการขอตั้งงบประมาณของกิจกรรม</u></div>
<div id="detailModalDiv"></div>
</script>

<script id="detailModalMainFooterTemplate"  type="text/x-handler-template">
<a href="#" class="btn" id="cancelBtn">กลับหน้าหลัก</a> 
</script>

<script id="detailAllocationRecordFooterTemplate"  type="text/x-handler-template">
	 <button class="pull-left btn backToProposal">ย้อนกลับ</button>
<a href="#" class="btn" id="cancelBtn">กลับหน้าหลัก</a> 
</script>

<script id="detailAllocationBasicFooterTemplate"  type="text/x-handler-template">
	<button class="pull-left btn btn-primary updateAllocRec">บันทึก</button> 
	 <button class="pull-left btn backToProposal">ย้อนกลับ</button>
<a href="#" class="btn" id="cancelBtn">กลับหน้าหลัก</a> 
</script>
<script id="detailAllocationBasicTemplate" type="text/x-handler-template">
	<div id="formulaBox">
		<div id="allocRecId" data-id="{{id}}">
			<div style="height:35px;margin-bottom:10px;">
				<strong>รายการ:</strong> 
			</div>
			<div style="height:35px;">
				<strong>ระบุงบประมาณ:</strong>
			</div>
		</div>
		<div id="allocRecStrgy" data-id="{{id}}">
			<div style="height:35px;margin-bottom:5px;padding-top:5px;">
				<strong>{{budgetType.name}}</strong>
			</div>
			<div style="height:35px;" id="totalInputForm">
				<div class="input-append"><input type="text" id="totalInputTxt" style="width:120px;" value="{{amountAllocated}}"></input><span class="add-on">บาท</span></div>
			</div>
		</div>
	</div>
</script>

<script id="detailAllocationRecordStrategyFooterTemplate"  type="text/x-handler-template">
	<button class="pull-left btn btn-primary updateAllocRecStrgy">บันทึก</button> 
	 <button class="pull-left btn backToProposal">ย้อนกลับ</button>
<a href="#" class="btn" id="cancelBtn">กลับหน้าหลัก</a> 
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

<script src="<c:url value='/resources/js/pages/m63f02.js'/>"></script>

<script type="text/javascript">
var objectiveId = "${objective.id}";
var fiscalYear = "${fiscalYear}";

var pageUrl = "/page/m63f02/";
var mainTblView  = null;
var mainCtrView = null;
var objectiveCollection = null;
var budgetTypeSelectionView = null;
var rootCollection;
var l = null;
var e1;
var e2;
var treeStore;

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


$(document).ready(function() {
	Ext.QuickTips.init();

	Ext.define('data.Model.Objective', {
        extend: 'Ext.data.Model',
        fields: [{
        	name: 'name', type: 'string'
        }, {
        	name: 'code', type: 'string'
        }, {
        	name: 'codeAndName', 
            convert: function(v, rec) {
            	return '['+ rec.data.code + '] ' + rec.data.name;
            }
		},{
			name: 'proposals', mapping: 'proposals'
		},{
			name: 'allocationRecordsR1', mapping: 'allocationRecordsR1'
		},{
			name: 'sumProposals', 
            convert: function(v, rec) {
            	var sum = 0;
            	_.forEach(rec.data.proposals, function(proposal) {
            		sum += proposal.amountRequest;
            		BudgetType.findOrCreate(proposal.budgetType);
            		Organization.findOrCreate(proposal.owner);
            	});
            	return sum;		
            }
        },{
			name: 'sumProposalsNext1year', 
            convert: function(v, rec) {
            	var sum = 0;
            	_.forEach(rec.data.proposals, function(proposal) {
            		if(!isNaN(proposal.amountRequestNext1Year)){
            			sum += proposal.amountRequestNext1Year;
            		}
            	});
            	return sum;		
            }
        },{
			name: 'sumProposalsNext2year', 
            convert: function(v, rec) {
            	var sum = 0;
            	_.forEach(rec.data.proposals, function(proposal) {
            		if(!isNaN(proposal.amountRequestNext2Year)){
            			sum += proposal.amountRequestNext2Year;
            		}
            	});
            	return sum;		
            }
        },{
			name: 'sumProposalsNext3year', 
            convert: function(v, rec) {
            	var sum = 0;
            	_.forEach(rec.data.proposals, function(proposal) {
            		if(!isNaN(proposal.amountRequestNext3Year)){
            			sum += proposal.amountRequestNext3Year;
            		}
            	});
            	return sum;		
            }
        }, {
        	name: 'sumAllocationR1',
        	convert: function(v, rec) {
        		var sum=0;
        		_.forEach(rec.data.allocationRecordsR1, function(record) {
        			if(record.index == 0) {        				
        				sum += record.amountAllocated;
        			}	
        		});
        		return sum;
        	}
        }]
    });
	
    
	mainCtrView = new MainCtrView();
	mainCtrView.render();
	
	
	/* 
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
	
	*/
	
});
</script>