<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
	<div class="span12">
		<div id="mainCtr">
		</div>
	</div>
</div>

<script id="mainCtrTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td><strong>โครงสร้างแผนงาน ประจำปี {{this.0.fiscalYear}}</strong></td>
		</tr>
	</thead>
	<tbody>
		<tr data-level="1">
			<td style="padding-left:12px;"><span>
					<input class="checkbox_tree bullet" type="checkbox" id="bullet_{{this.0.id}}"/>
					<label class="expand" for="bullet_{{this.0.id}}"><img width=5 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/></label>
					<input class="checkbox_tree" type="checkbox" id="item_{{this.0.id}}"/>
					<label class="main" for="item_{{this.0.id}}">{{this.0.name}}</label>
				</span>
			</td>
		</tr>
		{{{childrenNodeTpl this.0.children 1}}}
	</tbody>
</table>
</script>

<script id="childrenNodeTemplate" type="text/x-handler-template">
	<tr data-level="{{this.level}}">
		<td style="padding-left:{{this.padding}}px;">
			<span>
					<input class="checkbox_tree bullet" type="checkbox" id="bullet_{{this.id}}"/>
					<label class="expand" for="bullet_{{this.id}}"><img width=5 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/></label>
					<input class="checkbox_tree" type="checkbox" id="item_{{this.id}}"/>
					<label class="main" for="item_{{this.id}}">{{this.name}}</label>
			</span> 
		</td>
	</tr>
	{{{childrenNodeTpl this.children this.level}}}
</script>

<script id="rootMainCtrTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="mainTbl">
	<thead>
		<tr>
			<td>เลือกปีงบประมาณ</td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>{{this}} <a href="./{{this}}/" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
		</tr>
	</tbody>
</table>
</script>


<script type="text/javascript">
var pageUrl = "/page/m2f11/";
var mainTblView  = null;
var objectiveTypeCollection = null;
var l = null;



Handlebars.registerHelper('childrenNodeTpl', function(children, level) {
	  var out = '';
	  var childNodeTpl = Handlebars.compile($("#childrenNodeTemplate").html());
	  if(level==undefined) level=0;
	  if(children != null && children.length > 0) {
	  	children.forEach(function(child){
	  		child["level"] = level+1;
	  		child["padding"] = (parseInt(level)+1) * 12;
	    	out = out + childNodeTpl(child);
	  	});
	  }

	  return out;
});

$(document).ready(function() {
	
	var MainTblView = Backbone.View.extend({
		initialize: function(){
		    this.collection.bind('reset', this.render, this);
		},

		el: "#mainCtr",
		mainTblTpl : Handlebars.compile($("#mainCtrTemplate").html()),
		
		render: function() {
			this.$el.html(this.mainTblTpl(this.collection.toJSON()));
		},
		
		events: {
			"click input[type=checkbox].bullet" : "toggle"
		},
		
		toggle: function(e) {
			l=e;
			var clickLevel = $(l.target).parents('tr').attr('data-level');
			$(l.target).next('label').toggleClass("expand collapse");
			
			var currentTr = $(l.target).parents('tr');
			
			
			currentTr.nextUntil('tr[data-level='+clickLevel+']').toggle();
		}
		
	});
	
	objectiveTypeCollection = new ObjectiveTypeCollection();
	objectiveTypeCollection.url = appUrl("/ObjectiveType/root");
	
	mainTblView = new MainTblView({collection: objectiveTypeCollection});
	
	//now if this is root url
	if(location.pathname == myApiUrl +pageUrl ) {
		// this is the root now
		// now we'll load root one onto this mainTbl
		$.get(appUrl("/ObjectiveType/root/"), function(data) {
			var t = Handlebars.compile($("#rootMainCtrTemplate").html());
			$('#mainCtr').html(t(data));
		});
	} else {
		pathArray = location.pathname.split('/').slice(1,-1);
		objectiveTypeCollection.url=appUrl("/ObjectiveType/root/" + pathArray[pathArray.length-1] );
		
		//now we can just fetch and render...
		objectiveTypeCollection.fetch();
		
		
		
	}
	
	
	
	
});
</script>