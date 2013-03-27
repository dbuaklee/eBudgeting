<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>การเชื่อมโยงกิจกรรม <c:if test="${not empty fiscalYear}">ปีงบประมาณ ${fiscalYear}</c:if></h4> 
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


<script id="mainCtrTemplate" type="text/x-handler-template">
<div class="row">
	<div id="mainSelection" class="span11"></div>

	<div id="mainTree" class="span6">
		<div class="content">
			
		</div>
	</div>
	<div id="childrenSlt" class="span5" style="border: 1px;">
		
	</div>
</div>
</script>

<script id="treeRootTemplate" type="text/x-handler-template">
	<table class="table table-bordered">
		<tr data-id={{id}} data-level="{{parentLevel}}">
			<td><span class="label label-info mini">{{type.name}}</span><br/>
				<a href="#" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i>{{name}}</a></td>
			<td style="width:40px;"> </td>
		</tr>
	</table>
</script>

<script id="loadingSpanTemplate" type="text/x-handler-template">
	<span class="loading"> Loading <img src="/eBudgeting/resources/graphics/loading-small.gif"/></span>
</script>
<script id="treeTRTemplate" type="text/x-handler-template">
	<tr data-id={{id}} data-level="{{parentLevel}}">
			<td style="padding-left: {{paddingLevel parentLevel}}px;"><span class="label label-info mini">{{type.name}}</span><br/>
				{{#if isLeaf}}
					 <a href="#" class="nextChildrenLnk"><i class="icon icon-circle nextChildrenLnk"> </i> </i>
				{{else}}
					{{#if arrowDown}}
						<a href="#" class="nextChildrenLnk"><i class="icon icon-chevron-down nextChildrenLnk"> </i> </i>
					{{else}}
						<a href="#" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"> </i> </i>
					{{/if}}
				{{/if}}
				[{{code}}] {{name}}</a> 
			</td>
				<td>
				{{#if type.unlinkable}}
					<button type="button" class="btn unlink">UnLink</button>
				{{/if}}
				</td>

	</tr>
</script>

<script  id=childrenSltTemplate type="text/x-handler-template">
<div style="padding: 12px;margin-top: {{topPadding}}px; background-color: #FFFFCC; border: 1px solid #DDDDDD;">
	<div class="control">
		<form class="form-search">
				<div class="input-append pull-left">
					<input type="text" id="availableChildrenSearch" class="span2 search-query">
					<button type="submit" id="search" class="btn">ค้นหาทะเบียน</button>
				</div> &nbsp;
				<button type="submit" id="searchDisplayAll" class="btn">แสดงผลทั้งหมด</button>
		</form>
	</div>
	<div class="content">
		
	</div>
</div>
</script>


<script  id=availableChildrenTemplate type="text/x-handler-template">
เลือก{{typeName}}เพื่อเชื่อมโยง
<div style="height: 250px;overflow:auto;">
<table class="table table-bordered">	
	<thead>
	</thead>
	<tbody>
	{{#each this}}
		<tr data-id="{{id}}">
			<td><button type="button" class="btn link">Link</button></td><td>[{{code}}] {{name}}</td>
		</tr>
	{{/each}}
	</tbody>	
</table>
<div>
</script>


<script id="mainSelectionTemplate" type="text/x-handler-template">
<form class="form-horizontal">
<div class="control-group"  style="margin-bottom:5px;">
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
		<div class="control-group">
			<label class="control-label">ผลผลิต/โครงการ :</label>
			<div class="controls">
				<select class="span5" disabled="disabled">
					<option>กรุณาเลือก...</option>
				</select>
			</div> 
		</div>
</script>


<script id="type103DisabledSelection" type="text/x-handler-template">
		<div class="control-group">
			<label class="control-label">กิจกรรมหลัก :</label>
			<div class="controls">
				<select class="span5" disabled="disabled">
					<option>กรุณาเลือก...</option>
				</select>
			</div> 
		</div>
</script>

<script src="<c:url value='/resources/js/pages/m51f17.js'/>"></script>

<script type="text/javascript">

var fiscalYear = "${fiscalYear}";
var e1;
var e2;

Handlebars.registerHelper("paddingLevel", function(level) {
	var step = level-4;
	return (step*50) + 8;

});

$(document).ready(function() {
	
	if(fiscalYear.length > 0) {
		

		
		mainCtrView = new MainCtrView();
		mainCtrView.render();
	}
});
</script>