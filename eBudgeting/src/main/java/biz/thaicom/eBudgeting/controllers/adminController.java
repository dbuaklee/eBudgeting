package biz.thaicom.eBudgeting.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.thaicom.eBudgeting.repositories.DatabaseSchemaExport;

@Controller
public class adminController {
	@Autowired
	private DatabaseSchemaExport databaseSchemaExport;
	
	@RequestMapping("/admin/databaseSchemaExport") 
	public @ResponseBody String databaseSchemaExport() {
		databaseSchemaExport.getSchema();
		
		return "success";
	}
	

}
