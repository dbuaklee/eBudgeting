package biz.thaicom.eBudgeting.controllers.rest;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import biz.thaicom.eBudgeting.models.webui.PageUI;
import biz.thaicom.eBudgeting.services.EntityService;
import biz.thaicom.security.models.User;

@Controller
public class UserRestController {
	private static final Logger logger = LoggerFactory.getLogger(UserRestController.class);
	
	
	@Autowired
	private EntityService entityService;
	
	@RequestMapping(value="/User/page/{pageNumber}") 
	public @ResponseBody Page<User> getPagedObjectiveByFiscalYearAndType(
			@PathVariable Integer pageNumber) {
		PageRequest pageRequest =
	            new PageRequest(pageNumber - 1, PageUI.PAGE_SIZE, Sort.Direction.ASC, "username");
		
		return entityService.findUser(pageRequest);
	}
	
	
}
