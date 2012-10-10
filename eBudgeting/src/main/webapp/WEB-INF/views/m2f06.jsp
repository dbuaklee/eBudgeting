<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
	<div class="span12">

	    <ul class="breadcrumb" id="headNav">
	    	<c:forEach items="${breadcrumb}" var="link" varStatus="status">
	    		<c:choose>
					<c:when test="${status.last}">
						<li class="active">${link.value}</li>
					</c:when>
					<c:otherwise>
						<li><a href="${link.url}">${link.value}</a> <span class="divider">/</span></li>
					</c:otherwise>
				</c:choose>
	    	</c:forEach>
	    </ul>

		

		<div id="modal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" id="closeBtn">Close</a> 
				<a href="#"	class="btn btn-primary" id="saveBtn">Save changes</a>
			</div>
		</div>


		<div class="control-group" id="mainCtr">
			
		
		</div>


	</div>
</div>

<script id="rootMainCtrTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td>เลือกปีงบประมาณ</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>{{this}} <a href="./{{this}}/" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
		</tr>
	</tbody>
</table>
</script>

<script id="mainCtrTemplate" type="text/x-handler-template">
<label class="control-label" for="mainTbl">{{type.name}} {{indexHuman index}} {{name}}</label>
<div class="controls" style="margin-bottom: 15px;">
	<a href="#" class="btn btn-mini btn-info menuNew"><i class="icon icon-file icon-white"></i> เพิ่มรายการ</a>
	<a href="#" class="btn btn-mini btn-primary menuEdit"><i class="icon icon-edit icon-white"></i> แก้ไข</a>
	<a href="#" class="btn btn-mini btn-danger menuDelete"><i class="icon icon-trash icon-white"></i> ลบ</a> 
