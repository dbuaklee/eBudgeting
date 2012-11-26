<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="hero-unit white">
<div id="headLine">
	<h4>การเชื่อมโยงกิจกรรม <c:if test="${not empty fiscalYear}">ปีงบประมาณ ${fiscalYear}</c:if></h4> 
</div>

<div class="row">
	<div class="span11">
		
		<div id="modal" class="modal hide fade">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<span style="font-weight: bold;"></span>
			</div>
			<div class="modal-body">
				
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" id="cancelBtn">Close</a> 
				<a href="#"	class="btn btn-primary" id="saveBtn">Save changes</a>
			</div>
		</div>
	
		<div class="control-group" id="mainCtr">
			
			<c:choose>
			<c:when test="${rootPage}">
				<table class="table table-bordered" id="mainTbl">
					<thead>
						<tr>
							<td>เลือกปีงบประมาณ</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${fiscalYears}" var="fiscalYear">
						<tr>
								<td> <a href="./${fiscalYear.fiscalYear}/" class="nextChildrenLnk">${fiscalYear.fiscalYear}<i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>			
			</c:when>
			</c:choose>	
		</div>

		
		
	</div>
</div>
</div>


<script id="mainCtrTemplate" type="text/x-handler-template">
<div class="row">
	<div id="mainTree" class="span7">
		<div class="content">
			
		</div>
	</div>
	<div id="childrenSlt" class="span4" style="border: 1px;">
		
	</div>
</div>
</script>

<script id="treeRootTemplate" type="text/x-handler-template">
	<table class="table table-bordered">
		<tr data-id={{id}}>
			<td><a href="#" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i> ปี {{fiscalYear}}</a></td>
		</tr>
	</table>
</script>

<script id="loadingSpanTemplate" type="text/x-handler-template">
	<span class="loading"> Loading <img src="/eBudgeting/resources/graphics/loading-small.gif"/></span>
</script>
<script id="treeTRTemplate" type="text/x-handler-template">
	<tr data-id={{id}}>
			<td  style="padding-left: {{paddingLevel parentLevel}}px;"><span class="label label-info mini">{{type.name}}</span><br/>
				<a href="#" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i> {{name}}</a> <button type="button" class="btn unlink">UnLink</button></td>
	</tr>
</script>

<script  id=childrenSltTemplate type="text/x-handler-template">
<div style="padding: 12px;margin-top: {{topPadding}}px; background-color: #F5F5F5;">
	<div class="control">
		<form class="form-search">
			<div class="input-append">
				<input type="text" id="availableChildrenSearch" class="span2 search-query">
				<button type="submit" class="btn">Search</button>
			</div>
		</form>
	</div>
	<div class="content">
		
	</div>
</div>
</script>


<script  id=availableChildrenTemplate type="text/x-handler-template">
เลือก{{typeName}}ที่ยังไม่ได้เชื่อมโยง
<table class="table table-bordered">	
	<thead>
	</thead>
	<tbody>
	{{#each this}}
		<tr data-id="{{id}}">
			<td><button type="button" class="btn link">Link</button></td><td>[{{code}}] {{name}}</td>
		</tr>
	{{/each}}
	</tbody>	
</table>
</script>


<script type="text/javascript">

var fiscalYear = "${fiscalYear}";
var e1;

Handlebars.registerHelper("paddingLevel", function(level) {
	var step = level-1;
	return (step*50) + 8;

});


$(document).ready(function() {
	
	if(fiscalYear.length > 0) {
		
		var MainTreeView = Backbone.View.extend({
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
				"click a.nextChildrenLnk"  : "loadChildren" 
			},
			loadChildren: function(e) {
				e1 = e;
				
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
					$(trEl).find('td').append(this.loadingTRTemplate());
					var children = new ObjectiveCollection();
					children.fetch({
						url: appUrl('/Objective/' + selectedObjective.get('id') + '/children'),
						success: _.bind(function() {
							selectedObjective.set('children', children);
							
							
							
							this.$el.find('.loading').fadeOut(1000, _.bind(function() {
								    // Animation complete.
								   this.$el.find('.loading').remove();
							  }, this));
							
							for(var i=0; i<children.length; i++) {
								var html = this.treeTRTemplate(children.at(i).toJSON());
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
				
				$.ajax({
					type: 'GET',
					url: appUrl('/Objective/' + selectedObjective.get('id') + '/childrenTypeName'),
					success: function(response) {
						mainCtrView.childrenSltView.renderWith({
							topPadding: height, 
							objective: selectedObjective, 
							typeName: response
						});		
					}
				});
				
				
				
				return false;
			
			}
			
			
			
		});
	
		var ChildrenSltView = Backbone.View.extend({
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
			
			renderWith: function(options) {
				this.topPadding = options.topPadding;
				this.objective = options.objective;
				this.typeName = options.typeName;
				
				this.render();
				
				this.availableChildren = new ObjectiveCollection();
				this.availableChildren.fetch({
					url: appUrl('/Objective/' + this.objective.get('id') + '/availableChildren' ),
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
		
		var MainCtrView = Backbone.View.extend({
			initialize: function() {
				
			},
			el: "#mainCtr",
			events: {
	
			},
			mainCtrTemplate: Handlebars.compile($("#mainCtrTemplate").html()),
			
			render: function() {
				this.$el.html(this.mainCtrTemplate());
				this.mainTreeView = new MainTreeView({el: "#mainCtr #mainTree div.content"});
				this.childrenSltView = new ChildrenSltView({el: "#mainCtr #childrenSlt"});
				
				
				this.mainTreeView.rootObjective.fetch({
					url: appUrl('/Objective/ROOT/'+fiscalYear),
			
					success : _.bind(function() {
						this.mainTreeView.rootObjective.trigger('reset');
					},this)
				});
			},
			
			events: {

			}
			
			
		});
		
		mainCtrView = new MainCtrView();
		mainCtrView.render();
	}
});
</script>