<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
	<div class="span12">
		
		<c:if test="${breadcrumb}">
		    <ul class="breadcrumb" id="headNav">
		    	<c:forEach items="${breadcrumb}" var="link" varStatus="status">
		    		<c:choose>
						<c:when test="${status.last}">
							<li class="active">${link.value}</li>
						</c:when>
						<c:otherwise>
							<li><a href="${link.url}">${link.value}</a> <span class="divider">/</span></li>
						</c:otherwise>
					</c:choose>
		    	</c:forEach>
		    </ul>
	    </c:if>

		

		<div id="modal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" id="closeBtn">Close</a> 
				<a href="#"	class="btn btn-primary" id="saveBtn">Save changes</a>
			</div>
		</div>


		<div class="control-group" id="mainCtr">
		<c:if test="${breadcrumb == false}">
			<table class="table table-bordered" id="mainTbl">
				<thead>
					<tr>
						<td>เลือกปีงบประมาณ</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<c:forEach items="${fiscalYears}" var="fiscalYear">
							<td>${fiscalYear} <a href="./${fiscalYear}/0/" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
						</c:forEach>
					</tr>
				</tbody>
			</table>			
		</c:if>
		</div>


	</div>
</div>

<script id="fiscalYearMainCtrTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td>เลือกปีงบประมาณ</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			{{#each this}}
				<td>{{this}} <a href="./{{this}}/0/" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
			{{/each}}
		</tr>
	</tbody>
</table>
</script>

<script type="text/javascript">
$(document).ready(function() {

	
});
</script>
