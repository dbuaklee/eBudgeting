var DetailModalView = Backbone.View.extend({
	/**
	 * @memeberOf DetailModalView
	 */
	initialize: function() {
		
	},
	
	el: '#detailModal',
	
	detailModalTemplate : Handlebars.compile($('#detailModalTemplate').html()),
	
	
	renderWithObjective : function(objective) {
		this.currentObjective = objective;
		this.render();
	},
	render: function() {
		
		this.$el.find('.modal-header span').html(this.currentObjective.get('name'));
		
		var json = this.currentObjective.toJSON();
		
		
		var html = this.detailModalTemplate(json);
		this.$el.find('.modal-body').html(html);
		
		this.$el.modal({show: true, backdrop: 'static', keyboard: false});
		
		return this;
	}
});

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

var MainSelectionView = Backbone.View.extend({
	/**
	 * @memberOf MainSelectionView
	 */
	mainSelectionTemplate : Handlebars.compile($("#mainSelectionTemplate").html()),
	selectionTemplate : Handlebars.compile($("#selectionTemplate").html()),
	type102DisabledSelectionTemplate : Handlebars.compile($("#type102DisabledSelection").html()),
	type103DisabledSelectionTemplate : Handlebars.compile($("#type103DisabledSelection").html()),
	
	
	initialize: function() {
		
		this.type102Collection = new ObjectiveCollection();
		this.type103Collection = new ObjectiveCollection();
		
		_.bindAll(this, 'renderInitialWith');
		_.bindAll(this, 'renderType102');
		_.bindAll(this, 'renderType103');
		this.type102Collection.bind('reset', this.renderType102);
		this.type103Collection.bind('reset', this.renderType103);
	},
	events: {
		"change select#type101Slt" : "type101SltChange",
		"change select#type102Slt" : "type102SltChange",
		"change select#type103Slt" : "type103SltChange"
	},
	type101SltChange : function(e) {
		var type101Id = $(e.target).val();
		if(type101Id != 0) {
			this.type102Collection.fetch({
				url: appUrl('/Objective/' + type101Id + '/children'),
				success: _.bind(function() {
					this.type102Collection.trigger('reset');
				}, this)
			});
		}
		
		mainCtrView.emptyTbl();
		
	},
	type102SltChange : function(e) {
		var type102Id = $(e.target).val();
		if(type102Id != 0) {
			this.type103Collection.fetch({
				url: appUrl('/Objective/' + type102Id + '/children'),
				success: _.bind(function() {
					this.type103Collection.trigger('reset');
				}, this)
			});
		}
		
		this.$el.find('#type103Div').empty();
		this.$el.find('#type103Div').html(this.type103DisabledSelectionTemplate());
		
		mainCtrView.emptyTbl();
	},
	
	type103SltChange : function(e) {
		var type103Id = $(e.target).val();
		if(type103Id != 0) {
			var obj = Objective.findOrCreate(type103Id);
			mainCtrView.renderMainTblWithParent(obj);
			
		} else {
			mainCtrView.emptyTbl();
		}
	
	},
	
	renderType102: function(e) {
		var json = this.type102Collection.toJSON();
		json.type =  {};
		json.type.name = "ผลผลิต/โครงการ";
		json.type.id = "102";
		var html = this.selectionTemplate(json);
		
		// now render 
		this.$el.find('#type102Div').empty();
		this.$el.find('#type102Div').html(html);
		
		this.$el.find('#type103Div').empty();
		this.$el.find('#type103Div').html(this.type103DisabledSelectionTemplate());
		
		
	},
	
	renderType103: function(e) {
		var json = this.type103Collection.toJSON();
		json.type =  {};
		json.type.name = "กิจกรรมหลัก";
		json.type.id = "103";
		var html = this.selectionTemplate(json);
		
		// now render 
		this.$el.find('#type103Div').empty();
		this.$el.find('#type103Div').html(html);
		
		
	},
	
	render: function() {
		
		if(this.rootChildrenObjectiveCollection != null) {
			var json = this.rootChildrenObjectiveCollection.toJSON();
			
			var html = this.mainSelectionTemplate(json);
			this.$el.html(html);
		}
	}, 
	renderInitialWith: function(objective) {
		
		e1=this;
		
		this.rootObjective = objective;
		
		// now get this rootObjective Children
		this.rootChildrenObjectiveCollection = new ObjectiveCollection();
		
		this.rootChildrenObjectiveCollection.fetch({
			url: appUrl('/Objective/' + this.rootObjective.get('id') + '/children'),
			success : _.bind(function() {
				
				this.render();
			},this)
		});
		
	}
	
});



