<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
	
	<link href="<c:url value='/resources/jslibs/bootstrap-2.1/css/bootstrap.css'/>" rel="stylesheet">
	<link href="<c:url value='/resources/css/app.css'/>" rel="stylesheet">
	<script src="<c:url value='/resources/jslibs/jquery-1.8.0.min.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/underscore-1.3.3.min.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/bootstrap-2.1/js/bootstrap.min.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/backbone-0.9.2.min.js'/>"></script>
	<script src="<c:url value='/resources/jslibs/handlebars-1.0.0.beta.6.js'/>"></script>
	
	<script src="<c:url value='/resources/js/app.js'/>"></script>
	
	<title>${title}</title>
</head>

<body>
	<div id="container-header" class="container">
		<tiles:insertAttribute name="header"/>		
	</div>


	<div id="container-body" class="container">
		<tiles:insertAttribute name="body" />
	</div>


	<div id="container-footer" class="container">
		<tiles:insertAttribute name="footer" />
	</div>

</body>
</html>