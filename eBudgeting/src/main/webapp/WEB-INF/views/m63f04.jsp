 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>การประมวลผลก่อนการปรับลดงบประมาณครั้งที่ 1</h4> 
</div>


	<div class="row">
		<div class="span11">
			<c:if test="${rootPage == false}">
				<ul class="breadcrumb" id="headNav">
					<c:forEach items="${breadcrumb}" var="link" varStatus="status">
						<c:choose>
							<c:when test="${status.last}">
								<li class="active">${link.value}</li>
							</c:when>
							<c:otherwise>
								<li><a href="<c:url value='${link.url}'></c:url>">${link.value}</a>
									<span class="divider">/</span></li>
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


<script id="processingTemplate" type="text/x-handler-template">
	<div><img src="/eBudgeting/resources/graphics/loading-small.gif"/> Processing... </div>
</script>

<script id="loadingTemplate" type="text/x-handler-template">
	<div>Loading <img src="/eBudgeting/resources/graphics/spinner_bar.gif"/></div>
</script>

<script id="mainTblTemplate" type="text/x-handler-template">
<div style="margin-bottom:20px;">
	<button id="processBtn" class="btn btn-primary">ประมวลผลก่อนการปรับลดงบประมาณครั้งที่ 1</button>
</div>
<table class="table table-bordered table-striped">
	<thead>
		<tr>
			<td style="width: 400px;">กิจกรรม</td>
			<td style="width: 100px;">ขอตั้งระดับกิจกรรม</td>
			<td style="width: 100px;">ขอตั้งระดับรายการ</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>

<script id="mainTblTbodyTemplate" type="text/x-handler-template">
{{#each this}}
<tr data-id={{id}}>
	<td style="padding-left:{{paddingLeft}}px;"> 
		<span class="label label-info">{{type.name}}</span><br/>
		{{#if isLeaf}}
			<i id=caret-{{id}} class="icon-circle"></i></icon>
		{{else}} 
			<a id="link-{{id}}" class="drillDown" href="#"><i id="caret-{{id}}" class="icon-chevron-right"></i></icon></a> 
		{{/if}}
		{{name}} </td>
	<td style="text-align: right; padding-right: 15px;"> <br/>{{formatNumber sumObjectiveProposalAmountRequest}}</td>
	<td style="text-align: right; padding-right: 15px;"> <br/>{{formatNumber sumProposalAmountRequest}}</td>
</tr>
{{/each}}
</script>

<script src="<c:url value='/resources/js/pages/m63f04.js'/>"></script>

<script type="text/javascript">
	var fiscalYear = "${fiscalYear}";
	var rootObjectiveId = "${rootObjective.id}";
	
	$('#mainCtr').html('<div>Loading <img src="/eBudgeting/resources/graphics/spinner_bar.gif"/></div>');
	
	var mainTblView = new MainTblView({
		rootObjectiveId : rootObjectiveId
	});
	mainTblView.render();
	
</script>