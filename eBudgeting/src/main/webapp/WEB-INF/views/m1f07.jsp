<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="hero-unit white">
<div id="headLine">
	
</div>

<div class="row">
	<div class="span11">

		<div id="unitModal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" id="closeBtn">กลับหน้าหลัก</a>
			</div>
		</div>

		<div id="modal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" id="saveBtn">บันทึกข้อมูล</a>  
				<a href="#" class="btn" id="closeBtn">ยกเลิก</a>
			</div>
		</div>


		<div class="control-group" id="mainCtr">	
		</div>


	</div>
</div>

</div>

<script id="mainCtrTemplate" type="text/x-handler-template">
<div class="controls" style="margin-bottom: 15px;">
	
	<div>
	
	<div class="pull-left" style="margin-right: 25px;">
	<a href="#" class="btn btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มชื่อผู้ใช้งาน</a>
	</div>

	<div class="pull-right">
	<form class="form-search">
		<div class="input-append pull-left">
			<input type="text" id="availableChildrenSearch" class="span2 search-query">
			<button id="search" class="btn">ค้นหา</button>
		</div> &nbsp;
		<button id="searchDisplayAll" class="btn">แสดงทั้งหมด</button>
	
	</form>	
	</div>

	</div>

	<div class="clearfix"></div>

	{{#if pageParams}}
	{{#with pageParams}}
    <div class="pagination pagination-small">
        <span style="border: 1px;">พบทั้งสิ้น {{totalElements}} รายการ </span> <b>หน้า : </b> <ul>
		{{#each page}}
	    <li {{#if isActive}}class="active"{{/if}}><a href="#" class="pageLink" data-id="{{pageNumber}}">
				{{#if isPrev}}&laquo;{{/if}} 
				{{#if isNext}}&raquo;{{/if}}
				{{#if showPageNumber}} {{pageNumber}} {{/if}}

			</a>
		</li>
	    {{/each}}
    </div>
	{{/with}}
	{{/if}}

</div>
<table class="table table-bordered table-striped" id="mainTbl">
	<thead>
		<tr>
			<td style="width:20px;"></td>
			<td style="width:100px;">Username</td>
			<td style="width:150px;">ชื่อ</td>
			<td style="width:200px;">นามสกุล</td>
			<td style="width:140px;">ต้นสังกัด</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>

<script id="userRowTemplate" type="text/x-handelbars-template">
<td> <a href="#" class="deleteUser"><i class="icon-trash icon-red"></i></a></td>
<td> {{username}} </td>
<td> {{person.firstName}} </td>
<td> {{person.lastName}} </td>
<td> {{person.workAt.name}}({{person.workAt.abbr}})</td>
</script>

<script id="tbodyTemplate" type="text/x-handlebars-template">
{{#each this}}
<tr data-id="{{id}}">
</tr>
{{/each}}
</script>

<script id="modalBodyTemplate" type="text/x-handlebars-template">
<form>
	<label>ระบุชื่อ{{type.name}}</label>
	<textarea rows="2" class="span5" id="nameTxt">{{name}}</textarea>
	
	{{#if hasParent}}
	<label>เชื่อมโยง{{parentTypeName}}</label>
	<select class="span5" id="parentSlt">
		<option value="0">ยังไม่ระบุ</option>
		{{#each parentSelectionList}}
			<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.code}} {{this.name}}</option>
		{{/each}}
	</select>
	{{/if}}

	{{#if hasRelatedType}}
	{{#each relations}}
	<label>เชื่อมโยง{{relationInfo.name}}</label>
	<select class="span5 relationSlt" parentId="{{relationInfo.parentId}}" id="relation-{{relationInfo.parentId}}">
		<option value="0">ยังไม่ระบุ</option>
		{{#each selectionList}}
			<option value="{{this.id}}" {{#if this.selected}}selected='selected'{{/if}}>{{this.code}} {{this.name}}</option>
		{{/each}}
		</select>
	{{/each}}
	{{/if}}

</form>
</script>


<script src="<c:url value='/resources/js/pages/m1f07.js'/>"></script>

<script type="text/javascript">
<!--
var objectiveId = "${objective.id}";
var fiscalYear = "${fiscalYear}";
var typeId = "${typeId}";
var userCollection = new UserPagableCollection([], {
	targetPage: 1
});


var mainTblView;

var e1;


$(document).ready(function() {
	mainTblView = new MainTblView({collection: userCollection});
	mainTblView.renderTargetPage(1);
});

//-->
</script>