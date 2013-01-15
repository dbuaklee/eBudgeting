<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>ทะเบียนรายการหลักสำหรับบันทึกงบประมาณกิจกรรม <c:if test="${not empty fiscalYear}">ปีงบประมาณ ${fiscalYear}</c:if></h4> 
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

<script id="modalTemplate" type="text/x-handler-template">
<form>
	<label>ชื่อรายการกลาง</label>
	<input type="text" id="nameTxt" value="{{name}}">
</form>
</script>

<script id="mainCtrTemplate" type="text/x-handler-template">
<div style="margin-bottom: 24px;">
	<button class="btn" type="button" id="saveBtn">บันทึกรายการที่เลือก</button>
</div>
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td width="20"></td>
			<td style="width: 100px; text-align:center">รายการหลัก</td>
			<td>ชื่อรายการ</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>

<script id="rowTemplate" type="text/x-handler-template">
{{#each this}}
<tr data-id={{id}} {{#if isMainType}}class="info"{{/if}}>
	<td></td>
	<td style="width: 100px; text-align:center;"> <input type="checkbox" class="mainType" name="ids" value="{{id}}" {{#if isMainType}}checked="checked"{{/if}}></td>
	<td style="padding-left: {{paddingLevel budgetType.parentLevel}}px;">{{budgetType.name}}</td>
</tr>
{{/each}}
</script>
	
<script type="text/javascript">
var fiscalBudgetTypeCollection = new FiscalBudgetTypeCollection();
var fiscalYear = "${fiscalYear}";
var e1;

Handlebars.registerHelper("paddingLevel", function(level) {
	var step = level-1;
	return (step*50) + 8;

});


$(document).ready(function() {
	
	if(fiscalYear.length > 0) {
	
		var MainCtrView = Backbone.View.extend({
			initialize: function() {
				this.collection.bind('reset', this.render, this);
			},
			events: {
	
			},
			mainCtrTpl: Handlebars.compile($("#mainCtrTemplate").html()),
			rowTpl : Handlebars.compile($("#rowTemplate").html()),
			el: '#mainCtr',
			collection : fiscalBudgetTypeCollection,
			
			render: function() {
				this.$el.html(this.mainCtrTpl());
				this.$el.find('tbody').html(this.rowTpl(this.collection.toJSON()));
			},
			
			events: {
				"click .mainType" : "checkboxClick",
				"click #saveBtn" : "saveBtnClick"
 			},
			
			checkboxClick: function(e) {
				$(e.target).parents('tr').toggleClass('info');
			},
			
			saveBtnClick: function(e) {
				var ids = [];
				$('#mainTbl').find('tr.info').map(function(){
				  ids.push($(this).attr('data-id'));
				});
				
				$.ajax({
					type: 'POST',
					url: appUrl('/FiscalBudgetType/setMainBudget/'+ fiscalYear),
					data: {
						ids: ids
					},
					success: function() {
						alert("บันทึกข้อมูลเรียบร้อย");	
					}
				});
			}
			
			
		});
		
		mainCtrView = new MainCtrView();
		
		fiscalBudgetTypeCollection.fetch({
			url: appUrl('/FiscalBudgetType/fiscalYear/' + fiscalYear + '/upToLevel/3' ),
			success: function() {
				
				fiscalBudgetTypeCollection.trigger('reset');
			}
		});
	}
});
</script>