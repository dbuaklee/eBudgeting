package biz.thaicom.eBudgeting.exception;

import java.util.List;

import biz.thaicom.eBudgeting.models.bgt.BudgetProposal;

public class ObjectiveHasBudgetProposalException extends Exception {
	/**
	 * 
	 */
	private static final long serialVersionUID = 8891435932418377739L;
	
	private List<BudgetProposal> proposals;
	
	public ObjectiveHasBudgetProposalException(List<BudgetProposal> proposals) {
		this.proposals = proposals;
	}

	public List<BudgetProposal> getProposals() {
		return proposals;
	}

	public void setProposals(List<BudgetProposal> proposals) {
		this.proposals = proposals;
	}
	
	public String toString() {
		return "มีการตั้งงบประมาณสำหรับกิจกรรมนี้แล้ว";
	}
	
}
