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

	<!-- 
	<link href="<c:url value='/resources/jslibs/jquery-easyui-1.3.2/themes/default/easyui.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/jslibs/jquery-easyui-1.3.2/themes/icon.css'/>" rel="stylesheet">
 	-->
 	

	<link href="<c:url value='/resources/jslibs/ext-4.2.1.883/resources/ext-theme-neptune/ext-theme-neptune-all.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/jslibs/jqueryui-1.9.2/css/redmond/jquery-ui-1.9.2.custom.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/jslibs/bootstrap-2.3.1/css/bootstrap.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/jslibs/bootstrap-2.3.1/css/font-awesome-3.0.min.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/app.css'/>" rel="stylesheet">
	

	
	<script src="<c:url value='/resources/jslibs/jqueryui-1.9.2/js/jquery-1.8.3.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/jqueryui-1.9.2/js/jquery-ui-1.9.2.custom.min.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/jquery.ui.datepicker-th.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/jquery.ui.datepicker.ext.be.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/jquery.fileDownload-1.4.2.js'/>"></script>
	
	<!-- 
	<script src="<c:url value='/resources/jslibs/jquery-easyui-1.3.2/jquery.easyui.min.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/jquery-easyui-1.3.2/datagrid-detailview.js'/>"></script>
	 -->
	 
	<script src="<c:url value='/resources/jslibs/ext-4.2.1.883/ext-all.js'/>"></script>
	
		<script src="<c:url value='/resources/jslibs/lodash-1.3.1.min.js'/>"></script>
	<!-- 
	<script src="<c:url value='/resources/jslibs/underscore-1.5.1.min.js'/>"></script>
	 -->
	 
	<script src="<c:url value='/resources/jslibs/bootstrap-2.3.1/js/bootstrap.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/bootstrap-editable-1.1.4/js/bootstrap-editable.min.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/backbone-1.0.0.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/backbone-relational-0.8.5.js'/>"></script>
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
	
<script type="text/javascript">
$(document).ready(function() {
   // register Global error handling here .. if there isn't one
   
	$(document).ajaxError( function(event, jqXHR, ajaxSettings, thrownError){
		if(jqXHR.status == 403) {
			alert('Session Timeout,  Please Log in again');
			window.location.reload();
		} else {
			alert("Error Status Code: " + jqXHR.status + " " + jqXHR.statusText + "\n" + jqXHR.responseText);	
		}
		
	});
 });
</script>	
</body>
</html>
