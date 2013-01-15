<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>ทะเบียนรายการและระดับรายการ</h4>	
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
				<input type="text" id="standardPriceTxt" style="width:70px;" value="{{standardPrice}}"></input> &times;
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
				<input type="text" id="standardPriceTxt" style="width:70px;" value="{{standardPrice}}"></input> &times;
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
		<span class="times">{{#if lastColumn}}<button type="button" id="timesAddBtn"> &times;</button>{{else}} &times;{{/if}}</span>
	{{/unless}}
</div>
{{#unless noTimesSign}}
<div style="text-align: center;">
	<a href="#" class="deleteFormulaColumn" style="color:#BD362F;"><span><i class="icon-trash"></i> ลบ</span></a>
</div>
{{/unless}}
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
					<button type="submit" id="search" class="btn">ค้นหารายการ</button>
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
<div class="controls" style="margin-bottom: 15px;">
	<a href="#" class="btn btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มชื่อทะเบียน</a>
	<a href="#" class="btn btn-primary menuEdit"><i class="icon icon-edit icon-white"></i> แก้ไขทะเบียน</a>
	<a href="#" class="btn btn-danger menuDelete"><i class="icon icon-trash icon-white"></i> ลบรายการ</a> 
</div>
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
			= {{formatNumber standardPrice}} บาท &times; {{{formulaLine formulaColumns false}}}
  		{{/with}} {{/if}} </a>
		{{#if strategies}}
			<div><u>รายการย่อย</u></div>
			<ul>
				{{#each strategies}}
				<li data-id="{{id}}"><a href="#" class="deleteStrategy" style="color:#BD362F;"><span><i class="icon-trash"></i></span></a><a href="#" class="editStrategy">{{name}} = {{formatNumber standardPrice}} บาท &times; {{{formulaLine formulaColumns false}}}</a></li>
				{{/each}}
			</ul>
		{{/if}}
	</td>
	<td> {{unit.name}} </td>
	<td> {{commonType.name}} </td>
</script>

<script id="formulaCellTemplate" type="text/x-handlebars-template">
<strong>[{{code}}] {{name}} {{#if standardStrategy}} {{#with  standardStrategy}}
			= {{formatNumber standardPrice}} บาท &times; {{{formulaLine formulaColumns false}}}
  		{{/with}} {{/if}} </a>
</strong> <br/>
<button class='btn btn-mini btn-info addFormula'>เพิ่มรายการย่อย</button>
<button class='btn btn-mini btn-info addDefaultFormula'>กำหนดราคา</button>
<button class='btn btn-mini btn-danger deleteDefaultFormula'>ลบการกำหนดราคา</button>
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

var pageUrl = "/page/m51f09/";

var mainTblView;
var budgetTypeSltView;
var rootBudgetType = new BudgetType({id: 0});

var e1,e2;

var formulaStrategyCollection = new FormulaStrategyCollection();
var budgetTypeCollection = new BudgetTypePagableCollection();
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
	
	var FormulaColumnView = Backbone.View.extend({
		formulaColumnTemplate: Handlebars.compile($("#formulaColumnTemplate").html()),
		initialize: function(options) {
			if(options != null) {
				this.el = options.el;
				this.formulaColumn = options.formulaColumn;
				this.lastColumn = options.lastColumn;
				this.parentStrategy = options.parentStrategy;
				this.parentModal = options.parentModal;
				this.nth = options.nth;
			}
			this.active = true;
		},
		
		render: function() {
			var json=this.formulaColumn.toJSON();
			if(this.lastColumn) {
				json.lastColumn=true;
			}
			
			if(this.parentStrategy.get('isStandardItem') == true) {
				json.noTimesSign = true;
			}
			
			var html=this.formulaColumnTemplate(json);
			this.$el.html(html);
		},
		
		removeAddTimesBtn: function() {
			var spanEl = this.$el.find('span.times');
			spanEl.empty();
			spanEl.html(' &times');
			this.lastColumn = false;
			
		},
		putAddTimesBtn: function() {
			var spanEl = this.$el.find('span.times');
			spanEl.empty();
			spanEl.html('<button type="button" id="timesAddBtn"> &times;</button>');
			this.lastColumn = true;
			
		},
		
		events: {
			
			"change .unitName" : "changeUnitName",
			"click a.deleteFormulaColumn" : "removeSelf"
			
		},
		changeUnitName: function(e) {
			this.formulaColumn.set('unitName',$(e.target).val());
		},
		removeSelf: function(e) {
			
			var activeList = _.where(this.parentModal.formulaColumnDiv, {active: true});
			if( activeList.length == 1) {
				alert("คุณไม่สามารถลบรายการคำนวณสุดท้ายได้");
				return false;
			}
			
			this.active = false;
			activeList = _.where(this.parentModal.formulaColumnDiv, {active: true});
			
			if(this.lastColumn) {
				// we need to toggle the one before us!?
				e1=this;						
				var maxNextFcView = _.max(activeList, function(fcView) { return fcView.nth; } );
				maxNextFcView.putAddTimesBtn();
			}
			
			
			this.$el.empty();
			this.$el.css("padding", "0px");
			this.parentStrategy.get('formulaColumns').remove(this.formulaColumn);
			return false;
		}
	});
	
	var FormulaLineModalView = Backbone.View.extend({
		initialize: function(options) {
			_.bindAll(this,'back');
			_.bindAll(this,'addFormulaColumn');
			_.bindAll(this,'renderFormulaLineWith');
			
			if(options != null) {
				this.isStandardItem = options.isStandardItem;
			} else {
				this.isStandardItem = false;
			}
			
		},
		el: "#formulaLineModal",
		model: null,
		formulaLineModalTemplate: Handlebars.compile($("#formulaLineModalTemplate").html()),
		formulaLineTemplate: Handlebars.compile($("#formulaLineTemplate").html()),
		formulaColumnFormTemplate: Handlebars.compile($("#formulaColumnFormTemplate").html()),
		
		collection: new FormulaColumnCollection(),
		
		render: function() {
			var html;
			if( this.currentStrategy.get('id') == null )  {
				html = this.isStandardItem ? "เพิ่มราคากลาง" : "เพิ่มรายการย่อย";
			} else {
				html = this.isStandardItem ? "แก้ไขราคากลาง" : "แก้ไขรายการย่อยและการกำหนดราคาต่อหน่วย (บาท/หน่วยนับ)";
			}
			this.$el.find('.modal-header span').html(html);
			
			
			html = this.formulaLineModalTemplate(this.currentStrategy.toJSON());
			
			// if formulaColumns is no go
			var formulaColumns = this.currentStrategy.get('formulaColumns');
			if((formulaColumns.length == 0 && this.currentStrategy.get('id') != null) || 
					(formulaColumns.length == 0 && this.currentStrategy.get('isStandardItem') == true)) {
				var fc = new FormulaColumn();
				formulaColumns.add(fc);
			}
			
			
			this.$el.find('.modal-body').html(html);
			
			// now add div
			this.formulaColumnDiv = [];
			for(var i=0; i<formulaColumns.length; i++) {
				$('#formulaBox').append("<div></div>");
				
				var nthDiv = i+3;
				var el = "#formulaBox > div:nth-child("+ nthDiv +")";
				var lastColumn = false;
				if(i==formulaColumns.length-1) {
					lastColumn = true;
				}
				var fcView = new FormulaColumnView({el: el, formulaColumn: formulaColumns.at(i),
					lastColumn: lastColumn, parentStrategy: this.currentStrategy, parentModal: this, nth: nthDiv}); 
				this.formulaColumnDiv.push(fcView);
				fcView.render();
			}
			
			
			
			this.$el.modal({show: true, backdrop: 'static', keyboard: false});
		},
		
		renderFormulaLineWith: function(formulaStrategy, budgetType){
			if(formulaStrategy != null) {
				this.currentStrategy = formulaStrategy;
				this.currentBudgetType = budgetType;
				this.isStandardItem = formulaStrategy.get('isStandardItem');
				if(this.currentStrategy.get('formulaColumns') != null) {
					this.collection = this.currentStrategy.get('formulaColumns');
				};
				
				this.collection.bind('add', this.addNewFormulaColumn, this);
				this.render();
			}
		},
		
		events: {
			
			"click #backBtn" : "back",
			"click #saveStrategyBtn" : "saveStrategy",
			"click #timesAddBtn" : "addFormulaColumn"
			
		},
		addFormulaColumn : function(e) {
			var formulaColumns = this.currentStrategy.get('formulaColumns');
			var fc = new FormulaColumn();
			formulaColumns.add(fc);			
			
			e2=formulaColumns;
			$('#formulaBox').append("<div></div>");
			
			var nthDiv = formulaColumns.length + 2;
			var el = "#formulaBox > div:nth-child("+ nthDiv +")";
			
			var fcView = new FormulaColumnView({el: el, formulaColumn: fc, lastColumn: true, parentStrategy: this.currentStrategy, parentModal: this, nth: nthDiv});
			var lastFcView = _.last(this.formulaColumnDiv);
			lastFcView.removeAddTimesBtn();
			
			this.formulaColumnDiv.push(fcView);
			fcView.render();
			
			return false;
			
		},
		
		saveStrategy: function(e) {
			var nameTxt = this.$el.find("#strategyName").val();
			var standardPriceTxt = this.$el.find("#standardPriceTxt").val();
			var newStrategy = false;
			if(this.currentStrategy.get('id') == null) {
				newStrategy = true;
			}
			
			if(this.currentStrategy.get('isStandardItem') == true) {
				this.currentStrategy.set('name', this.currentBudgetType.get('name'));
			} else {
				this.currentStrategy.set('name', nameTxt);
			}
			this.currentStrategy.set('standardPrice', standardPriceTxt);
			this.currentStrategy.set('fiscalYear', fiscalYear);
			this.currentStrategy.set('isStandardItem', this.isStandardItem == null ? false : this.isStandardItem);
			
			var fcList = this.currentStrategy.get('formulaColumns');

			if(fcList.length > 0) {
				for(var i=0; i<fcList.length; i++) {
					fcList.at(i).set('index', i);
				}
			}
			
			this.currentStrategy.save(null, {
				success: _.bind(function() {
					if(newStrategy) {
						if(this.currentStrategy.get('isStandardItem') == true) {
							this.currentBudgetType.set('standardStrategy',this.currentStrategy);
						} else {
							this.currentBudgetType.get('strategies').add(this.currentStrategy);
						}
						
						
					}
					this.currentStrategy.get('formulaColumns').comparator = function(formulaColumn) {
						  return formulaColumn.get("index");
					};
					this.currentStrategy.get('formulaColumns').sort();
					
					this.render();
				},this)
			});
			
			return false;
		},
		
		back: function(e) {
			if(this.currentStrategy.get('formulaColumns') == null) {
				this.currentStrategy.set('formulaColumns', this.collection);
			}
			
			
			this.currentStrategy.trigger('changeFormula', this.currentStrategy);
			this.currentBudgetType.trigger('renderRow', this.currentBudgetType);
			
			// nothing to recover just hide!
			this.$el.modal('hide');
		}
		
	});
	
	var MainTblView = Backbone.View.extend({
		initialize: function(options){
		    this.collection.bind('reset', this.render, this);
		},
	
		el: "#mainCtr",
		selectedObjective: null,
		currentLineVal: null,
		
		newRowTemplate: Handlebars.compile($("#newRowTemplate").html()),
		editRowTemplate: Handlebars.compile($("#editRowTemplate").html()),
		formulaCellTemplate: Handlebars.compile($("#formulaCellTemplate").html()),
		mainCtrTemplate: Handlebars.compile($("#mainCtrTemplate").html()),
		tbodyTemplate: Handlebars.compile($("#tbodyTemplate").html()),
		budgetTypeRowTemplate: Handlebars.compile($("#budgetTypeRowTemplate").html()),
		
		formulaInLineEditTpl : Handlebars.compile($("#formulaInLinEditTemplate").html()),
		formulaLineModalView : new FormulaLineModalView(),
		
		render: function() {
			// first render the control
			
			var json = this.collection.toPageParamsJSON();
			json.searchTxt = this.searchTxt;
			var html = this.mainCtrTemplate(json);
			
			this.$el.html(html);
			
			// then the inside row
			json=this.collection.toJSON();
			json.pageParams = this.collection.toPageParamsJSON();
		
			
			html = this.tbodyTemplate(json);
			this.$el.find('tbody').html(html);

			// bind all cell
			this.collection.each(function(model){

				model.bind('change', this.renderObjective, this);
				model.bind('changeFormula', this.renderChild, this);
				this.renderFormulaStrategy(model);
			}, this);

			return this;
		},
		
		renderTargetPage: function(page) {
			// we have to refresh collection
			this.collection.setTargetPage(page);
			if(this.searchTxt == null) {
				this.collection.fetch();
			} else {
				this.collection.fetch({
					type: 'POST',
					data: {
						query: this.searchTxt
					}
				});
			}
		},
		
		renderRow: function(budgetType) {
			var currentTr = this.$el.find('tr[data-id='+budgetType.get('id')+']');
			
			$(currentTr).empty();
			$(currentTr).html(this.budgetTypeRowTemplate(budgetType.toJSON()));
		},
		
		events: {
			"click .menuNew" : "newRow",
			"click .menuDelete" : "deleteRow",
			"click .menuEdit"	: "editRow",
			"click .lineSave" : "saveLine",
			"click .lineUpdate" : "updateLine",
			"click .cancelLineSave" : "cancelSaveLine",
			"click .cancelLineUpdate" : "cancelUpdateLine",
			"click button#search" : "searchBtnClick",
			"click button#searchDisplayAll" : "searchDisplayAllBtnClick",

			"click a.pageLink" : "gotoPage",
			
			"click a.showFormulaToolBar" : "showFormulaToolBar",
			
			"click button.addFormula" : "addFormula",
			"click button.addDefaultFormula" : "addDefaultFormula",
			"click button.deleteDefaultFormula" : "deleteDefaultFormula",
			"click button.cancelFormula" : "cancelFormula",
			"click a.deleteStrategy" : "deleteStrategy",
			"click a.editStrategy" : "editStrategy",
			
			"click .editFormulaLineBtn" : "editFormulaLine"
				
			
		},
		
		gotoPage: function(e) {
			var pageNumber = $(e.target).attr('data-id');
			this.renderTargetPage(pageNumber);
		},
		
		deleteStrategy: function(e) {
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			
			var currentFormulaId = $(e.currentTarget).parents('li').attr('data-id');
			var currentFormula = FormulaStrategy.findOrCreate(currentFormulaId);

		
			if(confirm("คุณต้องการลบข้อมูลสูตรการคำนวณ: " + currentFormula.get('name'))) {
				currentFormula.destroy({
					success: _.bind(function() {
						this.renderRow(currentBudgetType);
					},this)
				});
			}
		},
		
		editStrategy: function(e) {
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			currentBudgetType.on('renderRow', this.renderRow, this);
			
			var currentFormulaId = $(e.currentTarget).parents('li').attr('data-id');
			var currentFormula = FormulaStrategy.findOrCreate(currentFormulaId);

			this.formulaLineModalView.renderFormulaLineWith(currentFormula, currentBudgetType);
		},
		
		addFormula: function(e) {
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			currentBudgetType.on('renderRow', this.renderRow, this);
			
			var currentFormula = new FormulaStrategy();
			currentFormula.set('type', currentBudgetType);
			

			this.formulaLineModalView.renderFormulaLineWith(currentFormula, currentBudgetType);
		},
		 
		addDefaultFormula: function(e) {
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			currentBudgetType.on('renderRow', this.renderRow, this);
			
			var currentFormula = currentBudgetType.get('standardStrategy');
			if(currentFormula == null) {
				currentFormula = new FormulaStrategy();
				currentFormula.set("type", currentBudgetType);
				currentFormula.set("name", currentBudgetType.get('name'));
				currentFormula.set("isStandardItem", true);
			} 

			this.formulaLineModalView.renderFormulaLineWith(currentFormula, currentBudgetType);
		},
		
		deleteDefaultFormula: function(e) {
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			currentBudgetType.on('renderRow', this.renderRow, this);
			
			var currentFormula = currentBudgetType.get('standardStrategy');
			if(currentFormula != null) {
				currentFormula.destroy({
					success: function(){
						alert("คุณได้ลบข้อมูลแล้ว");
						currentBudgetType.trigger('renderRow', currentBudgetType);
					}
				});
			} 
		},
		
		cancelFormula : function(e) {
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			
			this.renderRow(currentBudgetType);
			
		},
		
		showFormulaToolBar : function(e) {
		
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			var currentTd = $(e.currentTarget).parents('td');
			
			
			
			$(currentTd).empty();
			var json = currentBudgetType.toJSON();
			var html = this.formulaCellTemplate(json);
			$(currentTd).html(html);
			
			return false;
			
		},
		
		searchDisplayAllBtnClick: function(e) {
			this.searchTxt = null;
			this.collection.setTargetPage(1);
			this.collection.fetch();
			return false;
		},
		
		searchBtnClick: function(e) {
			this.searchTxt = this.$el.find('#searchQuery').val();
			this.collection.setTargetPage(1);
			this.collection.fetch({
				type: 'POST',
				data: {
					query: this.searchTxt
				}
			});
			return false;
		},
		
		editFormulaLine : function(e) {
			var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('budgetType-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			
			var currentFormulaId = $(e.currentTarget).parents('tr').attr('data-id');
			var currentFormula = FormulaStrategy.findOrCreate(currentFormulaId);

			this.formulaLineModalView.renderFormulaLineWith(currentFormula, currentBudgetType);
		},
		
		newRow: function(e) {
			if(! $(e.currentTarget).hasClass('disabled') ) {
				var json = {};
				json.index = this.collection.length;
				
				json.unitList = listTargetUnits.toJSON();
				
				json.commonTypeList = listBudgetCommonType.toJSON();
				
				
				$('#newRowCtr').html(this.newRowTemplate(json));
				var currentBudgetTypeId = $('select#budgetTypeSlt').val();
				
				//now populate the budgetTypeSlt
			    var budgetTypeSlt = BudgetType.findOrCreate({id: currentBudgetTypeId});
			    budgetTypeSlt.fetch({success: _.bind(function(){
			    	if(budgetTypeSlt.get('children').length > 0) {
			    		this.budgetTypeSelection = new BudgetTypeSelectionView({
			    			model: budgetTypeSlt, el:'.budgetTypeSlt', mainTblView: this});
			    		this.budgetTypeSelection.render();
			    	}
		    	},this)});
				
				
				this.$el.find('a.btn').toggleClass('disabled');
			}
		},
		
		editRow: function(e) {
			var fsId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
			
			if((! $(e.currentTarget).hasClass('disabled') ) && $('input[name=rowRdo]:checked').length == 1) {

				var model = this.collection.get(fsId);
				
				var json = model.toJSON();
				
				json.unitList = listTargetUnits.toJSON();
				
				var unit = _.find(json.unitList, function(unit) {
					if(json.unit != null) {
						return json.unit.id == unit.id;
					}
				});
				
				if(unit!=null) {unit.selected = true;}
				
				json.commonTypeList = listBudgetCommonType.toJSON();
				json.editBudgetType = true;
				
				var commonType =  _.find(json.commonTypeList, function(commonType) {
					if(json.commonType!=null) {
						
						return json.commonType.id == commonType.id;
					}
				});
				
				if(commonType!=null) {
					commonType.selected = true;
				}

				
				$('#newRowCtr').html(this.newRowTemplate(json));	
				
				this.$el.find('a.btn').toggleClass('disabled');
				
				/* var model = this.collection.get(fsId);
				
				var json = model.toJSON();
					
				json.unitList = listTargetUnits.toJSON();
				if(model.get('unit') != null) {
					for(var i=0; i<json.unitList.length; i++) {
						if(json.unitList[i].id == model.get('unit').get('id')) {}
						json.unitList[i].selected = 'selected';
					}
				}
				
				
				json.commonTypeList = listBudgetCommonType.toJSON();
				if(model.get('commonType') != null) {
					for(var i=0; i<json.commonTypeList.length; i++) {
						if(json.commonTypeList[i].id == model.get('commonType').get('id')) {}
						json.commonTypeList[i].selected = 'selected';
					}
				}

				var html = this.editRowTemplate(json);
				$('input[name=rowRdo]:checked').parents('tr').html(html); */
			} else {
				alert('กรุณาเลือกรายการที่ต้องการแก้ไข');
			}
		},
		
		
		cancelUpdateLine: function(e) {
			//now put back the value
			// well do nothing just reset the collection
			this.$el.find('a.btn').toggleClass('disabled');
			this.collection.trigger('reset');
			
		},
		
		cancelSaveLine: function(e) {
			//now put back the value
			// well do nothing just reset the collection
			
			this.$el.find('a.btn').toggleClass('disabled');
			$('#newRowCtr').empty();
			
		},
		
		updateLine: function(e) {
			var inputNameVal = this.$el.find('#nameTxt').val();
			var budgetTypeId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
			var modelToUpdate = this.collection.get(budgetTypeId);
			modelToUpdate.save({name: inputNameVal}, {
				success: _.bind(function() {
					this.collection.trigger('reset');
				}, this)
			});
			
		},
		
		saveLine: function(e) {

			var id = $(e.target).attr('data-id');
			var budgetType = BudgetType.findOrCreate(id);
			
			
			var parentBudgetType;
			var newBudgetType;
			var inputNameVal = this.$el.find('#nameTxt').val();
			var unitId = this.$el.find('select#unitSlt').val();
			var unit = TargetUnit.findOrCreate(unitId);
			
			var commonTypeId = this.$el.find('select#commonTypeSlt').val();
			var commonType = BudgetCommonType.findOrCreate(commonTypeId);
			
			
			
			if(budgetType== null) {
				var parentTypeId = this.$el.find('select.type:last').val();
				parentBudgetType = BudgetType.findOrCreate(parentTypeId);
				
				newBudgetType = new BudgetType();
				newBudgetType.set('name', inputNameVal);
				newBudgetType.set('parent', parentBudgetType);
				newBudgetType.set('parentLevel', 4);
				newBudgetType.set('parentPath', '.' + parentBudgetType.get('id') + parentBudgetType.get('parentpath'));
				
			} else {
				parentBudgetType = budgetType.get('parent');
				newBudgetType = budgetType;
				newBudgetType.set('name', inputNameVal);
				
			}
			
			newBudgetType.set('commonType', commonType);
			newBudgetType.set('unit', unit);
			
			
			
			newBudgetType.save(null, {
				success: function() {
					
				}
			});
			
			this.$el.find('a.btn').toggleClass('disabled');
			this.collection.trigger("reset");
		
		},
		
		deleteRow: function(e) {
			var budgetTypeId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
			
			if( (! $(e.currentTarget).hasClass('disabled')) && $('input[name=rowRdo]:checked').length == 1 ) {
				
				var modelToDelete = this.collection.get(budgetTypeId);
				
				
					if(confirm("คุณต้องการลบรายการ " + modelToDelete.get('name'))) {
					
						modelToDelete.destroy({
							success: _.bind(function() {					
								this.collection.remove(modelToDelete);
							
								this.collection.fetch();
							},this)
						});
				} 
			} else {
				alert('กรุณาเลือกรายการที่ต้องการลบ');
			}
		},
		
		
		
		renderFormulaStrategy: function(formulaStrategy) {
			var formulaStrategyEl = this.$el.find('tr[data-id='+ formulaStrategy.get('id') +']');
			
			var json = formulaStrategy.toJSON();
			
			formulaStrategyEl.html(this.budgetTypeRowTemplate(json));
			
		},
		
		renderChild: function(caller) {
			this.renderFormulaStrategy(caller);
		}
		
		
	});
	
	var BudgetSltView = Backbone.View.extend({
		budgetSltTemplate :  Handlebars.compile($("#budgetSltTemplate").html()),
		mainTblView: new MainTblView({collection: budgetTypeCollection}),
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
				this.mainTblView.searchTxt = null;
				this.mainTblView.collection.setTargetPage(1);
				this.mainTblView.collection.setMainTypeId(budgetTypeSelectedId);
				this.mainTblView.collection.setLevel(4);
				this.mainTblView.collection.setCurrentFiscalYear(fiscalYear);
				this.mainTblView.collection.fetch({
					success: function() {
						// we should now load it's children?
						// set this.mainTblV
					}
				});
			}
		}
		
	});


	var BudgetTypeSelectionView = Backbone.View.extend({
		initialize: function(options){
			if(options != null) {
				this.el = options.el;
				this.model = options.model;
			} 
		},
		
		el: "#budgetSelectionCtr",
		
		selectionTpl : Handlebars.compile($("#budgetSltTemplate").html()),
		
		render: function(){
			// first clear the siblings select
			this.$el.nextAll('div').remove();
			this.$el.empty();
			this.$el.html(this.selectionTpl(this.model.get('children').toJSON()));
		},
		
		events: {
			"change select:first" : "selectionChange" // only the first one
		},
		
		selectionChange: function(e) {
			var selectedBudgetTypeId = $(e.target).val();
			// now try to get this model
			var budgetType = BudgetType.findOrCreate(selectedBudgetTypeId);
			e1 = budgetType;
			budgetType.fetch({success: _.bind(function(model, response){
				var fetchedBudgetType = response;
				if(fetchedBudgetType.parentLevel < 3) {
					
					var nextEl = this.$el.selector + " select + div";
					this.nextBudgetTypeSelectionView = new BudgetTypeSelectionView({model: budgetType, el: nextEl, mainTblView: this.mainTblView});
					this.nextBudgetTypeSelectionView.render();
					
				} else {
					
					 
				}

			}, this)});
			
			// ok we'll have to set back to this!?
			
		}
	});

	
	
	var headLineStr = '<h4> ทะเบียนรายการและรายการย่อย';
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