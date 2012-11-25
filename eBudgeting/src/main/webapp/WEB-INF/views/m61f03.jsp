<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>การบันทึกงบประมาณ ระดับกิจกรรมหลัก <c:if test="${not empty fiscalYear}">ปีงบประมาณ ${fiscalYear}</c:if></h4> 
	<h4>หน่วยงาน: <sec:authentication property="principal.workAt.name"/></h4>
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

		<div id="targetValueModal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body"></div>
			<div class="modal-footer">
				<a href="#" class="btn" id="saveBtn">บันทึกข้อมูล</a>  
				<a href="#" class="btn" id="cancelBtn">ยกเลิก</a>
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
							<c:forEach items="${fiscalYears}" var="fiscalYear">
							<tr>
								
									<td><a href="./${fiscalYear.fiscalYear}/${fiscalYear.id}/"
										class="nextChildrenLnk">${fiscalYear.fiscalYear} <i
											class="icon icon-chevron-right nextChildrenLnk"></i>
									</a></td>
							
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

<script id="loadingTemplate" type="text/x-handler-template">
	<div>Loading <img src="/eBudgeting/resources/graphics/spinner_bar.gif"/></div>
</script>

<script id="mainCtrBodyTemplate" type="text/x-handler-template">
<div id="form">
	<form id="objectiveSltFrm">
		<label>กรุณาเลือกกิจกรรมหลัก </label>
		<select class="span4 objectiveSlt">
			<option value="0">กรุณาเลือก ... </option>
			{{#each this}}
			<option value="{{id}}">[{{code}}] {{name}}</option>
			{{/each}}
		</select>
	</form>
</div>
<div id="table">
</div>
</script>


<script type="text/javascript">
	var objectiveId = "${objective.id}";
	var fiscalYear = "${fiscalYear}";

	var pageUrl = "/page/m61f03/";
	var mainTblView = null;
	var objectiveCollection = new ObjectiveCollection();
	
	
	
	var l = null;
	var e1;


	var MainTblView = Backbone.View.extend({
		initialize : function() {

		},
		
		mainCtrBodyTemplate : Handlebars.compile($("#mainCtrBodyTemplate").html()),

		el : "#mainCtr",
		
		render: function() {
			var json=objectiveCollection.toJSON();
			
			var html = this.mainCtrBodyTemplate(json);
			this.$el.html(html); 
			
		},
		
		events : {
			"change .objectiveSlt" : "changeObjective"
		},
		
		changeObjective: function(e) {
			var targetObjectiveId = $(e.target).val();
			if(targetObjectiveId == 0) {
				return alert("กรุณาเลือกกิจกรรมหลักให้ถูกต้อง");
			}
			
			// now we should load the table of this objective 
			
			
		}
		
		
	});

	$(document).ready(function() {

		if(fiscalYear.length > 0) {
		
			objectiveCollection.fetch({
				url: appUrl('/Objective/' + fiscalYear + '/type/' + 103),
				success: function() {
					mainTblView = new MainTblView();
					mainTblView.render();
				}
			});

		}

	});
</script>
