package biz.thaicom.eBudgeting.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.thaicom.eBudgeting.dao.BgtDao;
import biz.thaicom.eBudgeting.repositories.DatabaseSchemaExport;

@Controller
public class adminController {
	@Autowired
	private DatabaseSchemaExport databaseSchemaExport;
	
	@Autowired
	private BgtDao bgtDao;
	
	@RequestMapping("/admin/") 
	public String adminLandingPage(Model model) {
		model.addAttribute("adminPage", true);
		return "admin/home";
	}
	
	@RequestMapping("/admin/newDatabaseSchema") 
	public @ResponseBody String newDatabaseSchema() {
		databaseSchemaExport.getSchema();
		
		// now we want to populate data into database?
		
		
		return "success";
	}
	
	@RequestMapping("/admin/populateSampleData")
	public @ResponseBody String populateSampleData() {
		bgtDao.executeFromFile();
		
		return "success";
		
	}
	

}
