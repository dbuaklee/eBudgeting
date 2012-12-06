var myApiUrl = '/eBudgeting';
function appUrl(url) {
	return myApiUrl  + url; 
}


// Model
Objective = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [
	    {
	    	type: Backbone.HasOne,
	    	key: 'type',
	    	relatedModel: 'ObjectiveType'
	    },{
	    	type: Backbone.HasMany,
	    	key: 'children',
	    	relatedModel: 'Objective',
	    	collectionType: 'ObjectiveCollection'	    
	    },{
	    	type: Backbone.HasMany,
	    	key: 'budgetTypes',
	    	relatedModel: 'BudgetType',
	    	collectionType: 'BudgetTypeCollection'
	    },{
	    	type: Backbone.HasOne,
	    	key: 'parent',
	    	relatedModel: 'Objective'
	    }, {
	    	type: Backbone.HasMany,
	    	key: 'proposals',
	    	relatedModel: 'BudgetProposal',
	    	collectionType: 'BudgetProposalCollection'
	    },{
	    	type: Backbone.HasMany,
	    	key: 'filterProposals',
	    	relatedModel: 'BudgetProposal',
	    	collectionType: 'BudgetProposalCollection'
	    },{
	    	type: Backbone.HasMany,
	    	key: 'sumBudgetTypeProposals',
	    	relatedModel: 'BudgetProposal',
	    	collectionType: 'BudgetProposalCollection'
	    }, {
	    	type: Backbone.HasMany,
	    	key: 'allocationRecords',
	    	relatedModel: 'AllocationRecord',
	    	collectionType: 'AllocationRecordCollection'
	    }, {
	    	type: Backbone.HasMany,
	    	key: 'allocationRecordsR1',
	    	relatedModel: 'AllocationRecord',
	    	collectionType: 'AllocationRecordCollection'
	    }, {
	    	type: Backbone.HasMany,
	    	key: 'allocationRecordsR2',
	    	relatedModel: 'AllocationRecord',
	    	collectionType: 'AllocationRecordCollection'
	    }, {
	    	type: Backbone.HasMany,
	    	key: 'allocationRecordsR3',
	    	relatedModel: 'AllocationRecord',
	    	collectionType: 'AllocationRecordCollection'
	    }, {
	    	type: Backbone.HasMany,
	    	key: 'reservedBudgets',
	    	relatedModel: 'ReservedBudget',
	    	collectionType: 'ReservedBudgetCollection'
	    }, {
	    	type: Backbone.HasMany,
	    	key: 'targets',
	    	relatedModel: 'ObjectiveTarget',
	    	collectionType: 'ObjectiveTargetCollection'
	    }, {
	    	type: Backbone.HasMany,
	    	key: 'units',
	    	relatedModel: 'TargetUnit',
	    	collectionType: 'TargetUnitCollection'
	    },{
	    	type: Backbone.HasMany,
	    	key: 'targetValues',
	    	relatedModel: 'TargetValue',
	    	collectionType: 'TargetValueCollection'
	    }, {
	    	type:Backbone.HasMany,
	    	key: 'filterTargetValues',
	    	relatedModel: 'TargetValue',
	    	collectionType: 'TargetValueCollection'
	    }, {
	    	type: Backbone.HasMany,
	    	key: 'targetValueAllocationRecords',
	    	relatedModel: 'TargetValueAllocationRecord',
	    	collectionType: 'TargetValueAllocationRecordCollection'
	    }, {
	    	type: Backbone.HasMany,
	    	key: 'targetValueAllocationRecordsR1',
	    	relatedModel: 'TargetValueAllocationRecord',
	    	collectionType: 'TargetValueAllocationRecordCollection'
	    },  {
	    	type: Backbone.HasMany,
	    	key: 'targetValueAllocationRecordsR2',
	    	relatedModel: 'TargetValueAllocationRecord',
	    	collectionType: 'TargetValueAllocationRecordCollection'
	    }, {
	    	type: Backbone.HasMany,
	    	key: 'targetValueAllocationRecordsR3',
	    	relatedModel: 'TargetValueAllocationRecord',
	    	collectionType: 'TargetValueAllocationRecordCollection'
	    }, {
	    	type: Backbone.HasMany,
	    	key: 'relations',
	    	relatedModel: 'ObjectiveRelations',
	    	collectionType: 'ObjectiveRelationsCollection'
	    }, {
	    	type: Backbone.HasOne,
	    	key: 'objectiveName', 
	    	relatedModel: 'ObjectiveName'
	    }
	    
	],
	urlRoot: appUrl('/Objective'),
	levelSort: function() {
		if(this.get('parentPath') == null) {
			return parseInt(0);
		}
		var levelNum = this.get('parentPath').split(".").length;
		
		// now padding to index 
		if(this.get('index') > 9) {
			return parseInt("" + levelNum + this.get('index'));
		} else {
			return parseInt("" + levelNum + "0" + this.get('index'));
		}
		
	}
});

