package biz.thaicom.eBudgeting.models.bgt;

import java.io.Serializable;

import biz.thaicom.eBudgeting.models.pln.Objective;

public class ObjectiveBudgetProposalDTO implements Serializable {

	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 8411191545523871320L;
	
	private Objective	objective;
	
	private BudgetProposal budgetProposal;
	
	public Objective getObjective() {
		return objective;
	}
	public void setObjective(Objective objective) {
		this.objective = objective;
	}
	public BudgetProposal getBudgetProposal() {
		return budgetProposal;
	}
	public void setBudgetProposal(BudgetProposal budgetProposal) {
		this.budgetProposal = budgetProposal;
	}
	
	
	
	
}
