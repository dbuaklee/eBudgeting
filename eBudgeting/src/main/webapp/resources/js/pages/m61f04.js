	var StrategySelectionView = Backbone.View.extend({
		/**
	     *  @memberOf StrategySelectionView
	     */
		initialize : function(options) {
			_.bindAll(this, 'render');
			_.bindAll(this, 'renderWithStrategy');
			_.bindAll(this, 'strategySelect');
			
			if(options != null) {
				this.parentModal = options.parentModal;
			} 
			this.displayNull=false;
			
		},
		
		events : {
			"change #strategySlt" : "strategySelect",
			"click .saveProposal" : "saveProposal",
			"click .copytoNextYear" : "copyToNextYear",
			"change .formulaColumnInput" : "inputChange",
			"click .updateProposal" : "updateProposal",
			"click .backToProposal" : "backToProposal"
			
		},
		
		inputModalTemplate : Handlebars.compile($('#inputModalTemplate').html()),
		strategySelectionTemplate : Handlebars.compile($('#strategySelectionTemplate').html()),
		currentStrategyCollection : null,
	
		render : function() {
			var selectionDiv = this.$el.find('#strategySelectionDiv > div:first-child');
			if (this.currentStrategyCollection != null && this.currentStrategyCollection.length > 0) {
				var json = this.currentStrategyCollection.toJSON();
				selectionDiv.html(this.strategySelectionTemplate(json));
			} else {
				if(this.displayNull) {
					selectionDiv.html("ไม่มีรายการย่อย");
				} else {
					selectionDiv.html(this.strategySelectionTemplate({}));
				}
			}
	
		},
		
		backToProposal: function(e) {
			this.parentModal.render();
		},
	
		setRootModel: function(collection, displayNull) {
			this.currentStrategyCollection=collection;
			if(displayNull == true) {
				this.displayNull = true;
			} else {
				this.displayNull = false;
			}
		},
		
		renderWithStrategy : function(strategyCollection, parentModal, budgetType) {
			this.parentModal = parentModal;
			this.currentStrategyCollection = strategyCollection;
			this.currentBudgetType = budgetType;
			this.displayNull = true;
			this.currentStrategy = null;
			this.render();
		},
	
		renderWithWithDisableSelect : function(formulaStrategies,proposalStrategy, parentModal) {
			this.parentModal = parentModal;
			this.currentStrategyCollection = formulaStrategies;
			this.currentEditProposalStrategy = proposalStrategy;
	
			if (this.currentStrategyCollection != null) {
				var json = this.currentStrategyCollection.toJSON();
	
				for ( var i = 0; i < json.length; i++) {
					if (json[i].id == proposalStrategy.get('formulaStrategy').get('id')) {
						json[i].selected = true;
					}
				}
	
				json.editStrategy = true;
	
				this.$el.html(this.strategySelectionTemplate(json));
	
				// now the Form!
				this.currentStrategy = proposalStrategy.get('formulaStrategy');
	
				var columns = this.currentStrategy.get('formulaColumns');
				//now set the last column
				columns.at(columns.length - 1).set("$last", true);
	
				// here we'll get the propose column
	
				var json = this.currentStrategy.toJSON();
				json.propsalStrategyName = proposalStrategy.get('name');
				json.proposalStrategyId = proposalStrategy.get('id');
				json.editStrategy = true;
	
				json.next1Year = this.currentStrategy.get('fiscalYear') + 1;
				json.next1YearValue = proposalStrategy.get('amountRequestNext1Year');
	
				json.next2Year = this.currentStrategy.get('fiscalYear') + 2;
				json.next2YearValue = proposalStrategy.get('amountRequestNext2Year');
	
				json.next3Year = this.currentStrategy.get('fiscalYear') + 3;
				json.next3YearValue = proposalStrategy.get('amountRequestNext3Year');
	
				var totalMulti = 1;
	
				for ( var i = 0; i < json.formulaColumns.length; i++) {
					if (json.formulaColumns[i].isFixed) {
						var colId = json.formulaColumns[i].id;
						// now find this colId in requestColumns
						var rc = proposalStrategy.get('requestColumns');
						var foundRC = rc.where({
							column : FormulaColumn.findOrCreate(colId)
						});
						json.formulaColumns[i].value = foundRC[0].get('amount');
	
						totalMulti = totalMulti * parseInt(foundRC[0].get('amount'));
					} else {
						totalMulti = totalMulti * parseInt(json.formulaColumns[i].value);
					}
	
				}
				json.total = totalMulti;
				// now will go through
	
				var html = this.inputModalTemplate(json);
				// render strategy!
				this.$el.find('#input-form').html(html);
	
			}
	
		},
		
		setCurrentBudgetTypeAndStrategy: function(budgetType, strategy) {
			this.currentBudgetType = budgetType;
			this.currentStrategy = strategy;
		},
		
		validateInput: function(e) {
			if( isNaN( +$(e.target).val() ) ) {
				$(e.target).parent('div').addClass('control-group error');
				alert('กรุณาใส่ข้อมูลเป็นตัวเลขเท่านั้น');
				return false;
			} else {
				$(e.target).parent('div').removeClass('control-group error');
			}
		},
		
	
		inputChange : function(e) {
			// validate the box
			if( isNaN( +$(e.target).val() ) ) {
				$(e.target).parent('div').addClass('control-group error');
				alert('กรุณาใส่ข้อมูลเป็นตัวเลขเท่านั้น');
				return false;
			} else {
				$(e.target).parent('div').removeClass('control-group');
				$(e.target).parent('div').removeClass('error');
				
			}
			
			// OK we'll go through all td value
			var standardPrice = this.currentStrategy.get('standardPrice');
			
			if(isNaN(standardPrice) || standardPrice == null) {
				standardPrice = 1;
			}
			var amount = standardPrice;
			
			var allInput = this.$el.find('.formulaColumnInput');
			for(var i=0; i<allInput.length; i++ ) {
				amount = amount * allInput[i].value;
			}
			
			// now put amount back amount
			this.$el.find('#totalInputTxt').val(addCommas(amount));
		},
	
		copyToNextYear : function(e) {
			var valueToCopy = $('#totalInputTxt').val();
			valueToCopy = valueToCopy.replace(/,/g, '');
			this.$el.find('#amountRequestNext1Year').val(valueToCopy);
			this.$el.find('#amountRequestNext2Year').val(valueToCopy);
			this.$el.find('#amountRequestNext3Year').val(valueToCopy);
		},
	
		renderInputStrategy: function(strategy) {
			this.currentStrategy=strategy;
			var columns = strategy.get('formulaColumns');
			//now set the last column
			columns.at(columns.length - 1).set("$last", true);
	
			// here we'll get the propose column
	
			var json = strategy.toJSON();
			
			if(json.unit != null) {
				json.budgetTypeUnitName = json.unit.name; 
				json.targetUnitId = json.unit.id;
			} else if(json.type.unit != null) {
				json.budgetTypeUnitName = json.type.unit.name;
				json.targetUnitId = json.type.unit.id;
			}
			
			json.next1Year = strategy.get('fiscalYear') + 1;
			json.next2Year = strategy.get('fiscalYear') + 2;
			json.next3Year = strategy.get('fiscalYear') + 3;
			var html = this.inputModalTemplate(json);
			// render strategy!
			this.$el.find('#input-form').html(html);
			
			// now update with the parent 
			this.parentModal.currentFormulaStrategySelection = strategy; 
	
		},
		
		strategySelect : function(e) {
	
			var strategyId = e.target.value;
	
			var strategy = this.currentStrategyCollection.get(strategyId);
			this.currentStrategy = strategy;
			this.renderInputStrategy(strategy);
			
		},
	
		updateProposal : function(e) {
			var validated=true;
			this.$el.find('input:enabled').each(function(e) {
				
				if( isNaN( +$(this).val() ) ) {
					$(this).parent('div').addClass('control-group error');
					validated = false;
					
				} else {
					$(this).parent('div').removeClass('control-group error');
				}
			});
			
			if(validated == false) {
				alert('กรุณาใส่ข้อมูลที่เป็นตัวเลขเท่านั้น');
				return false;
			}
			
			
			
			//now get the proposalId
			var proposalStrategyId = this.$el.find('#proposalStrategyId').attr('data-id');
			var proposalStrategy = ProposalStrategy.findOrCreate(proposalStrategyId);
			
			if (proposalStrategy != null) {
				
				// we just pick up changes
				// loop through formulaColumns
				if(this.currentStrategy!=null) {
					var i;
					calculatedAmount = this.currentStrategy.get('standardPrice');
					var formulaColumns = this.currentStrategy.get('formulaColumns');
					for (i = 0; i < formulaColumns.length; i++) {
		
						var fc = formulaColumns.at(i);
						if (fc.get('isFixed')) {
							var colId = fc.get('id');
							// now find this colId in requestColumns
							var rc = proposalStrategy.get('requestColumns');
							var foundRC = rc.where({
								column : FormulaColumn.findOrCreate(colId)
							})[0];
		
							foundRC.set('amount', this.$el.find('#formulaColumnId-' + fc.get('id')).val());
		
							if (calculatedAmount == 0) {
								calculatedAmount = foundRC.get('amount');
							} else {
								calculatedAmount = calculatedAmount * foundRC.get('amount');
							}
		
						} else {
							if (calculatedAmount == 0) {
								calculatedAmount = fc.get('value');
							} else {
								calculatedAmount = calculatedAmount	* fc.get('value');
							}
						}
					}
					
					proposalStrategy.set('totalCalculatedAmount', calculatedAmount);
				} else {
					proposalStrategy.set('totalCalculatedAmount', this.$el.find('#totalInputTxt').val());	
				}
				
				
				proposalStrategy.set('targetValue', this.$el.find("#targetValue").val());
				proposalStrategy.set('amountRequestNext1Year', this.$el.find('#amountRequestNext1Year').val());
				proposalStrategy.set('amountRequestNext2Year', this.$el.find('#amountRequestNext2Year').val());
				proposalStrategy.set('amountRequestNext3Year', this.$el.find('#amountRequestNext3Year').val());
	
				// now we can send changes to the server?
				var json = proposalStrategy.toJSON();
	
				
				this.$el.find('button.updateProposal').html('<icon class="icon-refresh icon-spin"></icon> กำลังบันทึกข้อมูล...');
				$.ajax({
					type : 'PUT',
					url : appUrl('/ProposalStrategy/' + proposalStrategy.get('id')),
					data : JSON.stringify(json),
					contentType : 'application/json;charset=utf-8',
					dataType : "json",
					success : _.bind(function(data) {
						// OK we should update our budgetProposal too
						var proposal = proposalStrategy.get('proposal');
						proposal.set('amountRequest', proposalStrategy.get('totalCalculatedAmount'));
						proposal.set('amountRequestNext1Year', proposalStrategy.get('amountRequestNext1Year'));
						proposal.set('amountRequestNext2Year', proposalStrategy.get('amountRequestNext2Year'));
						proposal.set('amountRequestNext3Year', proposalStrategy.get('amountRequestNext3Year'));
						
						
						this.parentModal.render();
					}, this)
				});
			}
	
		},
	
		saveProposal : function(e) {
			var validated=true;
			this.$el.find('input:enabled').each(function(index) {
				
				if( isNaN( +$(this).val() ) ) {
					$(this).parent('div').addClass('control-group error');
					validated = false;
					
				} else {
					$(this).parent('div').removeClass('control-group error');
				}
			});
			
			if(validated == false) {
				alert('กรุณาใส่ข้อมูลที่เป็นตัวเลขเท่านั้น');
				return false;
			}
			
			var objective = this.parentModal.objective;
			var budgetType = this.currentBudgetType;
	
			var budgetProposal = this.currentBudgetProposal;
	
			if (budgetProposal == null) {
				// create new BudgetProposal
				budgetProposal = new BudgetProposal();
				budgetProposal.set('forObjective', objective);
				budgetProposal.set('budgetType', budgetType);
				// now put this proposal into objective;
				objective.get('filterProposals').push(budgetProposal);
			}
	
			
			
			// we will make a new ProposalStrategy
			var proposalStrategy = new ProposalStrategy();
			budgetProposal.get('proposalStrategies').add(proposalStrategy);
			
			proposalStrategy.set('formulaStrategy', this.currentStrategy);
			var calculatedAmount = 0;
			
			if(this.currentStrategy == null) {
				calculatedAmount = this.$el.find('#totalInputTxt').val();
				proposalStrategy.set('name', this.currentBudgetType.get('name'));
			} else{
				// loop through formulaColumns
				proposalStrategy.set('name', this.currentStrategy.get('name'));
				var i;
				calculatedAmount = this.currentStrategy.get('standardPrice');
				var formulaColumns = this.currentStrategy.get('formulaColumns');
				for (i = 0; i < formulaColumns.length; i++) {
					var fc = formulaColumns.at(i);
					if (fc.get('isFixed')) {
						var requestColumn = new RequestColumn();
						requestColumn.set('amount', this.$el.find('#formulaColumnId-' + fc.get('id')).val());
						requestColumn.set('column', fc);
						requestColumn.set('proposalStrategy', proposalStrategy);
	
						proposalStrategy.get('requestColumns').add(requestColumn);
	
						if (calculatedAmount == 0) {
							calculatedAmount = requestColumn.get('amount');
						} else {
							calculatedAmount = calculatedAmount * requestColumn.get('amount');
						}
	
					} else {
						if (calculatedAmount == 0) {
							calculatedAmount = fc.get('value');
						} else {
							calculatedAmount = calculatedAmount * fc.get('value');
						}
					}
				}
			}
			proposalStrategy.set('totalCalculatedAmount', calculatedAmount);
			
			proposalStrategy.set('proposal', budgetProposal);
			proposalStrategy.set('amountRequestNext1Year', this.$el.find('#amountRequestNext1Year').val());
			proposalStrategy.set('amountRequestNext2Year', this.$el.find('#amountRequestNext2Year').val());
			proposalStrategy.set('amountRequestNext3Year', this.$el.find('#amountRequestNext3Year').val());
			
			var unitId = this.$el.find('#targetValue').attr('data-unitId');
			if(unitId !=null) {
				var unit = TargetUnit.findOrCreate(unitId);
				proposalStrategy.set('targetUnit', unit);
				proposalStrategy.set('targetValue', this.$el.find('#targetValue').val());
			}
			
			
			budgetProposal.set('amountRequest', calculatedAmount);
			budgetProposal.set('amountRequestNext1Year', this.$el.find('#amountRequestNext1Year').val());
			budgetProposal.set('amountRequestNext2Year', this.$el.find('#amountRequestNext2Year').val());
			budgetProposal.set('amountRequestNext3Year', this.$el.find('#amountRequestNext3Year').val());
	
			// either do create or update!?
			if (budgetProposal.get('id') == null) {
				this.$el.find('button.saveProposal').html('<icon class="icon-refresh icon-spin"></icon> กำลังบันทึกข้อมูล...');
				saveModel(budgetProposal,
					_.bind(function(resp,status,xhr) {
						budgetProposal.set('id', resp.id);
						// now set id for each proposal / request column
						if(resp.proposalStrategies != null) {
							proposalStrategy.set('id', resp.proposalStrategies[0].id);
						}
						
						this.parentModal.objective.get('filterProposals').add(budgetProposal);
						this.parentModal.render();		
					},this));

				
			} 	
		}
	});

	var BudgetTypeAllSelectionView = Backbone.View.extend({
		/**
		 * 
		 * @memberOf BudgetTypeAllSelectionView
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
			if(this.model != null) {
				this.$el.html(this.budgetInputSelectionTemplate(this.model.toJSON()));
			} else {
				this.$el.html(this.budgetInputSelectionTemplate({}));
			}
			
			
		},
		
		events: {
			"change select" : "selectionChange" 
		},
		
		setRootModel: function(rootModel) {
			this.model =  rootModel;
			
		},
		
		selectionChange: function(e) {
			var selectedBudgetTypeId = $(e.target).val()[0];
			// now try to get this model
			var budgetType = BudgetType.findOrCreate(selectedBudgetTypeId);
			budgetType.fetch({success: _.bind(function(model, response){
				var fetchedBudgetType = response;
				if(fetchedBudgetType.children != null && fetchedBudgetType.children.length > 0) {
					//we feed this to the next level?
					this.parentModal.updateBudgetTypeSelectionLevelWithModel(this.level+1, budgetType);
					
				} else {
					
					// then we should now filling in the proposed budget
					
					// ok now we'll get the strategy here
					var formulaStrategies = new FormulaStrategyCollection();

					formulaStrategies.fetch({
						url : appUrl('/FormulaStrategy/search/' + fiscalYear + "/" + budgetType.get('id')),
						success : _.bind(function(data) {
							// we'll have to loop through formulaStrategies
							if(formulaStrategies.length > 0) {
								
								for(var i=0; i<formulaStrategies.length; i++) {
									
									var fs = formulaStrategies.at(i);
									if(fs.get('isStandardItem') == true) {
										budgetType.set('standardStrategy', fs);
										formulaStrategies.remove(fs);
									}
								}
							}
							
							budgetType.set('strategies', formulaStrategies);
							
							this.parentModal.updateStrategySelection(budgetType, formulaStrategies);
						}, this)
					});
					
				}
			}, this)});
			
			// ok we'll have to set back to this!?
			
		},

		renderWithDisableSelect : function(budgetProposal, proposalStrategy) {
			
			this.strategySelectionView = new StrategySelectionView({parentModal: this.parentModal});
	
			var budgetType = budgetProposal.get('budgetType');
			
			// ok now we'll get the strategy here
			var formulaStrategies = new FormulaStrategyCollection;
	
			formulaStrategies.fetch({
				url : appUrl('/FormulaStrategy/search/' + fiscalYear + "/" + budgetType.get('id')),
				success : _.bind(function(data) {
					budgetType.set('strategies', formulaStrategies);
					this.strategySelectionView.setElement(this.el);
	
					this.strategySelectionView.renderWithWithDisableSelect(	formulaStrategies, proposalStrategy, this.parentModal);
	
				}, this)
			});
		}
		
	});

	var ModalView = Backbone.View.extend({
		/**
		 * @memberOf ModalView
		 * 
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
		inputObjectiveDetailDivTemplate : Handlebars.compile($('#inputObjectiveDetailDivTemplate').html()),
		
		updateBudgetTypeSelectionLevelWithModel: function(level, model) {
			//set the previos level to this model
			this.currentBudgetTypeSelection[level-2]=model;
			// and remove all the rest forward
			for(var i=level-1; i<this.budgetTypeSelectionArray.length; i++) {
				this.currentBudgetTypeSelection[i] = null;
			}
			
			level = level-1;
			var btView = this.budgetTypeSelectionArray[level];
			btView.setRootModel(model);
			
			// reset input area
			$('#input-form').empty();
			
			// render the next selection
			btView.render();
			
			// and for the rest set to null
			for(var i=level+1; i<this.budgetTypeSelectionArray.length; i++) {
				this.budgetTypeSelectionArray[i].setRootModel(null);
				this.budgetTypeSelectionArray[i].render();
			}
			
		},
		
		updateStrategySelection: function(budgetType, formulaStrategies) {
			this.currentBudgetTypeSelection[3] = budgetType;
			this.budgetTypeSelectionArray[4].renderWithStrategy(formulaStrategies, this, budgetType);
			
			
			if(budgetType.get('standardStrategy') != null) {
				this.budgetTypeSelectionArray[4].renderInputStrategy(budgetType.get('standardStrategy'));
			} else {
				var json = {budgetTypeName: budgetType.get('name')};
				
				if(budgetType.get('unit') != null) {
					json.budgetTypeUnitName = budgetType.get('unit').get('name');
					json.targetUnitId = budgetType.get('unit').get('id');
					
				}
				
				json.next1Year = fiscalYear+1;
				json.next2Year = fiscalYear+2;
				json.next3Year = fiscalYear+3;
				
				$('#input-form').html(this.defaultInputTemplate(json));
			}
		},
		
		events : {
			"click .removeProposal" : "removeProposal",
			"click .editProposal" : "editProposal",
			"click #cancelBtn" : "cancelModal",
			"click .close" : "cancelModal",
			"click .backToProposal" : "backToProposal",
			"click #addBudget" : "renderInputALL",
			"click #addObjectiveDetail" : "renderObjectiveDetailInput",
			"change .objectiveDetail" : "updateObjectiveDetailModel",
			"click #saveObjectiveDetail" : "saveObjectiveDetail",
			"click #printObjectiveDetail" : "printObjectiveDetail"
				
				

		},
		backToProposal: function(e) {
			this.render();
		},
		cancelModal : function(e) {
			this.$el.modal('hide');
			mainCtrView.renderMainTbl();
		},
		editProposal : function(e) {
			var proposalStrategyId = $(e.target).parents('li').attr('data-id');
			var budgetProposalId = $(e.target).parents('li').attr('proposal-id');

			// now get this one
			var budgetProposal = this.objective.get('filterProposals').get(budgetProposalId);
			var proposalStrategy = budgetProposal.get('proposalStrategies').get(proposalStrategyId);

			// we'll begin by render the budgetTypeSelectionView
			this.renderEditProposal(budgetProposal, proposalStrategy);

		},

		removeProposal : function(e) {
			var proposalStrategyId = $(e.target).parents('li').attr('data-id');
			var budgetProposalId = $(e.target).parents('li').attr('proposal-id');

			// now get this one
			var budgetProposal = this.objective.get('filterProposals').get(budgetProposalId);
			var proposalStrategy = budgetProposal.get('proposalStrategies').get(proposalStrategyId);

			if (proposalStrategy != null) {
				// we can start deleting it now.. 

				var r = confirm("คุณต้องการนำรายการนี้ออก?");
				if (r == true) {
					$.ajax({
						type : 'DELETE',
						url : appUrl('/ProposalStrategy/' + proposalStrategyId),
						success : _.bind(function() {
								budgetProposal.get('proposalStrategies').remove(proposalStrategy);
								var newAmount = budgetProposal.get('amountRequest') - proposalStrategy.get('totalCalculatedAmount');
								budgetProposal.set('amountRequest', newAmount);

								// now we'll have to trigger change all the way up ward

								this.objective.trigger('change',this.objective);
								this.render();
							}, this)
						});

				}
				return false;

			}
		},
		
		renderEditProposal: function(budgetProposal, proposalStrategy) {
			this.$el.find('.modal-body').html(this.inputEditProposalTemplate());
			
			this.startegySelectionView = new StrategySelectionView({el: '#inputAll', parentModal: this});
			this.startegySelectionView.setCurrentBudgetTypeAndStrategy(budgetProposal.get('budgetType'), proposalStrategy.get('formulaStrategy'));
			
			var json;
			if(proposalStrategy.get('formulaStrategy') == null) {
				var budgetType = budgetProposal.get('budgetType');
				json = proposalStrategy.toJSON();
				json.budgetTypeName = budgetType.get('name');
				
				if(proposalStrategy.get('targetUnit') != null) {
					
					if(proposalStrategy.get('targetUnit') instanceof Backbone.Model) {
						json.budgetTypeUnitName = proposalStrategy.get('targetUnit').get('name');
						json.targetUnitId = proposalStrategy.get('targetUnit').get('id');	
					} else {
						var t = TargetUnit.findOrCreate(proposalStrategy.get('targetUnit'));
						if(t!=null) {
							json.budgetTypeUnitName = t.get('name');
							json.targetUnitId = t.get('id');
						}
					}
					
					
				}
				
				json.next1Year = fiscalYear + 1;
				json.next1YearValue = proposalStrategy.get('amountRequestNext1Year');
	
				json.next2Year = fiscalYear + 2;
				json.next2YearValue = proposalStrategy.get('amountRequestNext2Year');
	
				json.next3Year = fiscalYear + 3;
				json.next3YearValue = proposalStrategy.get('amountRequestNext3Year');
				json.proposalStrategyId = proposalStrategy.get('id');
				
				this.$el.find('#input-form').html(this.defaultInputTemplate(json));
			} else {
				json = proposalStrategy.get('formulaStrategy').toJSON();
				json.targetValue = proposalStrategy.get('targetValue');
				if(proposalStrategy.get('targetUnit') instanceof Backbone.Model) {
					json.budgetTypeUnitName = proposalStrategy.get('targetUnit').get('name');
					json.targetUnitId = proposalStrategy.get('targetUnit').get('id');	
				} else {
					var t = TargetUnit.findOrCreate(proposalStrategy.get('targetUnit'));
					if(t!=null) {
						json.budgetTypeUnitName = t.get('name');
						json.targetUnitId = t.get('id');
					}
				}
				
				json.total = proposalStrategy.get('totalCalculatedAmount');
				
				json.proposalStrategyId = proposalStrategy.get('id');
				json.next1Year = fiscalYear + 1;
				json.next1YearValue = proposalStrategy.get('amountRequestNext1Year');
	
				json.next2Year = fiscalYear + 2;
				json.next2YearValue = proposalStrategy.get('amountRequestNext2Year');
	
				json.next3Year = fiscalYear + 3;
				json.next3YearValue = proposalStrategy.get('amountRequestNext3Year');
				
				// now fill in value from request columns
				for(var i=0; i< json.formulaColumns.length; i++) {
					var fcId = json.formulaColumns[i].id;
					for(var j=0; j<proposalStrategy.get('requestColumns').length; j++) {
						if(proposalStrategy.get('requestColumns').at(j).get('column').get('id') == fcId) {
							json.formulaColumns[i].value = proposalStrategy.get('requestColumns').at(j).get('amount');
						}
					}
					
				}
				
				this.$el.find('#input-form').html(this.inputModalTemplate(json));
			}
			
			
		},
		
		renderObjectiveDetailInput : function(e) {
			// we'll have to fetch the detail and put it back on the model
			this.detail = new ObjectiveDetail();
			this.detail.fetch({
				url: appUrl('/ObjectiveDetail/byObjective/'+ this.objective.get('id') +'/ofCurrentUser'),
				success: _.bind(function(model, xhr, options) {
					this.detail.set('forObjective', this.objective.get('id'));
					
					var json = this.detail.toJSON();
					this.$el.find('.modal-body').html(this.inputObjectiveDetailDivTemplate(json));
				},this)
			});
			
			
		},
		
		printObjectiveDetail : function(e) {
			this.detail = new ObjectiveDetail();
			this.detail.fetch({
				url: appUrl('/ObjectiveDetail/byObjective/'+ this.objective.get('id') +'/ofCurrentUser'),
				success: _.bind(function(model, xhr, options) {
					if(this.detail.get('id') == null) {
						alert("คุณยังไม่ได้บันทึกรายละเอียดโครงการ");
					} else {
						window.open(appUrl("/m61f04.docx/"+fiscalYear+"/ObejctiveDetail/"+this.detail.get('id')+"/m61f04.docx"));
					}
				},this) 
			});
			
		},
		
		updateObjectiveDetailModel : function(e) {
			// ok we can update this.detail
			this.detail.set(e.target.id, $(e.target).val());
		},
		
		saveObjectiveDetail: function(e) {
			if(this.detail != null) {
				this.detail.save({}, {
					success: _.bind(function(model, xhr, options) {
						this.detail.set("forObjective", this.objective);
						alert("บันทึกข้อมูลรายละเอียดโครงการแล้ว");
					},this)
				});
			}
		},

		renderInputALL : function(e) {
			this.$el.find('.modal-body').html(this.inputAllDivTemplate());
			
			var rootBudgetType = BudgetType.findOrCreate({id:0});
		    rootBudgetType.fetch({success: _.bind(function(){
		    	this.budgetTypeSelectionViewL1 =  new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL1 > div', level: 1, parentModal: this});
				this.budgetTypeSelectionViewL2 = new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL2 > div', level: 2, parentModal: this});
				this.budgetTypeSelectionViewL3 = new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL3 > div', level: 3, parentModal: this});
				this.budgetTypeSelectionViewL4 = new BudgetTypeAllSelectionView({el: '#budgetTypeSelectionDivL4 > div', level: 4, parentModal: this});
				this.startegySelectionView = new StrategySelectionView({el: '#inputAll', parentModal: this});

				this.budgetTypeSelectionArray = [];
				this.budgetTypeSelectionArray.push(this.budgetTypeSelectionViewL1);
				this.budgetTypeSelectionArray.push(this.budgetTypeSelectionViewL2);
				this.budgetTypeSelectionArray.push(this.budgetTypeSelectionViewL3);
				this.budgetTypeSelectionArray.push(this.budgetTypeSelectionViewL4);
				this.budgetTypeSelectionArray.push(this.startegySelectionView);

				
				
		    	this.budgetTypeSelectionViewL1.$el = $('#budgetTypeSelectionDivL1 > div');
		    	this.budgetTypeSelectionViewL1.setRootModel(rootBudgetType);
		    	this.budgetTypeSelectionViewL1.render();
		    	
		    	
		    	this.budgetTypeSelectionViewL2.$el = $('#budgetTypeSelectionDivL2 > div');
		    	this.budgetTypeSelectionViewL2.setRootModel(null);
		    	this.budgetTypeSelectionViewL2.render();
		    	
		    	this.budgetTypeSelectionViewL3.$el = $('#budgetTypeSelectionDivL3 > div');
		    	this.budgetTypeSelectionViewL3.setRootModel(null);
		    	this.budgetTypeSelectionViewL3.render();
		    	
		    	this.budgetTypeSelectionViewL4.$el = $('#budgetTypeSelectionDivL4 > div');
		    	this.budgetTypeSelectionViewL4.setRootModel(null);
		    	this.budgetTypeSelectionViewL4.render();
		    	
		    	this.startegySelectionView.$el = $('#inputAll');
		    	this.startegySelectionView.renderWithStrategy(null, this, null);
		    	this.startegySelectionView.render();
	    	},this)});
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
			"click .detail" : "detailModal",
			"click .targetValueModal" : "detailTargetValue"
		},
		
		detailTargetValue: function(e) {
			var currentObjectiveId = $(e.target).parents('tr').attr('data-id');
			var currentObjective = Objective.findOrCreate(currentObjectiveId);
			
			var targetId = $(e.target).attr('target-id');
			var valueId = $(e.target).attr('data-id');
			
			this.targetValueModalView.renderWith(currentObjective, targetId, valueId);
			
			
		},

		detailModal : function(e) {
			var currentObjectiveId = $(e.target).parents('tr').attr('data-id');
			var currentObjective = Objective.findOrCreate(currentObjectiveId);

			var proposalStrategyCollection = new ProposalStrategyCollection();
			proposalStrategyCollection.fetch({
				url : appUrl('/ProposalStrategy/find/' + fiscalYear + '/' + currentObjective.get('id')),
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
				
				objectiveCollection.url = appUrl("/ObjectiveWithBudgetProposal/" + fiscalYear+ "/" + this.currentParentObjective.get('id') + "/flatDescendants");
				
				objectiveCollection.fetch({
					success : _.bind( function() {
						// we will now sorted out this mess!
						var i;
						for (i = 0; i < objectiveCollection.length; i++) {
							var o = objectiveCollection.at(i);
							if (o.get('parent') != null) {
								var parentId = o.get('parent').get('id');
								if (parentId == objectiveId) {
									this.collection.add(o);
								}
	
							var parentObj = objectiveCollection.get(parentId);
								if (parentObj != null) {
									parentObj.get('children').add(o);
								}
							}
						}
						
						this.collection.add(objectiveCollection.where({parent: this.currentParentObjective}));
						
						var allProposal = new BudgetProposalCollection(); 
						_.each(this.collection.pluck('filterProposals'), function(bpCollection) {
							if(bpCollection.length > 0) {
								bpCollection.each(function(bp) {
									allProposal.add(bp);
								});
							}
						});
						
						var json = this.collection.toJSON();
						json.allProposal = allProposal.toJSON();
					
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
			e1=currentTr;
			
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