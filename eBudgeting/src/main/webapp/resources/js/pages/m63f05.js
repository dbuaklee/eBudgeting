var FormulaColumnView = Backbone.View.extend({
	/**
     *  @memberOf FormulaColumnView
     */
	formulaColumnTemplate: Handlebars.compile($("#formulaColumnTemplate").html()),
	initialize: function(options) {
		if(options != null) {
			this.el = options.el;
			this.formulaColumn = options.formulaColumn;
			this.lastColumn = options.lastColumn;
			this.parentStrategy = options.parentStrategy;
			this.parentModal = options.parentModal;
			this.nth = options.nth;
		}
		this.active = true;
	},
	
	render: function() {
		var json=this.formulaColumn.toJSON();
		if(this.lastColumn) {
			json.lastColumn=true;
		}
		
		if(this.parentStrategy.get('isStandardItem') == true) {
			json.noTimesSign = true;
		}
		
		var html=this.formulaColumnTemplate(json);
		this.$el.html(html);
	},
	
	removeAddTimesBtn: function() {
		var spanEl = this.$el.find('span.times');
		spanEl.empty();
		spanEl.html(' &times');
		this.lastColumn = false;
		
	},
	putAddTimesBtn: function() {
		var spanEl = this.$el.find('span.times');
		spanEl.empty();
		spanEl.html('<button type="button" id="timesAddBtn"> &times;</button>');
		this.lastColumn = true;
		
	},
	
	events: {
		
		"change .unitName" : "changeUnitName",
		"click a.deleteFormulaColumn" : "removeSelf"
		
	},
	changeUnitName: function(e) {
		this.formulaColumn.set('unitName',$(e.target).val());
	},
	removeSelf: function(e) {
		
		var activeList = _.where(this.parentModal.formulaColumnDiv, {active: true});
		if( activeList.length == 1) {
			alert("คุณไม่สามารถลบรายการคำนวณสุดท้ายได้");
			return false;
		}
		
		this.active = false;
		activeList = _.where(this.parentModal.formulaColumnDiv, {active: true});
		
		if(this.lastColumn) {
			// we need to toggle the one before us!?
			e1=this;						
			var maxNextFcView = _.max(activeList, function(fcView) { return fcView.nth; } );
			maxNextFcView.putAddTimesBtn();
		}
		
		
		this.$el.empty();
		this.$el.css("padding", "0px");
		this.parentStrategy.get('formulaColumns').remove(this.formulaColumn);
		return false;
	}
});