</div>
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td width="20"></td>
			<td width="50">ลำดับที่</td>
			<td>{{#each type.children}}{{name}} {{/each}}</td>
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
</script>


<script id="tbodyTemplate" type="text/x-handlebars-template">
{{#each this}}
<tr data-id="{{id}}"><td><input type="radio" name="rowRdo" id="rdo_{{index}}" value="{{index}}"/></td>
	<td> {{indexHuman index}} </td>
	<td> {{name}} 
		{{#if this.children}}
			<a href="./{{id}}/" class="nextChildrenLnk"><i class="icon icon-chevron-right"></i> </a>
		{{else}}
			<button class="btn btn-mini">เพิ่มรายการย่อย</button>
			<button class="btn btn-mini detail">กำหนดรายละเอียด</button>
		{{/if}} 
	</td>

</tr>
{{/each}}
</script>

<script id="budgetTypeSelectionTemplate" type="text/x-handler-template">

</script>


<script id="newRowTemplate" type="text/x-handlebars-template">
<td></td>
	<td> {{indexHuman index}} </td>
	<td> <input type='text' placeholder='...' class='span7' value="{{name}}"></input> 
			<button indexHolder='{{index}}' class='btn btn-mini btn-info lineSave'>บันทึก</button>
			<button indexHolder='{{index}}' class='btn btn-mini btn-danger cancelLineSave'>ยกเลิก</button>
	</td>

</script>

<script id="modalTemplate" type="text/x-handlebars-template">
<form>
	<label>ตัวชี้วัด</label>
	<input type="text" placeholder="Type something">

	<label>หมวดงบประมาณ</label>
	<div id="budgetSelectionCtr"></div>

</form>
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

<script id="proposalInputTemplate" type="text/x-handler-template">
<div id="proposalInputCtr">
<label>ระบุชื่อรายการงบประมาณ</label>
<input type="text"/> <br/>
</div>
</script>

<script type="text/javascript">
<!--
var mainTblView;

var e1;
var objectiveCollection;
var currentPath='${currentPath}';

var ROOT='${ROOT}';




$(document).ready(function() {
	// bind to popstate
	$(window).bind('popstate', function(e) {
	  console.log(e.state);
	});

	
	var BudgetProposalView = Backbone.View.extend({
		initialize: function(options){
			if(options != null) {
				this.el = options.el;
				this.model = options.model;
			} 
			
		},
		el: "#budgetSelectionCtr",
		budgetProposalInputTpl : Handlebars.compile($("#proposalInputTemplate").html()),
		
		render: function(){
			// first clear the siblings select
			this.$el.nextAll('div').remove();
			this.$el.empty();
			this.$el.html(this.budgetProposalInputTpl(this.model.toJSON()));
		}
	});
	
	var ModalView = Backbone.View.extend({
		initialize: function(){
		    
		},
		el: "#modal",
		objective : null,
		modalTemplate: Handlebars.compile($("#modalTemplate").html()),
		
		render: function() {
			if(this.objective != null) {
			
				var html = this.modalTemplate(this.objective.toJSON());
				this.$el.find('.modal-header span').html(this.objective.get('name'));
				this.$el.find('.modal-body').html(html);
	
				
			    var rootBudgetType = BudgetType.findOrCreate({id:0});
			    rootBudgetType.fetch({success: _.bind(function(){
			    	this.budgetTypeSelection = new BudgetTypeSelectionView({model: rootBudgetType, el:'#budgetSelectionCtr'});
			    	this.budgetTypeSelection.render();
			    },this)});
				
				
				this.$el.modal({show: true, backdrop: 'static', keyboard: false});
			}
		},
		
		events: {
			"click #closeBtn" : "close",
			"click #saveBtn" : "save"
		},
		
		close: function(e) {
			e1=this.$el;
			this.$el.modal('hide');
		},
		
		save: function(e) {
			// try saving objective back to server!?
		},
		
		renderWith: function(objective) {
			this.setObjective(objective);
			this.render();
		},
		
		setObjective: function(objective) {
			this.objective = objective;
		}
		
	});

	var BudgetTypeSelectionView = Backbone.View.extend({
		initialize: function(options){
			if(options != null) {
				this.el = options.el;
				this.model = options.model;
			} 
			
		},
		el: "#budgetSelectionCtr",
		selectionTpl : Handlebars.compile($("#selectionTemplate").html()),
		
		render: function(){
			// first clear the siblings select
			this.$el.nextAll('div').remove();
			this.$el.empty();
			this.$el.html(this.selectionTpl(this.model.toJSON()));
		},
		
		events: {
			"change select:first" : "selectionChange" // only the first one
		},
		
		selectionChange: function(e) {
			var selectedBudgetTypeId = $(e.target).val();
			// now try to get this model
			var budgetType = BudgetType.findOrCreate(selectedBudgetTypeId);
			budgetType.fetch({success: _.bind(function(){
				if(!budgetType.get('children').isEmpty()) {
					var nextEl = this.$el.selector + " select + div";
					this.nextBudgetTypeSelectionView = new BudgetTypeSelectionView({model: budgetType, el: nextEl});
					this.nextBudgetTypeSelectionView.render();
				} else {
					// then we should now filling in the proposed budget
					var nextEl = this.$el.selector + " select + div";
					this.nextBudgetTypeSelectionView = new BudgetProposalView({model: budgetType, el: nextEl});
					this.nextBudgetTypeSelectionView.render();
				}
			}, this)});
			
		}
	});

	var MainTblView = Backbone.View.extend({
		initialize: function(){
		    this.collection.bind('reset', this.render, this);
		    
		},
	
		el: "#mainCtr",
		selectedObjective: null,
		currentLineVal: null,
		modalView: new ModalView(),
		
		newRowTemplate: Handlebars.compile($("#newRowTemplate").html()),
		mainCtrTemplate: Handlebars.compile($("#mainCtrTemplate").html()),
		tbodyTemplate: Handlebars.compile($("#tbodyTemplate").html()),
	
		
		render: function() {
			// first render the control
			var html;
			
			if(this.selectedObjective != null) {
				html = this.mainCtrTemplate(this.selectedObjective.toJSON());
			} else {
				html = this.mainCtrTemplate({name: 'ปี 2556', type:{name: 'งบประมาณ', children: [{name:'แผนงาน'}]} });
			}
			this.$el.html(html);
			
			// then the inside row
			html = this.tbodyTemplate(this.collection.toJSON());
			this.$el.find('tbody').html(html);
			
			return this;
		},
		
		events: {
			"click .menuNew" : "newRow",
			"click .menuDelete" : "deleteRow",
			"click .menuEdit"	: "editRow",
			"click .lineSave" : "saveLine",
			"click .cancelLineSave" : "cancelSaveLine",
			"click .detail" : "detailModal"
		},
		
		newRow: function(e) {
			if(! $(e.currentTarget).hasClass('disabled') ) {
				$('#mainTbl tbody').append('<tr>'+this.newRowTemplate({index:this.collection.length})+'</tr>');
				this.$el.find('a.btn').toggleClass('disabled');
			}
		},
		
		cancelSaveLine: function(e) {
			//now put back the value
			// well do nothing just reset the collection
			
			this.$el.find('a.btn').toggleClass('disabled');
			this.collection.trigger("reset");
			
		},
		
		saveLine: function(e) {
			
			 
			inputVal = $(e.currentTarget).prev('input').val();
			indexRow = parseInt($(e.currentTarget).attr('indexHolder'));
			if(this.collection.at(indexRow) == null) {
				
				this.collection.add(new Objective({name: inputVal, index: indexRow}));
			} else {
				var model  = this.collection.at(indexRow);
				model.set('name', inputVal);
			}
			
			this.$el.find('a.btn').toggleClass('disabled');
			
			this.collection.trigger("reset");
		
		},
		
		deleteRow: function(e) {
			if( (! $(e.currentTarget).hasClass('disabled')) && $('input[name=rowRdo]:checked').length == 1 ) {
				var indexToDelete = $('input[name=rowRdo]:checked').val();
				var modelToDelete = this.collection.at(indexToDelete);
				this.collection.remove(modelToDelete);
				
				// now we have to run through and reindex
				this.collection.each(function(model, index) {
					model.set('index', index);
				});
				
				this.collection.trigger('reset');
			} else {
				alert('กรุณาเลือกรายการที่ต้องการลบ');
			}
		},
		
		editRow: function(e) {
			if((! $(e.currentTarget).hasClass('disabled') ) && $('input[name=rowRdo]:checked').length == 1) {
				this.$el.find('a.btn').toggleClass('disabled');
				var index = $('input[name=rowRdo]:checked').val();
				var model = this.collection.at(index);
				// now save current line Value 
				this.currentLineVal = this.collection.at(index).get('name');
				
				var html = this.newRowTemplate(model.toJSON());
				$('input[name=rowRdo]:checked').parents('tr').html(html);
			} else {
				alert('กรุณาเลือกรายการที่ต้องการแก้ไข');
			}
		},
		
		detailModal: function(e) {
			// now prepare information for modal
			e1 = $(e.currentTarget);
			
			var objectiveId = $(e.currentTarget).parents('tr').attr('data-id');
			var objective = this.collection.get(objectiveId);
			
			this.modalView.renderWith(objective);
			
		},
		
		slideInChildren: function(e) {
			e1 = e;
			var id = $(e.target).parents('tr').attr('data-id');
			
				
			var f1 = function() {
				//once the animation is done
				// now load content and replace in div...
				this.collection.url='/eBudgeting/Objective/'+this.id+'/children';
				this.collection.fetch();
	
			};
			
			f1 = _.bind(f1, {collection: this.collection, id: id});
			
			// change the ul
			
			
			lastLiHtml = $('#headNav').children().last().html();
			prevLiHref = $('#headNav').find('a:last').attr('href');
			
			if(this.selectedObjective.get('parent') == null) {
				lastHref = prevLiHref + "2556/";
			} else {
				lastHref = prevLiHref + this.selectedObjective.get('id') + "/";	
			}
			
			// get selected id;
			this.selectedObjective = this.collection.get(id); 
			
			$('#headNav').children().last().html("<li><a href=" + lastHref +">"+ lastLiHtml +"</a> <span class='divider'>/</span></li>");
			
			var humanIndex = this.selectedObjective.get('index')+1;
			$('#headNav').append("<li class='active'>" + this.selectedObjective.get('type').get('name') + "ที่ " +
					humanIndex + "</li>");
			
			// now update currentPath with
			//history.pushState($('#mainTbl').html(),null,window.document.URL+id+"/");
			
			html = "<div style='height: 100px;display: table-cell; vertical-align: middle; text-align: center;'>Loading <br/><img src='/eBudgeting/resources/graphics/spinner_bar.gif'></img></div>";
			// slide In spinner
			this.$el.slideLeft(html,f1);
							
			//return false to not navigate to new page
			return false;
		}
		
	});
	
	
	//rowCol.trigger('reset');
	
	//experimental
	objectiveCollection = new ObjectiveCollection();
	
	
	
	// now we can create a view
	mainTblView = new MainTblView({
		collection: objectiveCollection
	});
	
	lastObjectiveId="${lastObjectiveId}";
	if(!isNaN(parseInt(lastObjectiveId))) {
		var objective = new Objective();
		objective.url = "/eBudgeting/Objective/" + lastObjectiveId;
		objective.fetch({success: function() {
			mainTblView.selectedObjective = objective;
			mainTblView.render();
		}});
			
	}
	
	objectiveCollection.url = "${url}";
	
	if(ROOT != 'true') {
		objectiveCollection.fetch();
		
	} else {
		// now we'll load different one onto this mainTbl
		$.get(objectiveCollection.url, function(data) {
			var t = Handlebars.compile($("#rootMainCtrTemplate").html());
			$('#mainCtr').html(t(data));
		});
	}


});

//-->
</script>