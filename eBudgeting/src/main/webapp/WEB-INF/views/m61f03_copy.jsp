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
				<a href="#" class="btn" id="saveBtn">บันทึกข้อมูล</a> 
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
<div id="resultTable">
</div>
</script>


<script id="resultTableTemplate" type="text/x-handler-template">
<table class="table table-bordered">
	<thead>
	<tr>
		<td style="width:400px;">รายการหลัก</td>
		<td>งบประมาณขอตั้ง ปี {{fiscalYear}}</td>
		<td>งบประมาณขอตั้ง ปี {{next1Year}}</td>
		<td>งบประมาณขอตั้ง ปี {{next2Year}}</td>
		<td>งบประมาณขอตั้ง ปี {{next3Year}}</td>
	</tr>
	</thead>
	<tbody>
	{{#each this}}
		<tr data-id="{{objectiveBudgetId}}">
			<td>{{name}}</td>
			<td data-id="{{id}}">{{#if amountRequest}}<a href="#" class="editBudget">{{formatNumber amountRequest}} บาท</a>{{else}}<a class="editBudget" href="#">เพิ่มงบประมาณ</a>{{/if}}</td>
			<td>{{#if amountRequestNext1Year}}{{formatNumber amountRequestNext1Year}} บาท{{else}} - {{/if}}</td>
			<td>{{#if amountRequestNext2Year}}{{formatNumber amountRequestNext2Year}} บาท{{else}} - {{/if}}</td>
			<td>{{#if amountRequestNext3Year}}{{formatNumber amountRequestNext3Year}} บาท{{else}} - {{/if}}</td>
		</tr>
	{{/each}}
	<tr class="sumRow">
		<td> รวมทั้งสิ้น </td>
		<td>{{formatNumber sumAmountRequest}} บาท</td>
		<td>{{formatNumber sumAmountRequestNext1Year}} บาท</td>
		<td>{{formatNumber sumAmountRequestNext2Year}} บาท</td>
		<td>{{formatNumber sumAmountRequestNext3Year}} บาท</td>
	</tr> 
	</tbody>
</table>
</script>

<script id="modalBodyTemplate" type="text/x-handlebars-template">
<form>
	ปี {{fiscalYear}} : <input type="text" id="amountRequest" value="{{amountRequest}}"/> บาท <br/>
	ประมาณการปี {{next1Year}}: <input type="text" id="amountRequestNext1Year" value="{{amountRequestNext1Year}}"/> บาท <br/>
	ประมาณการปี {{next2Year}}: <input type="text" id="amountRequestNext2Year" value="{{amountRequestNext2Year}}"/> บาท <br/>
	ประมาณการปี {{next3Year}}: <input type="text" id="amountRequestNext3Year" value="{{amountRequestNext3Year}}"/> บาท <br/>
</form>
</script>

<script type="text/javascript">
	var objectiveId = "${objective.id}";
	var fiscalYear = "${fiscalYear}";

	var pageUrl = "/page/m61f03/";
	var mainTblView = null;
	var objectiveCollection = new ObjectiveCollection();
	
	var mainBudgetType = new BudgetTypeCollection();

	
	
	var l = null;
	var e1;
	var e2;
	
	var ModalView = Backbone.View.extend({
		modalBodyTemplate: Handlebars.compile($("#modalBodyTemplate").html()),
		
		initialize: function(options) {
			
		},
		
		el: "#modal",
		
		events: {
			"click #cancelBtn" : "close",
			"click #saveBtn" : "save"
		},
		
		close : function() {
			this.$el.modal('hide');
		},
		save : function(e) {
			if(this.objectiveBudgetProposal == null) {
				this.objectiveBudgetProposal = new ObjectiveBudgetProposal;
				this.objectiveBudgetProposal.set('budgetType', this.budgetType);
				this.objectiveBudgetProposal.set('forObjective', this.objective);
			}
			
			this.objectiveBudgetProposal.save({
				amountRequest: this.$el.find('#amountRequest').val(),
				amountRequestNext1Year: this.$el.find('#amountRequestNext1Year').val(),
				amountRequestNext2Year: this.$el.find('#amountRequestNext2Year').val(),
				amountRequestNext3Year: this.$el.find('#amountRequestNext3Year').val(),
			}, {
				success: _.bind(function() {
					if(mainTblView.objectiveBudgetProposalCollection.get(this.objectiveBudgetProposal.get('id')) == null) {
						mainTblView.objectiveBudgetProposalCollection.add(this.objectiveBudgetProposal);
					}
					
					// rerender the td cell
					mainTblView.renderResultTable();
					
					this.$el.modal('hide');
				}, this)
			});
		},
		render: function() {
			
			this.$el.find('.modal-header span').html("บันทึกงบประมาณ " + this.budgetType.get('name'));
			
			var json = {};
			if(this.objectiveBudgetProposal != null) {
				json = this.objectiveBudgetProposal.toJSON();	
			}
			
			json.fiscalYear = fiscalYear;
			json.next1Year = parseInt(fiscalYear)+1;
			json.next2Year = parseInt(fiscalYear)+2;
			json.next3Year = parseInt(fiscalYear)+3;
			 
			var html = this.modalBodyTemplate(json);
			this.$el.find('.modal-body').html(html);
			
			
			this.$el.modal({show: true, backdrop: 'static', keyboard: false});
			return this;
			
		}
	});

	var MainTblView = Backbone.View.extend({
		initialize : function() {

		},
		modal : new ModalView(),
		mainCtrBodyTemplate : Handlebars.compile($("#mainCtrBodyTemplate").html()),
		resultTableTemplate : Handlebars.compile($("#resultTableTemplate").html()),

		el : "#mainCtr",
		
		render: function() {
			var json=objectiveCollection.toJSON();
			
			var html = this.mainCtrBodyTemplate(json);
			this.$el.html(html); 
			
		},
		
		events : {
			"change .objectiveSlt" : "changeObjective",
			"click .editBudget" : "clickEditBudget"
		},
		
		clickEditBudget: function(e) {
			var objectiveBudgetId = $(e.target).parents('tr').attr('data-id');
			var budgetTypeId = $(e.target).parents('td').attr('data-id');
			
			this.modal.budgetType = BudgetType.findOrCreate(budgetTypeId);
			this.modal.objective = this.objective;
			
			var obp = null;
			if(objectiveBudgetId.length > 0) {
				obp = ObjectiveBudgetProposal.findOrCreate(objectiveBudgetId);
				this.modal.objectiveBudgetProposal = obp;
			} else {
				this.modal.objectiveBudgetProposal = null;
			}
			
			this.modal.render();
			
		},
		
		changeObjective: function(e) {
			var targetObjectiveId = $(e.target).val();
			if(targetObjectiveId == 0) {
				return alert("กรุณาเลือกกิจกรรมหลักให้ถูกต้อง");
			}
			
			this.objective = Objective.findOrCreate(targetObjectiveId);
			
			
			// now we should load the table of this objective 
			this.objectiveBudgetProposalCollection = new ObjectiveBudgetProposalCollection();
			this.objectiveBudgetProposalCollection.fetch({
				url: appUrl('/ObjectiveBudgetProposal/'+fiscalYear+'/'+targetObjectiveId),
				success: _.bind(function() {
					
					
					this.renderResultTable();
				}, this)
			});
			
		},
		
		renderResultTable : function() {
			var json = mainBudgetType.toJSON();
			
			var sumAmountRequest = 0;
			var sumAmountRequestNext1Year = 0;
			var sumAmountRequestNext2Year = 0;
			var sumAmountRequestNext3Year = 0;
			
			for(var i=0; i<this.objectiveBudgetProposalCollection.length; i++) {
				var amountRequest = this.objectiveBudgetProposalCollection.at(i).get('amountRequest');
				var budgetType = this.objectiveBudgetProposalCollection.at(i).get('budgetType');
				
				
				var index = mainBudgetType.indexOf(budgetType);
				
				json[index].amountRequest = amountRequest;
				sumAmountRequest += amountRequest;
				
				json[index].amountRequestNext1Year = this.objectiveBudgetProposalCollection.at(i).get('amountRequestNext1Year');
				sumAmountRequestNext1Year += this.objectiveBudgetProposalCollection.at(i).get('amountRequestNext1Year');
				
				json[index].amountRequestNext2Year = this.objectiveBudgetProposalCollection.at(i).get('amountRequestNext2Year');
				sumAmountRequestNext2Year += this.objectiveBudgetProposalCollection.at(i).get('amountRequestNext2Year');
				
				json[index].amountRequestNext3Year = this.objectiveBudgetProposalCollection.at(i).get('amountRequestNext3Year');
				sumAmountRequestNext3Year += this.objectiveBudgetProposalCollection.at(i).get('amountRequestNext3Year');
				
				json[index].objectiveBudgetId =  this.objectiveBudgetProposalCollection.at(i).get('id');
				
			}
			
			json.fiscalYear = fiscalYear;
			json.next1Year = parseInt(fiscalYear)+1;
			json.next2Year = parseInt(fiscalYear)+2;
			json.next3Year = parseInt(fiscalYear)+3;
			
			json.sumAmountRequest = sumAmountRequest;
			json.sumAmountRequestNext1Year = sumAmountRequestNext1Year;
			json.sumAmountRequestNext2Year = sumAmountRequestNext2Year;
			json.sumAmountRequestNext3Year = sumAmountRequestNext3Year;
			
			var html = this.resultTableTemplate(json);
			this.$el.find('#resultTable').html(html);
			

		}
		
		
	});

	$(document).ready(function() {

		if(fiscalYear.length > 0) {
		
			mainBudgetType.fetch({
				url: appUrl('/BudgetType/fiscalYear/' +fiscalYear+ '/mainType')
			});
			
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
