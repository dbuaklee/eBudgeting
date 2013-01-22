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
	<div id="mainSelection" class="span11"></div>

	<div id="mainTree" class="span6">
		<div class="content">
			
		</div>
	</div>
	<div id="childrenSlt" class="span5" style="border: 1px;">
		
	</div>
</div>
</script>

<script id="treeRootTemplate" type="text/x-handler-template">
	<table class="table table-bordered">
		<tr data-id={{id}} data-level="{{parentLevel}}">
			<td><span class="label label-info mini">{{type.name}}</span><br/>
				<a href="#" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i>{{name}}</a></td>
			<td style="width:40px;"> </td>
		</tr>
	</table>
</script>

<script id="loadingSpanTemplate" type="text/x-handler-template">
	<span class="loading"> Loading <img src="/eBudgeting/resources/graphics/loading-small.gif"/></span>
</script>
<script id="treeTRTemplate" type="text/x-handler-template">
	<tr data-id={{id}} data-level="{{parentLevel}}">
			<td style="padding-left: {{paddingLevel parentLevel}}px;"><span class="label label-info mini">{{type.name}}</span><br/>
				<a href="#" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i> [{{code}}] {{name}}</a> 
			</td>
				<td>
				{{#if type.unlinkable}}
					<button type="button" class="btn unlink">UnLink</button>
				{{/if}}
				</td>

	</tr>
</script>

<script  id=childrenSltTemplate type="text/x-handler-template">
<div style="padding: 12px;margin-top: {{topPadding}}px; background-color: #FFFFCC; border: 1px solid #DDDDDD;">
	<div class="control">
		<form class="form-search">
				<div class="input-append pull-left">
					<input type="text" id="availableChildrenSearch" class="span2 search-query">
					<button type="submit" id="search" class="btn">Search</button>
				</div> &nbsp;
				<button type="submit" id="searchDisplayAll" class="btn">แสดงผลทั้งหมด</button>
		</form>
	</div>
	<div class="content">
		
	</div>
</div>
</script>


<script  id=availableChildrenTemplate type="text/x-handler-template">
เลือก{{typeName}}เพื่อเชื่อมโยง
<div style="height: 250px;overflow:auto;">
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
<div>
</script>


<script id="mainSelectionTemplate" type="text/x-handler-template">
<form class="form-horizontal">
<div class="control-group"  style="margin-bottom:5px;">
	<label class="control-label">แผนงาน :</label> 
	<div class="controls">
		<select id="type101Slt" class="span5">
			<option>กรุณาเลือก...</option>
			{{#each this}}<option value={{id}}>[{{code}}] {{name}}</option>{{/each}}
		</select>
	</div>
</div>
	<div id="type102Div">
		<div class="control-group"  style="margin-bottom:5px;">
			<label class="control-label">ผลผลิต/โครงการ :</label>
			<div class="controls">
				<select class="span5" disabled="disabled">
					<option>กรุณาเลือก...</option>
				</select>
			</div> 
		</div>	
	</div>
	<div id="type103Div">
		<div class="control-group"  style="margin-bottom:5px;">
			<label class="control-label">กิจกรรมหลัก :</label>
			<div class="controls">
				<select class="span5" disabled="disabled">
					<option>กรุณาเลือก...</option>
				</select>
			</div> 
		</div>

	</div>
</form>
</script>

<script id="selectionTemplate" type="text/x-handler-template">
<div class="control-group"  style="margin-bottom:5px;">
	<label class="control-label">{{type.name}} :</label>
	<div class="controls">
		<select id="type{{type.id}}Slt" class="span5">
			<option>กรุณาเลือก...</option>
			{{#each this}}<option value={{id}}>[{{code}}] {{name}}</option>{{/each}}
		</select>
	</div> 
</div>
</script>

<script id="type102DisabledSelection" type="text/x-handler-template">
		<div class="control-group">
			<label class="control-label">ผลผลิต/โครงการ :</label>
			<div class="controls">
				<select class="span5" disabled="disabled">
					<option>กรุณาเลือก...</option>
				</select>
			</div> 
		</div>
</script>


<script id="type103DisabledSelection" type="text/x-handler-template">
		<div class="control-group">
			<label class="control-label">กิจกรรมหลัก :</label>
			<div class="controls">
				<select class="span5" disabled="disabled">
					<option>กรุณาเลือก...</option>
				</select>
			</div> 
		</div>
</script>


<script type="text/javascript">

var fiscalYear = "${fiscalYear}";
var e1;
var e2;

Handlebars.registerHelper("paddingLevel", function(level) {
	var step = level-4;
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
				
				if(clickunLinkObjective != null) {
					clickunLinkObjective.url = appUrl('/Objective/'+ clickunLinkObjectiveId);
					
					clickunLinkObjective.destroy({wait:true,
						success: function() {
							$(e.target).parents("tr").remove();
						},
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
		
		mainCtrView = new MainCtrView();
		mainCtrView.render();
	}
});
</script>