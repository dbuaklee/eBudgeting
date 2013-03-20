<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="hero-unit white">
<div id="headLine">
	<h4>การประมวลผลการกระทบยอดเงินงบประมาณจากระดับรายการมาที่ระดับกิจกรรม</h4> 
</div>

<div class="row">
	<div class="span11">
		
		<div id="modal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<a href="#" class="btn" id="cancelBtn">กลับหน้าหลัก</a> 
			</div>
		</div>
		
		<div id="mainCtr">

		</div>

	</div>
</div>
</div>

<script id="loadingTemplate" type="text/x-handler-template">
	<div>Loading <img src="/eBudgeting/resources/graphics/spinner_bar.gif"/></div>
</script>

<script id="mainTblTemplate" type="text/x-handler-template">
<table class="table table-bordered table-striped">
	<thead>
		<tr>
			<td style="width: 200px;">กิจกรรม</td>
			<td>ขอตั้งระดับกิจกรรม</td>
			<td>ขอตั้งระดับรายการ</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>

<script src="<c:url value='/resources/js/pages/m62f01.js'/>"></script>

<script type="text/javascript">
	var organizationId = "${user.workAt.id}";
	var fiscalYear = "${fiscalYear}";
	
	var mainTblView = new MainTblView();
	mainTblView.render();
	
</script>
