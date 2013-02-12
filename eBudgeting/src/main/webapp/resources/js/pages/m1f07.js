var ModalView = Backbone.View.extend({
	/**
     *  @memberOf ModalView
     */
	modalBodyTemplate: Handlebars.compile($("#modalBodyTemplate").html()),
	
	initialize: function(options) {
		
	},
	
	el: "#modal",
	
	events: {
		"click #closeBtn" : "close",
		"click #saveBtn" : "save"
	},
	
	close : function() {
		this.$el.modal('hide');
	},
	save : function(e) {
		var newObj = this.currentObjective.get('id') == null;
		// now collect data 
		this.currentObjective.set('name', this.$el.find('#nameTxt').val());
		
		// now save parent
		if(this.$el.find('#parentSlt').length > 0) {
			var parent = Objective.findOrCreate(this.$el.find('#parentSlt').val());
			if(parent != null){
				this.currentObjective.set('parent', parent);	
			} else {
				this.currentObjective.set('parent', null);
			}
		}
		
		//then 
		var relationSlt = this.$el.find('.relationSlt');
		var relations = this.currentObjective.get('relations');
		for(var i=0; i<relationSlt.length; i++) {
			if($(relationSlt[i]).val() != 0 ){
				if(relations.at(i).get('objective') == null) {
					
					relations.at(i).set('objective', this.currentObjective);
					relations.at(i).set('parent', Objective.findOrCreate($(relationSlt[i]).val()));
					
				} else {
					// update this relation!
					relations.at(i).set('parent', Objective.findOrCreate($(relationSlt[i]).val()));
					
				}
			} else {
				relations.at(i).set('parent',null);
			}				
		}
		
		// we should be fine to save here?
		this.currentObjective.save(null,{
			success: _.bind(function() {
				if(newObj) {
					var lastPage = objectiveCollection.totalPages;
					if(objectiveCollection.totalElements % objectiveCollection.pageSize == 0 ) {
						lastPage++;
					}
					mainTblView.renderTargetPage(lastPage);						
				}
				
				this.$el.modal('hide');
				
			},this)
		});
		
	},
	render: function() {
		if(this.currentObjective.get('name') == null) {
		
			this.$el.find('.modal-header span').html("เพิ่มทะเบียน" + objectiveType.get('name'));
		} else {
			this.$el.find('.modal-header span').html(objectiveType.get('name') + 
					"<br/> <span style='font-weight: normal;'> [" + this.currentObjective.get('code') + "]"+ this.currentObjective.get('name') + "</span>");
		}
		
		var json = this.currentObjective.toJSON();
		
	 	e1=this.currentObjective;
		
		if( hasUnit.length > 0 ) {
			json.hasUnit = true;
			json.unitSelectionList = listTargetUnits.toJSON();
			
			// loop through the parent
			for(var i=0; i<json.unitSelectionList.length; i++) {
				if(this.currentObjective.get('units') != null && 
						this.currentObjective.get('units').at(0) != null) {
					if(json.unitSelectionList[i].id == this.currentObjective.get('units').at(0).get('id')) {
						json.unitSelectionList[i].selected = "selected";
					}
				}
			}
			
		}
		
		
		if(hasParent.length > 0 ) {
			json.hasParent = true;
			json.parentTypeName = parentTypeName;
			json.parentTypeId = parentTypeId;
			json.parentSelectionList = parentObjectiveCollection.toJSON();
		
			// loop through the parent
			for(var i=0; i<json.parentSelectionList.length; i++) {
				if(this.currentObjective.get('parent') != null) {
					if(json.parentSelectionList[i].id == this.currentObjective.get('parent').get('id')) {
						json.parentSelectionList[i].selected = "selected";
					}
				}
			}
		}
		
		
		// now associcate each listOfObjective
		if(hasRelatedType == true) {
			json.hasRelatedType=true;
			for(var i=0; i< relatedTypeList.length; i++) {
				
				json.relations[i].selectionList = listObjective[relatedTypeList[i]].toJSON();
				
				for(var j=0; j<json.relations[i].selectionList.length; j++) {
					if(json.relations[i].parent != null) {
						if(json.relations[i].selectionList[j].id == json.relations[i].parent.id) {
							json.relations[i].selectionList[j].selected = "selected";
						}
							
					}
				}
				json.relations[i].relationInfo = {};
				json.relations[i].relationInfo.name = relatedTypenameList[i];
				json.relations[i].relationInfo.parentId = relatedTypeList[i];
			}
		} else{
			json.hasRelatedType=false;	
		}
		
		var html = this.modalBodyTemplate(json);
		this.$el.find('.modal-body').html(html);
		
		
		this.$el.modal({show: true, backdrop: 'static', keyboard: false});
		return this;
		
	},
	
	renderWithObjective: function(objective) {
		this.currentObjective = objective;
		this.render();
	}
	
});