var FormulaLineModalView = Backbone.View.extend({
	/**
     *  @memberOf FormulaLineModalView
     */
	initialize: function(options) {
		_.bindAll(this,'back');
		_.bindAll(this,'addFormulaColumn');
		_.bindAll(this,'renderFormulaLineWith');
		
		if(options != null) {
			this.isStandardItem = options.isStandardItem;
		} else {
			this.isStandardItem = false;
		}
		
	},
	el: "#formulaLineModal",
	model: null,
	formulaLineModalTemplate: Handlebars.compile($("#formulaLineModalTemplate").html()),
	formulaLineTemplate: Handlebars.compile($("#formulaLineTemplate").html()),
	formulaColumnFormTemplate: Handlebars.compile($("#formulaColumnFormTemplate").html()),
	
	collection: new FormulaColumnCollection(),
	
	render: function() {
		var html;
		if( this.currentStrategy.get('id') == null )  {
			html = this.isStandardItem ? "เพิ่มราคากลาง" : "เพิ่มรายการย่อย";
		} else {
			html = this.isStandardItem ? "แก้ไขราคากลาง" : "แก้ไขรายการย่อยและการกำหนดราคาต่อหน่วย (บาท/หน่วยนับ)";
		}
		this.$el.find('.modal-header span').html(html);
		
		
		html = this.formulaLineModalTemplate(this.currentStrategy.toJSON());
		
		// if formulaColumns is no go
		var formulaColumns = this.currentStrategy.get('formulaColumns');
		if((formulaColumns.length == 0 && this.currentStrategy.get('id') != null) || 
				(formulaColumns.length == 0 && this.currentStrategy.get('isStandardItem') == true)) {
			var fc = new FormulaColumn();
			formulaColumns.add(fc);
		}
		
		
		this.$el.find('.modal-body').html(html);
		
		// now add div
		this.formulaColumnDiv = [];
		for(var i=0; i<formulaColumns.length; i++) {
			$('#formulaBox').append("<div></div>");
			
			var nthDiv = i+3;
			var el = "#formulaBox > div:nth-child("+ nthDiv +")";
			var lastColumn = false;
			if(i==formulaColumns.length-1) {
				lastColumn = true;
			}
			var fcView = new FormulaColumnView({el: el, formulaColumn: formulaColumns.at(i),
				lastColumn: lastColumn, parentStrategy: this.currentStrategy, parentModal: this, nth: nthDiv}); 
			this.formulaColumnDiv.push(fcView);
			fcView.render();
		}
		
		
		
		this.$el.modal({show: true, backdrop: 'static', keyboard: false});
	},
	
	renderFormulaLineWith: function(formulaStrategy, budgetType){
		if(formulaStrategy != null) {
			this.currentStrategy = formulaStrategy;
			this.currentBudgetType = budgetType;
			this.isStandardItem = formulaStrategy.get('isStandardItem');
			if(this.currentStrategy.get('formulaColumns') != null) {
				this.collection = this.currentStrategy.get('formulaColumns');
			};
			
			this.collection.bind('add', this.addNewFormulaColumn, this);
			this.render();
		}
	},
	
	events: {
		
		"click #backBtn" : "back",
		"click #saveStrategyBtn" : "saveStrategy",
		"click #timesAddBtn" : "addFormulaColumn"
		
	},
	addFormulaColumn : function(e) {
		var formulaColumns = this.currentStrategy.get('formulaColumns');
		var fc = new FormulaColumn();
		formulaColumns.add(fc);			
		
		e2=formulaColumns;
		$('#formulaBox').append("<div></div>");
		
		var nthDiv = formulaColumns.length + 2;
		var el = "#formulaBox > div:nth-child("+ nthDiv +")";
		
		var fcView = new FormulaColumnView({el: el, formulaColumn: fc, lastColumn: true, parentStrategy: this.currentStrategy, parentModal: this, nth: nthDiv});
		var lastFcView = _.last(this.formulaColumnDiv);
		lastFcView.removeAddTimesBtn();
		
		this.formulaColumnDiv.push(fcView);
		fcView.render();
		
		return false;
		
	},
	
	saveStrategy: function(e) {
		var nameTxt = this.$el.find("#strategyName").val();
		var standardPriceTxt = this.$el.find("#standardPriceTxt").val();
		var newStrategy = false;
		if(this.currentStrategy.get('id') == null) {
			newStrategy = true;
		}
		
		if(this.currentStrategy.get('isStandardItem') == true) {
			this.currentStrategy.set('name', this.currentBudgetType.get('name'));
		} else {
			this.currentStrategy.set('name', nameTxt);
		}
		//this.currentStrategy.set('standardPrice', standardPriceTxt);
		this.currentStrategy.get('allocationStandardPriceMap').at(0).set('standardPrice', standardPriceTxt);
		this.currentStrategy.set('fiscalYear', fiscalYear);
		this.currentStrategy.set('isStandardItem', this.isStandardItem == null ? false : this.isStandardItem);
		
		var fcList = this.currentStrategy.get('formulaColumns');

		if(fcList.length > 0) {
			for(var i=0; i<fcList.length; i++) {
				fcList.at(i).set('index', i);
			}
		}
		
		this.currentStrategy.save(null, {
			url: appUrl('/FormulaStrategy/updateStandardPrice/R1/' + this.currentStrategy.get('id')),
			success: _.bind(function() {
				if(newStrategy) {
					if(this.currentStrategy.get('isStandardItem') == true) {
						this.currentBudgetType.set('standardStrategy',this.currentStrategy);
					} else {
						this.currentBudgetType.get('strategies').add(this.currentStrategy);
					}
					
					
				}
				this.currentStrategy.get('formulaColumns').comparator = function(formulaColumn) {
					  return formulaColumn.get("index");
				};
				this.currentStrategy.get('formulaColumns').sort();
				
				this.render();
			},this)
		});
		
		return false;
	},
	
	back: function(e) {
		if(this.currentStrategy.get('formulaColumns') == null) {
			this.currentStrategy.set('formulaColumns', this.collection);
		}
		
		
		this.currentStrategy.trigger('changeFormula', this.currentStrategy);
		this.currentBudgetType.trigger('renderRow', this.currentBudgetType);
		
		// nothing to recover just hide!
		this.$el.modal('hide');
	}
	
});

