package biz.thaicom.eBudgeting.controllers.rest;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import biz.thaicom.eBudgeting.models.bgt.BudgetProposal;

@Controller
public class BudgetProposalRestController {
	
	@RequestMapping("/BudgetProposal/{fiscalYear}/{ownerId}/")
	public List<BudgetProposal> findBudgetProposalByFiscalYearAndOwnerId(
			@PathVariable Integer fiscalYear,
			@PathVariable Long ownerId) {
		
		return null;
	}
	
	
}
