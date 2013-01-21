<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>

<html lang="th">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="<c:url value='/resources/jslibs/html5shiv.js'/>"></script>
      <script src="<c:url value='/resources/jslibs/html5shiv-printshiv.js'/>"></script>
    <![endif]-->	

	<link href="<c:url value='/resources/jslibs/jqueryui-1.9.2/css/redmond/jquery-ui-1.9.2.custom.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/jslibs/jqGrid-4.4.1/css/ui.jqgrid.css'/>" rel="stylesheet">	
	<link href="<c:url value='/resources/jslibs/bootstrap-2.2.2/css/bootstrap.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/jslibs/bootstrap-2.2.2/css/font-awesome-3.0.min.css'/>" rel="stylesheet">
	
	<link href="<c:url value='/resources/jslibs/bootstrap-editable-1.1.4/css/bootstrap-editable.css'/>" rel="stylesheet">

	<link href="<c:url value='/resources/css/app.css'/>" rel="stylesheet">
	<script src="<c:url value='/resources/jslibs/jqueryui-1.9.2/js/jquery-1.8.3.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/jqueryui-1.9.2/js/jquery-ui-1.9.2.custom.min.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/underscore-dev-1.4.3.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/bootstrap-2.2.2/js/bootstrap.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/bootstrap-editable-1.1.4/js/bootstrap-editable.min.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/backbone-0.9.2.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/backbone-relational-0.6.0.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/handlebars-1.0.0.beta.6.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/moment-1.7.2.min.js'/>"></script>	
		
	<script src="<c:url value='/resources/js/appUtils.js'/>"></script>
	<script src="<c:url value='/resources/js/eBudgeting-app.js'/>"></script>

	
	<title>${title}</title>
</head>

<body>
	<c:choose>
		<c:when test="${adminPage == true}">
			<div id="container-header" class="container">
				<tiles:insertAttribute name="header-admin"/>		
			</div>
		</c:when>
		<c:otherwise>
			<div id="container-header" class="container">
				<tiles:insertAttribute name="header"/>		
			</div>	
		</c:otherwise>
	</c:choose>


	<div id="container-body" class="container">
		<tiles:insertAttribute name="body" />
	</div>


	<div id="container-footer" class="container">
		<tiles:insertAttribute name="footer" />
	</div>

</body>
</html>