ObjectiveName = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type: Backbone.HasOne,
		key: 'type',
		relatedModel: 'ObjectiveType'
	}, {
		type: Backbone.HasMany,
		key: 'units',
		relatedModel: 'TargetUnit',
		collectionType: 'TargetUnitCollection'
	}],
	urlRoot: appUrl('/ObjectiveName/')
	    
});

ObjectiveRelations = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type: Backbone.HasOne,
		key: 'objective',
		relatedModel: 'Objective'
	}, {
		type: Backbone.HasOne,
		key: 'parent',
		relatedModel: 'Objective'
	},{
		type: Backbone.HasOne,
		key: 'parentType',
		relatedModel: 'ObjectiveType'
	}, {
		type: Backbone.HasOne,
		key: 'childType',
		relatedModel: 'ObjectiveType'
	}],
	urlRoot: appUrl('/ObjectiveRelations')
});

ObjectiveType = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [
	    {
	    	type: Backbone.HasOne,
	    	key: 'parent',
	    	relatedModel: 'ObjectiveType'
	    },{
	    	type: Backbone.HasMany,
	    	key: 'children',
	    	relatedModel: 'ObjectiveType',
	    	collectionType: 'ObjectiveTypeCollection'
	    }
	],
	urlRoot: appUrl('/ObjectiveType')
});

BudgetCommonType = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	urlRoot: appUrl('/BudgetCommonType/')
});

BudgetType = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [
	    {
	    	type: Backbone.HasMany,
	    	key: 'children',
	    	relatedModel: 'BudgetType',
	    	collectionType: 'BudgetTypeCollection',
	    	reverseRelation: {
	    		type: Backbone.HasOne,
	    		key: 'parent'
	    	}
	    },{
	    	type: Backbone.HasMany,
	    	key: 'strategies',
	    	relatedModel: 'FormulaStrategy',
	    	collectionType: 'FormulaStrategyCollection'
	    }
	],
	setIdUrl: function(id) {
		this.url = this.urlRoot + "/" + id;
	},
	urlRoot: appUrl('/BudgetType'),
	loadParent: function(budgetTypeCollection, current) {
		if(this.get('parent') != null) {
			this.get('parent').fetch({
				success: _.bind(function(model, response) {
					budgetTypeCollection.add(response);
					_.each(response.children, function(child) {
						if(child.id == current.id) {
							child.selected = true;
						}
					});
					
					if(this.get('parent') != null) {
						this.loadParent(budgetTypeCollection, response);
					} else {
						budgetTypeCollection.trigger('finishLoadParent', budgetTypeCollection);
					}
					
				}, this.get('parent'))
			});
		} else {
			budgetTypeCollection.trigger('finishLoadParent', budgetTypeCollection);
		}
		
	}
});
FiscalBudgetType =  Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type: Backbone.HasOne,
    	key: 'budgetType',
    	relatedModel: 'BudgetType'
	}]
});



FormulaColumn = Backbone.RelationalModel.extend({
	idAttribute: 'id',

	urlRoot: appUrl('/FormulaColumn')
});

FormulaStrategy = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [
	    {
	    	type:Backbone.HasMany,
	    	key: 'formulaColumns',
	    	relatedModel: 'FormulaColumn',
	    	reversRelation: {
	    		type: Backbone.HasOne,
	    		key: 'strategy'
	    	}
	    	
	    },{
	    	type: Backbone.HasOne,
	    	key: 'type',
	    	relatedModel: 'BudgetType',
	    	collectionType: 'BudgetTypeCollection'
	    },{
	    	type: Backbone.HasOne,
	    	key: 'commonType',
	    	relatedModel: 'BudgetCommonType'
	    },{
	    	type: Backbone.HasOne,
	    	key: 'unit',
	    	relatedModel: 'TargetUnit'
	    }
	],
	urlRoot: appUrl('/FormulaStrategy')

});

ProposalStrategy = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type:Backbone.HasOne,
		key: 'formulaStrategy',
		relatedModel: 'FormulaStrategy'
			
	},{
    	type:Backbone.HasMany,
    	key: 'requestColumns',
    	relatedModel: 'RequestColumn',
    	reversRelation: {
    		type: Backbone.HasMany,
    		key: 'proposalStrategy'
    	}
	}],
	urlRoot: appUrl('/ProposalStrategy')
});

