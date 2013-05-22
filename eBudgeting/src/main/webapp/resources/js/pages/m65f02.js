var DetailModalView = Backbone.View.extend({
	/**
	 * @memberOf DetailModalView
	 */
	initialize: function(options) {
		
	},
	
	el: '#detailModal',
	
	detailModalTemplate : Handlebars.compile($('#detailModalTemplate').html()),
	detailViewTableTemplate: Handlebars.compile($('#detailViewTableTemplate').html()),
	events: {
		"click .amountAllocatedInput" : "amountAllocatedInput",
		"click #cancelBtn" : "cancelBtn"
	},
	setParentView: function(view) {
		this.parentView = view;
	},
	cancelBtn : function(e) {
		this.$el.modal('hide');
		this.parentView.reloadTable();
		
	},
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
		// now render table
		
		//prepare the allocation
		_.forEach(json.sumBudgetTypeProposals, _.bind(function(proposal) {
			var budgetType = BudgetType.findOrCreate({id:proposal.budgetType.id});
			// search the allocationR1 
			var allocationRecord = this.currentObjective.get('allocationRecordsR1').findWhere({budgetType:budgetType});
			if(allocationRecord  != null) {
				proposal.amountAllocatedR1 = allocationRecord.get('amountAllocated');
			}
			allocationRecord = this.currentObjective.get('allocationRecordsR2').findWhere({budgetType:budgetType});
			if(allocationRecord  != null) {
				proposal.amountAllocatedR2 = allocationRecord.get('amountAllocated');
			}
			allocationRecord = this.currentObjective.get('allocationRecordsR3').findWhere({budgetType:budgetType});
			if(allocationRecord  != null) {
				proposal.amountAllocatedR3 = allocationRecord.get('amountAllocated');
				proposal.allocationId = allocationRecord.get('id');
			}
			
		},this));
		
		html = this.detailViewTableTemplate(json);
		this.$el.find('#detailModalDiv').html(html);
		
		return this;
	},
	amountAllocatedInput : function(e) {
		var allocationRecord = AllocationRecord.findOrCreate($(e.target).attr('data-allocationId'));
		this.currentEditedAllocationRecord = allocationRecord;
		Ext.MessageBox.prompt('ระบุค่างบประมาณที่ปรับลดครั้งที่ 3', allocationRecord.get('budgetType').get('name'),
				this.showResultText, this, false, allocationRecord.get('amountAllocated'));
	},
	showResultText: function(btn, text){
		if(this.currentEditedAllocationRecord != null) {
			this.currentEditedAllocationRecord.set('amountAllocated', parseInt(text));
			this.currentEditedAllocationRecord.save(null, {
				success: _.bind(function() {
					alert('บันทึกข้อมูลเรียบร้อยแล้ว');
					this.render();
				},this)
			});
		}
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
	
	detailModalView: new DetailModalView(),
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
		
		var currentObjectiveId = $(e.target).attr('data-objectiveId');
		
		//var budgetProposalCollection = new BudgetProposalCollection();
		this.currentObjective = Objective.findOrCreate( this.treeStore.getById(currentObjectiveId).raw);
		this.detailModalView.setParentView(this);
		this.detailModalView.renderWithObjective(this.currentObjective);
		
		return false;
		
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
	reloadTable: function() {
		this.treeStore.reload();
	},
	renderMainTbl: function() {
		
		//this.collection = new ObjectiveCollection();
		//this.rootCollection = new ObjectiveCollection();
		
		//this.collection.url = appUrl("/ObjectiveWithBudgetProposalAndAllocation/"+ fiscalYear + "/" + this.currentParentObjective.get('id') +"/flatDescendants");
		
		//this.$el.find('#mainTbl').html(this.loadingTemplate());
		this.$el.find('#mainTbl').empty();
		
		this.treeStore = Ext.create('Ext.data.TreeStore', {
	        model: 'data.Model.Objective',
	        proxy: {
	            type: 'ajax',
	            //the store will get the content from the .json file
	            url: appUrl("/ObjectiveWithBudgetProposalAndAllocation/"+ fiscalYear + "/" + this.currentParentObjective.get('id') +"/flatDescendants")
	        },
	        folderSort: false
	    });
		
		if(this.tree !=null) {
			this.tree.destroy();
		}
		
		this.tree = Ext.create('Ext.tree.Panel', {
			id: 'treeGrid',
	        title: 'การของบประมาณ',
	        width: 820,
	        height: 300,
	        renderTo: Ext.getElementById('mainTbl'),
	        collapsible: false,
	        rootVisible: false,
	        store: this.treeStore,
	        columnLines: true, 
	        rowLines: true,
	        multiSelect: true,
	        frame: true,
	        columns: [{
	             //this is so we know which column will show the tree
	        	xtype: 'treecolumn',
	            text: 'กิจกรรม',
	            sortable: true,
	            dataIndex: 'codeAndName',
	        	width: 300,
	            locked: true,
	            renderer: function(value, metaData, record, rowIdx, colIdx, store) {
	                metaData.tdAttr = 'data-qtip="' + value + '"';
	                if(record.data.children == null || record.data.children.length == 0) {
	                	return "<a href='#' data-objectiveId=" + record.data.id +  " class='detail'>"+ value + "</a>";	
	                }
	                return value;
	            }
	        }, {
	        	text: 'เป้าหมาย',
	        	width: 80,
	        	sortable: false,
	        	align: 'center'
	        }, {
	        	text: 'ขอตั้งปี ' + fiscalYear,
	        	width: 120,
	        	sortable : false,
	        	dataIndex: 'sumProposals',
	        	align: 'right',
	        	renderer: function(value) {
	        		return addCommas(value);
	        	}
	        	
	        }, {
	        	text: 'ขอตั้งปี ' + (parseInt(fiscalYear)+1),
	        	width: 120,
	        	sortable : false,
	        	dataIndex: 'sumProposalsNext1year',
	        	align: 'right',
	        	renderer: function(value) {
	        		return addCommas(value);
	        	}
	        	
	        }, {
	        	text: 'ขอตั้งปี ' + (parseInt(fiscalYear)+2),
	        	width: 120,
	        	sortable : false,
	        	dataIndex: 'sumProposalsNext2year',
	        	align: 'right',
	        	renderer: function(value) {
	        		return addCommas(value);
	        	}
	        	
	        }, {
	        	text: 'ขอตั้งปี ' + (parseInt(fiscalYear)+3),
	        	width: 120,
	        	sortable : false,
	        	dataIndex: 'sumProposalsNext3year',
	        	align: 'right',
	        	renderer: function(value) {
	        		return addCommas(value);
	        	}
	        	
	        }, {
	        	text: 'ปรับลดครั้งที่ 1',
	        	width: 120,
	        	sortable : false,
	        	dataIndex: 'sumAllocationR1',
	        	align: 'right',
	        	renderer: function(value) {
	        		return addCommas(value);
	        	}
	        		
	        }, {
	        	text: 'ปรับลดครั้งที่ 2',
	        	width: 120,
	        	sortable : false,
	        	dataIndex: 'sumAllocationR2',
	        	align: 'right',
	        	renderer: function(value) {
	        		return addCommas(value);
	        	}
	        		
	        }, {
	        	text: 'ปรับลดครั้งที่ 3',
	        	width: 120,
	        	sortable : false,
	        	dataIndex: 'sumAllocationR3',
	        	align: 'right',
	        	renderer: function(value) {
	        		return addCommas(value);
	        	}
	        		
	        }]
		});	
	}
});
	