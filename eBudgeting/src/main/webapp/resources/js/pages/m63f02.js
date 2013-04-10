var ModalView = Backbone.View.extend({
	/**
     *  @memberOf ModalView
     */
	initialize: function() {
		
	},
	
	el: "#modal",
	
	modalTemplate: Handlebars.compile($('#modalTemplate').html()),
	modalFormTemplate: Handlebars.compile($('#inputModalTemplate').html()),
	
	events: {
		"click #cancelBtn" : "cancelModal",
		"click #saveBtn" : "saveModal"
	},
	
	cancelModal: function(e) {
		  window.location.reload();
	},
	
	saveModal: function(e) {
		var amountAllocated = $('#amountAllocated').val();
		var allocationRecordId = $('#amountAllocated').attr('data-id');
		
		var record = AllocationRecord.findOrCreate(allocationRecordId);
		
		var newAmount = parseInt(amountAllocated);
		
		record.set('amountAllocated', newAmount);
		
		if(record == null) {
			// Post a new allocation Record
			record = new AllocationRecord();
			record.set('amountAllocated', amountAllocated);
			record.set('budgetType', budgetType);
			record.set('forObjective', this.objectvie);
		} else {
		
			// now try to save this..
			$.ajax({
				type: 'PUT',
				url: appUrl('/AllocationRecord/'+record.get('id')),
				contentType: 'application/json;charset=utf-8',
				dataType: "json",
				data: JSON.stringify(record.toJSON()),
				success: function() {
					window.location.reload();
				}
			});
		}
		
	},
	
	
	render: function() {
		if(this.objective != null) {
			
			this.$el.find('.modal-header span').html(this.objective.get('name'));
			
			var json =this.budgetProposalCollection.toJSON();
			json.budgetType = this.budgetType.toJSON();
			
			
			var html = this.modalTemplate(json);
			this.$el.find('.modal-body').html(html);
			
			html = this.modalFormTemplate(this.allocationRecord.toJSON());
			this.$el.find('.modal-body').append(html);
						
		}
		
		
		this.$el.modal({show: true, backdrop: 'static', keyboard: false});
		return this;
	},
	
	renderWith: function(currentObjective, currentAllocationRecord, currentBudgetType, budgetProposalCollection) {
		this.objective = currentObjective;
		this.allocationRecord = currentAllocationRecord;
		this.budgetType = currentBudgetType;
		this.budgetProposalCollection = budgetProposalCollection;
		this.render();
	}
});

var TargetValueModalView=Backbone.View.extend({
	/**
	 * @memberOf TargetValueModalView
	 */
	initialize: function() {
		
	},
	
	el: "#targetValueModal",
	
	events : {
		"click #saveBtn" : "saveTargetValue",
		"click #cancelBtn" : "cancelTargetValue",
	},
	
	targetValueModalTpl : Handlebars.compile($("#targetValueModalTemplate").html()),
	render: function() {
		
		
		this.$el.find('.modal-header span').html(this.objectiveTarget.get('name'));
		
		var html = this.targetValueModalTpl(this.targetValue.toJSON());
		this.$el.find('.modal-body').html(html);

		
		
		this.$el.modal({
			show : true,
			backdrop : 'static',
			keyboard : false
		});
		return this;
	},
	cancelTargetValue: function() {
		this.$el.modal('hide');
	},
	saveTargetValue: function() {
		// we'll try to save
		var input = parseInt(this.$el.find('input').val());
		
		this.targetValue.save({
			 amountAllocated: input
		}, {
			success: function(){
				window.location.reload();
			}
		});
		
		
		
	},
	
	renderWith: function(objective, targetId, valueId) {
		this.objective = objective;
		this.objectiveTarget=ObjectiveTarget.findOrCreate(targetId);
		this.targetValue=TargetValueAllocationRecord.findOrCreate(valueId);
		if(this.targetValue == null) {
			this.targetValue = new TargetValue();
			this.targetValue.set('forObjective', objective);
			this.targetValue.set('target', this.objectiveTarget);
		}
		this.render();
	}

});

var MainTblView = Backbone.View.extend({
	/**
	 * @memberOf MainTbleView
	 */
	initialize: function(){
	    this.collection.bind('reset', this.render, this);
	    _.bindAll(this, 'detailModal');
	},
	
	el: "#mainCtr",
	mainTblTpl : Handlebars.compile($("#mainCtrTemplate").html()),
	modalView : new ModalView(),
	targetValueModalView : new TargetValueModalView(),
	
	events:  {
		"click input[type=checkbox].bullet" : "toggle",
		"click .detail" : "detailModal",
		"click .targetValueModal" : "targetValueModal"
	},
	
	targetValueModal: function(e) {
		var currentObjectiveId = $(e.target).parents('tr').attr('data-id');
		var currentObjective = Objective.findOrCreate(currentObjectiveId);
		
		var targetId = $(e.target).attr('target-id');
		var valueId = $(e.target).attr('data-id');
		
		this.targetValueModalView.renderWith(currentObjective, targetId, valueId);
	},
	
	detailModal: function(e) {
		var currentObjectiveId = $(e.target).parents('tr').attr('data-id');
		var currentObjective = Objective.findOrCreate(currentObjectiveId);
		
		var currentAllocationRecordId = $(e.target).attr('data-id');
		var currentAllocationRecord = AllocationRecord.findOrCreate(currentAllocationRecordId);
		
		var currentBudgetTypeId = currentAllocationRecord.get('budgetType').get('id');
		var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
		
		var budgetProposalCollection = new BudgetProposalCollection();
		budgetProposalCollection.fetch({
			url: appUrl('/BudgetProposal/find/' + fiscalYear +'/'+ currentObjective.get('id') + '/' + currentBudgetTypeId),
			success: _.bind(function() {
				this.modalView.renderWith(currentObjective,  currentAllocationRecord, currentBudgetType, budgetProposalCollection);		
			},this)
		});
		
		
	},
	render: function() {
		var json= this.collection.toJSON();
		
		var allProposal = new BudgetProposalCollection(); 
		_.each(rootCollection.pluck('sumBudgetTypeProposals'), function(bpCollection) {
			if(bpCollection.length > 0) {
				bpCollection.each(function(bp) {
					allProposal.add(bp);
				});
			}
		});
		
		
		var allAllocationRecordsR1 = new AllocationRecordCollection(); 
		_.each(rootCollection.pluck('allocationRecordsR1'), function(ar1Collection) {
			if(ar1Collection.length > 0) {
				ar1Collection.each(function(ar) {
					ar1Collection.add(ar);
				});
			}
		});
		
		json.allProposal = allProposal.toJSON();
		json.allAllocationRecordsR1 = allAllocationRecordsR1.toJSON();
		
		this.$el.html(this.mainTblTpl(json));
		
	},
	
	
	
	toggle: function(e) {
		l=e;
		var clickLevel = $(l.target).parents('tr').attr('data-level');
		$(l.target).next('label').toggleClass("expand collapse");
		
		var currentTr = $(l.target).parents('tr');
		
		currentTr.nextUntil('tr[data-level='+clickLevel+']').toggle();
	}
	
});
	