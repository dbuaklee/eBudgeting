<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="hero-unit white">

<div id="headLine">
	<c:if test='${not empty readOnly}'>
		<div class="alert">
    			<strong>Sign Off แล้ว</strong> สามารถเปิดดูข้อมูลได้อย่างเดียว ไม่สามารถแก้ไขเพิ่มเติมได้ 
    		</div>
	</c:if><h4>การบันทึกงบประมาณ ระดับรายการ</h4>
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
<div class="menu">{{#unless readOnly}}<button id="addBudget" class="btn">เพื่มรายการงบประมาณ</button> <button class="btn">บันทึกข้อมูลโครงการ</button>{{/unless}}</div>
<div><u>รายการงบประมาณลงข้อมูลไว้แล้ว</u></div>
	{{{listProposalStrategies filterProposals readOnly}}}
</div>
</script>

<script id="inputEditProposalTemplate" type="text/x-handler-template">
<div id="inputAll" class="span10">
<form id="input-form">
		
</form>
<button class="btn btn-mini btn-primary updateProposal">บันทึก</button>  <button class="btn btn-mini backToProposal">ย้อนกลับ</button>
</div>
</script>

<script id="inputAllDivTemplate" type="text/x-handler-template">
<div id="inputAll">
กรอกข้อมูลใหม่
<div class="row">
<div class="span2" id="budgetTypeSelectionDivL1">หมวดหลัก<div></div></div>
<div class="span2" id="budgetTypeSelectionDivL2">หมวดย่อย<div></div></div>
<div class="span2" id="budgetTypeSelectionDivL3">รายการหลัก<div></div></div>
<div class="span2" id="budgetTypeSelectionDivL4">รายการ<div></div></div>
<div class="span2" id="strategySelectionDiv">รายการย่อย<div></div>
</div>
<div id="inputDiv" class="span10">
	<form id="input-form" style="margin-bottom:0px;">
		
	</form>
</div>
</div>
<button class="btn btn-mini btn-primary saveProposal">บันทึก</button> <button class="btn btn-mini backToProposal">ย้อนกลับ</button>
</script>

<script id="targetValueModalTemplate" type="text/x-handler-template">
<form>
	<label>ระบุค่าเป้าหมาย</label>
	<input type="text" value="{{value}}"/> {{target.unit.name}}
</form>
</script>

<script id="defaultInputTemplate" type="text/x-handler-template">
	<div id="formulaBox">
		<div id="proposalStrategyId" data-id="{{proposalStrategyId}}">
			<div style="height:35px;margin-bottom:10px;">
				รายการ: 
			</div>
			<div style="height:35px;">
				จำนวนขอตั้ง:
			</div>
		</div>
		<div>
			<div style="height:35px;margin-bottom:5px;padding-top:5px;">
				<strong>{{budgetTypeName}}</strong>
			</div>
			<div style="height:35px;" id="totalInputForm">
				<div class="input-append"><input type="text" id="totalInputTxt" style="width:120px;" value="{{totalCalculatedAmount}}"></input><span class="add-on">บาท</span></div>
			</div>
		</div>
	</div>
	
<div class="clearfix"></div>
<div id="formulaBox">
	<div>
		<div style="margin-top:11px;"> <button class="btn copytoNextYear">คัดลอกไปประมาณการ 3 ปี</button></div>
	</div>
	<div style="margin: 0px 8px;">
		<div><b>ปี {{next1Year}}:</b></div><div class="input-append"><input style="width:120px;" type="text" id="amountRequestNext1Year" value="{{next1YearValue}}"/><span class="add-on">บาท</span></div>
	</div>
	<div style="margin: 0px 8px;">
		<div><b>ปี {{next2Year}}:</b></div><div class="input-append"><input style="width:120px;" type="text" id="amountRequestNext2Year" value="{{next2YearValue}}"/><span class="add-on">บาท</span></div>
	</div>
	<div style="margin: 0px 8px;">
		<div><b>ปี {{next3Year}}:</b></div><div class="input-append"><input style="width:120px;" type="text" id="amountRequestNext3Year" value="{{next3YearValue}}"/><span class="add-on">บาท</span></div>
	</div>
</div>
<div class="clearfix"></div>
{{#if budgetTypeUnitName}}
<div id="formulaBox">
	<div>
		<div style="vertical-align:middle"> <strong>ระบุค่าเป้าหมาย:</strong></div>
	</div>
	<div style="margin: 0px 8px;">
		<div class="input-append"><input style="width:80px;" type="text" id="targetValue" value="{{targetValue}}" data-unitId="{{targetUnitId}}"/><span class="add-on">{{budgetTypeUnitName}}</span></div>
	</div>
</div>
{{/if}}
<div class="clearfix"></div>
</script>


<script id="inputModalTemplate" type="text/x-handler-template">
	<div id="proposalStrategyId" data-id="{{proposalStrategyId}}">
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
				<input type="text" id="standardPriceTxt" style="width:70px;" disabled="disabled" value="{{standardPrice}}"></input> &times;
			</div>
		</div>
		{{#each formulaColumns}}
		<div>
			<div style="height:35px;margin-bottom:10px;">
				<input type="text" style="width:70px;" value="{{unitName}}" disabled="disabled"/>
			</div>
			<div style="height:35px;">
				<input type="text" class="formulaColumnInput" id="formulaColumnId-{{id}}" style="width:70px;"  value="{{value}}"></input> {{#if $last}}={{else}}&times;{{/if}}
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
<div id="formulaBox">
	<div>
		<div style="margin-top:11px;"> <button class="btn copytoNextYear">คัดลอกไปประมาณการ 3 ปี</button></div>
	</div>
	<div style="margin: 0px 8px;">
		<div><b>ปี {{next1Year}}:</b></div><div class="input-append"><input style="width:120px;" type="text" id="amountRequestNext1Year" value="{{next1YearValue}}"/><span class="add-on">บาท</span></div>
	</div>
	<div style="margin: 0px 8px;">
		<div><b>ปี {{next2Year}}:</b></div><div class="input-append"><input style="width:120px;" type="text" id="amountRequestNext2Year" value="{{next2YearValue}}"/><span class="add-on">บาท</span></div>
	</div>
	<div style="margin: 0px 8px;">
		<div><b>ปี {{next3Year}}:</b></div><div class="input-append"><input style="width:120px;" type="text" id="amountRequestNext3Year" value="{{next3YearValue}}"/><span class="add-on">บาท</span></div>
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


<script id="budgetInputSelectionTemplate" type="text/x-handler-template">
<select id="budgetType_{{this.id}}" multiple="multiple" style="height: 100px;" class="span2">
	{{#if this}}
	{{#each this.children}}
		<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.name}}</option>
	{{/each}}
{{else}} {{/if}}
</select>
</script>

<script id="proposalListTemplate" type="text/x-handler-template">
<ul>
{{#each this}}
	<li>{{name}}: {{formatNumber total}} บาท</li>
{{/each}}
</ul>
</script>

<script id="proposalStrategyListTemplate" type="text/x-handler-template">
{{#each this}}
	<div> 
	<u>{{name}}: {{formatNumber total}} บาท </u>
	<ul id="budgetProposalLst">
		{{#each proposals}}
		{{#each proposalStrategies}} 
			<li data-id="{{id}}" proposal-id="{{../id}}">
				{{#unless ../../../readOnly}} 
				<a href="#" class="editProposal"><i class="icon-edit icon-blue editProposal"></i></a>				
				<a href="#" class="removeProposal"><i class="icon-trash icon-red removeProposal"></i></a>
				{{/unless}}
				{{#if formulaStrategy}}
					{{formulaStrategy.name}} : {{{formulaLine this}}} = {{{formatNumber totalCalculatedAmount}}} บาท
				{{else}}
					{{name}} = {{{formatNumber totalCalculatedAmount}}} บาท
				{{/if}}
				{{#if targetUnit}}
					(เป้าหมาย: {{formatNumber targetValue}} {{targetUnit.name}})
				{{/if}}

			</li>
		{{/each}}
		{{/each}}
	</ul>
	</div>
	{{/each}}
</script>

<script type="text/javascript">
	var objectiveId = "${objectiveId}";
	var fiscalYear = parseInt("${fiscalYear}");

	var pageUrl = "/page/m2f12/";
	var mainCtrView = null;
	var objectiveCollection = null;
	var budgetTypeSelectionView = null;
	var rootCollection;
	var topBudgetList = ["งบบุคลากร","งบดำเนินงาน","งบลงทุน","งบอุดหนุน","งบรายจ่ายอื่น"];
	var l = null;
	var e1;
	var e2;
	var readOnly = "${readOnly}";

	var proposalListTemplate = Handlebars.compile($('#proposalListTemplate').html());
	var proposalStrategyListTemplate = Handlebars.compile($('#proposalStrategyListTemplate').html());
	
	Handlebars.registerHelper("listProposalStrategies", function(proposals, readOnly) {
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
		
 		json.readOnly = readOnly;
		
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

	var StrategySelectionView = Backbone.View.extend({
		initialize : function(options) {
			_.bindAll(this, 'render');
			_.bindAll(this, 'renderWithStrategy');
			_.bindAll(this, 'strategySelect');
			
			if(options != null) {
				this.parentModal = options.parentModal;
			} 
			this.displayNull=false;
			
		},
		
		events : {
			"change #strategySlt" : "strategySelect",
			"click .saveProposal" : "saveProposal",
			"click .copytoNextYear" : "copyToNextYear",
			"change .formulaColumnInput" : "inputChange",
			"click .updateProposal" : "updateProposal",
			"click .backToProposal" : "backToProposal"
			
		},
		
		inputModalTemplate : Handlebars.compile($('#inputModalTemplate').html()),
		strategySelectionTemplate : Handlebars.compile($('#strategySelectionTemplate').html()),
		currentStrategyCollection : null,
	
		render : function() {
			var selectionDiv = this.$el.find('#strategySelectionDiv > div:first-child');
			if (this.currentStrategyCollection != null && this.currentStrategyCollection.length > 0) {
				var json = this.currentStrategyCollection.toJSON();
				selectionDiv.html(this.strategySelectionTemplate(json));
			} else {
				if(this.displayNull) {
					selectionDiv.html("ไม่มีรายการย่อย");
				} else {
					selectionDiv.html(this.strategySelectionTemplate({}));
				}
			}
	
		},
		
		backToProposal: function(e) {
			this.parentModal.render();
		},
	
		setRootModel: function(collection, displayNull) {
			this.currentStrategyCollection=collection;
			if(displayNull == true) {
				this.displayNull = true;
			} else {
				this.displayNull = false;
			}
		},
		
		renderWithStrategy : function(strategyCollection, parentModal, budgetType) {
			this.parentModal = parentModal;
			this.currentStrategyCollection = strategyCollection;
			this.currentBudgetType = budgetType;
			this.displayNull = true;
			this.currentStrategy = null;
			this.render();
		},
	
		renderWithWithDisableSelect : function(formulaStrategies,proposalStrategy, parentModal) {
			this.parentModal = parentModal;
			this.currentStrategyCollection = formulaStrategies;
			this.currentEditProposalStrategy = proposalStrategy;
	
			if (this.currentStrategyCollection != null) {
				var json = this.currentStrategyCollection.toJSON();
	
				for ( var i = 0; i < json.length; i++) {
					if (json[i].id == proposalStrategy.get('formulaStrategy').get('id')) {
						json[i].selected = true;
					}
				}
	
				json.editStrategy = true;
	
				this.$el.html(this.strategySelectionTemplate(json));
	
				// now the Form!
				this.currentStrategy = proposalStrategy.get('formulaStrategy');
	
				var columns = this.currentStrategy.get('formulaColumns');
				//now set the last column
				columns.at(columns.length - 1).set("$last", true);
	
				// here we'll get the propose column
	
				var json = this.currentStrategy.toJSON();
				json.propsalStrategyName = proposalStrategy.get('name');
				json.proposalStrategyId = proposalStrategy.get('id');
				json.editStrategy = true;
	
				json.next1Year = this.currentStrategy.get('fiscalYear') + 1;
				json.next1YearValue = proposalStrategy.get('amountRequestNext1Year');
	
				json.next2Year = this.currentStrategy.get('fiscalYear') + 2;
				json.next2YearValue = proposalStrategy.get('amountRequestNext2Year');
	
				json.next3Year = this.currentStrategy.get('fiscalYear') + 3;
				json.next3YearValue = proposalStrategy.get('amountRequestNext3Year');
	
				var totalMulti = 1;
	
				for ( var i = 0; i < json.formulaColumns.length; i++) {
					if (json.formulaColumns[i].isFixed) {
						var colId = json.formulaColumns[i].id;
						// now find this colId in requestColumns
						var rc = proposalStrategy.get('requestColumns');
						var foundRC = rc.where({
							column : FormulaColumn.findOrCreate(colId)
						});
						json.formulaColumns[i].value = foundRC[0].get('amount');
	
						totalMulti = totalMulti * parseInt(foundRC[0].get('amount'));
					} else {
						totalMulti = totalMulti * parseInt(json.formulaColumns[i].value);
					}
	
				}
				json.total = totalMulti;
				// now will go through
	
				var html = this.inputModalTemplate(json);
				// render strategy!
				this.$el.find('#input-form').html(html);
	
			}
	
		},
		
		setCurrentBudgetTypeAndStrategy: function(budgetType, strategy) {
			this.currentBudgetType = budgetType;
			this.currentStrategy = strategy;
		},
	
		inputChange : function(e) {
			// OK we'll go through all td value
			var standardPrice = this.currentStrategy.get('standardPrice');
			
			if(isNaN(standardPrice) || standardPrice == null) {
				standardPrice = 1;
			}
			var amount = standardPrice;
			
			var allInput = this.$el.find('.formulaColumnInput');
			for(var i=0; i<allInput.length; i++ ) {
				amount = amount * allInput[i].value;
			}
			
			// now put amount back amount
			this.$el.find('#totalInputTxt').val(addCommas(amount));
		},
	
		copyToNextYear : function(e) {
			var valueToCopy = $('#totalInputTxt').val();
			valueToCopy = valueToCopy.replace(/,/g, '');
			this.$el.find('#amountRequestNext1Year').val(valueToCopy);
			this.$el.find('#amountRequestNext2Year').val(valueToCopy);
			this.$el.find('#amountRequestNext3Year').val(valueToCopy);
		},
	
		renderInputStrategy: function(strategy) {
			this.currentStrategy=strategy;
			var columns = strategy.get('formulaColumns');
			//now set the last column
			columns.at(columns.length - 1).set("$last", true);
	
			// here we'll get the propose column
	
			var json = strategy.toJSON();
			
			if(json.unit != null) {
				json.budgetTypeUnitName = json.unit.name; 
				json.targetUnitId = json.unit.id;
			} else if(json.type.unit != null) {
				json.budgetTypeUnitName = json.type.unit.name;
				json.targetUnitId = json.type.unit.id;
			}
			
			json.next1Year = strategy.get('fiscalYear') + 1;
			json.next2Year = strategy.get('fiscalYear') + 2;
			json.next3Year = strategy.get('fiscalYear') + 3;
			var html = this.inputModalTemplate(json);
			// render strategy!
			this.$el.find('#input-form').html(html);
			
			// now update with the parent 
			this.parentModal.currentFormulaStrategySelection = strategy; 
	
		},
		
		strategySelect : function(e) {
	
			var strategyId = e.target.value;
	
			var strategy = this.currentStrategyCollection.get(strategyId);
			this.currentStrategy = strategy;
			this.renderInputStrategy(strategy);
			
		},
	
		updateProposal : function(e) {
			//now get the proposalId
			var proposalStrategyId = this.$el.find('#proposalStrategyId').attr('data-id');
			var proposalStrategy = ProposalStrategy.findOrCreate(proposalStrategyId);
			
			if (proposalStrategy != null) {
				
				// we just pick up changes
				// loop through formulaColumns
				if(this.currentStrategy!=null) {
					var i;
					calculatedAmount = this.currentStrategy.get('standardPrice');
					var formulaColumns = this.currentStrategy.get('formulaColumns');
					for (i = 0; i < formulaColumns.length; i++) {
		
						var fc = formulaColumns.at(i);
						if (fc.get('isFixed')) {
							var colId = fc.get('id');
							// now find this colId in requestColumns
							var rc = proposalStrategy.get('requestColumns');
							var foundRC = rc.where({
								column : FormulaColumn.findOrCreate(colId)
							})[0];
		
							foundRC.set('amount', this.$el.find('#formulaColumnId-' + fc.get('id')).val());
		
							if (calculatedAmount == 0) {
								calculatedAmount = foundRC.get('amount');
							} else {
								calculatedAmount = calculatedAmount * foundRC.get('amount');
							}
		
						} else {
							if (calculatedAmount == 0) {
								calculatedAmount = fc.get('value');
							} else {
								calculatedAmount = calculatedAmount	* fc.get('value');
							}
						}
					}
				} else {
					proposalStrategy.set('totalCalculatedAmount', this.$el.find('#totalInputTxt').val());	
				}
				
				
				proposalStrategy.set('targetValue', this.$el.find("#targetValue").val());
				proposalStrategy.set('amountRequestNext1Year', this.$el.find('#amountRequestNext1Year').val());
				proposalStrategy.set('amountRequestNext2Year', this.$el.find('#amountRequestNext2Year').val());
				proposalStrategy.set('amountRequestNext3Year', this.$el.find('#amountRequestNext3Year').val());
	
				// now we can send changes to the server?
				var json = proposalStrategy.toJSON();
	
				
				this.$el.find('button.updateProposal').html('<icon class="icon-refresh icon-spin"></icon> กำลังบันทึกข้อมูล...');
				$.ajax({
					type : 'PUT',
					url : appUrl('/ProposalStrategy/' + proposalStrategy.get('id')),
					data : JSON.stringify(json),
					contentType : 'application/json;charset=utf-8',
					dataType : "json",
					success : _.bind(function(data) {
						// OK we should update our budgetProposal too
						var proposal = proposalStrategy.get('proposal');
						proposal.set('amountRequest', proposalStrategy.get('totalCalculatedAmount'));
						proposal.set('amountRequestNext1Year', proposalStrategy.get('amountRequestNext1Year'));
						proposal.set('amountRequestNext2Year', proposalStrategy.get('amountRequestNext2Year'));
						proposal.set('amountRequestNext3Year', proposalStrategy.get('amountRequestNext3Year'));
						
						
						this.parentModal.render();
					}, this)
				});
			}
	
		},
	
		saveProposal : function(e) {
			var objective = this.parentModal.objective;
			var budgetType = this.currentBudgetType;
	
			var budgetProposal = this.currentBudgetProposal;
	
			if (budgetProposal == null) {
				// create new BudgetProposal
				budgetProposal = new BudgetProposal();
				budgetProposal.set('forObjective', objective);
				budgetProposal.set('budgetType', budgetType);
				// now put this proposal into objective;
				objective.get('filterProposals').push(budgetProposal);
			}
	
			
			
			// we will make a new ProposalStrategy
			var proposalStrategy = new ProposalStrategy();
			budgetProposal.get('proposalStrategies').add(proposalStrategy);
			
			proposalStrategy.set('formulaStrategy', this.currentStrategy);
			var calculatedAmount = 0;
			
			if(this.currentStrategy == null) {
				calculatedAmount = this.$el.find('#totalInputTxt').val();
				proposalStrategy.set('name', this.currentBudgetType.get('name'));
			} else{
				// loop through formulaColumns
				proposalStrategy.set('name', this.currentStrategy.get('name'));
				var i;
				calculatedAmount = this.currentStrategy.get('standardPrice');
				var formulaColumns = this.currentStrategy.get('formulaColumns');
				for (i = 0; i < formulaColumns.length; i++) {
					var fc = formulaColumns.at(i);
					if (fc.get('isFixed')) {
						var requestColumn = new RequestColumn();
						requestColumn.set('amount', this.$el.find('#formulaColumnId-' + fc.get('id')).val());
						requestColumn.set('column', fc);
						requestColumn.set('proposalStrategy', proposalStrategy);
	
						proposalStrategy.get('requestColumns').add(requestColumn);
	
						if (calculatedAmount == 0) {
							calculatedAmount = requestColumn.get('amount');
						} else {
							calculatedAmount = calculatedAmount * requestColumn.get('amount');
						}
	
					} else {
						if (calculatedAmount == 0) {
							calculatedAmount = fc.get('value');
						} else {
							calculatedAmount = calculatedAmount * fc.get('value');
						}
					}
				}
			}
			proposalStrategy.set('totalCalculatedAmount', calculatedAmount);
			
			proposalStrategy.set('proposal', budgetProposal);
			proposalStrategy.set('amountRequestNext1Year', this.$el.find('#amountRequestNext1Year').val());
			proposalStrategy.set('amountRequestNext2Year', this.$el.find('#amountRequestNext2Year').val());
			proposalStrategy.set('amountRequestNext3Year', this.$el.find('#amountRequestNext3Year').val());
			
			var unitId = this.$el.find('#targetValue').attr('data-unitId');
			if(unitId !=null) {
				var unit = TargetUnit.findOrCreate(unitId);
				proposalStrategy.set('targetUnit', unit);
				proposalStrategy.set('targetValue', this.$el.find('#targetValue').val());
			}
			
			
			budgetProposal.set('amountRequest', calculatedAmount);
			budgetProposal.set('amountRequestNext1Year', this.$el.find('#amountRequestNext1Year').val());
			budgetProposal.set('amountRequestNext2Year', this.$el.find('#amountRequestNext2Year').val());
			budgetProposal.set('amountRequestNext3Year', this.$el.find('#amountRequestNext3Year').val());
	
			// either do create or update!?
			if (budgetProposal.get('id') == null) {
				this.$el.find('button.saveProposal').html('<icon class="icon-refresh icon-spin"></icon> กำลังบันทึกข้อมูล...');
				saveModel(budgetProposal,
					_.bind(function(resp,status,xhr) {
						budgetProposal.set('id', resp.id);
						// now set id for each proposal / request column
						if(resp.proposalStrategies != null) {
							proposalStrategy.set('id', resp.proposalStrategies[0].id);
						}
						
						this.parentModal.objective.get('filterProposals').add(budgetProposal);
						this.parentModal.render();		
					},this));

				
			} 	
		}
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
			if(this.model != null) {
				this.$el.html(this.budgetInputSelectionTemplate(this.model.toJSON()));
			} else {
				this.$el.html(this.budgetInputSelectionTemplate({}));
			}
			
			
		},
		
		events: {
			"change select" : "selectionChange" 
		},
		
		setRootModel: function(rootModel) {
			this.model =  rootModel;
			
		},
		
		selectionChange: function(e) {
			var selectedBudgetTypeId = $(e.target).val()[0];
			// now try to get this model
			var budgetType = BudgetType.findOrCreate(selectedBudgetTypeId);
			budgetType.fetch({success: _.bind(function(model, response){
				var fetchedBudgetType = response;
				if(fetchedBudgetType.children != null && fetchedBudgetType.children.length > 0) {
					//we feed this to the next level?
					this.parentModal.updateBudgetTypeSelectionLevelWithModel(this.level+1, budgetType);
					
				} else {
					
					// then we should now filling in the proposed budget
					
					// ok now we'll get the strategy here
					var formulaStrategies = new FormulaStrategyCollection();

					formulaStrategies.fetch({
						url : appUrl('/FormulaStrategy/search/' + fiscalYear + "/" + budgetType.get('id')),
						success : _.bind(function(data) {
							// we'll have to loop through formulaStrategies
							if(formulaStrategies.length > 0) {
								
								for(var i=0; i<formulaStrategies.length; i++) {
									
									var fs = formulaStrategies.at(i);
									if(fs.get('isStandardItem') == true) {
										budgetType.set('standardStrategy', fs);
										formulaStrategies.remove(fs);
									}
								}
							}
							
							budgetType.set('strategies', formulaStrategies);
							
							this.parentModal.updateStrategySelection(budgetType, formulaStrategies);
						}, this)
					});
					
				}
			}, this)});
			
			// ok we'll have to set back to this!?
			
		},

		renderWithDisableSelect : function(budgetProposal, proposalStrategy) {
			
			this.strategySelectionView = new StrategySelectionView({parentModal: this.parentModal});
	
			var budgetType = budgetProposal.get('budgetType');
			
			// ok now we'll get the strategy here
			var formulaStrategies = new FormulaStrategyCollection;
	
			formulaStrategies.fetch({
				url : appUrl('/FormulaStrategy/search/' + fiscalYear + "/" + budgetType.get('id')),
				success : _.bind(function(data) {
					budgetType.set('strategies', formulaStrategies);
					this.strategySelectionView.setElement(this.el);
	
					this.strategySelectionView.renderWithWithDisableSelect(	formulaStrategies, proposalStrategy, this.parentModal);
	
				}, this)
			});
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
		
		updateBudgetTypeSelectionLevelWithModel: function(level, model) {
			//set the previos level to this model
			this.currentBudgetTypeSelection[level-2]=model;
			// and remove all the rest forward
			for(var i=level-1; i<this.budgetTypeSelectionArray.length; i++) {
				this.currentBudgetTypeSelection[i] = null;
			}
			
			level = level-1;
			var btView = this.budgetTypeSelectionArray[level];
			btView.setRootModel(model);
			
			// reset input area
			$('#input-form').empty();
			
			// render the next selection
			btView.render();
			
			// and for the rest set to null
			for(var i=level+1; i<this.budgetTypeSelectionArray.length; i++) {
				this.budgetTypeSelectionArray[i].setRootModel(null);
				this.budgetTypeSelectionArray[i].render();
			}
			
		},
		
		updateStrategySelection: function(budgetType, formulaStrategies) {
			this.currentBudgetTypeSelection[3] = budgetType;
			this.budgetTypeSelectionArray[4].renderWithStrategy(formulaStrategies, this, budgetType);
			
			
			if(budgetType.get('standardStrategy') != null) {
				this.budgetTypeSelectionArray[4].renderInputStrategy(budgetType.get('standardStrategy'));
			} else {
				var json = {budgetTypeName: budgetType.get('name')};
				
				if(budgetType.get('unit') != null) {
					json.budgetTypeUnitName = budgetType.get('unit').get('name');
					json.targetUnitId = budgetType.get('unit').get('id');
					
				}
				
				json.next1Year = fiscalYear+1;
				json.next2Year = fiscalYear+2;
				json.next3Year = fiscalYear+3;
				
				$('#input-form').html(this.defaultInputTemplate(json));
			}
		},
		
		events : {
			"click .removeProposal" : "removeProposal",
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

		renderInputALL : function(proposalStrategy) {
			this.$el.find('.modal-body').html(this.inputAllDivTemplate());
			
			var rootBudgetType = BudgetType.findOrCreate({id:0});
		    rootBudgetType.fetch({success: _.bind(function(){
		    	this.budgetTypeSelectionViewL1 =  new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL1 > div', level: 1, parentModal: this});
				this.budgetTypeSelectionViewL2 = new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL2 > div', level: 2, parentModal: this});
				this.budgetTypeSelectionViewL3 = new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL3 > div', level: 3, parentModal: this});
				this.budgetTypeSelectionViewL4 = new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL4 > div', level: 4, parentModal: this});
				this.startegySelectionView = new StrategySelectionView({el: '#inputAll', parentModal: this});

				this.budgetTypeSelectionArray = [];
				this.budgetTypeSelectionArray.push(this.budgetTypeSelectionViewL1);
				this.budgetTypeSelectionArray.push(this.budgetTypeSelectionViewL2);
				this.budgetTypeSelectionArray.push(this.budgetTypeSelectionViewL3);
				this.budgetTypeSelectionArray.push(this.budgetTypeSelectionViewL4);
				this.budgetTypeSelectionArray.push(this.startegySelectionView);

				
				
		    	this.budgetTypeSelectionViewL1.$el = $('#budgetTypeSelectionDivL1 > div');
		    	this.budgetTypeSelectionViewL1.setRootModel(rootBudgetType);
		    	this.budgetTypeSelectionViewL1.render();
		    	
		    	
		    	this.budgetTypeSelectionViewL2.$el = $('#budgetTypeSelectionDivL2 > div');
		    	this.budgetTypeSelectionViewL2.setRootModel(null);
		    	this.budgetTypeSelectionViewL2.render();
		    	
		    	this.budgetTypeSelectionViewL3.$el = $('#budgetTypeSelectionDivL3 > div');
		    	this.budgetTypeSelectionViewL3.setRootModel(null);
		    	this.budgetTypeSelectionViewL3.render();
		    	
		    	this.budgetTypeSelectionViewL4.$el = $('#budgetTypeSelectionDivL4 > div');
		    	this.budgetTypeSelectionViewL4.setRootModel(null);
		    	this.budgetTypeSelectionViewL4.render();
		    	
		    	this.startegySelectionView.$el = $('#inputAll');
		    	this.startegySelectionView.renderWithStrategy(null, this, null);
		    	this.startegySelectionView.render();
	    	},this)});
		},
		
		render : function() {
			if (this.objective != null) {
				var json = this.objective.toJSON();
				json.readOnly = readOnly;
				var html = this.modalTemplate(json);
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
				
				
				
				
				this.$el.find('.modal-header span').html("ค่าเป้าหมาย" + this.objective.get('name') + " (" + this.objectiveTarget.get('unit').get('name') + ")");
				
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
					requestedValue: input
				}, {
					success: function(){
						window.location.reload();
					}
				});
				
				
				
			},
			
			renderWith: function(objective, targetId, valueId) {
				this.objective = objective;
				this.objectiveTarget=ObjectiveTarget.findOrCreate(targetId);
				this.targetValue=TargetValue.findOrCreate(valueId);
				if(this.targetValue == null) {
					this.targetValue = new TargetValue();
					this.targetValue.set('forObjective', objective);
					this.targetValue.set('target', this.objectiveTarget);
				}
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
			
			e1=this;
			
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
		targetValueModalView : new TargetValueModalView(),

		events : {
			"click input[type=checkbox].bullet" : "toggle",
			"click .detail" : "detailModal",
			"click .targetValueModal" : "detailTargetValue"
		},
		
		detailTargetValue: function(e) {
			var currentObjectiveId = $(e.target).parents('tr').attr('data-id');
			var currentObjective = Objective.findOrCreate(currentObjectiveId);
			
			var targetId = $(e.target).attr('target-id');
			var valueId = $(e.target).attr('data-id');
			
			this.targetValueModalView.renderWith(currentObjective, targetId, valueId);
			
			
		},

		detailModal : function(e) {
			var currentObjectiveId = $(e.target).parents('tr').attr('data-id');
			var currentObjective = Objective.findOrCreate(currentObjectiveId);

			var proposalStrategyCollection = new ProposalStrategyCollection();
			proposalStrategyCollection.fetch({
				url : appUrl('/ProposalStrategy/find/' + fiscalYear + '/' + currentObjective.get('id')),
				success : _.bind(function() {
					var proposals = currentObjective.get('filterProposals');
					var i;
					for (i = 0; i < proposalStrategyCollection.length; i++) {
						var strategy = proposalStrategyCollection.at(i);
						proposals.get(strategy.get('proposal').get('id')).get(
								'proposalStrategies').add(strategy);
					}

					this.modalView.renderWith(currentObjective);
				}, this)
			});

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
				
				objectiveCollection.url = appUrl("/ObjectiveWithBudgetProposal/" + fiscalYear+ "/" + this.currentParentObjective.get('id') + "/flatDescendants");
				
				objectiveCollection.fetch({
					success : _.bind( function() {
						// we will now sorted out this mess!
						var i;
						for (i = 0; i < objectiveCollection.length; i++) {
							var o = objectiveCollection.at(i);
							if (o.get('parent') != null) {
								var parentId = o.get('parent').get('id');
								if (parentId == objectiveId) {
									this.collection.add(o);
								}
	
							var parentObj = objectiveCollection.get(parentId);
								if (parentObj != null) {
									parentObj.get('children').add(o);
								}
							}
						}
						
						this.collection.add(objectiveCollection.where({parent: this.currentParentObjective}));
						
						var allProposal = new BudgetProposalCollection(); 
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
			
			
/*			
			var allProposal = new BudgetProposalCollection(); 
			_.each(rootCollection.pluck('filterProposals'), function(bpCollection) {
				if(bpCollection.length > 0) {
					bpCollection.each(function(bp) {
						allProposal.add(bp);
					});
				}
			});
			
			
			
			
			
			var json = this.collection.toJSON();
			json.allProposal = allProposal.toJSON();
			
			this.$el.html(this.mainTblTpl(json));
*/


			//render Each one in the collection first
//			this.$el.html(this.mainTbl1Tpl(this.collection.toJSON()));
//			for(var i= 0; i< this.collection.length; i++) {
//				var o = this.collection.at(i);
//				this.$el.find('#mainTbl tbody').append(this.nodeRowTpl(o.toJSON()));
				
				// get this children

//			}
			
			// now render all the children
//			var next = objectiveCollection.indexOf(this.collection.at(this.collection.length)) + 1;
			
//			for(next; next < objectiveCollection.length; next ++) {
				
//				var o = objectiveCollection.at(next);
//				var html  = this.nodeRowTpl(o.toJSON());
				
				
//				var parentEl = this.$el.find('tr[data-id='+ o.get('parent').get('id') +']');
				
				
//				$(html).insertAfter(this.$el.find(parentEl));
//			}

		
			// now we have to run the table row number
			
/*			
			this.$el.find('#mainTbl tbody td:first-child', this).each(function(i){
		        $(this).html((i+1) + ".");
		    });
			
*/

			
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
			e1=currentTr;
			
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

		mainCtrView = new MainCtrView();
		mainCtrView.render();

	});
</script>
