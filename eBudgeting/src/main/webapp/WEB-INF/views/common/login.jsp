<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<div class="hero-unit" style="margin-top: 60px;">
	<div class="page-header">
		<img src="<c:url value="/resources/graphics/header2.gif"/>"/> 
		<h3>Login</h3>
	</div>


	<form class="form-horizontal" action="<c:url value='/j_spring_security_check'/>"
		method="POST">
	<c:if test="${not empty failed}">
      <div class="alert alert-error">
        Your login attempt was not successful, try again.<br/>
        Reason: <c:out value="${SPRING_SECURITY_LAST_EXCEPTION.message}"/>.
      </div>
    </c:if>

		<fieldset>
			<div class="control-group">
				<label class="control-label" for="userName"><b>* username:</b></label>
				<div class="controls">
					<input type="text" class="input-xlarge" name="j_username"/>
				</div>
			</div>
		</fieldset>

		<fieldset>
			<div class="control-group">
				<label class="control-label" for="password"><b>* Password:</b></label>
				<div class="controls">
					<input type="password" class="input-xlarge" name="j_password"/>
				</div>
			</div>
		</fieldset>
		<div class="form-actions">
			<button type="submit" class="btn btn-primary" name="_eventId_next">ตกลง</button>
			<button type="reset" class="btn" name="_eventId_cancel">ยกเลิก</button>
			
		</div>
	</form>
</div>