RequestColumn = Backbone.RelationalModel.extend({
	idAtrribute: 'id',
	relations: [{
		type:Backbone.HasOne,
		key: 'proposalStrategy',
		relatedModel: 'ProposalStrategy'
	}],
	urlRoot: appUrl('/RequestColumn')
});

AllocationRecord = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type: Backbone.HasOne,
		key: 'forObjective',
		relatedModel : 'Objective'
	},{
		type: Backbone.HasOne,
		key: 'budgetType',
		relatedModel : 'BudgetType'
	}],
	urlRoot: appUrl('/AllocationRecord')
});

BudgetProposal = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type:Backbone.HasOne,
		key: 'forObjective',
		relatedModel: 'Objective'
	},{
		type:Backbone.HasMany,
		key: 'proposalStrategies',
		relatedModel: 'ProposalStrategy'
	},{
		type:Backbone.HasOne,
		key: 'budgetType',
		relatedModel: 'BudgetType'
	},{
		type:Backbone.HasOne,
		key: 'owner',
		relatedModel: 'Organization'
	}],
	urlRoot: appUrl('/BudgetProposal')
});
ObjectiveBudgetProposal = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type:Backbone.HasOne,
		key: 'forObjective',
		relatedModel: 'Objective'
	},{
		type:Backbone.HasOne,
		key: 'budgetType',
		relatedModel: 'BudgetType'
	}],
	urlRoot: appUrl('/ObjectiveBudgetProposal/')
});

ReservedBudget = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type:Backbone.HasOne,
		key: 'forObjective',
		relatedModel: 'Objective'
	},{
		type:Backbone.HasOne,
		key: 'budgetType',
		relatedModel: 'BudgetType'
	}],
	urlRoot: appUrl('/ReservedBudget')
});

ProposalStrategy = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type:Backbone.HasOne,
		key: 'formulaStrategy',
		relatedModel: 'FormulaStrategy'
	},{
		type:Backbone.HasMany,
		key: 'requestColumns',
		relatedModel: 'RequestColumn'
	},{
		type:Backbone.HasOne,
		key: 'proposal',
		relatedModel: 'BudgetProposal' 
	}],
	urlRoot: appUrl('/ProposalStrategy')
});

RequestColumn = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type:Backbone.HasOne,
		key: 'proposalStrategy',
		relatedModel: 'ProposalStrategy'
	}, {
		type:Backbone.HasOne,
		key: 'column',
		relatedModel: 'FormulaColumn'
	}]
});

Organization = Backbone.RelationalModel.extend({
	idAttribute: 'id'
});

ObjectiveTarget = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type: Backbone.HasOne,
		key: 'unit',
		relatedModel: 'TargetUnit',
		reversRelation: {
    		type: Backbone.HasMany,
    		key: 'targets'
    	}
	}],
	urlRoot: appUrl('/ObjectiveTarget/')
});

TargetUnit = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type: Backbone.HasMany,
		key: 'targets',
		relatedModel: 'ObjectiveTarget'
	}],
	urlRoot: appUrl('/TargetUnit/')
});
TargetValue = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type: Backbone.HasOne,
		key: 'target',
		relatedModel: 'ObjectiveTarget',
	},{
		type: Backbone.HasOne,
		key: 'forObjective',
		relatedModel: 'Objective'
	},{
		type:Backbone.HasOne,
		key: 'owner',
		relatedModel: 'Organization'
	}],
	urlRoot: appUrl('/TargetValue/')
});
TargetValueAllocationRecord = Backbone.RelationalModel.extend({
	idAttribute: 'id',
	relations: [{
		type: Backbone.HasOne,
		key: 'forObjective',
		relatedModel : 'Objective'
	},{
		type: Backbone.HasOne,
		key: 'target',
		relatedModel : 'ObjectiveTarget'
	}],
	urlRoot: appUrl('/TargetValueAllocationRecord')
});