var MainCtrView = Backbone.View.extend({
	/**
	 * @memberOf MainCtrView
	 */
	initialize: function(){
	    //this.collection.bind('reset', this.render, this);
	    _.bindAll(this, 'detailModal');
	},
	
	el: "#mainCtr",
	mainCtrTemplate : Handlebars.compile($("#mainCtrTemplate").html()),
	mainTblTpl : Handlebars.compile($("#mainTblTemplate").html()),
	easyuiTreegridTemplate : Handlebars.compile($("#easyuiTreegridTemplate").html()),
	loadingTemplate : Handlebars.compile($("#loadingTemplate").html()),
	
	detailModalVeiw: new DetailModalView(),
	modalView : new ModalView(),
	targetValueModalView : new TargetValueModalView(),
	
	
	events:  {
		"click input[type=checkbox].bullet" : "toggle",
		"click .detail" : "detailModal",
		"click .targetValueModal" : "targetValueModal",
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
	render : function() {
		this.$el.html(this.mainCtrTemplate());
		this.mainSelectionView = new MainSelectionView({el: "#mainCtr #mainSelection"});
		
					
		this.rootObjective = new Objective(); 
		this.rootObjective.fetch({
			url: appUrl('/Objective/ROOT/'+fiscalYear),
			success : _.bind(function() {
				this.mainSelectionView.renderInitialWith(this.rootObjective);
			},this)
		});
	},
	
	emptyTbl: function(e) {
		this.$el.find('#mainTbl').empty();
	},
	renderMainTblWithParent: function(parentObjective){
		this.currentParentObjective = parentObjective;
		this.renderMainTbl();
	},
	renderMainTbl: function() {
		
		this.collection = new ObjectiveCollection();
		this.rootCollection = new ObjectiveCollection();
		
		this.collection.url = appUrl("/ObjectiveWithBudgetProposalAndAllocation/"+ fiscalYear + "/" + this.currentParentObjective.get('id') +"/flatDescendants");
		
		this.$el.find('#mainTbl').html(this.loadingTemplate());
		
		//console.profile("a");
//		$('#treegrid').treegrid({  
//	        url: appUrl("/ObjectiveWithBudgetProposalAndAllocation/"+ fiscalYear + "/" + this.currentParentObjective.get('id') +"/flatDescendants"),
//	        method: 'GET',
//	        idField:'id',  
//	        treeField:'code',
//	        nowrap: false,
//	        columns:[[{
//	            title:'code',field:'code',width:160, 
//	            formatter: function(value,row,index) {
//	            	var type = ObjectiveType.findOrCreate({id: row.type});
//	            	if(type.get('name') == null) {
//	            		type.fetch();
//	            	}
//	            	return type.get('name') + "[" +row.code + "]";
//	            } 
//	        }, {
//	           	title:'name',field:'name',width:250, formatter: function(value,row,index) {return row.name;} 
//	        }]]  
//	    });
		//console.profileEnd("a");
		
		this.collection.fetch({
			success: _.bind(function(){
				this.$el.find('#mainTbl').html(this.easyuiTreegridTemplate());
				
			    $('#treegrid').treegrid({  
			        data:this.collection.toJSON(),
			        method: 'GET',
			        idField:'id',  
			        treeField:'code',
			        nowrap: false,
			        title: 'รายละเอียดงบประมาณ',
			        width: 825,
			        columns:[[{
			            title:'รหัสกิจกรรม',field:'code',width:180,
			            formatter: function(value,row,index) {return row.type.name + "[" +row.code + "]";},
			            styler: function(value,row,index) {return 'vertical-align:top;padding-top: 2px;'; }
			        },{
			        	title:'ชื่อกิจกรรม',field:'name',width:390, formatter: function(value,row,index) {return row.name;}
			        },{
			        	title:'งบประมาณที่ขอตั้ง', field: 'sumBudgetProposal',width: 100,
			        	formatter: function(value,row,index) {
			        		var amount = 0;
			        		for(var i=0; i<row.proposals.length; i++ ){
			        			amount += row.proposals[i].amountRequest;
			        		}
			        		return addCommas(amount);
			        	},
			        	styler: function(value, row, index){return 'text-align:right;vertical-align:top;padding-top: 2px;';}
			        },{
			        	title:'งบประมาณที่เสนอปรับลด', field: 'allocationR1',width: 130,
			        	formatter: function(value,row,index) {
			        		var amount = 0;
			        		
			        		for(var i=0; i<row.allocationRecordsR1.length; i++ ){
			        			amount += row.allocationRecordsR1[i].amountAllocated;
			        		}
			        		return '<a href="#" class="detail" data-id="">' + addCommas(amount) + '</a>';
			        	},
			        	styler: function(value, row, index){return 'text-align:right;vertical-align:top;padding-top: 2px;';}
			        }]],
			        onClickCell: _.bind(function(field, row) {
			        	if(field == 'allocationR1'){
			        		this.detailModalVeiw.renderWithObjective(Objective.findOrCreate({id: row.id}));
			        	}
			        },this)
			    });
				
//
//				var json= this.collection.toJSON();
//				
//				var allProposal = new BudgetProposalCollection(); 
//				_.each(this.rootCollection.pluck('sumBudgetTypeProposals'), function(bpCollection) {
//					if(bpCollection.length > 0) {
//						bpCollection.each(function(bp) {
//							allProposal.add(bp);
//						});
//					}
//				});
//				
//				
//				var allAllocationRecordsR1 = new AllocationRecordCollection(); 
//				_.each(this.rootCollection.pluck('allocationRecordsR1'), function(ar1Collection) {
//					if(ar1Collection.length > 0) {
//						ar1Collection.each(function(ar) {
//							ar1Collection.add(ar);
//						});
//					}
//				});
//				
//				json.allProposal = allProposal.toJSON();
//				json.allAllocationRecordsR1 = allAllocationRecordsR1.toJSON();
//				
//				this.$el.html(this.mainTblTpl(json));
//				
			},this)
		});
		

		
	},
	
	
	
	toggle: function(e) {
		l=e;
		var clickLevel = $(l.target).parents('tr').attr('data-level');
		$(l.target).next('label').toggleClass("expand collapse");
		
		var currentTr = $(l.target).parents('tr');
		
		currentTr.nextUntil('tr[data-level='+clickLevel+']').toggle();
	}
	
});
	