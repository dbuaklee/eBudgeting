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
import biz.thaicom.eBudgeting.models.pln.ObjectiveTarget;
import biz.thaicom.eBudgeting.models.pln.TargetUnit;
import biz.thaicom.eBudgeting.models.webui.Breadcrumb;
import biz.thaicom.eBudgeting.services.EntityService;
import biz.thaicom.security.models.Activeuser;
import biz.thaicom.security.models.ThaicomUserDetail;

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
	

	
//	@RequestMapping("/page/m2f06/**")
//	public String render_m2f06(Model model, HttpServletRequest request) {
//		String pattern = (String)
//		        request.getAttribute(HandlerMapping.BEST_MATCHING_PATTERN_ATTRIBUTE); 
//		
//		String searchTerm = new AntPathMatcher().extractPathWithinPattern(pattern, 
//		        request.getServletPath());
//
//		String url = webAppcontext +  "/page/m2f06/";
//		List<Map<String,String>> breadcrumb = new ArrayList<Map<String,String>>();
//		
//		logger.debug(searchTerm);
//		if(searchTerm == null || searchTerm.length()==0) {
//			model.addAttribute("url", "/eBudgeting/Objective/root");
//			model.addAttribute("ROOT", true);
//			HashMap<String, String> map = new HashMap<String, String>();
//			map.put("url", url);
//			map.put("value", "ROOT");
//			breadcrumb.add(map);
//			model.addAttribute("breadcrumb", breadcrumb);
//		} else {
//			// now tokenized the string
//			StringTokenizer token = new StringTokenizer(searchTerm,"/");
//			List<String> items = new ArrayList<String>();
//			while(token.hasMoreTokens()){
//				items.add(token.nextToken());
//			}
//			
//			if(items.size() == 1) {
//				// first part is year
//				model.addAttribute("url", "/eBudgeting/Objective/root/"+items.get(0));
//			} else {
//				model.addAttribute("url", "/eBudgeting/Objective/"+items.get(items.size()-1)+"/children");
//				model.addAttribute("lastObjectiveId", items.get(items.size()-1));
//				// now we need all parents of this object
//				
//			}
//			
//			Objective objective = null;
//			
//			// here we recontruct the breadcrumb
//			for(int i=0; i<items.size(); i++) {
//				
//				HashMap<String, String> map = new HashMap<String, String>();
//				
//				if(i > 0) {
//					url = url  + items.get(i) + "/";
//					map.put("url", url);
//					int index = objective.getIndex()+1;
//					map.put("value", objective.getType().getName() + "ที่  " + index);
//					breadcrumb.add(map);
//					
//				} else {
//					map.put("url", url);
//					map.put("value", "ROOT");
//					breadcrumb.add(map);
//					
//					map = new HashMap<String, String>();
//					url = url + items.get(i) + "/";
//					map.put("url", url);
//					map.put("value", items.get(i));
//					breadcrumb.add(map);
//
//				}
//				
//				if(i+1 < items.size()) {
//					// do this if it's not the last one
//					Long nextId = null;
//					try {
//						nextId = Long.parseLong(items.get(i+1));
//					} catch (NumberFormatException e) {
//						// we should just failed here! 
//					}
//					
//					objective = entityService.findOjectiveById(nextId);
//				}
//				
//				
//			}
//			model.addAttribute("breadcrumb", breadcrumb);
//		}
//		
//		model.addAttribute("currentPath", url);
//		return "m2f06";
//	}
	
	
	@RequestMapping("/page/m2f11/")
	public String runder_m2f11(
			Model model, HttpServletRequest request) {
		
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		
		return "m2f11";
	}
	
	@RequestMapping("/page/m2f11/{fiscalYear}/{objectiveId}")
	public String runder_m2f11OfYear(
			@PathVariable Integer fiscalYear,
			@PathVariable Long objectiveId,
			Model model, HttpServletRequest request) {
		
		logger.debug("fiscalYear = {}, objectiveId = {}", fiscalYear, objectiveId);
		
		// now find the one we're looking for
		Objective objective = entityService.findOjectiveById(objectiveId);
		if(objective != null ) {
			logger.debug("Objective found!");
			
			model.addAttribute("objective", objective);
			// now construct breadcrumb?
			
			List<Breadcrumb> breadcrumb = entityService.createBreadCrumbObjective("/page/m2f11", fiscalYear, objective); 
			
			model.addAttribute("breadcrumb", breadcrumb.listIterator());
			model.addAttribute("rootPage", false);
			model.addAttribute("objective", objective);
			
		} else {
			logger.debug("Objective NOT found! redirect to fiscal year selection");
			// go to the root one!
			return "redirect:/page/m2f11/";
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
	public String render_m2f12OfYear(
			@PathVariable Integer fiscalYear,
			@PathVariable Long objectiveId,
			Model model, HttpServletRequest request,
			@Activeuser ThaicomUserDetail currentUser) {
		
		logger.debug("fiscalYear = {}, objectiveId = {}", fiscalYear, objectiveId);
		
		// now find the one we're looking for
		Objective objective = entityService.findOjectiveById(objectiveId);
		if(objective != null ) {
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
	
	
	@RequestMapping("/page/m3f01/")
	public String runder_m3f01(
			Model model, HttpServletRequest request) {
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		return "m3f01";
	}
	
	@RequestMapping("/page/m3f01/{fiscalYear}/{objectiveId}")
	public String render_m3f01OfYear(
			@PathVariable Integer fiscalYear,
			@PathVariable Long objectiveId,
			Model model, HttpServletRequest request) {
		
		logger.debug("fiscalYear = {}, objectiveId = {}", fiscalYear, objectiveId);
		
		// now find the one we're looking for
		Objective objective = entityService.findOjectiveById(objectiveId);
		if(objective != null ) {
			logger.debug("Objective found!");
			
			model.addAttribute("objective", objective);
			// now construct breadcrumb?
			
			List<Breadcrumb> breadcrumb = entityService.createBreadCrumbObjective("/page/m2f06", fiscalYear, objective); 
			
			model.addAttribute("breadcrumb", breadcrumb.listIterator());
			model.addAttribute("rootPage", false);
			model.addAttribute("objective", objective);
			
		} else {
			logger.debug("Objective NOT found! redirect to fiscal year selection");
			// go to the root one!
			return "redirect:/page/m3f01/";
		}
		
		return "m3f01";
	}
	
	@RequestMapping("/page/m3f02/")
	public String render_m3f02(
			Model model, HttpServletRequest request) {
		
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		logger.debug("htt");
		return "m3f02";
	}
	
	@RequestMapping("/page/m3f02/{fiscalYear}/{objectiveId}")
	public String render_m3f02OfYear(
			@PathVariable Integer fiscalYear,
			@PathVariable Long objectiveId,
			Model model, HttpServletRequest request) {
		
		logger.debug("fiscalYear = {}, objectiveId = {}", fiscalYear, objectiveId);
		
		// now find the one we're looking for
		Objective objective = entityService.findOjectiveById(objectiveId);
		if(objective != null ) {
			logger.debug("Objective found!");
			
			model.addAttribute("objective", objective);
			// now construct breadcrumb?
			
			List<Breadcrumb> breadcrumb = entityService.createBreadCrumbObjective("/page/m3f02", fiscalYear, objective); 
			
			model.addAttribute("breadcrumb", breadcrumb.listIterator());
			model.addAttribute("rootPage", false);
			model.addAttribute("objective", objective);
			
		} else {
			logger.debug("Objective NOT found! redirect to fiscal year selection");
			// go to the root one!
			return "redirect:/page/m3f02/";
		}
		
		return "m3f02";
	}
	
	@RequestMapping("/page/m3f03/")
	public String render_m3f03(
			Model model, HttpServletRequest request) {
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		return "m3f03";
	}
	
	@RequestMapping("/page/m3f03/{fiscalYear}/{objectiveId}")
	public String render_m3f03OfYear(
			@PathVariable Integer fiscalYear,
			@PathVariable Long objectiveId,
			Model model, HttpServletRequest request) {
		
		logger.debug("fiscalYear = {}, objectiveId = {}", fiscalYear, objectiveId);
		
		// now find the one we're looking for
		Objective objective = entityService.findOjectiveById(objectiveId);
		if(objective != null ) {
			logger.debug("Objective found!");
			
			model.addAttribute("objective", objective);
			// now construct breadcrumb?
			
			List<Breadcrumb> breadcrumb = entityService.createBreadCrumbObjective("/page/m3f03", fiscalYear, objective); 
			
			model.addAttribute("breadcrumb", breadcrumb.listIterator());
			model.addAttribute("rootPage", false);
			model.addAttribute("objective", objective);
			
		} else {
			logger.debug("Objective NOT found! redirect to fiscal year selection");
			// go to the root one!
			return "redirect:/page/m3f01/";
		}
		
		return "m3f03";
	}
	
	
	@RequestMapping("/page/m2f06/")
	public String runder_m2f06(
			Model model, HttpServletRequest request) {
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		return "m2f06";
	}
	
	@RequestMapping("/page/m2f06/{fiscalYear}/{objectiveId}")
	public String render_m2f06OfYear(
			@PathVariable Integer fiscalYear,
			@PathVariable Long objectiveId,
			Model model, HttpServletRequest request) {
		
		logger.debug("fiscalYear = {}, objectiveId = {}", fiscalYear, objectiveId);
		
		// now find the one we're looking for
		Objective objective = entityService.findOjectiveById(objectiveId);
		if(objective != null ) {
			logger.debug("Objective found!");
			
			model.addAttribute("objective", objective);
			// now construct breadcrumb?
			
			List<Breadcrumb> breadcrumb = entityService.createBreadCrumbObjective("/page/m2f06", fiscalYear, objective); 
			
			model.addAttribute("breadcrumb", breadcrumb.listIterator());
			model.addAttribute("rootPage", false);
			model.addAttribute("objective", objective);
			
		} else {
			logger.debug("Objective NOT found! redirect to fiscal year selection");
			// go to the root one!
			return "redirect:/page/m2f06/";
		}
		
		return "m2f06";
	}
	
	@RequestMapping("/page/m1f05/")
	public String runder_m1f05(
			Model model, HttpServletRequest request) {
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		return "m1f05";
	}

	@RequestMapping("/page/m3f04/")
	public String runder_m3f04(
			Model model, HttpServletRequest request) {
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		return "m3f04";
	}
	
	@RequestMapping("/page/m3f05/")
	public String runder_m3f05(
			Model model, HttpServletRequest request) {
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		return "m3f05";
	}
	
	@RequestMapping("/page/m3f06/")
	public String runder_m3f06(
			Model model, HttpServletRequest request) {
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		return "m3f06";
	}
	
	@RequestMapping("/page/m4f01/")
	public String runder_m4f01(
			Model model, HttpServletRequest request) {
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		return "m4f01";
	}
	
	@RequestMapping("/page/m4f02/")
	public String runder_m4f02(
			Model model, HttpServletRequest request) {
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		return "m4f02";
	}
	
	@RequestMapping("/page/m4f02/{fiscalYear}/{objectiveId}")
	public String render_m4f02OfYear(
			@PathVariable Integer fiscalYear,
			@PathVariable Long objectiveId,
			Model model, HttpServletRequest request) {
		
		logger.debug("fiscalYear = {}, objectiveId = {}", fiscalYear, objectiveId);
		
		// now find the one we're looking for
		Objective objective = entityService.findOjectiveById(objectiveId);
		if(objective != null ) {
			logger.debug("Objective found!");
			
			model.addAttribute("objective", objective);
			// now construct breadcrumb?
			
			List<Breadcrumb> breadcrumb = entityService.createBreadCrumbObjective("/page/m4f02", fiscalYear, objective); 
			
			model.addAttribute("breadcrumb", breadcrumb.listIterator());
			model.addAttribute("rootPage", false);
			model.addAttribute("objective", objective);
			
		} else {
			logger.debug("Objective NOT found! redirect to fiscal year selection");
			// go to the root one!
			return "redirect:/page/m4f02/";
		}
		
		return "m4f02";
	}
	
	@RequestMapping("/page/m1f03/")
	public String render_m1f03(
			Model model, HttpServletRequest request) {
		List<TargetUnit> targetUnits = entityService.findAllTargetUnits();		
		model.addAttribute("rootPage", true);
		model.addAttribute("targetUnits", targetUnits);
		return "m1f03";
	}
	
	@RequestMapping("/page/m2f14/")
	public String render_m2f14(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		return "m2f14";
	}
	
	@RequestMapping("/page/m2f14/{fiscalYear}/")
	public String render_m2f14WithFiscalYear(
			@PathVariable Integer fiscalYear,
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		
		return "m2f14";
	}
	
	




	@RequestMapping("/page/m51f01/")
	public String render_m51f01(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 109);
		return "m51f01";
	}
	
	@RequestMapping("/page/m51f01/{fiscalYear}")
	public String render_m51f01(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 109);
		return "m51f01";
	}
	
	@RequestMapping("/page/m51f02/")
	public String render_m51f02(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 121);
		return "m51f02";
	}
	
	@RequestMapping("/page/m51f02/{fiscalYear}")
	public String render_m51f02(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 121);
		return "m51f02";
	}
	
	@RequestMapping("/page/m51f03/")
	public String render_m51f03(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 110);
		return "m51f03";
	}
	
	@RequestMapping("/page/m51f03/{fiscalYear}")
	public String render_m51f03(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 110);
		return "m51f03";
	}
	
	
	@RequestMapping("/page/m51f04/")
	public String render_m51f04(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 111);
		return "m51f04";
	}
	
	@RequestMapping("/page/m51f04/{fiscalYear}")
	public String render_m51f04(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 111);
		return "m51f04";
	}
	
	@RequestMapping("/page/m51f05/")
	public String render_m51f05(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 112);
		return "m51f05";
	}
	
	@RequestMapping("/page/m51f05/{fiscalYear}")
	public String render_m51f05(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 112);
		return "m51f05";
	}

	@RequestMapping("/page/m51f06/")
	public String render_m51f06(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 101);
		return "m51f06";
	}
	
	@RequestMapping("/page/m51f06/{fiscalYear}")
	public String render_m51f06(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 101);
		return "m51f06";
	}
	
	@RequestMapping("/page/m51f07/")
	public String render_m51f07(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 102);
		return "m51f07";
	}
	
	@RequestMapping("/page/m51f07/{fiscalYear}")
	public String render_m51f07(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 102);
		return "m51f07";
	}

	@RequestMapping("/page/m51f08/")
	public String render_m51f08(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 103);
		return "m51f08";
	}
	
	@RequestMapping("/page/m51f08/{fiscalYear}")
	public String render_m51f08(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 103);
		return "m51f08";
	}
	
	@RequestMapping("/page/m52f01/")
	public String render_m52f01(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 113);
		return "m52f01";
	}
	
	@RequestMapping("/page/m52f01/{fiscalYear}")
	public String render_m52f01(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 113);
		return "m52f01";
	}
	
	
	@RequestMapping("/page/m53f01/")
	public String render_m53f01(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 114);
		return "m53f01";
	}
	
	@RequestMapping("/page/m53f01/{fiscalYear}")
	public String render_m53f01(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 114);
		return "m53f01";
	}
	
	@RequestMapping("/page/m53f02/")
	public String render_m53f02(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 115);
		return "m53f02";
	}
	
	@RequestMapping("/page/m53f02/{fiscalYear}")
	public String render_m53f02(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 115);
		return "m53f02";
	}
	
	@RequestMapping("/page/m53f03/")
	public String render_m53f03(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 116);
		return "m53f03";
	}
	
	@RequestMapping("/page/m53f03/{fiscalYear}")
	public String render_m53f03(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 116);
		return "m53f03";
	}
	@RequestMapping("/page/m54f01/")
	public String render_m54f01(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 118);
		return "m54f01";
	}
	
	@RequestMapping("/page/m54f01/{fiscalYear}")
	public String render_m54f01(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 118);
		return "m54f01";
	}
	@RequestMapping("/page/m55f01/")
	public String render_m55f01(
			Model model, HttpServletRequest request) {
		model.addAttribute("rootPage", true);
		List<Objective> fiscalYears = entityService.findRootFiscalYear();		
		model.addAttribute("rootPage", true);
		model.addAttribute("fiscalYears", fiscalYears);
		model.addAttribute("typeId", 119);
		return "m55f01";
	}
	
	@RequestMapping("/page/m55f01/{fiscalYear}")
	public String render_m55f01(
			Model model, @PathVariable Integer fiscalYear,
			HttpServletRequest request) {

				
		model.addAttribute("rootPage", false);
		model.addAttribute("fiscalYear", fiscalYear);
		model.addAttribute("typeId", 119);
		return "m55f01";
	}

}


