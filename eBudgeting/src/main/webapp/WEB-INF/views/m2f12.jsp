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
			<th width="80">ประมาณการ  {{next this.0.fiscalYear 1}}</th>
			<th width="80">ประมาณการ  {{next this.0.fiscalYear 2}}</th>
			<th width="80">ประมาณการ  {{next this.0.fiscalYear 3}}</th>
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
						{{#each this.filterProposals}}
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
					<span>{{#if this.filterProposals}}{{{sumProposal this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposal this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
			</td>

			<td width="80" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposalNext1Year this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposalNext1Year this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
			</td>
			<td width="80" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposalNext2Year this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposalNext2Year this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
			</td>
			<td width="80" style="text-align:right;" class="{{#if this.children}}disable{{/if}}">
				{{#if this.children}}
					<span>{{#if this.filterProposals}}{{{sumProposalNext3Year this.filterProposals}}}{{else}}-{{/if}}</span>
				{{else}}
					<a href="#" id="editable2-{{this.id}} data-type="text" class="detail">{{#if this.filterProposals}}{{{sumProposalNext3Year this.filterProposals}}}{{else}}-{{/if}}</a>
				{{/if}}
			</td>

	</tr>
	{{{childrenNodeTpl this.children this.level}}}
</script>

<script id="modalTemplate" type="text/x-handler-template">
<div><u>รายการงบประมาณลงข้อมูลไว้แล้ว</u></div>
	{{#each filterProposals}}
	<div> 
	<u>{{budgetType.name}}</u>
	<ul id="budgetProposeLst">
		{{#each proposalStrategies}} 
			<li data-id="{{id}}" proposal-id="{{../id}}">
				<span class="label label-info"><a href="#" class="editProposal"><i class="icon icon-edit icon-white editProposal"></i></a></span>				
				<span class="label label-important"><a href="#" class="removeProposal"><i class="icon icon-trash icon-white removeProposal"></i></a></span>
				{{name}} : {{{formulaLine this}}} = {{{formatNumber totalCalculatedAmount}}} บาท</li>
		{{/each}}
	</ul>
	</div>
	{{/each}}				
</div>
<div id="budgetTypeSelectionDiv"></div>


</script>

<script id="inputModalTemplate" type="text/x-handler-template">
	<hr/>
	ชื่อรายการ: <input type="text" id="proposalName" value="{{propsalStrategyName}}"/>
	<table class="formula table table-condensed">
	<tr>
	{{#each this.formulaColumns}}
		<td style="text-align:center" width=80>
		{{columnName}} 
		</td>
		{{#if this.$last}}
			<td style="text-align:center" width=5 rowspan="3">
			=
			</td>
		{{else}}
			<td style="text-align:center" width=5 rowspan="3">
			X
			</td>
		{{/if}}
	{{/each}}
	<td  style="text-align:center" width=80>
		คิดเป็น
	</td>
	<td rowspan="3">
		<button class="btn btn-mini copytoNextYear">คัดลอกไปประมาณการ 3 ปี</button>
	</td>
	</tr>
	<tr>
	{{#each this.formulaColumns}}
		{{#if isFixed}}
		<td style="text-align:center" class="isNotFixed">
			<input id="formulaColumnId-{{id}}" type="text" class="span1 formulaColumnInput" value="{{value}}"></input>
		</td>
		{{else}}
		<td style="text-align:center" class="isFixed">
			{{formatNumber value}}
		</td>
		{{/if}}
		
	{{/each}}
	<td  style="text-align:center" id="totalInputForm">
		{{total}}
	</td>
	</tr>
	<tr>
	{{#each this.formulaColumns}}
		<td style="text-align:center">
		{{unitName}}
		</td>
	{{/each}}
	<td style="text-align:center">บาท
	</td>
	</tr>
	</table>
	ประมาณการปี {{next1Year}}: <input type="text" id="amountRequestNext1Year" value="{{next1YearValue}}"/> บาท <br/>
	ประมาณการปี {{next2Year}}: <input type="text" id="amountRequestNext2Year" value="{{next2YearValue}}"/> บาท <br/>
	ประมาณการปี {{next3Year}}: <input type="text" id="amountRequestNext3Year" value="{{next3YearValue}}"/> บาท <br/>
	{{#if editStrategy}}<button data-id="{{proposalStrategyId}}" class="btn btn-mini updateProposal">แก้ไข</button>{{else}}<button class="btn btn-mini saveProposal">บันทึก</button>{{/if}}
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

	Handlebars.registerHelper("sumProposal", function(proposals) {
		var amount = 0;
		for ( var i = 0; i < proposals.length; i++) {
			amount += proposals[i].amountRequest;
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

	Handlebars.registerHelper("formulaLine", function(strategy) {

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
					var j;
					for (j = 0; j < strategy.requestColumns.length; j++) {
						if (strategy.requestColumns[j].column.id == formulaColumns[i].id) {
							s = s
									+ "("
									+ addCommas(strategy.requestColumns[j].amount)
									+ formulaColumns[i].unitName
									+ ")";
						}
					}

				} else {
					s = s
							+ "("
							+ addCommas(formulaColumns[i].value)
							+ " " + formulaColumns[i].unitName
							+ ")";
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

	var StrategySelectionView = Backbone.View
			.extend({
				initialize : function() {
					_.bindAll(this, 'render');
					_.bindAll(this, 'renderWithStrategy');
					_.bindAll(this, 'strategySelect');

				},

				el : "#strategySelectionDiv",
				events : {
					"change #strategySlt" : "strategySelect",
					"click .saveProposal" : "saveProposal",
					"click .copytoNextYear" : "copyToNextYear",
					"change .formulaColumnInput" : 'inputChange',
					"click .updateProposal" : 'updateProposal'
				},
				inputModalTemplate : Handlebars
						.compile($('#inputModalTemplate').html()),
				strategySelectionTemplate : Handlebars.compile($(
						'#strategySelectionTemplate').html()),
				currentStrategyCollection : null,

				render : function() {
					if (this.currentStrategyCollection != null) {
						var json = this.currentStrategyCollection.toJSON();
						this.$el.html(this.strategySelectionTemplate(json));
					}

				},

				renderWithStrategy : function(strategyCollection, parentModal) {
					this.parentModal = parentModal;
					this.currentStrategyCollection = strategyCollection;
					this.render();
				},

				renderWithWithDisableSelect : function(formulaStrategies,
						proposalStrategy, parentModal) {
					this.parentModal = parentModal;
					this.currentStrategyCollection = formulaStrategies;
					this.currentEditProposalStrategy = proposalStrategy;

					if (this.currentStrategyCollection != null) {
						var json = this.currentStrategyCollection.toJSON();

						for ( var i = 0; i < json.length; i++) {
							if (json[i].id == proposalStrategy.get(
									'formulaStrategy').get('id')) {
								json[i].selected = true;
							}
						}

						json.editStrategy = true;

						this.$el.html(this.strategySelectionTemplate(json));

						// now the Form!
						this.currentStrategy = proposalStrategy
								.get('formulaStrategy');

						var columns = this.currentStrategy
								.get('formulaColumns');
						//now set the last column
						columns.at(columns.length - 1).set("$last", true);

						// here we'll get the propose column

						var json = this.currentStrategy.toJSON();
						json.propsalStrategyName = proposalStrategy.get('name');
						json.proposalStrategyId = proposalStrategy.get('id');
						json.editStrategy = true;

						json.next1Year = this.currentStrategy.get('fiscalYear') + 1;
						json.next1YearValue = proposalStrategy
								.get('amountRequestNext1Year');

						json.next2Year = this.currentStrategy.get('fiscalYear') + 2;
						json.next2YearValue = proposalStrategy
								.get('amountRequestNext2Year');

						json.next3Year = this.currentStrategy.get('fiscalYear') + 3;
						json.next3YearValue = proposalStrategy
								.get('amountRequestNext3Year');

						var totalMulti = 1;

						for ( var i = 0; i < json.formulaColumns.length; i++) {
							if (json.formulaColumns[i].isFixed) {
								var colId = json.formulaColumns[i].id;
								// now find this colId in requestColumns
								var rc = proposalStrategy.get('requestColumns');
								var foundRC = rc.where({
									column : FormulaColumn.findOrCreate(colId)
								});
								json.formulaColumns[i].value = foundRC[0]
										.get('amount');

								totalMulti = totalMulti
										* parseInt(foundRC[0].get('amount'));
							} else {
								totalMulti = totalMulti
										* parseInt(json.formulaColumns[i].value);
							}

						}
						json.total = totalMulti;
						// now will go through

						var html = this.inputModalTemplate(json);
						// render strategy!
						this.$el.find('#input-form').html(html);

					}

				},

				inputChange : function(e) {
					// OK we'll go through all td value
					var allTdIsFixed = $(e.target).parents('tr').find(
							'td.isFixed');
					var allTdIsNotFixed = $(e.target).parents('tr').find(
							'td.isNotFixed');

					var amount = 1;

					//now multiply all from is Fixed!
					for ( var i = 0; i < allTdIsFixed.length; i++) {
						var value = $(allTdIsFixed[i]).html();
						amount = amount * parseInt(value);
					}

					//now moveon to the rest
					for ( var i = 0; i < allTdIsNotFixed.length; i++) {
						var value = $(allTdIsNotFixed[i]).find('input').val();
						if (isNaN(parseInt(value))) {
							amount = "";
							break;
						}
						amount = amount * parseInt(value);
					}

					// now put amount back amount
					$('#totalInputForm').html(addCommas(amount));
				},

				copyToNextYear : function(e) {
					var valueToCopy = $('#totalInputForm').html();
					valueToCopy = valueToCopy.replace(/,/g, '');
					this.$el.find('#amountRequestNext1Year').val(valueToCopy);
					this.$el.find('#amountRequestNext2Year').val(valueToCopy);
					this.$el.find('#amountRequestNext3Year').val(valueToCopy);
				},

				strategySelect : function(e) {

					var strategyId = e.target.value;

					var strategy = this.currentStrategyCollection
							.get(strategyId);
					this.currentStrategy = strategy;

					var columns = strategy.get('formulaColumns');
					//now set the last column
					columns.at(columns.length - 1).set("$last", true);

					// here we'll get the propose column

					var json = strategy.toJSON();
					json.next1Year = strategy.get('fiscalYear') + 1;
					json.next2Year = strategy.get('fiscalYear') + 2;
					json.next3Year = strategy.get('fiscalYear') + 3;
					var html = this.inputModalTemplate(json);
					// render strategy!
					this.$el.find('#input-form').html(html);

				},

				updateProposal : function(e) {
					if (this.currentEditProposalStrategy != null) {
						var proposalStrategy = this.currentEditProposalStrategy;
						// we just pick up changes
						// loop through formulaColumns
						var i;
						var calculatedAmount = 0;
						var formulaColumns = this.currentStrategy
								.get('formulaColumns');
						for (i = 0; i < formulaColumns.length; i++) {

							var fc = formulaColumns.at(i);
							if (fc.get('isFixed')) {
								var colId = fc.get('id');
								// now find this colId in requestColumns
								var rc = proposalStrategy.get('requestColumns');
								var foundRC = rc.where({
									column : FormulaColumn.findOrCreate(colId)
								})[0];

								foundRC.set('amount', this.$el.find(
										'#formulaColumnId-' + fc.get('id'))
										.val());

								if (calculatedAmount == 0) {
									calculatedAmount = foundRC.get('amount');
								} else {
									calculatedAmount = calculatedAmount
											* foundRC.get('amount');
								}

							} else {
								if (calculatedAmount == 0) {
									calculatedAmount = fc.get('value');
								} else {
									calculatedAmount = calculatedAmount
											* fc.get('value');
								}
							}
						}
						proposalStrategy.set('totalCalculatedAmount',
								calculatedAmount);
						proposalStrategy.set('name', this.$el.find(
								'#proposalName').val());
						proposalStrategy.set('amountRequestNext1Year', this.$el
								.find('#amountRequestNext1Year').val());
						proposalStrategy.set('amountRequestNext2Year', this.$el
								.find('#amountRequestNext2Year').val());
						proposalStrategy.set('amountRequestNext3Year', this.$el
								.find('#amountRequestNext3Year').val());

						// now we can send changes to the server?
						var json = proposalStrategy.toJSON();

						$.ajax({
							type : 'PUT',
							url : appUrl('/ProposalStrategy/'
									+ proposalStrategy.get('id')),
							data : JSON.stringify(json),
							contentType : 'application/json;charset=utf-8',
							dataType : "json",
							success : _.bind(function(data) {
								this.parentModal.render();
							}, this)
						});
					}

				},

				saveProposal : function(e) {
					if (this.currentStrategy != null) {
						var objective = this.parentModal.objective;
						var budgetType = this.parentModal.budgetTypeSelectionView.currentBudgetType;

						var budgetProposal = null;

						//find appropriate budgetProposal, the one with budgetTypeid == the selected one
						var pList = objective.get('filterProposals');
						for ( var i = 0; i < pList.length; i++) {
							var proposal = pList.at(i);

							if (proposal.get('budgetType').get('id') == budgetType
									.get('id')) {
								budgetProposal = proposal;
								break;
							}

						}

						if (budgetProposal == null) {
							// create new BudgetProposal
							budgetProposal = new BudgetProposal();
							budgetProposal.set('forObjective', {
								id : objective.get('id')
							});
							budgetProposal.set('budgetType', {
								id : budgetType.get('id')
							});

							// now put this proposal into objective;
							objective.get('filterProposals').push(
									budgetProposal);
						}

						// we will make a new ProposalStrategy
						var proposalStrategy = new ProposalStrategy();

						proposalStrategy.set('formulaStrategy', {
							id : this.currentStrategy.get('id')
						});

						// loop through formulaColumns
						var i;
						var calculatedAmount = 0;
						var formulaColumns = this.currentStrategy
								.get('formulaColumns');
						for (i = 0; i < formulaColumns.length; i++) {
							var fc = formulaColumns.at(i);
							if (fc.get('isFixed')) {
								var requestColumn = new RequestColumn();
								requestColumn.set('amount', this.$el.find(
										'#formulaColumnId-' + fc.get('id'))
										.val());
								requestColumn.set('column', fc);
								requestColumn.set('proposalStrategy',
										proposalStrategy);

								proposalStrategy.get('requestColumns').add(
										requestColumn);

								if (calculatedAmount == 0) {
									calculatedAmount = requestColumn
											.get('amount');
								} else {
									calculatedAmount = calculatedAmount
											* requestColumn.get('amount');
								}

							} else {
								if (calculatedAmount == 0) {
									calculatedAmount = fc.get('value');
								} else {
									calculatedAmount = calculatedAmount
											* fc.get('value');
								}
							}
						}
						proposalStrategy.set('totalCalculatedAmount',
								calculatedAmount);
						proposalStrategy.set('proposal', budgetProposal);
						proposalStrategy.set('name', this.$el.find(
								'#proposalName').val());
						proposalStrategy.set('amountRequestNext1Year', this.$el
								.find('#amountRequestNext1Year').val());
						proposalStrategy.set('amountRequestNext2Year', this.$el
								.find('#amountRequestNext2Year').val());
						proposalStrategy.set('amountRequestNext3Year', this.$el
								.find('#amountRequestNext3Year').val());

						if (budgetProposal.get('id') == null) {
							// now ready to post back
							var json = budgetProposal.toJSON();
							json.forObjective = {
								id : json.forObjective.id
							};
							json.budgetType = {
								id : json.budgetType.id
							};

							$
									.ajax({
										type : 'POST',
										url : appUrl('/BudgetProposal'),
										data : JSON.stringify(json),
										contentType : 'application/json;charset=utf-8',
										dataType : "json",
										success : _
												.bind(
														function(data) {

															budgetProposal.set(
																	'id',
																	data.id);

															var json = proposalStrategy
																	.toJSON();
															json.formulaStrategy = null;
															json.proposal = null;

															var i;
															for (i = 0; i < json.requestColumns.length; i++) {
																json.requestColumns[i].column = {
																	id : json.requestColumns[i].column.id
																};
															}

															$
																	.ajax({
																		type : 'POST',
																		url : appUrl('/ProposalStrategy/'
																				+ budgetProposal
																						.get('id')
																				+ '/'
																				+ proposalStrategy
																						.get(
																								'formulaStrategy')
																						.get(
																								'id')),
																		data : JSON
																				.stringify(json),
																		contentType : 'application/json;charset=utf-8',
																		dataType : "json",
																		success : _
																				.bind(
																						function() {
																							budgetProposal
																									.get(
																											'proposalStrategies')
																									.push(
																											proposalStrategy);
																							console
																									.log('budgetProposal: '
																											+ budgetProposal
																													.toJSON());
																							e1 = budgetProposal;
																							// rerender?
																							this.parentModal
																									.render();
																						},
																						this)
																	});

														}, this)
									});
						} else {
							var json = proposalStrategy.toJSON();
							json.formulaStrategy = null;
							json.proposal = null;

							var i;
							for (i = 0; i < json.requestColumns.length; i++) {
								json.requestColumns[i].column = {
									id : json.requestColumns[i].column.id
								};
							}

							$.ajax({
								type : 'POST',
								url : appUrl('/ProposalStrategy/'
										+ budgetProposal.get('id')
										+ '/'
										+ proposalStrategy.get(
												'formulaStrategy').get('id')),
								data : JSON.stringify(json),
								contentType : 'application/json;charset=utf-8',
								dataType : "json",
								success : _.bind(function() {
									budgetProposal.get('proposalStrategies')
											.push(proposalStrategy);
									// rerender?
									e1 = budgetProposal;
									this.parentModal.render();
								}, this)
							});
						}

					}
				},

			});

	var BudgetTypeSelectionView = Backbone.View.extend({
		initialize : function() {
			_.bindAll(this, 'render');
			_.bindAll(this, 'selectionChange');

		},
		el : "#budgetTypeSelectionDiv",

		strategySelectionView : new StrategySelectionView(),

		budgetSelectionTemplate : Handlebars.compile($(
				'#budgetTypeSelectionTemplate').html()),
		render : function() {
			if (this.currentBudgetTypeCollection != null) {
				var json = this.currentBudgetTypeCollection.toJSON();

				this.$el.html(this.budgetSelectionTemplate(json));
			}
		},
		events : {
			"change #budgetTypeSlt" : "selectionChange" // only the first one

		},

		selectionChange : function(e) {

			var budgetTypeId = $(e.target).val();

			if (budgetTypeId > 0) {
				var budgetType = this.currentBudgetTypeCollection
						.get(budgetTypeId);
				this.currentBudgetType = budgetType;

				// ok now we'll get the strategy here
				var formulaStrategies = new FormulaStrategyCollection;

				formulaStrategies.fetch({
					url : appUrl('/FormulaStrategy/search/' + fiscalYear + "/"
							+ budgetType.get('id')),
					success : _.bind(function(data) {
						budgetType.set('strategies', formulaStrategies);
						this.strategySelectionView
								.setElement("#strategySelectionDiv");

						this.strategySelectionView.renderWithStrategy(
								formulaStrategies, this.parentModal);

					}, this)
				});

			}
		},

		renderWithBudgetTypes : function(budgetTypeCollection, parentmodal) {
			this.parentModal = parentmodal;
			this.currentBudgetTypeCollection = budgetTypeCollection;
			this.render();
		},

		renderWithDisableSelect : function(budgetProposal, proposalStrategy) {
			if (this.currentBudgetTypeCollection != null) {
				var budgetType = budgetProposal.get('budgetType');

				var json = this.currentBudgetTypeCollection.toJSON();

				// now mark the one with selected

				for ( var i = 0; i < json.length; i++) {
					if (json[i].id == budgetType.get('id')) {
						json[i].selected = true;
					}
				}

				json.editStrategy = true;

				this.$el.html(this.budgetSelectionTemplate(json));

				// ok now we'll get the strategy here
				var formulaStrategies = new FormulaStrategyCollection;

				formulaStrategies.fetch({
					url : appUrl('/FormulaStrategy/search/' + fiscalYear + "/"
							+ budgetType.get('id')),
					success : _.bind(function(data) {
						budgetType.set('strategies', formulaStrategies);
						this.strategySelectionView
								.setElement("#strategySelectionDiv");

						this.strategySelectionView.renderWithWithDisableSelect(
								formulaStrategies, proposalStrategy,
								this.parentModal);

					}, this)
				});
			}
		}

	});

	var ModalView = Backbone.View
			.extend({
				initialize : function() {

				},

				el : "#modal",

				budgetTypeSelectionView : new BudgetTypeSelectionView(),

				modalTemplate : Handlebars.compile($('#modalTemplate').html()),

				events : {
					"click .removeProposal" : "removeProposal",
					"click .editProposal" : "editProposal",
					"click #cancelBtn" : "cancelModal",
					"click .close" : "cancelModal"

				},

				cancelModal : function(e) {
					window.location.reload();
				},

				editProposal : function(e) {
					var proposalStrategyId = $(e.target).parents('li').attr(
							'data-id');
					var budgetProposalId = $(e.target).parents('li').attr(
							'proposal-id');

					// now get this one
					var budgetProposal = this.objective.get('filterProposals')
							.get(budgetProposalId);
					var proposalStrategy = budgetProposal.get(
							'proposalStrategies').get(proposalStrategyId);

					// we'll begin by render the budgetTypeSelectionView
					this.budgetTypeSelectionView.renderWithDisableSelect(
							budgetProposal, proposalStrategy);

				},

				removeProposal : function(e) {
					var proposalStrategyId = $(e.target).parents('li').attr(
							'data-id');
					var budgetProposalId = $(e.target).parents('li').attr(
							'proposal-id');

					// now get this one
					var budgetProposal = this.objective.get('filterProposals')
							.get(budgetProposalId);
					var proposalStrategy = budgetProposal.get(
							'proposalStrategies').get(proposalStrategyId);

					if (proposalStrategy != null) {
						// we can start deleting it now.. 

						var r = confirm("คุณต้องการนำรายการนี้ออก?");
						if (r == true) {
							$
									.ajax({
										type : 'DELETE',
										url : appUrl('/ProposalStrategy/'
												+ proposalStrategyId),
										success : _
												.bind(
														function() {

															budgetProposal
																	.get(
																			'proposalStrategies')
																	.remove(
																			proposalStrategy);
															var newAmount = budgetProposal
																	.get('amountRequest')
																	- proposalStrategy
																			.get('totalCalculatedAmount');
															budgetProposal
																	.set(
																			'amountRequest',
																			newAmount);

															// now we'll have to trigger change all the way up ward

															this.objective
																	.trigger(
																			'change',
																			this.objective);
															this.render();
														}, this)
									});

						}
						return false;

					}
				},

				render : function() {
					if (this.objective != null) {
						var html = this.modalTemplate(this.objective.toJSON());
						this.$el.find('.modal-header span').html(
								this.objective.get('name'));
						this.$el.find('.modal-body').html(html);

						this.budgetTypeSelectionView = new BudgetTypeSelectionView();
						this.budgetTypeSelectionView.renderWithBudgetTypes(
								this.objective.get('budgetTypes'), this);

					}

					this.$el.modal({
						show : true,
						backdrop : 'static',
						keyboard : false
					});
					return this;
				},

				renderWith : function(currentObjective) {
					this.objective = currentObjective;
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
			proposalStrategyCollection.fetch({
				url : appUrl('/ProposalStrategy/find/' + fiscalYear + '/'
						+ currentObjective.get('id')),
				success : _.bind(function() {
					var proposals = currentObjective.get('filterProposals');
					var i;
					for (i = 0; i < proposalStrategyCollection.length; i++) {
						var strategy = proposalStrategyCollection.at(i);
						proposals.get(strategy.get('proposal').get('id')).get(
								'proposalStrategies').add(strategy);
					}

					this.modalView.renderWith(currentObjective);
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

	$(document)
			.ready(
					function() {

						if (objectiveId != null && objectiveId.length > 0) {
							objectiveCollection = new ObjectiveCollection();
							rootCollection = new ObjectiveCollection();

							objectiveCollection.url = appUrl("/ObjectiveWithBudgetProposal/"
									+ fiscalYear
									+ "/"
									+ objectiveId
									+ "/flatDescendants");

							mainTblView = new MainTblView({
								collection : rootCollection
							});

							//load curent objective 
							parentObjective = new Objective({
								id : objectiveId
							});
							parentObjective.url = appUrl("/Objective/"
									+ objectiveId);
							parentObjective
									.fetch({
										success : function() {

											objectiveCollection
													.fetch({
														success : function() {
															// we will now sorted out this mess!
															var i;
															for (i = 0; i < objectiveCollection.length; i++) {
																var o = objectiveCollection
																		.at(i);
																if (o
																		.get('parent') != null) {
																	var parentId = o
																			.get(
																					'parent')
																			.get(
																					'id');
																	if (parentId == objectiveId) {
																		rootCollection
																				.add(o);
																	}

																	var parentObj = objectiveCollection
																			.get(parentId);
																	if (parentObj != null) {
																		parentObj
																				.get(
																						'children')
																				.add(
																						o);
																	}

																}
															}

															rootCollection
																	.trigger('reset');

														}
													});
										}
									});
						}

					});
</script>