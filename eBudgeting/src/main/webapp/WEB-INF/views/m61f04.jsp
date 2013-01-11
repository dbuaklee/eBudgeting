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
<script id="mainCtr1Template" type="text/x-handler-template">
<table class="table table-bordered" id="mainTbl" style="margin-bottom:0px; width:860px; table-layout:fixed;">
	<thead>
		<tr>
			<th style="width:400px;"><strong>แผนงาน/กิจกรรม ประจำปี {{this.0.fiscalYear}}</strong><br/>- ระดับ{{this.0.type.name}}</th>
			<th width="80">เป้าหมาย</th>
			<th width="80">ขอตั้งปี  {{this.0.fiscalYear}}</th>
			<th width="80">ประมาณการ  {{next this.0.fiscalYear 1}}</th>
			<th width="80">ประมาณการ  {{next this.0.fiscalYear 2}}</th>
			<th width="80">ประมาณการ  {{next this.0.fiscalYear 3}}</th>
		</tr>
	</thead>
</table>
<div style="height: 400px; overflow: auto; width:1150px">
<table class="table table-bordered" id="mainTbl" style="width:1150px; table-layout:fixed;">
	<tbody>
		
			
		
	</tbody>
</table>
</div>
</script>
<script id="childrenNormalNodeTemplate" type="text/x-handler-template">
		<tr>
			<td style="width:400px;"><a href="../{{this.id}}/" class="nextChildrenLnk">{{this.name}} <i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
			<td width="80"></td>
			<td style="text-align:right" width="80">{{#if this.proposals}} {{formatNumber this.proposals.0.amountRequest}} {{else}}0.00{{/if}}</td>
			<td width="80"></td>
			<td width="80"></td>
			<td width="80"></td>
		</tr>
</script>

<script id="nodeRowTemplate" type="text/x-handler-template">
	<tr data-level="{{this.level}}" data-id="{{this.id}}">
		
		<td style="width:400px;" class="{{#if this.children}}disable{{/if}}">
			<span style="padding-left:{{this.padding}}px;width:{{substract 405 this.padding}}px;">
					{{#if this.children}}
					<input class="checkbox_tree bullet" type="checkbox" id="bullet_{{this.id}}"/>
					<label class="expand" for="bullet_{{this.id}}"><img width=12 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/></label>
					{{else}}					
						<img width=8 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/> - 
					{{/if}}
					<input class="checkbox_tree" type="checkbox" id="item_{{this.id}}"/>
					<label class="main" for="item_{{this.id}}">
						{{#unless this.children}}<a href="#" class="detail">{{/unless}}
						<b>{{this.type.name}}ที่ {{indexHuman this.index}}</b> [{{this.code}}] {{this.name}}
						{{#unless this.children}}</a>{{/unless}}
					</label>
					{{#unless this.children}}
						<img width=12 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/>
						<ul>
						{{#each this.filterProposals}}
							 <li> {{budgetType.name}} - {{{formatNumber amountRequest}}} บาท</li>
						{{/each}}
						</ul>
					{{/unless}}
			</span> 
		</td>
			<td  style="width:60px;" class="{{#if this.children}}disable{{/if}}">
			<span>
				<ul>{{#each targets}}<li>{{unit.name}}</li>{{/each}}</ul>
			</span>
				
				 {{#unless this.children}}<br/><a col-id="1" href="#mainfrm" class="btn btn-mini">เพิ่ม/แก้ไข</a>{{/unless}}
			</td>
			<td  style="width:60px;" class="{{#if this.children}}disable{{/if}}">
			<span>
				<ul>{{#each targets}}<li>{{unit.name}}</li>{{/each}}</ul>
			</span>
			</td>
			<td style="width:120px;" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposal this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposal this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
			</td>

			<td style="width:120px;" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposalNext1Year this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposalNext1Year this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
			</td>
			<td style="width:120px;" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposalNext2Year this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposalNext2Year this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
			</td>
			<td style="width:120px;" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposalNext3Year this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposalNext3Year this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
			</td>
	</tr>
</script>

<script id="childrenNodeTemplate" type="text/x-handler-template">
	<tr data-level="{{this.level}}" data-id="{{this.id}}" class="type-{{type.id}}">
		<td style="width:20px;"></td>
		<td style="width:260px;" class="{{#if this.children}}disable{{/if}}">
			<div class="pull-left" style="margin-left:{{this.padding}}px; width:18px;">
					{{#if this.children}}
					<input class="checkbox_tree bullet" type="checkbox" id="bullet_{{this.id}}"/>
					<label class="expand" for="bullet_{{this.id}}"><icon class="icon-caret-down"></i></label>
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

<script id="modalTemplate" type="text/x-handler-template">
<div><u>รายการงบประมาณลงข้อมูลไว้แล้ว</u></div>
	{{#each filterProposals}}
	<div> 
	<u>{{budgetType.topParentName}} {{budgetType.name}}</u>
	<ul id="budgetProposeLst">
		{{#each proposalStrategies}} 
			<li data-id="{{id}}" proposal-id="{{../id}}">
				<span class="label label-info"><a href="#" class="editProposal"><i class="icon icon-edit icon-white editProposal"></i></a></span>				
				<span class="label label-important"><a href="#" class="removeProposal"><i class="icon icon-trash icon-white removeProposal"></i></a></span>
				{{name}} : {{{formulaLine this}}} = {{{formatNumber totalCalculatedAmount}}} บาท</li>
		{{/each}}
	</ul>
	</div>
	{{/each}}
</div>
<hr/>
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
<form id="input-form">
		
</form></div>
</div>
</script>


<script id="targetValueModalTemplate" type="text/x-handler-template">
<form>
	<label>ระบุค่าเป้าหมาย</label>
	<input type="text" value="{{value}}"/> {{target.unit.name}}
</form>
</script>

<script id="defaultInputTemplate" type="text/x-handler-template">
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
			<div style="height:35px;margin-bottom:5px;padding-top:5px;text-align:center;padding-right:30px;">
				<strong>ขอตั้ง</strong>
			</div>
			<div style="height:35px;" id="totalInputForm">
				<input type="text" id="totalInputTxt" style="width:120px;" value="{{total}}"></input>  บาท
			</div>
		</div>
	</div>
	
<div class="clearfix"></div>
<div style="margin-top:5px; margin-bottom: 10px;"> <button class="btn copytoNextYear">คัดลอกไปประมาณการ 3 ปี</button></div>
<div>
	ประมาณการปี {{next1Year}}: <input type="text" id="amountRequestNext1Year" value="{{next1YearValue}}"/> บาท <br/>
	ประมาณการปี {{next2Year}}: <input type="text" id="amountRequestNext2Year" value="{{next2YearValue}}"/> บาท <br/>
	ประมาณการปี {{next3Year}}: <input type="text" id="amountRequestNext3Year" value="{{next3YearValue}}"/> บาท <br/>
	{{#if editStrategy}}<button data-id="{{proposalStrategyId}}" class="btn btn-mini updateProposal">แก้ไข</button>{{else}}<button class="btn btn-mini saveProposal">บันทึก</button>{{/if}}
</div>
</script>


<script id="inputModalTemplate" type="text/x-handler-template">
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
				<input type="text" class="formulaColumnInput" style="width:70px;"  value="{{value}}"></input> {{#if $last}}={{else}}&times;{{/if}}
			</div>
		</div>
		{{/each}}
		<div>
			<div style="height:35px;margin-bottom:5px;padding-top:5px;text-align:center;padding-right:30px;">
				<strong>คิดเป็นขอตั้ง</strong>
			</div>
			<div style="height:35px;" id="totalInputForm">
				<input type="text" id="totalInputTxt" style="width:120px;" disabled="disabled" value="{{total}}"></input>  บาท
			</div>
		</div>
	</div>
	
<div class="clearfix"></div>
<div style="margin-top:5px; margin-bottom: 10px;"> <button class="btn copytoNextYear">คัดลอกไปประมาณการ 3 ปี</button></div>
<div>
	ประมาณการปี {{next1Year}}: <input type="text" id="amountRequestNext1Year" value="{{next1YearValue}}"/> บาท <br/>
	ประมาณการปี {{next2Year}}: <input type="text" id="amountRequestNext2Year" value="{{next2YearValue}}"/> บาท <br/>
	ประมาณการปี {{next3Year}}: <input type="text" id="amountRequestNext3Year" value="{{next3YearValue}}"/> บาท <br/>
	{{#if editStrategy}}<button data-id="{{proposalStrategyId}}" class="btn btn-mini updateProposal">แก้ไข</button>{{else}}<button class="btn btn-mini saveProposal">บันทึก</button>{{/if}}
</div>
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
	var objectiveId = "${objectiveId}";
	var fiscalYear = "${fiscalYear}";

	var pageUrl = "/page/m2f12/";
	var mainTblView = null;
	var objectiveCollection = null;
	var budgetTypeSelectionView = null;
	var rootCollection;
	var l = null;
	var e1;

	Handlebars.registerHelper("listProposals", function(proposals) {
		var retStr = "<ul>";
	 	if(proposals != null && proposals.length > 0) {
	 		var topParentName = proposals[0].budgetType.topParentName;
	 		retStr = retStr + "<li><u>" + topParentName +"</u><ul>";
	 		for(var i=0; i< proposals.length; i++) {
	 				

	 			
	 			if(topParentName == proposals[i].budgetType.topParentName) {
	 				retStr = retStr + "<li>" + proposals[i].budgetType.name + " - " + addCommas(proposals[i].amountRequest) + " บาท</li>";
	 			} else {
	 				retStr = retStr + "</ul></li><li><u>" + proposals[i].budgetType.topParentName + "</u><ul>";
	 				retStr = retStr + "<li>" + proposals[i].budgetType.name + " - " + addCommas(proposals[i].amountRequest) + " บาท</li>";
	 				
	 				topParentName = proposals[i].budgetType.topParentName;
	 			}
	 		}
	 		retStr = retStr + "</ul></li>";
	 			
	 	}
	 	retStr += "</ul>";
	 	
	 	return retStr;
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

		var s = "";

		if (strategy.formulaStrategy != null) {
			var formulaColumns = strategy.formulaStrategy.formulaColumns;
			for ( var i = 0; i < formulaColumns.length; i++) {
				if (i > 0) {
					s = s + " X ";
				}

				s = s + formulaColumns[i].columnName;
				if (formulaColumns[i].isFixed) {
					// now we'll go through requestColumns
					var j;
					for (j = 0; j < strategy.requestColumns.length; j++) {
						if (strategy.requestColumns[j].column.id == formulaColumns[i].id) {
							s = s + "(" + addCommas(strategy.requestColumns[j].amount)
								+ formulaColumns[i].unitName
								+ ")";
						}
					}

				} else {
					s = s + "(" + addCommas(formulaColumns[i].value)
						+ " " + formulaColumns[i].unitName
						+ ")";
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
			"change .formulaColumnInput" : 'inputChange',
			"click .updateProposal" : 'updateProposal'
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
	
		strategySelect : function(e) {
	
			var strategyId = e.target.value;
	
			var strategy = this.currentStrategyCollection
					.get(strategyId);
			this.currentStrategy = strategy;
	
			var columns = strategy.get('formulaColumns');
			//now set the last column
			columns.at(columns.length - 1).set("$last", true);
	
			// here we'll get the propose column
	
			var json = strategy.toJSON();
			json.next1Year = strategy.get('fiscalYear') + 1;
			json.next2Year = strategy.get('fiscalYear') + 2;
			json.next3Year = strategy.get('fiscalYear') + 3;
			var html = this.inputModalTemplate(json);
			// render strategy!
			this.$el.find('#input-form').html(html);
	
		},
	
		updateProposal : function(e) {
			if (this.currentEditProposalStrategy != null) {
				var proposalStrategy = this.currentEditProposalStrategy;
				// we just pick up changes
				// loop through formulaColumns
				var i;
				var calculatedAmount = 0;
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
				proposalStrategy.set('totalCalculatedAmount', calculatedAmount);
				proposalStrategy.set('name', this.$el.find('#proposalName').val());
				proposalStrategy.set('amountRequestNext1Year', this.$el.find('#amountRequestNext1Year').val());
				proposalStrategy.set('amountRequestNext2Year', this.$el.find('#amountRequestNext2Year').val());
				proposalStrategy.set('amountRequestNext3Year', this.$el.find('#amountRequestNext3Year').val());
	
				// now we can send changes to the server?
				var json = proposalStrategy.toJSON();
	
				$.ajax({
					type : 'PUT',
					url : appUrl('/ProposalStrategy/'
							+ proposalStrategy.get('id')),
					data : JSON.stringify(json),
					contentType : 'application/json;charset=utf-8',
					dataType : "json",
					success : _.bind(function(data) {
						this.parentModal.render();
					}, this)
				});
			}
	
		},
	
		saveProposal : function(e) {
			if (this.currentStrategy != null) {
				var objective = this.parentModal.objective;
				var budgetType = this.currentBudgetType;
	
				var budgetProposal = null;
	
				//find appropriate budgetProposal, the one with budgetTypeid == the selected one
				var pList = objective.get('filterProposals');
				for ( var i = 0; i < pList.length; i++) {
					var proposal = pList.at(i);
	
					if (proposal.get('budgetType').get('id') == budgetType
							.get('id')) {
						budgetProposal = proposal;
						break;
					}
	
				}
	
				if (budgetProposal == null) {
					// create new BudgetProposal
					budgetProposal = new BudgetProposal();
					budgetProposal.set('forObjective', {
						id : objective.get('id')
					});
					budgetProposal.set('budgetType', {
						id : budgetType.get('id')
					});
	
					// now put this proposal into objective;
					objective.get('filterProposals').push(budgetProposal);
				}
	
				// we will make a new ProposalStrategy
				var proposalStrategy = new ProposalStrategy();
	
				proposalStrategy.set('formulaStrategy', {
					id : this.currentStrategy.get('id')
				});
	
				// loop through formulaColumns
				var i;
				var calculatedAmount = 0;
				var formulaColumns = this.currentStrategy
						.get('formulaColumns');
				for (i = 0; i < formulaColumns.length; i++) {
					var fc = formulaColumns.at(i);
					if (fc.get('isFixed')) {
						var requestColumn = new RequestColumn();
						requestColumn.set('amount', this.$el.find(
								'#formulaColumnId-' + fc.get('id'))
								.val());
						requestColumn.set('column', fc);
						requestColumn.set('proposalStrategy',
								proposalStrategy);
	
						proposalStrategy.get('requestColumns').add(
								requestColumn);
	
						if (calculatedAmount == 0) {
							calculatedAmount = requestColumn
									.get('amount');
						} else {
							calculatedAmount = calculatedAmount
									* requestColumn.get('amount');
						}
	
					} else {
						if (calculatedAmount == 0) {
							calculatedAmount = fc.get('value');
						} else {
							calculatedAmount = calculatedAmount
									* fc.get('value');
						}
					}
				}
				proposalStrategy.set('totalCalculatedAmount',
						calculatedAmount);
				proposalStrategy.set('proposal', budgetProposal);
				proposalStrategy.set('name', this.$el.find(
						'#proposalName').val());
				proposalStrategy.set('amountRequestNext1Year', this.$el
						.find('#amountRequestNext1Year').val());
				proposalStrategy.set('amountRequestNext2Year', this.$el
						.find('#amountRequestNext2Year').val());
				proposalStrategy.set('amountRequestNext3Year', this.$el
						.find('#amountRequestNext3Year').val());
	
				if (budgetProposal.get('id') == null) {
					// now ready to post back
					var json = budgetProposal.toJSON();
					json.forObjective = {
						id : json.forObjective.id
					};
					json.budgetType = {
						id : json.budgetType.id
					};
	
					$.ajax({
						type : 'POST',
						url : appUrl('/BudgetProposal'),
						data : JSON.stringify(json),
						contentType : 'application/json;charset=utf-8',
						dataType : "json",
						success : _.bind(function(data) {
							budgetProposal.set('id',data.id);
	
							var json = proposalStrategy.toJSON();
							json.formulaStrategy = null;
							json.proposal = null;

							var i;
							for (i = 0; i < json.requestColumns.length; i++) {
								json.requestColumns[i].column = {
									id : json.requestColumns[i].column.id
								};
							}

							$.ajax({
								type : 'POST',
								url : appUrl('/ProposalStrategy/'
										+ budgetProposal.get('id')
										+ '/'
										+ proposalStrategy.get('formulaStrategy').get('id')),
								data : JSON
										.stringify(json),
								contentType : 'application/json;charset=utf-8',
								dataType : "json",
								success : _.bind(function() {
									budgetProposal.get('proposalStrategies').push(proposalStrategy);
									this.parentModal.render();
									
								},this)
							});

					}, this)
						});
				} else {
					var json = proposalStrategy.toJSON();
					json.formulaStrategy = null;
					json.proposal = null;
	
					var i;
					for (i = 0; i < json.requestColumns.length; i++) {
						json.requestColumns[i].column = {
							id : json.requestColumns[i].column.id
						};
					}
	
					$.ajax({
						type : 'POST',
						url : appUrl('/ProposalStrategy/'
								+ budgetProposal.get('id')
								+ '/'
								+ proposalStrategy.get(
										'formulaStrategy').get('id')),
						data : JSON.stringify(json),
						contentType : 'application/json;charset=utf-8',
						dataType : "json",
						success : _.bind(function() {
							budgetProposal.get('proposalStrategies')
									.push(proposalStrategy);
							// rerender?
							e1 = budgetProposal;
							this.parentModal.render();
						}, this)
					});
				}
	
			}
		},
	
	});

	var BudgetTypeAllSelectionView = Backbone.View.extend({
		initialize: function(options){
			if(options != null) {
				this.level = options.level;
				this.parentModal = options.parentModal;
			} 
			
		},
		selectionTpl : Handlebars.compile($("#selectionTemplate").html()),
		
		render: function(){
			// first clear the siblings select
			this.$el.empty();
			if(this.model != null) {
				this.$el.html(this.selectionTpl(this.model.toJSON()));
			} else {
				this.$el.html(this.selectionTpl({}));
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
					var formulaStrategies = new FormulaStrategyCollection;

					formulaStrategies.fetch({
						url : appUrl('/FormulaStrategy/search/' + fiscalYear + "/" + budgetType.get('id')),
						success : _.bind(function(data) {
							budgetType.set('strategies', formulaStrategies);
							this.parentModal.updateBudgetTypeSelectionLevelWithModel(this.level+1, formulaStrategies);
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
	
	var BudgetTypeSelectionView = Backbone.View.extend({
		initialize : function() {
			_.bindAll(this, 'render');
			_.bindAll(this, 'selectionChange');

		},
		el : "#budgetTypeSelectionDiv",

		strategySelectionView : new StrategySelectionView(),

		budgetSelectionTemplate : Handlebars.compile($(
				'#budgetTypeSelectionTemplate').html()),
		render : function() {
			if (this.currentBudgetTypeCollection != null) {
				var json = this.currentBudgetTypeCollection.toJSON();

				this.$el.html(this.budgetSelectionTemplate(json));
			}
		},
		events : {
			"change #budgetTypeSlt" : "selectionChange" // only the first one

		},

		selectionChange : function(e) {

			var budgetTypeId = $(e.target).val();

			if (budgetTypeId > 0) {
				var budgetType = this.currentBudgetTypeCollection
						.get(budgetTypeId);
				this.currentBudgetType = budgetType;

				// ok now we'll get the strategy here
				var formulaStrategies = new FormulaStrategyCollection;

				formulaStrategies.fetch({
					url : appUrl('/FormulaStrategy/search/' + fiscalYear + "/"
							+ budgetType.get('id')),
					success : _.bind(function(data) {
						budgetType.set('strategies', formulaStrategies);
						this.strategySelectionView
								.setElement("#strategySelectionDiv");

						this.strategySelectionView.renderWithStrategy(
								formulaStrategies, this.parentModal);

					}, this)
				});

			}
		},

		renderWithBudgetTypes : function(budgetTypeCollection, parentmodal) {
			this.parentModal = parentmodal;
			this.currentBudgetTypeCollection = budgetTypeCollection;
			this.render();
		},

		renderWithDisableSelect : function(budgetProposal, proposalStrategy) {
			if (this.currentBudgetTypeCollection != null) {
				var budgetType = budgetProposal.get('budgetType');

				var json = this.currentBudgetTypeCollection.toJSON();

				// now mark the one with selected

				for ( var i = 0; i < json.length; i++) {
					if (json[i].id == budgetType.get('id')) {
						json[i].selected = true;
					}
				}

				json.editStrategy = true;

				this.$el.html(this.budgetSelectionTemplate(json));

				// ok now we'll get the strategy here
				var formulaStrategies = new FormulaStrategyCollection;

				formulaStrategies.fetch({
					url : appUrl('/FormulaStrategy/search/' + fiscalYear + "/"
							+ budgetType.get('id')),
					success : _.bind(function(data) {
						budgetType.set('strategies', formulaStrategies);
						this.strategySelectionView
								.setElement("#strategySelectionDiv");

						this.strategySelectionView.renderWithWithDisableSelect(
								formulaStrategies, proposalStrategy,
								this.parentModal);

					}, this)
				});
			}
		}

	});

	var ModalView = Backbone.View.extend({
		initialize : function() {
			
		},

		el : "#modal",

		
		modalTemplate : Handlebars.compile($('#modalTemplate').html()),
		defaultInputTemplate : Handlebars.compile($('#defaultInputTemplate').html()),

		updateBudgetTypeSelectionLevelWithModel: function(level, model) {
			level = level-1;
			var btView = this.budgetTypeSelctionArray[level];
			if(level==4) {
				btView.setRootModel(model,true);
				$('#input-form').html(this.defaultInputTemplate({}));
			} else {
				btView.setRootModel(model);
				$('#input-form').empty();
			}
			btView.render();
			
			// and for the rest set to null
			for(var i=level+1; i<this.budgetTypeSelctionArray.length; i++) {
				this.budgetTypeSelctionArray[i].setRootModel(null);
				this.budgetTypeSelctionArray[i].render();
			}
			
		},
		
		events : {
			"click .removeProposal" : "removeProposal",
			"click .editProposal" : "editProposal",
			"click #cancelBtn" : "cancelModal",
			"click .close" : "cancelModal"

		},

		cancelModal : function(e) {
			window.location.reload();
		},
		editProposal : function(e) {
			var proposalStrategyId = $(e.target).parents('li').attr('data-id');
			var budgetProposalId = $(e.target).parents('li').attr('proposal-id');

			// now get this one
			var budgetProposal = this.objective.get('filterProposals').get(budgetProposalId);
			var proposalStrategy = budgetProposal.get('proposalStrategies').get(proposalStrategyId);

			// we'll begin by render the budgetTypeSelectionView
			this.budgetTypeSelectionView.renderWithDisableSelect(budgetProposal, proposalStrategy);

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

		render : function() {
			if (this.objective != null) {
				var html = this.modalTemplate(this.objective.toJSON());
				this.$el.find('.modal-header span').html(
						this.objective.get('name'));
				this.$el.find('.modal-body').html(html);
				
				var rootBudgetType = BudgetType.findOrCreate({id:0});
			    rootBudgetType.fetch({success: _.bind(function(){
			    	this.budgetTypeSelectionViewL1 =  new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL1 > div', level: 1, parentModal: this});
					this.budgetTypeSelectionViewL2 = new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL2 > div', level: 2, parentModal: this});
					this.budgetTypeSelectionViewL3 = new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL3 > div', level: 3, parentModal: this});
					this.budgetTypeSelectionViewL4 = new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL4 > div', level: 4, parentModal: this});
					this.startegySelectionView = new StrategySelectionView({el: '#inputAll', parentModal: this});

					this.budgetTypeSelctionArray = [];
					this.budgetTypeSelctionArray.push(this.budgetTypeSelectionViewL1);
					this.budgetTypeSelctionArray.push(this.budgetTypeSelectionViewL2);
					this.budgetTypeSelctionArray.push(this.budgetTypeSelectionViewL3);
					this.budgetTypeSelctionArray.push(this.budgetTypeSelectionViewL4);
					this.budgetTypeSelctionArray.push(this.startegySelectionView);

					
					
			    	this.budgetTypeSelectionViewL1.$el = $('#budgetTypeSelectionDivL1 > div');
			    	this.budgetTypeSelectionViewL1.setRootModel(rootBudgetType);
			    	this.budgetTypeSelectionViewL1.render();
			    	
			    	
			    	this.budgetTypeSelectionViewL2.$el = $('#budgetTypeSelectionDivL2 > div');
			    	this.budgetTypeSelectionViewL1.setRootModel(null);
			    	this.budgetTypeSelectionViewL2.render();
			    	
			    	this.budgetTypeSelectionViewL3.$el = $('#budgetTypeSelectionDivL3 > div');
			    	this.budgetTypeSelectionViewL1.setRootModel(null);
			    	this.budgetTypeSelectionViewL3.render();
			    	
			    	this.budgetTypeSelectionViewL4.$el = $('#budgetTypeSelectionDivL4 > div');
			    	this.budgetTypeSelectionViewL1.setRootModel(null);
			    	this.budgetTypeSelectionViewL4.render();
			    	
			    	this.startegySelectionView.$el = $('#inputAll');
			    	this.startegySelectionView.renderWithStrategy(null, this, null);
			    	this.startegySelectionView.render();
		    	},this)});
				
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

	var MainTblView = Backbone.View.extend({
		initialize : function() {
			this.collection.bind('reset', this.render, this);
			_.bindAll(this, 'detailModal');
			
			// puting loading sign
			this.$el.html(this.loadingTpl());
		},

		el : "#mainCtr",
		loadingTpl : Handlebars.compile($("#loadingTemplate").html()),
		mainTblTpl : Handlebars.compile($("#mainCtrTemplate").html()),
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
				url : appUrl('/ProposalStrategy/find/' + fiscalYear + '/'
						+ currentObjective.get('id')),
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
			this.$el.find('#mainTbl tbody td:first-child', this).each(function(i){
		        $(this).html((i+1) + ".");
		    });

			

		},

		toggle : function(e) {
			l = e;
			var clickLevel = $(l.target).parents('tr').attr('data-level');
			$(l.target).next('label').find('icon').toggleClass("icon-caret-right icon-caret-down");

			var currentTr = $(l.target).parents('tr');

			currentTr.nextUntil('tr[data-level=' + clickLevel + ']').toggle();
		}

	});

	$(document).ready(function() {

		if (objectiveId != null && objectiveId.length > 0) {
			objectiveCollection = new ObjectiveCollection();
			
			rootCollection = new ObjectiveCollection();
			

			objectiveCollection.url = appUrl("/ObjectiveWithBudgetProposal/" + fiscalYear+ "/" + objectiveId + "/flatDescendants");

			mainTblView = new MainTblView({
				collection : rootCollection
			});

			//load curent objective 
			parentObjective = new Objective({
				id : objectiveId
			});
			parentObjective.url = appUrl("/Objective/" + objectiveId);
			
			
			parentObjective.fetch({
				success : function() {
					objectiveCollection.fetch({
						success : function() {
							// we will now sorted out this mess!
							var i;
							for (i = 0; i < objectiveCollection.length; i++) {
								var o = objectiveCollection.at(i);
								if (o.get('parent') != null) {
									var parentId = o.get('parent').get('id');
									if (parentId == objectiveId) {
										rootCollection.add(o);
									}

								var parentObj = objectiveCollection.get(parentId);
									if (parentObj != null) {
										parentObj.get('children').add(o);
									}
								}
							}
							rootCollection.add(objectiveCollection.where({parent: parentObjective}));
							rootCollection.trigger('reset');
							
						}
					});
				}
			});
		}

	});
</script>
