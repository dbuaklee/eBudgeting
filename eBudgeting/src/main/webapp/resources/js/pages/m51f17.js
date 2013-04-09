var MainTreeView = Backbone.View.extend({
	/**
     *  @memberOf MainTreeView
     */
	
	initialize: function() {
		this.rootObjective = new Objective();
		this.rootObjective.bind('reset', this.render, this);
		
	},
	treeRootTemplate: Handlebars.compile($("#treeRootTemplate").html()),
	loadingTRTemplate: Handlebars.compile($("#loadingSpanTemplate").html()),
	treeTRTemplate: Handlebars.compile($("#treeTRTemplate").html()),
	render: function() {
		var json = this.rootObjective.toJSON();

		var html = this.treeRootTemplate(json);
		
		this.$el.html(html);
	}, 
	events : {
		"click a.nextChildrenLnk"  : "loadChildren" ,
		"click .unlink" : "unlinkBtnClick"
	},
	
	renderNewRow : function(parentObjective, newObjective) {
		// find tr of this parentObjective
		var parentTrEl = this.$el.find('tr[data-id='+ parentObjective.get('id') +']');
		var dataLevel = $(parentTrEl).attr("data-level");
		
		var prev = $(parentTrEl);
		var next = $(parentTrEl).next('tr');
		console.log('next: ' + $(next[0]).attr('data-id'));
		
		while(next.length>0 && $(next[0]).attr("data-level") > dataLevel ) {
			
			console.log('next: ' + $(next[0]).attr('data-id'));
			prev = $(next[0]);
			next = $(next[0]).next('tr');
			 
		}
		
		//rerender parent Objective
		if(parentObjective.get('isLeaf') == false) {
			parentTrEl.find('a.nextChildrenLnk').find('i').removeClass('icon-circle');
			parentTrEl.find('a.nextChildrenLnk').find('i').addClass('icon-chevron-down');
		}
		
		
		
		var json = newObjective.toJSON();
		
		if(json.type.id > 103 && json.type.id < 109) {
			json.type.unlinkable = true;
		} else {
			json.type.unlinkable = false;
		}
		
		var html = this.treeTRTemplate(json);
		$(prev).after(html);
		
		
		
	},
	
	unlinkBtnClick : function(e) {
		var clickunLinkObjectiveId = $(e.target).parents("tr").attr("data-id");
		console.log(clickunLinkObjectiveId);
		var clickunLinkObjective = Objective.findOrCreate(clickunLinkObjectiveId);
		var parentObjective = clickunLinkObjective.get('parent');
		console.log(parentObjective);
		
		if(clickunLinkObjective != null) {
			clickunLinkObjective.url = appUrl('/Objective/'+ clickunLinkObjectiveId);
			
			clickunLinkObjective.destroy({wait:true,
				success: _.bind(function() {
					$(e.target).parents("tr").remove();
					
					
					if(parentObjective.get('children').length == 0) {
					
						var parentTrEl = this.$el.find('tr[data-id='+ parentObjective.get('id') +']');
					
						parentTrEl.find('a.nextChildrenLnk').find('i').removeClass('icon-chevron-down');
						parentTrEl.find('a.nextChildrenLnk').find('i').addClass('icon-circle');
					}
					
				},this),
				error: function(model, xhr, options) {
					alert("ไม่สามารถลบรายการได้ \n Error: " + xhr.responseText);
				}
			});

		}
		
		
	
	},
	
	loadChildren: function(e) {
		
		
		// now remove anyone who might have this class
		this.$el.find('tr.selected').each(function(index, el) {
			$(el).removeClass('selected');
		});
		
		var trEl = $(e.target).parents('tr');
		var objectiveId = $(e.target).parents('tr').attr('data-id');
		$(trEl).addClass('selected');
		
		// we'll also now change the chevron
		$(trEl).find('i').removeClass('icon-chevron-right');
		$(trEl).find('i').addClass('icon-chevron-down');
		
		
		
		// now we load children
		var selectedObjective = Objective.findOrCreate(objectiveId);
		
		if(selectedObjective.get('children').length == 0) {
		
			// then we're appearing to be loading
			$(trEl).find('td:first').append(this.loadingTRTemplate());
			var children = new ObjectiveCollection();
			children.fetch({
				url: appUrl('/Objective/' + selectedObjective.get('id') + '/children'),
				success: _.bind(function() {
					selectedObjective.set('children', children);
					children.each(function(child) {
						child.set('parent', selectedObjective);
					});
					
					
					
					this.$el.find('.loading').fadeOut(1000, _.bind(function() {
						    // Animation complete.
						   this.$el.find('.loading').remove();
					  }, this));
					
					// console.log("children.length : " + children.length);
					for(var i=children.length-1; i>=0; i--) {
						// console.log(i);
						var json = children.at(i).toJSON();
						
						if(json.type.id > 103 && json.type.id < 109) {
							json.type.unlinkable = true;
						} else {
							json.type.unlinkable = false;
						}
						
						
						var html = this.treeTRTemplate(json);
						$(trEl).after(html);
						trEl = $(trEl).after();
					}
					
				}, this)
			});
		}
		
		// now get the hight of everyone
		var height = 0;
		$(trEl).prevAll().each(function(index, el) {
			height += $(el).height();
		});
		
		if( selectedObjective.get('type') != null && selectedObjective.get('type').get('id') >= 103  ) {
		
			$.ajax({
				type: 'GET',
				url: appUrl('/Objective/' + selectedObjective.get('id') + '/childrenTypeName'),
				success: function(response) {
					mainCtrView.childrenSltView.renderWith({
						topPadding: height, 
						objective: selectedObjective, 
						typeName: response,
						trEl : $(trEl)
					});		
				}
			});
			
		} else {
			mainCtrView.childrenSltView.clear();
		}
		
		
		
		return false;
	
	}
	
	
	
});

