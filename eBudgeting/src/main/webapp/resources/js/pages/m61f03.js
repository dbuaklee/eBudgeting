var BudgetTypeAllSelectionView = Backbone.View.extend({
	/**
     *  @memberOf BudgetTypeAllSelectionView
     */
	initialize: function(options){
		if(options != null) {
			this.level = options.level;
			this.parentModal = options.parentModal;
		} 
	},
	budgetInputSelectionTemplate : Handlebars.compile($("#budgetInputSelectionTemplate").html()),
	
	render: function(){
		// first clear the siblings select
		this.$el.empty();
		if(this.collection != null) {
			e1=this.collection;
			this.$el.html(this.budgetInputSelectionTemplate(this.collection.toJSON()));
		} else {
			this.$el.html(this.budgetInputSelectionTemplate({}));
		}
		
		
	},
	
	setCollection: function(collection) {
		this.collection =  collection;
	}
});

var ModalView = Backbone.View.extend({
	/**
     *  @memberOf ModalView
     */
	initialize : function() {
		
	},

	el : "#modal",

	currentBudgetTypeSelection: [],
	currentFormulaStrategySelection: null,
	
	modalTemplate : Handlebars.compile($('#modalTemplate').html()),
	inputAllDivTemplate : Handlebars.compile($('#inputAllDivTemplate').html()),
	
	inputEditProposalTemplate: Handlebars.compile($('#inputEditProposalTemplate').html()), 
	defaultInputTemplate : Handlebars.compile($('#defaultInputTemplate').html()),
	inputModalTemplate : Handlebars.compile($('#inputModalTemplate').html()),
	
	events : {
		"click .removeProposal" : "removeProposal",
		"click .saveProposal" : "saveProposal",
		"click .editProposal" : "editProposal",
		"click #cancelBtn" : "cancelModal",
		"click .close" : "cancelModal",
		"click .backToProposal" : "backToProposal",
		"click #addBudget" : "renderInputALL",
		"click .copytoNextYear" : "copyToNextYear",

	},
	backToProposal: function(e) {
		this.render();
	},
	cancelModal : function(e) {
		this.$el.modal('hide');
		mainCtrView.renderMainTbl();
	},
	copyToNextYear : function(e) {
		var valueToCopy = $('#totalInputTxt').val();
		valueToCopy = valueToCopy.replace(/,/g, '');
		this.$el.find('#amountRequestNext1Year').val(valueToCopy);
		this.$el.find('#amountRequestNext2Year').val(valueToCopy);
		this.$el.find('#amountRequestNext3Year').val(valueToCopy);
	},
 	saveProposal: function(e) {
		var validated1=true;
		var validated2=true;
		
		this.$el.find('input:enabled').each(function(e) {
			console.log($(this).val());
			
			if( isNaN( +$(this).val() ) ) {
				$(this).parent('div').addClass('control-group error');
				validated1 = false;
				
			} else {
				$(this).parent('div').removeClass('control-group error');
			}
		});
		
		if($('#budgetTypeSlt').length > 0) {
			if($('#budgetTypeSlt').val() == 0) {
				validated2 = false;
				$(this).parent('div').addClass('control-group error');
			} else {
				$(this).parent('div').removeClass('control-group error');
			}
		}
		
		if(validated1 == false || validated2 == false) {
			var msg1 = "";
			var msg2 = "";
			if(!validated1) {
				msg1= " -- ข้อมูลที่ใส่ต้องเป็นตัวเลข\n";
			}
			
			if(!validated2) {
				msg2 = " -- ต้องระบุหมวดงบประมาณ\n";
			}
			
			alert('กรุณาตรวจสอบข้อมูล\n' + msg1 + msg2);
			return;
		}
		
		
		this.$el.find('button.saveProposal').html('<icon class="icon-refresh icon-spin"></icon> กำลังบันทึกข้อมูล...');
		
		var obp = this.currentObjectiveBudgetProposal;
		
		var budgetTypeId = this.$el.find('#budgetTypeSlt').val();
		var budgetType = BudgetType.findOrCreate(budgetTypeId);
		
		if(obp.get('budgetType') == null ){
			obp.set('budgetType', budgetType);
		}
		
					// now get the input
		obp.set('amountRequest', this.$el.find('input#totalInputTxt').val());
		obp.set('amountRequestNext1Year', this.$el.find('input#amountRequestNext1Year').val());
		obp.set('amountRequestNext2Year', this.$el.find('input#amountRequestNext2Year').val());
		obp.set('amountRequestNext3Year', this.$el.find('input#amountRequestNext3Year').val());
		
		// now copy all target if exists!
		if(obp.get('targets') != null) {
			for(var i=0; i<obp.get('targets').length; i++) {
				var target = obp.get('targets').at(i);
				target.set('targetValue', this.$el.find('input#targetValue'+target.get('unit').get('id')).val());
			}
		}
		
		//now ready for save
		obp.save(null, {
			success: _.bind(function() {
				this.render();
			}, this)
		});
		
	},
	editProposal : function(e) {
		var obpId = $(e.target).parents('li').attr('data-id');
		var obp = ObjectiveBudgetProposal.findOrCreate(obpId);

		// we'll begin by render the budgetTypeSelectionView
		this.renderEditProposal(obp);

	},

	removeProposal : function(e) {
		$(e.target).parents('li').css('text-decoration', 'line-through');
		var obpId = $(e.target).parents('li').attr('data-id');
		var obp = ObjectiveBudgetProposal.findOrCreate(obpId);
		
		if (obp != null) {
			// we can start deleting it now.. 

			var r = confirm("คุณต้องการนำรายการนี้ออก?");
			if (r == true) {
				$.ajax({
					type : 'DELETE',
					url : appUrl('/ObjectiveBudgetProposal/' + obpId),
					success : _.bind(function() {
							this.objective.get('filterObjectiveBudgetProposals').remove(obp);
							this.render();
						}, this)
					});

			} else {
				$(e.target).parents('li').css('text-decoration', '');
			}
			return false;

		}
	},
	
	renderEditProposal: function(obp) {
		this.currentObjectiveBudgetProposal = obp;
		
		var json=obp.toJSON();
		json.next1Year = fiscalYear+1;
		json.next2Year = fiscalYear+2;
		json.next3Year = fiscalYear+3;
		
		this.$el.find('.modal-body').html(this.inputAllDivTemplate(json));		
		
	},

	renderInputALL : function() {
		
		var obp = new ObjectiveBudgetProposal();

		obp.set('forObjective', this.objective);
		
		if(this.objective.get('filterTargetValues') != null && this.objective.get('filterTargetValues').length > 0) {
			// we have to create new target Unit for this one
			for(var i=0; i< this.objective.get('filterTargetValues').length; i++) {
				var objTarget = this.objective.get('filterTargetValues').at(i).get('target');
				var target = new ObjectiveBudgetProposalTarget();
				target.set('unit', objTarget.get('unit'));
				target.set('objectiveBudgetProposal', obp);
				if(obp.get('targets') == null) {
					obp.set('targets', new ObjectiveBudgetProposalTargetCollection());
				}
				obp.get('targets').add(target);
			}
		}
		
		this.currentObjectiveBudgetProposal = obp;
		

		var budgetTypeSltCollection = new BudgetTypeCollection(mainBudgetTypeCollection.toJSON());
		// now we go through all filterObjectiveBudgetProposal and remove the budgetType
		var fobp = this.objective.get('filterObjectiveBudgetProposals');
		
		for(var i=0; i< fobp.length; i++) {
			budgetTypeSltCollection.remove(fobp.at(i).get('budgetType'));
		}
		
		console.log("budgetTypeSltCollection.length == " + budgetTypeSltCollection.length);
		
		if(budgetTypeSltCollection.length == 0) {
			alert('ไม่สามารถเพิ่มรายการงบประมาณได้เนื่องจากเลือกลงข้อมูลหมดทุกหมวดแล้ว');
		} else {
			
			var json = obp.toJSON();
			json.next1Year = fiscalYear+1;
			json.next2Year = fiscalYear+2;
			json.next3Year = fiscalYear+3;
			
			
			this.$el.find('.modal-body').html(this.inputAllDivTemplate(json));
			this.budgetTypeSelectionViewL1 =  new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL1', level: 1, parentModal: this});
			this.budgetTypeSelectionViewL1.setCollection(budgetTypeSltCollection);
		    this.budgetTypeSelectionViewL1.render();
		}	    			
	},
	
	render : function() {
		if (this.objective != null) {
			var json = this.objective.toJSON();
			json.readOnly = readOnly;
			var html = this.modalTemplate(json);
			this.$el.find('.modal-header span').html(this.objective.get('name'));
			this.$el.find('.modal-body').html(html);
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

var MainSelectionView = Backbone.View.extend({
	mainSelectionTemplate : Handlebars.compile($("#mainSelectionTemplate").html()),
	selectionTemplate : Handlebars.compile($("#selectionTemplate").html()),
	type102DisabledSelectionTemplate : Handlebars.compile($("#type102DisabledSelection").html()),
	type103DisabledSelectionTemplate : Handlebars.compile($("#type103DisabledSelection").html()),
	
	/**
     *  @memberOf MainSelectionView
     */
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
			obj.url = appUrl("/Objective/loadObjectiveBudgetProposal/" + obj.get('id'));
			obj.fetch({
				success: function(model, xhr, option) {
					mainCtrView.renderMainTblWithParent(obj);
				}
			});
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
     *  @memberOf MainCtrView
     */
	initialize : function() {
		//this.collection.bind('reset', this.render, this);
		_.bindAll(this, 'detailModal');
		
		// puting loading sign
		this.$el.html(this.loadingTpl());
	},

	el : "#mainCtr",
	loadingTpl : Handlebars.compile($("#loadingTemplate").html()),
	mainCtrTemplate : Handlebars.compile($("#mainCtrTemplate").html()),
	mainTblTpl : Handlebars.compile($("#mainTblTemplate").html()),
	nodeRowTpl : Handlebars.compile($("#nodeRowTemplate").html()),
	mainTbl1Tpl : Handlebars.compile($("#mainCtr1Template").html()),
	modalView : new ModalView(),

	 
	events : {
		"click input[type=checkbox].bullet" : "toggle",
		"click .detail" : "detailModal"
	},

	
	detailModal : function(e) {
		var currentObjectiveId = $(e.target).parents('tr').attr('data-id');
		var currentObjective = Objective.findOrCreate(currentObjectiveId);
		
		// find objectiveBudgetProposal of this Object? 
		
		this.modalView.renderWith(currentObjective);
	
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
	renderInputAll: function() {
		
	},
	renderMainTblWithParent: function(parentObjective){
		this.currentParentObjective = parentObjective;
		this.renderMainTbl();
	},
	renderMainTbl :function() {
		if(this.currentParentObjective!=null)	{
			this.$el.find('#mainTbl').html(this.loadingTpl());
			// getRootCollection
			objectiveCollection = new ObjectiveCollection();
			this.collection = new ObjectiveCollection();
			
			objectiveCollection.url = appUrl("/ObjectiveWithObjectiveBudgetProposal/" + fiscalYear+ "/" + this.currentParentObjective.get('id') + "/flatDescendants");
			
			objectiveCollection.fetch({
				success : _.bind( function() {
					// we will now sorted out this mess!
					var i;
					for (i = 0; i < objectiveCollection.length; i++) {
						var o = objectiveCollection.at(i);
						if (o.get('parent') != null) {
							var parentId = o.get('parent').get('id');

							var parentObj = objectiveCollection.get(parentId);
							if (parentObj != null) {
								parentObj.get('children').add(o);
							}
						}
					}
					
					this.collection.add(objectiveCollection.where({parent: this.currentParentObjective}));
					
					var allProposal = new ObjectiveBudgetProposalCollection(); 
					_.each(this.collection.pluck('filterObjectiveBudgetProposals'), function(bpCollection) {
						if(bpCollection.length > 0) {
							bpCollection.each(function(bp) {
								allProposal.add(bp);
							});
						}
					});
					
					var json = this.collection.toJSON();
					json.allProposal = allProposal.toJSON();
					json.objective = this.currentParentObjective.toJSON();
					e1=this.currentParentObjective;
					this.$el.find('#mainTbl').html(this.mainTblTpl(json));
					
					this.$el.find('#mainTbl tbody td:first-child', this).each(function(i){
				        $(this).html((i+1) + ".");
				    });
				
				}, this)
			});
		}
	},
		
	emptyTbl: function(e) {
		this.$el.find('#mainTbl').empty();
	},

	toggle : function(e) {
		var l = e;
		var id = $(l.target).parents('tr').attr('data-id');
		var showChildren = $(l.target).parents('tr').attr('showChildren');
		if(showChildren == "true") {
			$(l.target).parents('tr').attr('showChildren', "false");
		} else {
			$(l.target).parents('tr').attr('showChildren', "true");
		}
		$(l.target).next('label').find('icon.label-caret').toggleClass("icon-caret-right icon-caret-down");

		var currentTr = $(l.target).parents('tr');
		
		currentTr.nextAll('[parentPath*=".' + id + '."]').each(function(el) {
			var $el = $(this);
			
			if(showChildren == "true") {
				// this is hide
					$el.hide();
			} else {
				// this is show
					$el.show();
			}
			
		}); 
	}

});