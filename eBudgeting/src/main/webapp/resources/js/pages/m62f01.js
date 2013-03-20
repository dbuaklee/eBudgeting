var MainTblView = Backbone.View.extend({
	/**
	 * @memberOf MainTblView
	 */
	initialize: function(options){
	    this.collection = new ObjectiveCollection();
		this.collection.bind('reset', this.render, this);
	},

	el: "#mainCtr",
	
	mainTblTemplate: Handlebars.compile($("#mainTblTemplate").html()),
	
	render: function() {
		var html = this.mainTblTemplate();
		this.$el.html(html);
		
		return this;
	}
});