var ChildrenSltView = Backbone.View.extend({
	/**
     *  @memberOf ChildrenSltView
     */
	initialize: function() {
		
	},
	childrenSltTemplate: Handlebars.compile($("#childrenSltTemplate").html()),
	availableChildrenTemplate: Handlebars.compile($("#availableChildrenTemplate").html()),
	
	render: function() {
		var json = {};
		json.topPadding = this.topPadding;
		
		var html = this.childrenSltTemplate(json);
		
		this.$el.html(html);
	},
	
	events: {
		"click .link" : "linkBtnClick",
		"click button#search" : "searchBtnClick",
		"click button#searchDisplayAll" : "searchDisplayAllBtnClick"
	},
	clear: function(e) {
		this.$el.empty();
	},
	searchDisplayAllBtnClick: function(e) {
		this.availableChildren = new ObjectiveNameCollection();
		this.availableChildren.fetch({
			url: appUrl('/ObjectiveName/findChildrenNameOfObjective/' + this.objective.get('id') ),
			success: _.bind(function() {
				this.renderAvailableChildren();
			}, this)
		});
		return false;
	},
	
	searchBtnClick: function(e) {
		searchTxt = this.$el.find('#availableChildrenSearch').val();
		this.availableChildren = new ObjectiveNameCollection();
		this.availableChildren.fetch({
			url: appUrl('/ObjectiveName/findChildrenNameOfObjective/' + this.objective.get('id') ),
			data: {
				searchQuery: searchTxt
			},
			success: _.bind(function() {
				this.renderAvailableChildren();
			}, this)
		});
		return false;
	},
	linkBtnClick : function(e) {
		var objectiveNameId = $(e.target).parents('tr').attr('data-id');
		var newObjective = new Objective();
		newObjective.url = appUrl('/Objective/'+this.objective.get('id') + '/addChildObjectiveName/' + objectiveNameId);
		
		// now we link this.objective.id with objectiveNameId
		newObjective.fetch({
			success: _.bind(function(response) {
		
				
				// now add this to current parent
				this.objective.get('children').add(newObjective);
				this.objective.set('isLeaf',false);
				
				mainCtrView.mainTreeView.renderNewRow(this.objective, newObjective);
				
			}, this)
		});
		// then rerender? 
		
	},
	
	renderWith: function(options) {
		if(options != null) {
			this.topPadding = options.topPadding;
			this.objective = options.objective;
			this.typeName = options.typeName;
		}
		this.render();
		
		this.availableChildren = new ObjectiveNameCollection();
		this.availableChildren.fetch({
			url: appUrl('/ObjectiveName/findChildrenNameOfObjective/' + this.objective.get('id') ),
			success: _.bind(function() {
				this.renderAvailableChildren();
			}, this)
		});
	},
	
	renderAvailableChildren: function() {
		var el = this.$el.find('.content');	
		var json = this.availableChildren.toJSON();
		json.typeName = this.typeName;
		var html = this.availableChildrenTemplate(json);
		el.html(html);
	}
});

var MainSelectionView = Backbone.View.extend({
	/**
     *  @memberOf MainSelectionView
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
		
		mainCtrView.emptyTreeView();
		
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
		
		mainCtrView.emptyTreeView();
	},
	
	type103SltChange : function(e) {
		var type103Id = $(e.target).val();
		if(type103Id != 0) {
			mainCtrView.mainTreeView.rootObjective = Objective.findOrCreate(type103Id);
			mainCtrView.mainTreeView.render();
			mainCtrView.childrenSltView.$el.empty();
			
		} else {
			mainCtrView.emptyTreeView();
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
     *  @memberOf MainCtrView
     */
	
	
	initialize: function() {
		_.bindAll(this, 'render');
	},
	el: "#mainCtr",
	events: {

	},
	mainCtrTemplate: Handlebars.compile($("#mainCtrTemplate").html()),
	
	render: function() {
		this.$el.html(this.mainCtrTemplate());
		this.mainSelectionView = new MainSelectionView({el: "#mainCtr #mainSelection"});
		
		this.mainTreeView = new MainTreeView({el: "#mainCtr #mainTree div.content"});
		this.childrenSltView = new ChildrenSltView({el: "#mainCtr #childrenSlt"});
		
		
		this.rootObjective = new Objective(); 
		this.rootObjective.fetch({
			url: appUrl('/Objective/ROOT/'+fiscalYear),
			success : _.bind(function() {
				this.mainSelectionView.renderInitialWith(this.rootObjective);
			},this)
		});
	},
	
	events: {

	},
	
	emptyTreeView: function() {
		this.mainTreeView.$el.empty();
		this.childrenSltView.$el.empty();
	}
	
	
});