// PagableCollection
PagableCollection = Backbone.Collection.extend({
	
	parse: function(response) {
		this.pageSize = response.size;
		this.pageNumber = response.number;
		this.lastPage = response.lastPage;
		this.firstPage = response.firstPage;
		this.totalPages = response.totalPages;
		this.numberOfElements = response.numberOfElements;
		this.totalElements = response.totalElements;
		
		return response.content;
	},
	
	toPageJSON: function() {
		return {
			size: this.size,
			number: this.number,
			lastPage: this.lastPage,
			firstPage: this.firstPage,
			totalPages: this.totalPages,
			numberOfElements: this.numberOfElements,
			totalElements: this.totalElements,
			contents: this.toJSON()
		};
	},
	
	toPageParamsJSON: function() {
		var json={};
		json.hasPage=true;
		json.totalElements=this.totalElements;
		json.pageSize=this.pageSize;
		json.page=[];
		
		this.targetPage = parseInt(this.targetPage);
		
		var rem = this.targetPage % 10;
		
		var first = this.targetPage - rem;
		
		if(first > 0) {
			json.page.push({pageNumber: this.targetPage-10+1, isActive: false, isPrev: true});
		}
		
		var last = this.targetPage + (10-rem);
		if(last > this.totalPages) {
			last = this.totalPages;
		}
		
		for(var i=first; i<last; i++) {
			var isActive = i+1 == this.targetPage;
			json.page.push({pageNumber: i+1, isActive: isActive, showPageNumber: true});
		}
		
		if(last < this.totalPages) {
			
			var number=this.targetPage +10;
			if(number > this.totalPages) {
				number = this.totalPages;
			}
			
			json.page.push({pageNumber: number + 10+1, isActive: false, isNext: true});
		}
		
		return json;
	}
});


// Collection

ObjectiveCollection = Backbone.Collection.extend({
	model: Objective
});

ObjectiveNameCollection = Backbone.Collection.extend({
	model: ObjectiveName
});

ObjectiveNamePagableCollection = PagableCollection.extend({
	initialize: function(models, options) {
	    this.fiscalYear = options.fiscalYear;
	    this.objectiveTypeId = options.objectiveTypeId;
	    this.targetPage = options.targetPage;
	  },
	
	model: ObjectiveName,
	
	url: function() {
	    return appUrl('/ObjectiveName/fiscalYear/'+ this.fiscalYear +'/type/'+this.objectiveTypeId+'/page/'+this.targetPage);
	},
	
	getIds: function() {
		return this.pluck("id");
	},
	setParams: function(fiscalYear, ObjectiveTypeId, targetPage) {
		this.fiscalYear = fiscalYear;
	    this.objectiveTypeId = objectiveTypeId;
	    this.targetPage = targetPage;
	}
	
});

ObjectivePagableCollection = PagableCollection.extend({
	initialize: function(models, options) {
	    this.fiscalYear = options.fiscalYear;
	    this.objectiveTypeId = options.objectiveTypeId;
	    this.targetPage = options.targetPage;
	  },
	
	model: Objective,
	
	url: function() {
	    return appUrl('/Objective/'+ this.fiscalYear +'/type/'+this.objectiveTypeId+'/page/'+this.targetPage);
	},
	getIds: function() {
		return this.pluck("id");
	},
	setParams: function(fiscalYear, ObjectiveTypeId, targetPage) {
		this.fiscalYear = fiscalYear;
	    this.objectiveTypeId = objectiveTypeId;
	    this.targetPage = targetPage;
	}
	
});

ObjectiveTypeCollection = Backbone.Collection.extend({
	model: ObjectiveType
});
BudgetTypeCollection = Backbone.Collection.extend({
	model: BudgetType
});
BudgetCommonTypeCollection = Backbone.Collection.extend({
	model: BudgetCommonType
});
BudgetProposalCollection = Backbone.Collection.extend({
	model: BudgetProposal
});
FormulaStrategyCollection = Backbone.Collection.extend({
	model: FormulaStrategy
});
FormulaColumnCollection = Backbone.Collection.extend({
	model: FormulaColumn
});
ProposalStrategyCollection = Backbone.Collection.extend({
	model: ProposalStrategy
});
AllocationRecordCollection =Backbone.Collection.extend({
	model: AllocationRecord
}); 
TargetValueAllocationRecordCollection=Backbone.Collection.extend({
	model: TargetValueAllocationRecord
});
ReservedBudgetCollection =Backbone.Collection.extend({
	model: ReservedBudget
});
ObjectiveTargetCollection = Backbone.Collection.extend({
	model: ObjectiveTarget
});
TargetUnitCollection = Backbone.Collection.extend({
	model: TargetUnit
});
TargetUnitPagableCollection = PagableCollection.extend({
	initialize: function(models, options) {
	    this.targetPage = options.targetPage;
	},
	
	model: TargetUnit,
	
	url: function() {
	    return appUrl('/TargetUnit/page/'+this.targetPage);
	}
});

TargetValueCollection = Backbone.Collection.extend({
	model: TargetValue
});
ObjectiveRelationsCollection = Backbone.Collection.extend({
	model: ObjectiveRelations
});
FiscalBudgetTypeCollection = Backbone.Collection.extend({
	model: FiscalBudgetType
});
ObjectiveBudgetProposalCollection = Backbone.Collection.extend({
	model: ObjectiveBudgetProposal
}); 

//Handlebars Utils


