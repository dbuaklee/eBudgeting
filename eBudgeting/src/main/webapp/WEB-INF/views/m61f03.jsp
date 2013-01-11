<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>การบันทึกงบประมาณ ระดับกิจกรรม <c:if test="${not empty fiscalYear}">ปีงบประมาณ ${fiscalYear}</c:if></h4> 
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
<table id="budgetList"></table>
<div id="budgetListPager"></div>
</script>



<script type="text/javascript">
	var objectiveId = "${objective.id}";
	var fiscalYear = "${fiscalYear}";

	var pageUrl = "/page/m61f03/";
	var mainTblView = null;
	var objectiveCollection = new ObjectiveCollection();
	var rootObjective = new Objective();
	
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
			this.$el.html(this.mainCtrBodyTemplate());
			
			// Create the table
			var dogsTable = $("#budgetList").jqGrid({
				datatype: 'json',
			    width:'820',
			    height: '400',
			    treeGrid: true,
			    treeGridModel: 'adjacency',
			    url: appUrl('/ObjectiveWithBudgetProposal/'+fiscalYear+'/1/flatDescendants'), 
			    mtype: "GET",
			    caption: 'รายละเอียดงบประมาณ',
			    colNames:['id', 'รหัส', 'ชื่อกิจกรรม'],
			    colModel:[{
			    	name:'id',index:'id', width:1,hidden:true,key:true
			    },{
			    	name:'code', index: 'รหัส', width:50,
			    	align:'left', 
			    	cellattr: function (rowId, tv, rawObject, cm, rdata) {
			            return 'style="white-space: normal; line-height: normal; padding: 5px 5px 5px 5px; vertical-align: top;';
			    	}
			    }, {
			    	name:'name',  index: 'ชื่อกิจกรรม', width:50,
			    	align:'left',
			    	cellattr: function (rowId, tv, rawObject, cm, rdata) {
			            return 'style="white-space: normal; line-height: normal; padding: 5px 5px 5px 5px; vertical-align: top;';
			    	}
			    }],
			    loadComplete : function(data) {
			    	
			       
			    },
			    loadError : function(xhr, status, error) {
			        alert('grid loading error' + error);
			    },
			    pager: '#budgetListPager',
			    jsonReader: {
			        repeatitems: false,
			        id: "0",
			        cell: "",
			        root: function (obj) { 
						objectiveCollection = new ObjectiveCollection(obj);
						return objectiveCollection.toJSON(); 
					},
			        page: function (obj) { return 1; },
			        total: function (obj) { return 1; },
			        records: function (obj) { return obj.length; }
			    },
			    treeReader : {
	    		   level_field: "parentLevel",
	    		   parent_id_field: "parent", 
	    		   leaf_field: "isLeaf"
	    		}
			    
			});
		}
		
		
	});

	$(document).ready(function() {

		if(fiscalYear.length > 0) {
		
			mainBudgetType.fetch({
				url: appUrl('/BudgetType/fiscalYear/' +fiscalYear+ '/mainType')
			});
			
/*
			objectiveCollection.fetch({
				url: appUrl('/Objective/' + fiscalYear + '/type/' + 103),
				success: function() {
					mainTblView = new MainTblView();
					mainTblView.render();
				}
			});
 */			
			
			mainTblView = new MainTblView();
			mainTblView.render();
			

		}

	});
</script>
