<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>การปรับลดทะเบียนรายการ รอบที่ 1</h4>	
</div>

<div id="budgetRootSlt">
</div>

<div class="row">
	<div class="span11">
		<div id="standardPriceModal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<a href="#"	class="btn btn-primary" id="backBtn">กลับหน้าหลัก</a>
			</div>
		</div>

		<div id="formulaLineModal" class="modal wideModal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<button class="btn btn-primary" id="saveStrategyBtn"><i class="icon-save"></i> บันทึก</button>
				<a href="#"	class="btn" id="backBtn">กลับหน้าหลัก</a>
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
						<c:forEach items="${fiscalYears}" var="fiscalYear">
						<tr>
								<td> <a href="./${fiscalYear.fiscalYear}/" class="nextChildrenLnk">${fiscalYear.fiscalYear}<i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
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

<script id="budgetSltTemplate" type="text/x-handler-template">
<span style="vertical-align: middle"><strong>{{this.0.level.name}}: </strong></span>
<select id="budgetTypeSlt" class="type">
	<option value="0">กรุณาเลือกหมวดงบประมาณ</option>
	{{#each this}}
		<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.name}}</option>
	{{/each}}
</select>
<div></div>
</script>

<script id="formulaLineModalTemplate" type="text/x-handlebars-template">
{{#if isStandardItem}}
	<div style="border-bottom: 1px solid #C0C0C0;padding-bottom: 2px; margin-bottom:10px;font-weight:bold;">
		<b>การคำนวณ</b>
	</div>
	<div id="formulaColumnFormCtr"></div>
	<form class="form-inline">
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
				<input type="text" id="standardPriceTxt" style="width:70px;" value="{{allocationStandardPriceMap.0.standardPrice}}"></input> &times;
			</div>
		</div>
	</div>
	</form>
{{else}}
	<form id="strategyForm" class="form-horizontal">
		<div class="control-group">
			<label class="control-label" for="c">ชื่อรายการ</label>
			<div class="controls">
				<input type="text" id="strategyName" placeholder="..." value="{{name}}"> 
			</div>
		</div>
	</form> 
	{{#if id}}
	<div style="border-bottom: 1px solid #C0C0C0;padding-bottom: 2px; margin-bottom:10px;font-weight:bold;">
		<b>การคำนวณ</b>
	</div>
	<div id="formulaColumnFormCtr"></div>
	<form class="form-inline">
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
				<input type="text" id="standardPriceTxt" style="width:70px;" value="{{allocationStandardPriceMap.0.standardPrice}}"></input> &times;
			</div>
		</div>
	</div>
	</form>
	{{/if}}
{{/if}}

</script>

<script  id="formulaColumnTemplate" type="text/x-handlebars-template">
<div style="height:35px;margin-bottom:10px;">
	<input type="text" class="unitName"  style="width:70px;" value={{unitName}}></input>
</div>
<div style="height:35px;">
	<input type="text" style="width:70px;" value="<ขอตั้งระบุ>" disabled="disabled"/> 
	{{#unless noTimesSign}}
		<span class="times">{{#if lastColumn}} {{else}} &times;{{/if}}</span>
	{{/unless}}
</div>
</script>

<script id="formulaColumnFormTemplate" type="text/x-handlebars-template">
<div class="well">
<form id="addFormulaForm" {{#unless columnName}}newForm="true"{{/unless}}
	{{#if id}}data-id="{{id}}"{{/if}}>
		<label>ชื่อรายการ</label>
		<input type="text" name="columnName" value="{{columnName}}"/>
		<label class="checkbox">หน่วยขอตั้งเป็นผู้ระบุจำนวน/งบประมาณ
		<input type="checkbox" name="isFixed" {{#if isFixed}}checked="checked"{{/if}}/></label>
		<input type="text" name="value" {{#if isFixed}}disabled="disabled"{{/if}} value="{{value}}"/>
		<label>หน่วยนับ</label>
		<input type="text" name="unitName" value="{{unitName}}"/>
		<br/>
		<button class="btn btn-mini cancelFormulaColumnBtn">ยกเลิก</button>
		{{#if columnName}}<button class="btn btn-mini deleteFormulaColumnBtn">ลบรายการ</button>{{/if}}
		<button class="btn btn-mini btn-primary addFormulaColumnBtn">{{#if columnName}}แก้ไขรายการ{{else}}เพิ่มชื่อทะเบียน{{/if}}</button>
</form>
</div>
</script>

<script id="formulaLineTemplate" type="text/x-handlebars-template">
{{{formulaLine this true}}} 
</script>
<script id="formulaInLinEditTemplate" type="text/x-handlebars-template">
	<div style="margin-top:4px; margin-bottom:4px;">
		<input type="text" data-id="{{id}}" value="{{name}}"/> 
		<button class="btn btn-mini updateFormulaStrategy"><i class="icon-ok icon-white"/> แก้ไข</button>
		<button class="btn btn-mini cancelUpdateFormulaStrategy"><i class="icon-remove icon-white"/> ยกเลิก</button>
	</div>
</script>
<script id="formulaTemplate" type="text/x-handlebars-template">
{{#each this}}
	<li data-id={{id}} style="list-style-type: none; padding: 0;"> <input type="radio" data-id="{{../id}}" name="formulaSlt-{{../id}}" id="formulaSlt-{{../id}}" value="{{id}}"> {{name}} = {{{formulaLine formulaColumns false}}} </input> 
	</li>
{{/each}}
</script>

<script id="mainCtrTemplate" type="text/x-handler-template">
<div class="control">
		<form class="form-search">
				<div class="input-append pull-left">
					<input type="text" id="searchQuery" class="span2 search-query" value="{{searchTxt}}">
					<button type="submit" id="search" class="btn">ค้นหาทะเบียน</button>
				</div> &nbsp;
				<button type="submit" id="searchDisplayAll" class="btn">แสดงผลทั้งหมด</button>
		</form>
</div>
{{#if hasPage}}
    <div class="pagination pagination-small">
        <span style="border: 1px;">พบทั้งสิ้น {{totalElements}} รายการ </span> <b>หน้า : </b> <ul>
		{{#each page}}
			{{#if isActive}}<li class="pageLink active disable"><a href="#">{{pageNumber}}</a></li>{{else}}
		    	<li><a href="#" class="pageLink" data-id="{{pageNumber}}">
					{{#if isPrev}}&laquo;{{/if}} 
					{{#if isNext}}&raquo;{{/if}}
					{{#if showPageNumber}} {{pageNumber}} {{/if}}
					</a>
				</li>
			{{/if}}
	    {{/each}}
    </div>
{{/if}}
<div id="newRowCtr">
</div>
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td style="width:15px;"></td>
			<td style="width:80px;">หมวดหลัก</td>
			<td style="width:80px;">หมวดย่อย</td>
			<td style="width:100px;">รายการหลัก</td>
			<td >รายการ</td>		

			<td style="width:60px;">หน่วยนับ</td>
			<td style="width:100px;">รายการกลาง</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>

<script id="budgetTypeRowTemplate" type="text/x-handelbars-template">
<td><input type="radio" name="rowRdo" id="rdo_{{index}}" value="{{index}}"/></td>
	<td> {{budgetTypeName parentIds.[1]}}</td>
	<td> {{budgetTypeName parentIds.[2]}}	</td>
	<td> {{budgetTypeName parentIds.[3]}} </td>
	<td> <a href="#" class="showFormulaToolBar">[{{code}}] {{name}} 
		{{#if standardStrategy}} {{#with  standardStrategy}}
			= {{formatNumber allocationStandardPriceMap.0.standardPrice}} บาท &times; {{{formulaLine formulaColumns false}}}
  		{{/with}} {{/if}} </a>
		{{#if strategies}}
			<div><u>รายการย่อย</u></div>
			<ul>
				{{#each strategies}}
				<li data-id="{{id}}"><a href="#" class="editStrategy">{{name}} = {{formatNumber allocationStandardPriceMap.0.standardPrice}} บาท &times; {{{formulaLine formulaColumns false}}}</a></li>
				{{/each}}
			</ul>
		{{/if}}
	</td>
	<td> {{unit.name}} </td>
	<td> {{commonType.name}} </td>
</script>

<script id="formulaCellTemplate" type="text/x-handlebars-template">
<strong>[{{code}}] {{name}} {{#if standardStrategy}} {{#with  standardStrategy}}
			= {{formatNumber allocationStandardPriceMap.0.standardPrice}} บาท &times; {{{formulaLine formulaColumns false}}}
  		{{/with}} {{/if}} </a>
</strong> <br/>
<button class='btn btn-mini btn-info addDefaultFormula'>กำหนดราคา</button>
<button class='btn btn-mini btn-danger cancelFormula'>กลับ</button>

</script>


<script id="tbodyTemplate" type="text/x-handlebars-template">
{{#each this}}
<tr data-id="{{id}}" budgetType-id="{{type.id}}">
</tr>
{{/each}}
</script>

<script id="editRowTemplate" type="text/x-handelbars-template">
<td><input type="radio" name="rowRdo" id="rdo_{{index}}" value="{{index}}" checked="checked"/></td>
	<td> {{budgetTypeName parentIds.[1]}}</td>
	<td> {{budgetTypeName parentIds.[2]}}	</td>
	<td> {{budgetTypeName parentIds.[3]}} </td>
	<td> [{{code}}] <br/><input type="text" id="nameTxt" value="{{name}}"/> 
		<br/>
		<button class='btn btn-mini btn-info lineUpdate'>บันทึกข้อมูล</button>
		<button class='btn btn-mini btn-danger cancelLineUpdate'>ยกเลิก</button>
	</td>
	<td> {{unit.name}} </td>
	<td> {{commonType.name}} </td>
</script>

<script id="newRowTemplate" type="text/x-handlebars-template">
	<div class="well">
		 <form class="form-inline" data-id="{{id}}">
			<div class="control-group">
				{{#if this.editBudgetType}}
					<b>แก้ไขรายการย่อย</b>
				{{else}}
					<div class="controls  budgetTypeSlt">
					</div>
				{{/if}}
			</div>

			<div class="control-group">
				<label class="control-label" for="nameTxt"> <b>ชื่อรายการ:</b> </label>
				<div class="controls">
					<input id="nameTxt" type='text' placeholder='...' class='span7' value="{{name}}"></input> <br/>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="unit"> <b>หน่วยนับ:</b> </label>
				<div class="controls">
					<select id="unitSlt">
						<option value="0">กรุณาเลือก</option>
						{{#each unitList}}
							<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.name}}</option>
						{{/each}}
					</select>
				</div>
			</div>

			<div class="control-group">
				<label class="control-label" for="unit"> <b>รายการกลาง:</b> </label>
				<div class="controls">
					<select id="commonTypeSlt">
						<option value="0">กรุณาเลือก</option>
						{{#each commonTypeList}}
							<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.name}}</option>
						{{/each}}
					</select>
				</div>
			</div>
		</form>

		<button indexHolder='{{index}}' class='btn btn-mini btn-info lineSave' data-id="{{id}}">บันทึกข้อมูล</button>
		<button indexHolder='{{index}}' class='btn btn-mini btn-danger cancelLineSave'>ยกเลิก</button>
	</div>
</script>


<script src="<c:url value='/resources/js/pages/m63f05.js'/>"></script>


<script type="text/javascript">
Handlebars.registerHelper("budgetTypeName", function(typeId) {
	if(typeId != null) {
		var type = parentBudgetTypeCollection.get(typeId);
		if(type != null) {
			return type.get('name');
		} else {
			type = BudgetType.findOrCreate(typeId);
			if(type == null) {
				type = new BudgetType();
				type.set('id', typeId);
				$.ajaxSetup({async:false});
				type.fetch({
					success: function() {
						parentBudgetTypeCollection.add(type);
						
					}
				});
				$.ajaxSetup({async:true});
				return type.get('name');
			} else {
				parentBudgetTypeCollection.add(type);
				return type.get('name');
			}
		}
	}
});


Handlebars.registerHelper("parentBudgetType", function(type){
	if(type != null ) return type.name;
	return null;
});

Handlebars.registerHelper("formulaLine", function(formulaColumns, editForm){
	var s = "";
	if(editForm == false) {
		s = s+ "";
		
		if(formulaColumns == null || formulaColumns.length == 0) {
			s =	s+"เพิ่มรายการคำนวณ";
		}
	}
	
	if(formulaColumns != null) {
		for(var i=0; i < formulaColumns.length; i++) {
			
			if(i>0) { 
				s = s + " &times; "; 
			}
			
			if(editForm == true) {
				s = s + "<a class='editSpan' href='#' data-id="+ formulaColumns[i].id +">"; 
			}
			if(!formulaColumns[i].isFixed) {
				s = s + formulaColumns[i].unitName  + "";
			} else {
				s = s + " " + formulaColumns[i].unitName  + " ";
			}
			if(editForm == true) {
				s = s + "";
			}
		}
	} 
	if(editForm == true) {
		if(formulaColumns.length > 0) {
			s = s + " X ";
		}
		s = s + "<a href='#' class='editSpan'>เพิ่มคอลัมน์</a>";
	}else {
		s += "";	
	}
	
	
	return s;
});


var fiscalYear = "${fiscalYear}";
var typeId;

var pageUrl = "/page/ท63ด05/";

var mainTblView;
var budgetTypeSltView;
var rootBudgetType = new BudgetType({id: 0});

var e1,e2;

var formulaStrategyCollection = new FormulaStrategyCollection();
var parentBudgetTypeCollection = new BudgetTypeCollection();
var budgetTypeRootCollection = new BudgetTypeCollection();



var listTargetUnits = new TargetUnitCollection();
listTargetUnits.fetch({
	url: appUrl('/TargetUnit/')
});

var listBudgetCommonType = new BudgetCommonTypeCollection();
listBudgetCommonType.fetch({
	url: appUrl('/BudgetCommonType/fiscalYear/'+fiscalYear + "/")
});

 
$(document).ready(function() {
	

	
	var headLineStr = '<h4> การปรับลดทะเบียนรายการและรายการย่อย';
	if(fiscalYear!= null && fiscalYear.length > 0 ) {
		headLineStr += 	" ปีงบประมาณ " + fiscalYear + "  รอบที่ 1";
	
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