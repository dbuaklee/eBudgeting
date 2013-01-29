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
			<td>&nbsp;</td>
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
<div class="menu">{{#unless readOnly}}<button id="addBudget" class="btn">เพื่มรายการงบประมาณ</button> 
	<button class="btn" id="addObjectiveDetail">บันทึกข้อมูลโครงการ</button>{{/unless}}
	<button class="btn" id="printObjectiveDetail">พิมพ์ข้อมูลโครงการ</button>
</div>
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


<script id="inputObjectiveDetailDivTemplate" type="text/x-handler-template">
<div id="inputAll">
<div class="alert alert-info"><strong>โปรดกรอกข้อมูลรายละเอียดโครงการ</strong></div>

<form id="objectiveDeatilForm" class="form-horizontal">

<ul class="nav nav-tabs" id="objectiveDetailTab">
<li class="active"><a href="#detailFirstTab" data-toggle="tab">ผู้รับผิดชอบ</a></li>
<li><a href="#detailSecondTab" data-toggle="tab">หลักการ</a></li>
<li><a href="#detailThirdTab" data-toggle="tab">วิธีการดำเนินงาน</a></li>
<li><a href="#detailForthTab" data-toggle="tab">ระยะเวลา/เป้าหมาย</a></li>
<li><a href="#detailFifthTab" data-toggle="tab">ประโยชน์</a></li>
<li><a href="#detailSixthTab" data-toggle="tab">ผลการดำเนินงาน</a></li>
<li><a href="#detailSeventhTab" data-toggle="tab">พื้นที่เป้าหมาย</a></li>
</ul>

<div class="tab-content">
<div class="tab-pane active" id="detailFirstTab">
	<div style="paddign-left:15px;">
	<div class="control-group">
		<label class="control-label" for="officerInCharge">ผู้รับผิดชอบ</label>
		<div class="controls">
			<input class="span6 objectiveDetail" type="text" id="officerInCharge" placeholder="..." value="{{this.officerInCharge}}"></input>
		</div>
	</div>
	<div class="control-group">
		<label for="phoneNumber" class="control-label">เบอร์โทรศัพท์</label>
		<div class="controls"><input type="text" id="phoneNumber" placeholder="..." class="span2 objectiveDetail" value="{{this.phoneNumber}}"></input> 
			<span style="margin-left:58px"> Email  <input class="span3 objectiveDetail" type="text" placeholder="..." id="email" value="{{this.email}}"></span>
		</div>
	</div>
	</div>
</div>
<div class="tab-pane" id="detailSecondTab">
	<div style="padding-left:15px;">
		<label for="reason">1. หลักการและเหตุผล</label>
		<textarea class="span6 objectiveDetail" rows="3" id="reason">{{this.reason}}</textarea>
		<br/>
		<label style="margin-top:20px" for="reason">2. วัตถุประสงค์</label>	
		<textarea class="span6 objectiveDetail" rows="3" id="projectObjective">{{this.projectObjective}}</textarea>
	</div>
</div>
<div class="tab-pane" id="detailThirdTab">
	<div style="padding-left:15px;">
		<label for="methodology1">3.1 การรวบรวมข้อมูลทั่วไป</label>
		<textarea class="span6 objectiveDetail" rows="2" id="methodology1">{{this.methodology1}}</textarea>
		<br/>
		<label style="margin-top:20px" for="methodology2">3.2 การรวบรวมข้อมูลทางด้านเศรษฐกิจและสังคม</label>	
		<textarea class="span6 objectiveDetail" rows="2" id="methodology2">{{this.methodology2}}</textarea>
		<br/>
		<label style="margin-top:20px" for="methodology3">3.3 การนำเข้าและวิเคราะห์ข้อมูล</label>	
		<textarea class="span6 objectiveDetail" rows="2" id="methodology3">{{this.methodology3}}</textarea>
	</div>
</div>
<div class="tab-pane" id="detailForthTab">
	<div style="padding-left:15px;">
		<label for="location">4. สถานที่ดำเนินการ</label>
		<textarea class="span6 objectiveDetail" rows="1" id="location">{{this.location}}</textarea>
		<br/>
		<label style="margin-top:20px" for="timeframe">5. ระยะเวลาดำเนินการ</label>	
		<textarea class="span6 objectiveDetail" rows="1" id="timeframe">{{this.timeframe}}</textarea>
		<br/>
		<label style="margin-top:20px" for="targetDescription">6. เป้าหมายและงบประมาณ</label>	
		<textarea class="span6 objectiveDetail" rows="1" id="targetDescription">{{this.targetDescription}}</textarea>
	</div>
</div>
<div class="tab-pane" id="detailFifthTab">
	<div style="padding-left:15px;">
		<label for="outcome">7. ผลประโยชน์ที่คาดว่าจะได้รับ</label>
		<textarea class="span6 objectiveDetail" rows="4" id="outcome">{{this.outcome}}</textarea>
	</div>
</div>
<div class="tab-pane" id="detailSixthTab">
	<div style="padding-left:15px;">
		<label for="outcome">8. ผลการดำเนินงานตั้งแต่เริ่มต้นโครงการ</label>
		<textarea class="span6 objectiveDetail" rows="4" id="output">{{this.output}}</textarea>
	</div>
</div>
<div class="tab-pane" id="detailSeventhTab">
	<div style="padding-left:15px;">
		<label for="targetArea">9. พื้นที่เป้าหมาย</label>
		<textarea class="span6 objectiveDetail" rows="4" id="targetArea">{{this.targetArea}}</textarea>
	</div>
</div>
</div>

</form>

<button class="btn btn-mini btn-primary" id="saveObjectiveDetail">บันทึก</button> <button class="btn btn-mini backToProposal">ย้อนกลับ</button>
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

<script src="<c:url value='/resources/js/pages/m61f04.js'/>"></script>

<script type="text/javascript">
	var objectiveId = "${objectiveId}";
	var fiscalYear = parseInt("${fiscalYear}");

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


	$(document).ready(function() {

		mainCtrView = new MainCtrView();
		mainCtrView.render();

	});
</script>
