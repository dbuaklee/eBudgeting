package biz.thaicom.eBudgeting.view;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import biz.thaicom.eBudgeting.model.bgt.Objective;
import biz.thaicom.eBudgeting.services.ObjectiveService;

@Controller
public class MockUpDataController {
public static Logger logger = LoggerFactory.getLogger(GenericViewController.class);

	@Autowired
	private ObjectiveService objectiveService;

	@RequestMapping("/Objective/{id}/Children")
	public List<Objective> renderJsp(@PathVariable Long id) {
		
		return objectiveService.findObjectiveChildrenByObjectiveId(id);
	}
	
}
