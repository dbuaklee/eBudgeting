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
							<td>${fiscalYear.fiscalYear} <a href="./${fiscalYear.fiscalYear}/${fiscalYear.id}/" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
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
			<th width="400"><strong>แผนงาน/กิจกรรม ประจำปี {{this.0.fiscalYear}}</strong></th>
			<th width="80">เป้าหมาย</th>
			<th width="80">ขอตั้งปี  {{this.0.fiscalYear}}</th>
			<th width="80">ประมาณการ  {{next this.0.fiscalYear 1}}</th>
			<th width="80">ประมาณการ  {{next this.0.fiscalYear 2}}</th>
			<th width="80">ประมาณการ  {{next this.0.fiscalYear 3}}</th>
		</tr>
	</thead>
</table>
<div style="height: 400px; overflow: auto; width:920px">
<table class="table table-bordered" id="mainTbl" style="width:896px; table-layout:fixed;">
	<tbody>
		{{#if this.type.isLastToSelect}}
			{{{childrenNodeTpl this 0}}}
		{{else}}
			{{#each this}}
			<tr>
				<td class="" style="width: 400px; height: 0px;">{{name}} <a href="../{{id}}/" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
				<td class="" style="width: 80px; height: 0px;"></td>
				<td class="" style="width: 80px; height: 0px;"></td>
				<td class="" style="width: 80px; height: 0px;"></td>
				<td class="" style="width: 80px; height: 0px;"></td>
				<td class="" style="width: 80px; height: 0px;"></td>
			</tr>
			{{/each}}
		{{/if}}
	</tbody>
</table>
</div>
</script>

<script id="childrenNodeTemplate" type="text/x-handler-template">
	<tr data-level="{{this.level}}" data-index="{{this.id}}">
		<td style="padding-left:{{this.padding}}px;" class="{{#if this.children}}disable{{/if}}">
			<span>
					{{#if this.children}}
					<input class="checkbox_tree bullet" type="checkbox" id="bullet_{{this.id}}"/>
					<label class="expand" for="bullet_{{this.id}}"><img width=12 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/></label>
					{{else}}					
						<img width=8 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/> - 
					{{/if}}
					<input class="checkbox_tree" type="checkbox" id="item_{{this.id}}"/>
					<label class="main" for="item_{{this.id}}">{{this.type.name}} {{this.name}}</label>
			</span> 
		</td>
			<td class="{{#if this.children}}disable{{/if}}"><span></span>
				 {{#unless this.children}}<br/><a col-id="1" href="#mainfrm" class="btn btn-mini">เพิ่ม/แก้ไข</a>{{/unless}}
			</td>
			<td class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>0.00</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text">0.00</a>
				{{/if}}
			</td>

			<td class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>0.00</span>
				{{else}}
					<a href="#" id="editable3-{{this.id}} data-type="text">0.00</a>
				{{/if}}
			</td>
			<td class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>0.00</span>
				{{else}}
					<a href="#" id="editable4-{{this.id}} data-type="text">0.00</a>
				{{/if}}
			</td>
			<td class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>0.00</span>
				{{else}}
					<a href="#" id="editable5-{{this.id}} data-type="text">0.00</a>
				{{/if}}
			</td>

	</tr>
	{{{childrenNodeTpl this.children this.level}}}
</script>

<script id="rootMainCtrTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td>เลือกปีงบประมาณ</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>{{this}} <a href="./{{this}}/" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
		</tr>
	</tbody>
</table>
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
var objectiveId = "${objective.id}";
var fiscalYear = "${fiscalYear}";

var pageUrl = "/page/m2f12/";
var mainTblView  = null;
var objectiveCollection = null;
var budgetTypeSelectionView = null;
var l = null;

Handlebars.registerHelper('childrenNodeTpl', function(children, level) {
	  var out = '';
	  var childNodeTpl = Handlebars.compile($("#childrenNodeTemplate").html());
	  if(level==undefined) level=0;
	  if(children != null && children.length > 0) {
	  	children.forEach(function(child){
	  		child["level"] = level+1;
	  		child["padding"] = (parseInt(level)+1) * 12;
	    	out = out + childNodeTpl(child);
	  	});
	  }

	  return out;
});

Handlebars.registerHelper('next', function(val, next) {
	return val+next;
});



	var MainTblView = Backbone.View.extend({
		initialize: function(){
		    this.collection.bind('reset', this.render, this);
		    _.bindAll(this, 'showForm');
		},
		el: "#mainCtr",
		mainTblTpl : Handlebars.compile($("#mainCtrTemplate").html()),
		
		render: function() {
			this.$el.html(this.mainTblTpl(this.collection.toJSON()));
			
			$('a[id*=editable]').editable()
		},
		
		events: {
			"click input[type=checkbox].bullet" : "toggle",
			"click a" : "showForm"
		},
		
		toggle: function(e) {
			l=e;
			var clickLevel = $(l.target).parents('tr').attr('data-level');
			$(l.target).next('label').toggleClass("expand collapse");
			
			var currentTr = $(l.target).parents('tr');
			
			
			currentTr.nextUntil('tr[data-level='+clickLevel+']').toggle();
		},
		
		showForm: function(e) {
			l = e;
			
			$(e.target).prevAll('span').popover({title:'show', content:'content!'});
			
		}
		
	});
	
	
$(document).ready(function() {
	
	objectiveCollection = new ObjectiveCollection();
	objectiveCollection.url = appUrl("/Objective/"+ objectiveId +"/children");
	
	mainTblView = new MainTblView({collection: objectiveCollection});
	
	
	objectiveCollection.fetch();
	
});
</script>