var MainTblView = Backbone.View.extend({
	/**
     *  @memberOf MainTblView
     */
	initialize: function(options){
	    this.collection.bind('reset', this.render, this);
	},

	el: "#mainCtr",
	selectedObjective: null,
	currentLineVal: null,
	
	newRowTemplate: Handlebars.compile($("#newRowTemplate").html()),
	editRowTemplate: Handlebars.compile($("#editRowTemplate").html()),
	formulaCellTemplate: Handlebars.compile($("#formulaCellTemplate").html()),
	mainCtrTemplate: Handlebars.compile($("#mainCtrTemplate").html()),
	tbodyTemplate: Handlebars.compile($("#tbodyTemplate").html()),
	budgetTypeRowTemplate: Handlebars.compile($("#budgetTypeRowTemplate").html()),
	
	formulaInLineEditTpl : Handlebars.compile($("#formulaInLinEditTemplate").html()),
	formulaLineModalView : new FormulaLineModalView(),
	
	render: function() {
		// first render the control
		
		var json = this.collection.toPageParamsJSON();
		json.searchTxt = this.searchTxt;
		var html = this.mainCtrTemplate(json);
		
		this.$el.html(html);
		
		// then the inside row
		json=this.collection.toJSON();
		json.pageParams = this.collection.toPageParamsJSON();
	
		
		html = this.tbodyTemplate(json);
		this.$el.find('tbody').html(html);

		// bind all cell
		this.collection.each(function(model){

			model.bind('change', this.renderObjective, this);
			model.bind('changeFormula', this.renderChild, this);
			this.renderFormulaStrategy(model);
		}, this);

		return this;
	},
	
	renderTargetPage: function(page) {
		// we have to refresh collection
		this.collection.setTargetPage(page);
		if(this.searchTxt == null) {
			this.searchTxt = '';
		} 
		
		this.collection.fetch({
			type: 'POST',
			data: {
				query: this.searchTxt
			},
			success: _.bind(function() {
				this.render();
			},this)
		});
		
	},
	
	renderRow: function(budgetType) {
		var currentTr = this.$el.find('tr[data-id='+budgetType.get('id')+']');
		
		$(currentTr).empty();
		$(currentTr).html(this.budgetTypeRowTemplate(budgetType.toJSON()));
	},
	
	events: {
		"click .menuNew" : "newRow",
		"click .menuDelete" : "deleteRow",
		"click .menuEdit"	: "editRow",
		"click .lineSave" : "saveLine",
		"click .lineUpdate" : "updateLine",
		"click .cancelLineSave" : "cancelSaveLine",
		"click .cancelLineUpdate" : "cancelUpdateLine",
		"click button#search" : "searchBtnClick",
		"click button#searchDisplayAll" : "searchDisplayAllBtnClick",

		"click a.pageLink" : "gotoPage",
		
		"click a.showFormulaToolBar" : "showFormulaToolBar",
		
		"click button.addFormula" : "addFormula",
		"click button.addDefaultFormula" : "addDefaultFormula",
		"click button.deleteDefaultFormula" : "deleteDefaultFormula",
		"click button.cancelFormula" : "cancelFormula",
		"click a.deleteStrategy" : "deleteStrategy",
		"click a.editStrategy" : "editStrategy",
		
		"click .editFormulaLineBtn" : "editFormulaLine"
			
		
	},
	
	gotoPage: function(e) {
		var pageNumber = $(e.target).attr('data-id');
		this.renderTargetPage(pageNumber);
	},
	
	deleteStrategy: function(e) {
		var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
		var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
		
		var currentFormulaId = $(e.currentTarget).parents('li').attr('data-id');
		var currentFormula = FormulaStrategy.findOrCreate(currentFormulaId);

	
		if(confirm("คุณต้องการลบข้อมูลสูตรการคำนวณ: " + currentFormula.get('name'))) {
			currentFormula.destroy({
				success: _.bind(function() {
					this.renderRow(currentBudgetType);
				},this)
			});
		}
	},
	
	editStrategy: function(e) {
		var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
		var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
		currentBudgetType.on('renderRow', this.renderRow, this);
		
		var currentFormulaId = $(e.currentTarget).parents('li').attr('data-id');
		var currentFormula = FormulaStrategy.findOrCreate(currentFormulaId);

		this.formulaLineModalView.renderFormulaLineWith(currentFormula, currentBudgetType);
	},
	
	addFormula: function(e) {
		var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
		var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
		currentBudgetType.on('renderRow', this.renderRow, this);
		
		var currentFormula = new FormulaStrategy();
		currentFormula.set('type', currentBudgetType);
		

		this.formulaLineModalView.renderFormulaLineWith(currentFormula, currentBudgetType);
	},
	 
	addDefaultFormula: function(e) {
		var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
		var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
		currentBudgetType.on('renderRow', this.renderRow, this);
		
		var currentFormula = currentBudgetType.get('standardStrategy');
		if(currentFormula == null) {
			currentFormula = new FormulaStrategy();
			currentFormula.set("type", currentBudgetType);
			currentFormula.set("name", currentBudgetType.get('name'));
			currentFormula.set("isStandardItem", true);
		} 

		this.formulaLineModalView.renderFormulaLineWith(currentFormula, currentBudgetType);
	},
	
	deleteDefaultFormula: function(e) {
		var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
		var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
		currentBudgetType.on('renderRow', this.renderRow, this);
		
		var currentFormula = currentBudgetType.get('standardStrategy');
		if(currentFormula != null) {
			currentFormula.destroy({
				success: function(){
					alert("คุณได้ลบข้อมูลแล้ว");
					currentBudgetType.trigger('renderRow', currentBudgetType);
				}
			});
		} 
	},
	
	cancelFormula : function(e) {
		var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
		var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
		
		this.renderRow(currentBudgetType);
		
	},
	
	showFormulaToolBar : function(e) {
	
		var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('data-id');
		var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
		var currentTd = $(e.currentTarget).parents('td');
		
		
		
		$(currentTd).empty();
		var json = currentBudgetType.toJSON();
		var html = this.formulaCellTemplate(json);
		$(currentTd).html(html);
		
		return false;
		
	},
	
	searchDisplayAllBtnClick: function(e) {
		this.searchTxt = null;
		this.collection.setTargetPage(1);
		this.collection.fetch();
		return false;
	},
	
	searchBtnClick: function(e) {
		this.searchTxt = this.$el.find('#searchQuery').val();
		this.collection.setTargetPage(1);
		this.collection.fetch({
			type: 'POST',
			data: {
				query: this.searchTxt
			}
		});
		return false;
	},
	
	editFormulaLine : function(e) {
		var currentBudgetTypeId = $(e.currentTarget).parents('tr').attr('budgetType-id');
		var currentBudgetType = BudgetType.findOrCreate(currentBudgetTypeId);
		
		var currentFormulaId = $(e.currentTarget).parents('tr').attr('data-id');
		var currentFormula = FormulaStrategy.findOrCreate(currentFormulaId);

		this.formulaLineModalView.renderFormulaLineWith(currentFormula, currentBudgetType);
	},
	
	newRow: function(e) {
		if(! $(e.currentTarget).hasClass('disabled') ) {
			var json = {};
			json.index = this.collection.length;
			
			json.unitList = listTargetUnits.toJSON();
			
			json.commonTypeList = listBudgetCommonType.toJSON();
			
			
			$('#newRowCtr').html(this.newRowTemplate(json));
			var currentBudgetTypeId = $('select#budgetTypeSlt').val();
			
			//now populate the budgetTypeSlt
		    var budgetTypeSlt = BudgetType.findOrCreate({id: currentBudgetTypeId});
		    budgetTypeSlt.fetch({success: _.bind(function(){
		    	if(budgetTypeSlt.get('children').length > 0) {
		    		this.budgetTypeSelection = new BudgetTypeSelectionView({
		    			model: budgetTypeSlt, el:'.budgetTypeSlt', mainTblView: this});
		    		this.budgetTypeSelection.render();
		    	}
	    	},this)});
			
			
			this.$el.find('a.btn').toggleClass('disabled');
		}
	},
	
	editRow: function(e) {
		var fsId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
		
		if((! $(e.currentTarget).hasClass('disabled') ) && $('input[name=rowRdo]:checked').length == 1) {

			var model = this.collection.get(fsId);
			
			var json = model.toJSON();
			
			json.unitList = listTargetUnits.toJSON();
			
			var unit = _.find(json.unitList, function(unit) {
				if(json.unit != null) {
					return json.unit.id == unit.id;
				}
			});
			
			if(unit!=null) {unit.selected = true;}
			
			json.commonTypeList = listBudgetCommonType.toJSON();
			json.editBudgetType = true;
			
			var commonType =  _.find(json.commonTypeList, function(commonType) {
				if(json.commonType!=null) {
					
					return json.commonType.id == commonType.id;
				}
			});
			
			if(commonType!=null) {
				commonType.selected = true;
			}

			
			$('#newRowCtr').html(this.newRowTemplate(json));	
			
			this.$el.find('a.btn').toggleClass('disabled');
			
			/* var model = this.collection.get(fsId);
			
			var json = model.toJSON();
				
			json.unitList = listTargetUnits.toJSON();
			if(model.get('unit') != null) {
				for(var i=0; i<json.unitList.length; i++) {
					if(json.unitList[i].id == model.get('unit').get('id')) {}
					json.unitList[i].selected = 'selected';
				}
			}
			
			
			json.commonTypeList = listBudgetCommonType.toJSON();
			if(model.get('commonType') != null) {
				for(var i=0; i<json.commonTypeList.length; i++) {
					if(json.commonTypeList[i].id == model.get('commonType').get('id')) {}
					json.commonTypeList[i].selected = 'selected';
				}
			}

			var html = this.editRowTemplate(json);
			$('input[name=rowRdo]:checked').parents('tr').html(html); */
		} else {
			alert('กรุณาเลือกรายการที่ต้องการแก้ไข');
		}
	},
	
	
	cancelUpdateLine: function(e) {
		//now put back the value
		// well do nothing just reset the collection
		this.$el.find('a.btn').toggleClass('disabled');
		this.collection.trigger('reset');
		
	},
	
	cancelSaveLine: function(e) {
		//now put back the value
		// well do nothing just reset the collection
		
		this.$el.find('a.btn').toggleClass('disabled');
		$('#newRowCtr').empty();
		
	},
	
	updateLine: function(e) {
		var inputNameVal = this.$el.find('#nameTxt').val();
		var budgetTypeId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
		var modelToUpdate = this.collection.get(budgetTypeId);
		modelToUpdate.save({name: inputNameVal}, {
			success: _.bind(function() {
				this.collection.trigger('reset');
			}, this)
		});
		
	},
	
	saveLine: function(e) {

		var id = $(e.target).attr('data-id');
		var budgetType = BudgetType.findOrCreate(id);
		
		
		var parentBudgetType;
		var newBudgetType;
		var inputNameVal = this.$el.find('#nameTxt').val();
		var unitId = this.$el.find('select#unitSlt').val();
		var unit = TargetUnit.findOrCreate(unitId);
		
		var commonTypeId = this.$el.find('select#commonTypeSlt').val();
		var commonType = BudgetCommonType.findOrCreate(commonTypeId);
		
		
		
		if(budgetType== null) {
			var parentTypeId = this.$el.find('select.type:last').val();
			parentBudgetType = BudgetType.findOrCreate(parentTypeId);
			
			newBudgetType = new BudgetType();
			newBudgetType.set('name', inputNameVal);
			newBudgetType.set('parent', parentBudgetType);
			newBudgetType.set('parentLevel', 4);
			newBudgetType.set('parentPath', '.' + parentBudgetType.get('id') + parentBudgetType.get('parentpath'));
			
		} else {
			parentBudgetType = budgetType.get('parent');
			newBudgetType = budgetType;
			newBudgetType.set('name', inputNameVal);
			
		}
		
		newBudgetType.set('commonType', commonType);
		newBudgetType.set('unit', unit);
		
		
		
		newBudgetType.save(null, {
			success: function() {
				
			}
		});
		
		this.$el.find('a.btn').toggleClass('disabled');
		this.collection.trigger("reset");
	
	},
	
	deleteRow: function(e) {
		var budgetTypeId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
		
		if( (! $(e.currentTarget).hasClass('disabled')) && $('input[name=rowRdo]:checked').length == 1 ) {
			
			var modelToDelete = this.collection.get(budgetTypeId);
			
			
				if(confirm("คุณต้องการลบรายการ " + modelToDelete.get('name'))) {
				
					modelToDelete.destroy({
						success: _.bind(function() {					
							this.collection.remove(modelToDelete);
						
							this.collection.fetch();
						},this)
					});
			} 
		} else {
			alert('กรุณาเลือกรายการที่ต้องการลบ');
		}
	},
	
	
	
	renderFormulaStrategy: function(formulaStrategy) {
		var formulaStrategyEl = this.$el.find('tr[data-id='+ formulaStrategy.get('id') +']');
		
		var json = formulaStrategy.toJSON();
		
		formulaStrategyEl.html(this.budgetTypeRowTemplate(json));
		
	},
	
	renderChild: function(caller) {
		this.renderFormulaStrategy(caller);
	}
	
	
});