var MainTblView = Backbone.View.extend({
	/**
	 * @memberOf MainTblView
	 */
	initialize: function(options){
	    this.collection.bind('reset', this.render, this);
	},

	el: "#mainCtr",
	selectedObjective: null,
	currentLineVal: null,
	
	mainCtrTemplate: Handlebars.compile($("#mainCtrTemplate").html()),
	tbodyTemplate: Handlebars.compile($("#tbodyTemplate").html()),
	userRowTemplate: Handlebars.compile($("#userRowTemplate").html()),
	
	modalView : new ModalView(),
	
	render: function() {
		// first render the control
		var json = {};
		json.pageParams = this.collection.toPageParamsJSON();
		var html = this.mainCtrTemplate(json);

		this.$el.html(html);
		
		if(this.collection.length>0) {
			// then the inside row
			json=this.collection.toJSON();
			
			html = this.tbodyTemplate(json);
			this.$el.find('tbody').html(html);
		}

		// bind all cell
		this.collection.each(function(model){
			model.bind('change', this.renderObjective, this);
			this.renderUser(model);
		}, this);

		return this;
	},
	
	events: {
		"click .menuNew" : "newRow",
		"click .menuDelete" : "deleteRow",
		"click .menuEdit"	: "editRow",
		"click .menuEditUnit"	: "editRowUnit",
		
		"click a.pageLink" : "gotoPage"
	},
	
	newRow: function(e) {
		
		var newObj = new ObjectiveName();
		// and we'll have to do
		var relationCollection = new ObjectiveRelationsCollection();
		for(var j=0; j<relatedTypeList.length; j++ ) {
			relationCollection.push(new ObjectiveRelations());
		}
		newObj.set('relations', relationCollection);
		newObj.set('fiscalYear', fiscalYear);
		newObj.set('type', objectiveType);
		
		this.modalView.renderWithObjective(newObj);
		
	},
	editRow: function(e) {
		var objectiveId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
		
		if((! $(e.currentTarget).hasClass('disabled') ) && $('input[name=rowRdo]:checked').length == 1) {
			var model = this.collection.get(objectiveId);
				
			this.modalView.renderWithObjective(model);
		
		} else {
			alert('กรุณาเลือกรายการที่ต้องการแก้ไข');
		}
	},
	editRowUnit: function(e) {
		var objectiveId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
		
		if((! $(e.currentTarget).hasClass('disabled') ) && $('input[name=rowRdo]:checked').length == 1) {
			var model = this.collection.get(objectiveId);
				
			this.unitModalView.renderWithObjective(model);
		
		} else {
			alert('กรุณาเลือกรายการที่ต้องการแก้ไข');
		}
	},
	
	renderUser: function(user) {
		
		var userEl = this.$el.find('tr[data-id='+ user.get('id') +']');
		
		var json = user.toJSON();
		
			
		userEl.html(this.userRowTemplate(json));
		
	},
	
	deleteRow: function(e) {
		var objectiveId = $('input[name=rowRdo]:checked').parents('tr').attr('data-id');
		
		if( (! $(e.currentTarget).hasClass('disabled')) && $('input[name=rowRdo]:checked').length == 1 ) {
			
			var modelToDelete = this.collection.get(objectiveId);
			if(confirm("คุณต้องการลบรายการ " + modelToDelete.get('name'))) {
			
				modelToDelete.destroy({wait:true,
					success: _.bind(function() {					
						this.collection.remove(modelToDelete);
					
						// now we have to run through and reindex
						this.collection.each(function(model, index) {
							model.set('index', index);
						});
						
						this.collection.trigger('reset');
					},this),
					error: _.bind(function(model, xhr, options) {
						alert("ไม่สามารถลบรายการได้ \n Error: " + xhr.responseText);
					},this)
				});
			}
			
			this.collection.trigger('reset');
		
		} else {
			alert('กรุณาเลือกรายการที่ต้องการลบ');
		}
	},
	
	gotoPage: function(e) {
		var pageNumber = $(e.target).attr('data-id');
		this.renderTargetPage(pageNumber);
	},
	
	renderTargetPage: function(pageNumber) {
		
		userCollection.targetPage = pageNumber;
		
		userCollection.fetch({
			silent: true,
			success: function(){
				
				
				userCollection.trigger('reset');
				
				
			}
		});
	}
	
});