package biz.thaicom.eBudgeting.controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Stack;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.HandlerMapping;

import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.pln.Objective;
import biz.thaicom.eBudgeting.models.webui.Breadcrumb;
import biz.thaicom.eBudgeting.services.EntityService;

@Controller
public class GenericViewController {

	public static Logger logger = LoggerFactory.getLogger(GenericViewController.class);
	
	private static final String webAppcontext = "eBudgeting";
	
	@Autowired
	private EntityService entityService;
	
	@RequestMapping("/jsp/{jspName}")
	public String renderJsp(@PathVariable String jspName) {
		
		return jspName;
	}
	
	@RequestMapping("/page/m2f13/")
	public String render_m2f13_fiscalYear(Model model) {
		prepareRootPage(model);
		
		return "m2f13";
	}
	
	private void prepareRootPage(Model model) {
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		
	}

	@RequestMapping("/page/m2f13/{fiscalYear}/{budgetTypeId}")
	public String render_m2f13(Model model, HttpServletRequest request,
			@PathVariable Integer fiscalYear,
			@PathVariable Long budgetTypeId) { 
		
		logger.debug("fiscalYear = {}, budgetTypeId = {}", fiscalYear, budgetTypeId);
		
		if(budgetTypeId == null) 
			budgetTypeId = 0L;
		
		// now we just get the hold of this budgetType
		BudgetType budgetType = entityService.findBudgetTypeById(budgetTypeId);
		
		if(budgetType != null) {
			logger.debug("BudgetType found!");
			
			model.addAttribute("budgetType", budgetType);
			// now construct breadcrumb?
			
			List<Breadcrumb> breadcrumb = entityService.createBreadCrumbBudgetType("/page/m2f13", fiscalYear, budgetType); 
			
			model.addAttribute("breadcrumb", breadcrumb.listIterator());
			model.addAttribute("rootPage", false);
			model.addAttribute("budgetType", budgetType);
			
		} else {
			logger.debug("BudgetType NOT found! redirect to fiscal year selection");
			// go to the root one!
			return "redirect:/page/m2f13/";
		}
		
		return "m2f13";
	}
	
	@RequestMapping("/page/m2f06/**")
	public String render_m2f06(Model model, HttpServletRequest request) {
		String pattern = (String)
		        request.getAttribute(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE); 
		
		String searchTerm = new AntPathMatcher().extractPathWithinPattern(pattern, 
		        request.getServletPath());

		String url = webAppcontext +  "/page/m2f06/";
		List<Map<String,String>> breadcrumb = new ArrayList<Map<String,String>>();
		
		logger.debug(searchTerm);
		if(searchTerm == null || searchTerm.length()==0) {
			model.addAttribute("url", "/eBudgeting/Objective/root");
			model.addAttribute("ROOT", true);
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("url", url);
			map.put("value", "ROOT");
			breadcrumb.add(map);
			model.addAttribute("breadcrumb", breadcrumb);
		} else {
			// now tokenized the string
			StringTokenizer token = new StringTokenizer(searchTerm,"/");
			List<String> items = new ArrayList<String>();
			while(token.hasMoreTokens()){
				items.add(token.nextToken());
			}
			
			if(items.size() == 1) {
				// first part is year
				model.addAttribute("url", "/eBudgeting/Objective/root/"+items.get(0));
			} else {
				model.addAttribute("url", "/eBudgeting/Objective/"+items.get(items.size()-1)+"/children");
				model.addAttribute("lastObjectiveId", items.get(items.size()-1));
				// now we need all parents of this object
				
			}
			
			Objective objective = null;
			
			// here we recontruct the breadcrumb
			for(int i=0; i<items.size(); i++) {
				
				HashMap<String, String> map = new HashMap<String, String>();
				
				if(i > 0) {
					url = url  + items.get(i) + "/";
					map.put("url", url);
					int index = objective.getIndex()+1;
					map.put("value", objective.getType().getName() + "ที่  " + index);
					breadcrumb.add(map);
					
				} else {
					map.put("url", url);
					map.put("value", "ROOT");
					breadcrumb.add(map);
					
					map = new HashMap<String, String>();
					url = url + items.get(i) + "/";
					map.put("url", url);
					map.put("value", items.get(i));
					breadcrumb.add(map);

				}
				
				if(i+1 < items.size()) {
					// do this if it's not the last one
					Long nextId = null;
					try {
						nextId = Long.parseLong(items.get(i+1));
					} catch (NumberFormatException e) {
						// we should just failed here! 
					}
					
					objective = entityService.findOjectiveById(nextId);
				}
				
				
			}
			model.addAttribute("breadcrumb", breadcrumb);
		}
		
		model.addAttribute("currentPath", url);
		return "m2f06";
	}
	
	
	@RequestMapping("/page/m2f11/")
	public String runder_m2f11(
			Model model, HttpServletRequest request) {
		
		prepareRootPage(model);
		
		return "m2f11";
	}
	
	@RequestMapping("/page/m2f11/{fiscalYear}")
	public String runder_m2f11OfYear(
			@PathVariable Integer fiscalYear,
			Model model, HttpServletRequest request) {
		
		if(fiscalYear == null) {
			logger.debug("make year selection!");
		}
		
		return "m2f11";
	}
	
	@RequestMapping("/page/m2f12/")
	public String runder_m2f12(
			Model model, HttpServletRequest request) {
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		return "m2f12";
	}
	
	@RequestMapping("/page/m2f12/{fiscalYear}/{objectiveId}")
	public String runder_m2f12OfYear(
			@PathVariable Integer fiscalYear,
			@PathVariable Long objectiveId,
			Model model, HttpServletRequest request) {
		
		logger.debug("fiscalYear = {}, objectiveId = {}", fiscalYear, objectiveId);
		
		// now find the one we're looking for
		Objective objective = entityService.findOjectiveById(objectiveId);
		
		if(objective != null) {
			logger.debug("Objective found!");
			
			model.addAttribute("objective", objective);
			// now construct breadcrumb?
			
			List<Breadcrumb> breadcrumb = entityService.createBreadCrumbObjective("/page/m2f12", fiscalYear, objective); 
			
			model.addAttribute("breadcrumb", breadcrumb.listIterator());
			model.addAttribute("rootPage", false);
			model.addAttribute("objective", objective);
			
		} else {
			logger.debug("Objective NOT found! redirect to fiscal year selection");
			// go to the root one!
			return "redirect:/page/m2f12/";
		}
		
		return "m2f12";
	}

}