var BudgetSltView = Backbone.View.extend({
	/**
     *  @memberOf BudgetSltView
     */
	budgetSltTemplate :  Handlebars.compile($("#budgetSltTemplate").html()),
	mainTblView: new MainTblView({collection: new BudgetTypePagableCollection()}),
	initialize: function(options){
		
	    this.collection.bind('reset', this.render, this);
	    this.render();
	},
	
	events: {
		"change #budgetTypeSlt" : "changeSlt"
	},

	el: "#budgetRootSlt",
	selectedBudget: null,
	render: function() {
		if(this.collection != null) {
			
			var json = this.collection.toJSON();
			var html = this.budgetSltTemplate(json);
			
			this.$el.html(html);
			
		}
	},
	
	changeSlt: function(e) {
		var budgetTypeSelectedId = $('select#budgetTypeSlt').val();
		if(budgetTypeSelectedId != 0) {
			this.mainTblView.searchTxt = null;
			this.mainTblView.collection.setTargetPage(1);
			this.mainTblView.collection.setMainTypeId(budgetTypeSelectedId);
			this.mainTblView.collection.setLevel(4);
			this.mainTblView.collection.setCurrentFiscalYear(fiscalYear);
			this.mainTblView.collection.fetch({
				success: _.bind(function() {
					// we should now load it's children?
					// set this.mainTblV
					this.mainTblView.render();
				},this)
			});
		}
	}
	
});


