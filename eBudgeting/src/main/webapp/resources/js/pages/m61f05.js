var MainCtrView = Backbone.View.extend({
	/**
     *  @memberOf MainCtrView
     */
	initialize : function() {

	},

	el : "#mainCtr",
	events : {
		"click button.topRow" : "buttonClick"
	},
	
	mainTblTemplate : Handlebars.compile($("#mainTblTemplate").html()),
	
	render : function() {
		
		if(this.budgetSignOff != null) {
			var json = this.budgetSignOff.toJSON();
			this.$el.html(this.mainTblTemplate(json));
		}
	},
	
	renderWith : function(budgetSignOff) {
		this.budgetSignOff = budgetSignOff;
		this.render();
	},
	
	buttonClick: function(e) {
		var buttonId = $(e.target).prop('id');
		$.get(appUrl('/BudgetSignOff/'+fiscalYear +'/updateCommand/' + buttonId),
				_.bind(function(response) {
					var responsePerson = Person.findOrCreate(response.person.id);
					if(responsePerson == null) {
						responsePerson = new Person(response.person);
					}
					this.budgetSignOff.set(buttonId+'Person', responsePerson);
					this.budgetSignOff.set(buttonId+'TimeStamp', response.timeStamp);
					
					if(buttonId == 'lock1') {
						this.budgetSignOff.set('unLock1Person', null);
						this.budgetSignOff.set('unLock1TimeStamp', null);
						
					} else if(buttonId == 'lock2') {
						this.budgetSignOff.set('unLock2Person', null);
						this.budgetSignOff.set('unLock2TimeStamp', null);
						
					} else if(buttonId == 'unLock1') {
						this.budgetSignOff.set('lock1Person', null);
						this.budgetSignOff.set('lock1TimeStamp', null);
						
					} else if(buttonId == 'unLock2') {
						this.budgetSignOff.set('lock2Person', null);
						this.budgetSignOff.set('lock2TimeStamp', null);
					}
					this.render();
		},this));
	}
	
});