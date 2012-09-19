<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="row">
	<div class="span12">
		<div id="mainCtr">
		</div>
		
		<div id="mainfrm">
		
		</div>
	</div>
</div>

<script id="mainCtrTemplate" type="text/x-handler-template">
<table class="table table-bordered" id="mainTbl" style="margin-bottom:0px; width:900px; table-layout:fixed;">
	<thead>
		<tr>
			<td width="400"><strong>แผนงาน/กิจกรรม ประจำปี {{this.0.fiscalYear}}</strong></td>
			<td width="80">งบบุคลากร</td>
			<td width="80">งบดำเนินงาน</td>
			<td width="80">งบลงทุน</td>
			<td width="80">งบอุดหนุน</td>
			<td width="80">งบรายจ่ายอื่น</td>
		</tr>
	</thead>
</table>
<div style="height: 200px; overflow: auto; width:930px">
<table class="table table-bordered" id="mainTbl" style="width:900px; table-layout:fixed;">
	<tbody>
		{{{childrenNodeTpl this 0}}}
	</tbody>
</table>
</div>
</script>

<script id="childrenNodeTemplate" type="text/x-handler-template">
	<tr data-level="{{this.level}}" data-index="{{this.id}}">
		<td width="400" style="padding-left:{{this.padding}}px;">
			<span>
					<input class="checkbox_tree bullet" type="checkbox" id="bullet_{{this.id}}"/>
					<label class="expand" for="bullet_{{this.id}}"><img width=5 height=5 src="/eBudgeting/resources/graphics/1pixel.png"/></label>
					<input class="checkbox_tree" type="checkbox" id="item_{{this.id}}"/>
					<label class="main" for="item_{{this.id}}">{{this.type.name}} {{this.name}}</label>
			</span> 
		</td>
			<td width="80">0.00 <a href="#" class="btn btn-mini">+</a> <a href="#" class="btn btn-mini">-</a></td>
			<td width="80">0.00</td>
			<td width="80">0.00</td>
			<td width="80">0.00</td>
			<td width="80">0.00</td>
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
</table>
<div style="height: 200px; overflow: auto; width:100%;">
<table class="table table-bordered" id="mainTbl">
<table>
	<tbody>
		<tr>
			<td>{{this}} <a href="./{{this}}/" class="nextChildrenLnk"><i class="icon icon-chevron-right nextChildrenLnk"></i> </a></td>
		</tr>
	</tbody>
</table>
</div>
</script>

<script id="mainfrmTemplate" type="text/x-handler-template">
<br/>
<hr/>
{{this.type.name}} - {{this.name}}
<h4>กรุณากรอกข้อมูลงบประมาณ</h4>


<input type="text"></input> บาท
</script>


<script type="text/javascript">
var pageUrl = "/page/m2f12/";
var mainTblView  = null;
var objectiveCollection = null;
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
			"click input[type=checkbox].bullet" : "toggle",
			"click tr" : "showForm"
		},
		
		toggle: function(e) {
			l=e;
			var clickLevel = $(l.target).parents('tr').attr('data-level');
			$(l.target).next('label').toggleClass("expand collapse");
			
			var currentTr = $(l.target).parents('tr');
			
			
			currentTr.nextUntil('tr[data-level='+clickLevel+']').toggle();
		},
		
		showForm: function(e) {
			mainFrmTpl = Handlebars.compile($("#mainfrmTemplate").html())
			var collectionIdx = $(e.target).parents('tr').attr('data-index')
			
			var objective = new Objective();
			objective.url=appUrl('/Objective/' + collectionIdx);
			objective.fetch();
			
			l=objective;
			$('#mainfrm').html(mainFrmTpl(objective.toJSON()));
		}
		
	});
	
	objectiveCollection = new ObjectiveCollection();
	objectiveCollection.url = appUrl("/Objective/rootEager");
	
	mainTblView = new MainTblView({collection: objectiveCollection});
	
	//now if this is root url
	if(location.pathname == myApiUrl +pageUrl ) {
		// this is the root now
		// now we'll load root one onto this mainTbl
		$.get(appUrl("/Objective/root/"), function(data) {
			var t = Handlebars.compile($("#rootMainCtrTemplate").html());
			$('#mainCtr').html(t(data));
		});
	} else {
		pathArray = location.pathname.split('/').slice(1,-1);
		objectiveCollection.url=appUrl("/Objective/rootEager/" + pathArray[pathArray.length-1] );
		
		//now we can just fetch and render...
		objectiveCollection.fetch();
		
		
		
	}
	
	
	
	
});
</script>