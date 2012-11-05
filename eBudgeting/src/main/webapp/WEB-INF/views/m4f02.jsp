<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="row">
	<div class="span12">
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
			<c:choose>
				<c:when test="${rootPage}">
					<table class="table table-bordered" id="mainTbl">
						<thead>
							<tr>
								<td>เลือกปีงบประมาณ</td>
							</tr>
						</thead>
						<tbody>
							<tr>
								<c:forEach items="${fiscalYears}" var="fiscalYear">
									<td><a href="./${fiscalYear.fiscalYear}/${fiscalYear.id}/"
										class="nextChildrenLnk">${fiscalYear.fiscalYear} <i
											class="icon icon-chevron-right nextChildrenLnk"></i>
									</a></td>
								</c:forEach>
							</tr>
						</tbody>
					</table>
				</c:when>
			</c:choose>
		</div>

	</div>
</div>

<script id="budgetTypeSelectionTemplate" type="text/x-handler-template">
{{#if editStrategy}}<b>แก้ไขจำนวนเงิน</b>{{else}}<b>เลือกงบประมาณ</b>{{/if}}
<select id="budgetTypeSlt" {{#if editStrategy}} disabled {{/if}}>
	<option value="0">กรุณาเลือกรายการ</option>
	{{#each this}}
	<option value="{{id}}" {{#if selected}}selected='selected'{{/if}}>{{name}}</option>
	{{/each}}
</select>
<div id="strategySelectionDiv"></div>
</script>

<script id="strategySelectionTemplate" type="text/x-handler-template">
<select id="strategySlt" {{#if editStrategy}} disabled {{/if}}>
	<option value="0">กรุณาเลือกรายการ</option>
	{{#each this}}
	<option value="{{id}}" {{#if selected}}selected='selected'{{/if}}>{{name}}</option>
	{{/each}}
</select>
<div><form id="input-form">
		
	</form></div>
</script>

<script id="mainCtrTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="mainTbl" style="margin-bottom:0px; width:900px; table-layout:fixed;">
	<thead>
		<tr>
			<th stlye="width:400px;"><strong>แผนงาน/กิจกรรม ประจำปี {{this.0.fiscalYear}}</strong><br/>- ระดับ{{this.0.type.name}}</th>
			<th width="80">เป้าหมาย</th>
			<th width="80">ขอตั้งปี  {{this.0.fiscalYear}}</th>
			<th width="80">ปรับลดครั้งที่ 3 (เหลือ) </th>
			<th width="80">ยอดจัดสรรลงหน่วยรับ </th>
			<th width="80">ยอดจัดสรรลงส่วนกลาง </th>
		</tr>
	</thead>
</table>
<div style="height: 400px; overflow: auto; width:920px">
<table class="table table-bordered" id="mainTbl" style="width:900px; table-layout:fixed;">
	<tbody>
		
			{{{childrenNodeTpl this 0}}}
		
	</tbody>
</table>
</div>
</script>

<script id="childrenNormalNodeTemplate" type="text/x-handler-template">
		<tr>
			<td stlye="width:400px;"><a href="../{{this.id}}/" class="nextChildrenLnk">{{this.name}} <i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
			<td width="80"></td>
			<td style="text-align:right" width="80">{{#if this.proposals}} {{formatNumber this.proposals.0.amountRequest}} {{else}}0.00{{/if}}</td>
			<td width="80"></td>
			<td width="80"></td>
			<td width="80"></td>
		</tr>
</script>

<script id="childrenNodeTemplate" type="text/x-handler-template">
	<tr data-level="{{this.level}}" data-id="{{this.id}}">
		<td style="padding-left:{{this.padding}}px;width:{{substract 405 this.padding}}px;" class="{{#if this.children}}disable{{/if}}">
			<span>
					{{#if this.children}}
					<input class="checkbox_tree bullet" type="checkbox" id="bullet_{{this.id}}"/>
					<label class="expand" for="bullet_{{this.id}}"><img width=12 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/></label>
					{{else}}					
						<img width=8 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/> - 
					{{/if}}
					<input class="checkbox_tree" type="checkbox" id="item_{{this.id}}"/>
					<label class="main" for="item_{{this.id}}">
						{{#unless this.children}}<a href="#" class="detail">{{/unless}}
						<b>{{this.type.name}}ที่ {{indexHuman this.index}}</b> [{{this.id}}-{{this.code}}] {{this.name}}
						{{#unless this.children}}</a>{{/unless}}
					</label>
					{{#unless this.children}}
						<img width=12 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/>
						<ul>
						{{#each this.sumBudgetTypeProposals}}
							 <li> {{budgetType.name}} - {{{formatNumber amountRequest}}} บาท</li>
						{{/each}}
						</ul>
					{{/unless}}
			</span> 
		</td>
			<td  width="80"  class="{{#if this.children}}disable{{/if}}"><span></span>
				 {{#unless this.children}}<br/><a col-id="1" href="#mainfrm" class="btn btn-mini">เพิ่ม/แก้ไข</a>{{/unless}}
			</td>
			<td width="80" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.sumBudgetTypeProposals}}{{{sumProposal this.sumBudgetTypeProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<ul class="right-align">
					<li>
					<u>{{#if this.sumBudgetTypeProposals}}{{{sumProposal this.sumBudgetTypeProposals}}}{{/if}}</u>
					</li>
					{{#each this.sumBudgetTypeProposals}}
							 <li> {{{formatNumber amountRequest}}}</li>
					{{/each}}
					</ul>
				{{/if}}
			</td>

			<td width="80" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.allocationRecordsR3}} {{{sumAllocatedRecord this.allocationRecordsR3}}} {{else}} - {{/if}}</span>
				{{else}}
					<ul class="right-align">					
						<li><u>{{#if this.allocationRecordsR3}}{{{sumAllocatedRecord this.allocationRecordsR3}}}{{else}}-{{/if}}</u>
					
						{{#each this.allocationRecordsR3}}
					 		<li> {{{formatNumber amountAllocated}}}</li>
						{{/each}}
					</ul>
				{{/if}}
			</td>
			
			<td width="80" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.sumBudgetTypeProposals}} {{{sumAllocatedRecord this.sumBudgetTypeProposals}}} {{else}} - {{/if}}</span>
				{{else}}
					<ul class="right-align">					
						<li><u>{{#if this.sumBudgetTypeProposals}}{{{sumAllocatedRecord this.sumBudgetTypeProposals}}}{{else}}-{{/if}}</u>
					
						{{#each this.sumBudgetTypeProposals}}
							{{#if this.amountAllocated}}
					 		<li><a href="#" data-id="{{budgetType.id}}" class="detail"> {{{formatNumber amountAllocated}}}</a></li>
							{{else}}
							<li><a href="#" data-id="{{budgetType.id}}" class="detail"> จัดสรร </a></li>
							{{/if}}
						{{/each}}
					</ul>
				{{/if}}
			</td>

			<td width="80" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.reservedBudgets}} {{{sumAmountReserved this.reservedBudgets}}} {{else}} - {{/if}}</span>
				{{else}}
					<ul class="right-align">					
						<li><u>{{#if this.reservedBudgets}}{{{sumAmountReserved this.reservedBudgets}}}{{else}}-{{/if}}</u>
					
						{{#each this.reservedBudgets}}
					 		<li>  {{{formatNumber amountReserved}}}</li>
						{{/each}}
					</ul>
				{{/if}}
			</td>

	</tr>
	{{{childrenNodeTpl this.children this.level}}}
</script>

<script id="reservedBudgetInputTemplate" type="text/x-handler-template">
	<div>
		<input class="span2" type="text" data-id="{{id}}" {{#if amountReserved}}value="{{amountReserved}}"{{/if}} id="reservedBudgetInput"/> 
		<button class="btn btn-mini updateReservedBudget"><i class="icon-ok" icon-white"/> แก้ไข</button>
		<button class="btn btn-mini cancelUpdateReservedBudget"><i class="icon-remove" icon-white"/> ยกเลิก</button>
	</div>
</script>

<script id="modalHeaderTemplate" type="text/x-handler-template">
<div>
	หมวดงบประมาณ {{allocationRecordR3.budgetType.name}}
	<table>
		<tr><td>หลังปรับลดครั้งที่ 3 ได้รับ</td><td style="text-align:right">{{formatNumber allocationRecordR3.amountAllocated}} </td><td>บาท</td></tr>
		<tr><td>จัดสรรให้หน่วยงาน</td><td style="text-align:right">{{sumAllocatedRecord proposals}}</td><td> บาท</td></tr>
		<tr><td><a href="#" id="reservedBudgetLnk">จัดสรรเข้ายุทธศาสตร์กลาง</td><td style="text-align:right" id="reservedBudgetCell">{{formatNumber reservedBudget.amountReserved}} </td><td>บาท</td></tr>
		<tr><td>คงเหลือการจัดสรร</td><td style="text-align:right" id="amountLeftCell">{{amountLeft this}}</td><td>บาท</td></tr>
	</table>
</div>
	

</script>

<script id="modalTemplate" type="text/x-handler-template">
<div><u>รายการขอตั้งประมาณ</u></div>
	<ul id="budgetProposeLst">	
	{{#each this}}
		<li data-id="{{id}}"><a href="#" data-id="{{id}}" class="proposalLnk">{{owner.abbr}} ขอตั้ง = {{formatNumber amountRequest}}</a> บาท </a> / จัดสรร = {{formatNumber amountAllocated}} บาท</li> <div class="strategyDetail" style="display:none"/>
	{{/each}}
	</ul>
</div>
<div id="budgetTypeSelectionDiv"></div>
</script>

<script id="strategiesTemplate" type="text/x-handler-template">
<ul>
{{#each this}} 
	<li data-id="{{id}}" proposal-id="{{../id}}">
		<b>ขอตั้ง</b>			
		{{name}} : {{{formulaLine this false}}} = {{{formatNumber totalCalculatedAmount}}} บาท</li>

	<li style="list-style: none;" data-id="{{id}}"><a href="#" class="editProposal"><span class="label label-info"><i class="icon icon-edit icon-white editProposal"></i></span> จัดสรร </a>:  {{{formulaLine this true}}} = {{{formatNumberNotNull totalCalculatedAllocatedAmount}}} บาท</li>

{{/each}}
</ul>
</script>

<script id="editProposalFormTemplate" type="text/x-handler-template">
	<span class="label label-info"><i class="icon icon-edit icon-white editProposal"></i></span> จัดสรร :  
	{{#each formulaStrategy.formulaColumns}}
	{{columnName}}(<input type="text" class="span1 proposalEditInput" id="formulaStrategy-{{id}}" data-id="{{id}}" requestColumn-id="{{requestColumnId}}"
						 value="{{#if requestColumnId}}{{requestColumnAllocatedValue}}{{else}}{{allocatedAmount}}{{/if}}"/> {{unitName}}) {{#unless $last}} X {{/unless}} 
	{{/each}}
	
	 = <span id="totalCalculatedAllocatedAmount-{{id}}" class="totalCalculatedAllocatedAmount">{{{formatNumberNotNull totalCalculatedAllocatedAmount}}}</span> บาท <button class="btn btn-mini updateProposalStretegy"><i class="icon-ok" icon-white"/> แก้ไข</button>
		<button class="btn btn-mini cancelUpdateProposalStretegy"><i class="icon-remove" icon-white"/> ยกเลิก</button>
</script>

<script id="proposalInputTemplate" type="text/x-handler-template">
<div id="proposalInputCtr">
<br/>
ระบุชื่อรายการ <input type="text"/> <br/>
ระบุจำนวนเงินงบประมาณ <input type="text"/> <br/>

<button class="btn btn-primary">บันทึก</button> <button class="btn btn-primary">ยกเลิก</button> 
</div>
</script>


<script id="mainfrmTemplate" type="text/x-handler-template">
<br/>
<hr/>
<h4>กรุณากรอกข้อมูลงบประมาณ</h4>
{{this.type.name}} - {{this.name}}
<div id="budgetSelectionCtr"></div>
</script>


<script id="selectionTemplate" type="text/x-handler-template">
<select id="budgetType_{{this.id}}">
	<option value="0">กรุณาเลือกรายการ</option>
	{{#each this.children}}
	<option value="{{this.id}}">{{this.name}}</option>
	{{/each}}
</select>
<div></div>
</script>


<script type="text/javascript">
	var objectiveId = "${objective.id}";
	var fiscalYear = "${fiscalYear}";

	var pageUrl = "/page/m2f12/";
	var mainTblView = null;
	var objectiveCollection = null;
	var budgetTypeSelectionView = null;
	var rootCollection;
	var l = null;
	var e1;

	Handlebars.registerHelper("formatNumberNotNull", function(number){
		if(number == null || isNaN(number)) {
			return "????";
		} else {
			return addCommas(number);
		}
		
	});
	
	Handlebars.registerHelper("amountLeft", function(json) {
		var amountAllocated = json.allocationRecordR3.amountAllocated;
		var amountDistribute = 0;
		for(var i=0; i< json.proposals.length; i++){
			
			if(json.proposals[i].amountAllocated == null || isNaN(json.proposals[i].amountAllocated)) {
				//we'll skip this one!
					
			} else {
				amountDistribute = amountDistribute + json.proposals[i].amountAllocated;
			}
		}
		var amountReserved = json.reservedBudget.amountReserved;
		
		return addCommas( parseInt(amountAllocated) - parseInt(amountDistribute) - parseInt(amountReserved) );

	});
	Handlebars.registerHelper("sumProposal", function(proposals) {
		var amount = 0;
		for ( var i = 0; i < proposals.length; i++) {
			amount += proposals[i].amountRequest;
		}
		return addCommas(amount);

	});
	Handlebars.registerHelper("sumAllocatedRecord", function(records) {
		var amount = 0;
		for(var i=0; i<records.length; i++ ){
			amount += records[i].amountAllocated;
		}
		return addCommas(amount);
		
	});
	Handlebars.registerHelper("sumAmountReserved", function(records) {
		var amount = 0;
		for(var i=0; i<records.length; i++ ){
			amount += records[i].amountReserved;
			if(amount == null || isNaN(amount)) {
				return "จัดสรร";
			}
		}
		return addCommas(amount);
		
	});
	Handlebars.registerHelper("sumProposalNext1Year", function(proposals) {
		var amount = 0;
		for ( var i = 0; i < proposals.length; i++) {
			amount += proposals[i].amountRequestNext1Year;
		}
		return addCommas(amount);

	});
	Handlebars.registerHelper("sumProposalNext2Year", function(proposals) {
		var amount = 0;
		for ( var i = 0; i < proposals.length; i++) {
			amount += proposals[i].amountRequestNext2Year;
		}
		return addCommas(amount);

	});
	Handlebars.registerHelper("sumProposalNext3Year", function(proposals) {
		var amount = 0;
		for ( var i = 0; i < proposals.length; i++) {
			amount += proposals[i].amountRequestNext3Year;
		}
		return addCommas(amount);

	});


	Handlebars.registerHelper("formulaLine", function(strategy, isAllocated) {

		var s = "";

		if (strategy.formulaStrategy != null) {
			var formulaColumns = strategy.formulaStrategy.formulaColumns;
			for ( var i = 0; i < formulaColumns.length; i++) {

				if (i > 0) {
					s = s + " X ";
				}
				
				s = s + formulaColumns[i].columnName;
				
				if (formulaColumns[i].isFixed) {
					// now we'll go through requestColumns
					
					for (var j = 0; j < strategy.requestColumns.length; j++) {
						if (strategy.requestColumns[j].column.id == formulaColumns[i].id) {
							var str = "";
							
							if(isAllocated) {
								
								if(strategy.requestColumns[j].allocatedAmount==null) {
									 allocatedAmountStr = "????";
								} else {
									allocatedAmountStr = addCommas(strategy.requestColumns[j].allocatedAmount);
								}
								
								str += "("
									+ allocatedAmountStr
									+ " "+  formulaColumns[i].unitName
									+ ")";
							} else {
								str +=  "("
								+ addCommas(strategy.requestColumns[j].amount)
								+ formulaColumns[i].unitName
								+ ")";
							}
							s = s +  str;
						}
					}

				} else {
					if(isAllocated) {
						var allocatedValueStr = "";
						if(formulaColumns[i].allocatedValue == null) {
							allocatedValueStr = "????";
						} else {
							allocatedValueStr = addCommas(formulaColumns[i].allocatedValue);
						}
						
						s = s
							+ "("
							+ allocatedValueStr
							+ " " + formulaColumns[i].unitName
							+ ")";
						
					} else {
					
					s = s
							+ "("
							+ formulaColumns[i].value
							+ " " + formulaColumns[i].unitName
							+ ")";
					
					}
					
				}

			}
		}

		return s;
	});

	Handlebars.registerHelper('substract', function(a, b) {
		return a - b;
	});

	Handlebars.registerHelper('childrenNodeTpl', function(children, level) {
		var out = '';
		var childNodeTpl = Handlebars
				.compile($("#childrenNodeTemplate").html());
		var childNormalNodeTpl = Handlebars.compile($(
				"#childrenNormalNodeTemplate").html());
		if (level == undefined)
			level = 0;
		if (children != null && children.length > 0) {

			if (children[0].type.id > 0) {
				children.forEach(function(child) {
					child["level"] = level + 1;
					child["padding"] = (parseInt(level) + 1) * 12;
					out = out + childNodeTpl(child);
				});

			} else {
				children.forEach(function(child) {
					out = out + childNormalNodeTpl(child);
				});
			}
		}

		return out;
	});

	Handlebars.registerHelper('next', function(val, next) {
		return val + next;
	});


	var ModalView = Backbone.View.extend({
		initialize : function() {

		},

		el : "#modal",

		
		modalTemplate : Handlebars.compile($('#modalTemplate').html()),
		modalHeaderTemplate : Handlebars.compile($('#modalHeaderTemplate').html()),
		stategiesTemplate : Handlebars.compile($('#strategiesTemplate').html()),
		reservedBudgetInputTemplate : Handlebars.compile($('#reservedBudgetInputTemplate').html()),
		editProposalFormTemplate : Handlebars.compile($('#editProposalFormTemplate').html()),

		events : {
			"click .editProposal" : "editProposal",
			"click #cancelBtn" : "cancelModal",
			"click #saveBtn" : "saveModal",
			"click .close" : "cancelModal",
			"click .proposalLnk" : "toggleStrategy",
			"click #reservedBudgetLnk" : "toggleReservedBudgetCellInput",
			"click .cancelUpdateReservedBudget" : "cancelUpdateReservedBudget",
			"click .updateReservedBudget" : "updateReservedBudget",
			"change .proposalEditInput" : "updateTotalCalculatedValue",
			"click .updateProposalStretegy" : "updateProposalStretegy",
			"click .cancelUpdateProposalStretegy" : "cancelUpdateProposalStretegy"

		},
		
		saveModal: function(e) {
			//check first
			
			
			if(parseInt($('#amountLeftCell').html()) != 0) {
				alert("ยังเหลือยอดจัดสรร กรุณาจัดสรรให้ครบจำนวน");
				return;
			}
			
			//prepard json
			var json = {};
			json.proposals = this.budgetProposals.toJSON();
			json.reservedBudget = this.reservedBudget.toJSON();
			
			// can send budgetProposals back to save here...
			$.ajax({
				type : 'PUT',
				url : appUrl('/BudgetProposalsAndReservedBudget/'),
				data : JSON.stringify(json),
				contentType : 'application/json;charset=utf-8',
				dataType : "json",
				success : _.bind(function(data) {
					window.location.reload();
				}, this)
			});
			
		},

		cancelModal : function(e) {
			window.location.reload();
		},
		
		cancelUpdateProposalStretegy: function(e) {
			this.render();	
		},
		
		cancelUpdateReservedBudget: function(e) {
			this.render();
		},
		
		updateProposalStretegy: function(e) {
			var allInput = $(e.target).parents('li').find('.proposalEditInput');
			var strategyId = $(e.target).parents('li').attr('data-id');
			var totalMulti = 1;
			
			for(var i=0; i<allInput.length; i++) {
				// check if we update formulaStrategy or requestColumn
				var requestColumnId = parseInt($(allInput[i]).attr('requestColumn-id'));
				
				if(isNaN(requestColumnId)) {
					var formulaId = $(allInput[i]).attr('data-id');
					var fc = FormulaColumn.findOrCreate(formulaId);
					
					var inputValue = parseInt($(allInput[i]).val());
	
					if(!isNaN(inputValue)) {
						fc.set('allocatedValue', inputValue);
						if(totalMulti != null) {
							totalMulti = totalMulti * inputValue;
						}
					} else {
						totalMulti = null;
					}
				} else {
					
					var rc = RequestColumn.findOrCreate(requestColumnId);
	
					var inputValue = parseInt($(allInput[i]).val());
					
					if(!isNaN(inputValue)) {
						rc.set('allocatedAmount', inputValue);
						if(totalMulti != null) {
							totalMulti = totalMulti * inputValue;
						}
					} else {
						totalMulti = null;
					}

				}
				
			}
			// lastly 
			var ps = ProposalStrategy.findOrCreate(strategyId);
			ps.set('totalCalculatedAllocatedAmount', totalMulti);

			//not quite , update budgetProposal
			var budgetProposalId = $(e.target).parents('div.strategyDetail').prev().attr('data-id');
			var bp = BudgetProposal.findOrCreate(budgetProposalId);
			
			var totalAllocatedAmount =0;
			for(var i=0; i<bp.get('proposalStrategies').length;i++) {
				var calculatedAllocatedAmount = bp.get('proposalStrategies').at(i).get('totalCalculatedAllocatedAmount');
				if(calculatedAllocatedAmount != null) {
					totalAllocatedAmount += calculatedAllocatedAmount;
				}
			}
			
			bp.set('amountAllocated', totalAllocatedAmount);
			this.render();
			
		},
		
		updateReservedBudget : function(e) {
			var reservedAmount = $('#reservedBudgetInput').val();
			
			this.reservedBudget.set('amountReserved', parseInt(reservedAmount));
			
			this.render();
			
		},
		
		
		toggleReservedBudgetCellInput: function(e) {
			var json = this.reservedBudget.toJSON();
			var html = this.reservedBudgetInputTemplate(json);
				
			$('#reservedBudgetCell').html(html);
		},
		
		updateTotalCalculatedValue: function(e) {
			var allInput = $(e.target).parents('li').find('.proposalEditInput');
			var totalMulti=1;
			
			// now multiply all input
			for(var i=0; i<allInput.length; i++) {
				var inputValue = parseInt($(allInput[i]).val());
				
				if(!isNaN(inputValue)) {
					totalMulti = totalMulti * inputValue;
				} else {
					return false;
				}
			}
			
			// update the value
			var totalSpan = $(e.target).parents('li').find('.totalCalculatedAllocatedAmount');
			$(totalSpan).html(addCommas(totalMulti));
			
		},

		toggleStrategy : function(e) {
			var proposalId = $(e.target).attr('data-id');
			var currentProposal = BudgetProposal.findOrCreate(proposalId);
			
			// now make a div after this
			var nextDiv = $(e.target).parent().next();
			
			//prepare for data
			var json = currentProposal.get('proposalStrategies').toJSON();
			
			
			
			var html = this.stategiesTemplate(json);
			
			nextDiv.html(html);
			nextDiv.toggle();
			
		},
		
		editProposal : function(e) {
			
			var psId = $(e.target).parent().attr('data-id');
			// we have to turn this to input 
			var ps = ProposalStrategy.findOrCreate(psId);
			
			var json = ps.toJSON();
			
			var l = json.formulaStrategy.formulaColumns.length;
			
			json.formulaStrategy.formulaColumns[l-1].$last = true;
			// now go through and put the requestColumn back on
			for(var i=0; i<json.formulaStrategy.formulaColumns.length; i++) {
				if(json.formulaStrategy.formulaColumns[i].isFixed) {
					var columnId = json.formulaStrategy.formulaColumns[i].id;
					
					var fc = FormulaColumn.findOrCreate(columnId);
					
					var rc = ps.get('requestColumns').where({column: fc})[0];
					
					json.formulaStrategy.formulaColumns[i].requestColumnId = rc.get('id');
					json.formulaStrategy.formulaColumns[i].requestColumnAllocatedValue = rc.get('allocatedValue');
					
				}
			}
			
			var html = this.editProposalFormTemplate(json);
			
			$(e.target).parent().html(html);
			
		},

		render : function() {
			if (this.objective != null) {
				this.$el.find('.modal-header span').html(this.objective.get('name'));
				
				var html;
				
				
				
				var allocationRecordR3 = this.objective.get('allocationRecordsR3').where({budgetType: this.budgetType});
				var json = {};
				json.allocationRecordR3 = allocationRecordR3[0].toJSON();
				json.proposals = this.budgetProposals.toJSON();
				json.reservedBudget = this.reservedBudget.toJSON();
				
				html = this.modalHeaderTemplate(json);
				
				this.$el.find('.modal-body').html(html);
				
				html = this.modalTemplate(this.budgetProposals.toJSON());
				this.$el.find('.modal-body').append(html);

			}

			this.$el.modal({
				show : true,
				backdrop : 'static',
				keyboard : false
			});
			return this;
		},

		renderWith : function(currentObjective, currentBudgetType) {
			this.objective = currentObjective;
			this.budgetType = currentBudgetType;
			this.budgetProposals = new BudgetProposalCollection(this.objective.get('proposals').where({budgetType:this.budgetType}));
			this.reservedBudget = this.objective.get('reservedBudgets').where({budgetType:this.budgetType})[0];
			this.render();
		}
	});

	var MainTblView = Backbone.View.extend({
		initialize : function() {
			this.collection.bind('reset', this.render, this);
			_.bindAll(this, 'detailModal');
		},

		el : "#mainCtr",
		mainTblTpl : Handlebars.compile($("#mainCtrTemplate").html()),
		modalView : new ModalView(),

		events : {
			"click input[type=checkbox].bullet" : "toggle",
			"click .detail" : "detailModal"
		},

		detailModal : function(e) {
			var currentObjectiveId = $(e.target).parents('tr').attr('data-id');
			var currentObjective = Objective.findOrCreate(currentObjectiveId);

			var proposalStrategyCollection = new ProposalStrategyCollection();
			
			
			var currentBudgetTypeId = $(e.target).attr('data-id');
			var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
			
			proposalStrategyCollection.fetch({
				url : appUrl('/ProposalStrategy/findAll/' + fiscalYear + '/' + currentObjective.get('id')),
				success : _.bind(function() {
					
					var proposals = currentObjective.get('proposals');
					var i;
					for (i = 0; i < proposalStrategyCollection.length; i++) {
						var strategy = proposalStrategyCollection.at(i);
						proposals.get(strategy.get('proposal').get('id')).get('proposalStrategies').add(strategy);
					}

					this.modalView.renderWith(currentObjective, currentBudgetType);
				}, this)
			});

		},
		render : function() {
			this.$el.html(this.mainTblTpl(this.collection.toJSON()));

		},

		toggle : function(e) {
			l = e;
			var clickLevel = $(l.target).parents('tr').attr('data-level');
			$(l.target).next('label').toggleClass("expand collapse");

			var currentTr = $(l.target).parents('tr');

			currentTr.nextUntil('tr[data-level=' + clickLevel + ']').toggle();
		}

	});

	$(document).ready(function() {
		
		if(objectiveId != null && objectiveId.length >0 ) {
			objectiveCollection = new ObjectiveCollection();
			rootCollection = new ObjectiveCollection();
			
			objectiveCollection.url = appUrl("/ObjectiveWithBudgetProposalAndAllocation/"+ fiscalYear + "/" + objectiveId +"/flatDescendants");
			
			
			mainTblView = new MainTblView({collection: rootCollection});
			
			//load curent objective 
			parentObjective = new Objective({id: objectiveId});
			parentObjective.url=appUrl("/Objective/"+objectiveId);
			parentObjective.fetch({
				success: function() {

					objectiveCollection.fetch({
						success: function() {
							// we will now sorted out this mess!
							var i;
							for(i=0;i<objectiveCollection.length;i++){
								var o = objectiveCollection.at(i);
								if(o.get('parent') != null) {
									var parentId = o.get('parent').get('id');
									if(parentId == objectiveId) {
										rootCollection.add(o);
									}
									
									var parentObj = objectiveCollection.get(parentId);
									if(parentObj != null) {
										parentObj.get('children').add(o);	
									}
									
									// now sort out AllocationRecords R1/R2/R3
									
									var records = o.get('allocationRecords');
									
									o.set('allocationRecordsR1', records.where({index: 0}));
									o.set('allocationRecordsR2', records.where({index: 1}));
									o.set('allocationRecordsR3', records.where({index: 2}));
									
								}
							}
							
							rootCollection.trigger('reset');
							
						}
					});
				}
			});
		}
		
	});
</script>