var BudgetTypeSelectionView = Backbone.View.extend({
	/**
     *  @memberOf BudgetTypeSelectionView
     */
	initialize: function(options){
		if(options != null) {
			this.el = options.el;
			this.model = options.model;
		} 
	},
	
	el: "#budgetSelectionCtr",
	
	selectionTpl : Handlebars.compile($("#budgetSltTemplate").html()),
	
	render: function(){
		// first clear the siblings select
		this.$el.nextAll('div').remove();
		this.$el.empty();
		this.$el.html(this.selectionTpl(this.model.get('children').toJSON()));
	},
	
	events: {
		"change select:first" : "selectionChange" // only the first one
	},
	
	selectionChange: function(e) {
		var selectedBudgetTypeId = $(e.target).val();
		// now try to get this model
		var budgetType = BudgetType.findOrCreate(selectedBudgetTypeId);
		e1 = budgetType;
		budgetType.fetch({success: _.bind(function(model, response){
			var fetchedBudgetType = response;
			if(fetchedBudgetType.parentLevel < 3) {
				
				var nextEl = this.$el.selector + " select + div";
				this.nextBudgetTypeSelectionView = new BudgetTypeSelectionView({model: budgetType, el: nextEl, mainTblView: this.mainTblView});
				this.nextBudgetTypeSelectionView.render();
				
			} else {
				
				 
			}

		}, this)});
		
		// ok we'll have to set back to this!?
		
	}
});