package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.ObjectiveBudgetProposalDTO;
import biz.thaicom.eBudgeting.models.pln.Objective;

public interface ObjectiveRepository extends PagingAndSortingRepository<Objective, Long>, JpaSpecificationExecutor<Objective>{
	public List<Objective> findByTypeId(Long id);

	public List<Objective> findByParentIdAndFiscalYear(Long id, Integer fiscalYear);

	@Query("" +
			"SELECT objective " +
			"FROM Objective objective " +
			"WHERE objective.parent is null " +
			"")
	public List<Objective> findRootFiscalYear();
	
	
	@Query("" +  
			"SELECT objective, proposal " +
			"FROM BudgetProposal proposal " +
			"	RIGHT OUTER JOIN proposal.owner owner with owner.id = ?2 " +
			"	RIGHT OUTER JOIN proposal.forObjective objective with objective.fiscalYear = ?1 " +
			"WHERE " +
			"	" +
			"	 objective.parent.id = ?3 ")
//	@Query("" +  
//			"SELECT objective, proposal " +
//			"FROM Objective objective" +
//			"	LEFT OUTER JOIN BudgetProposal proposal" +
//			" ")
	public List<ObjectiveBudgetProposalDTO> findByObjectiveBudgetProposal(Integer fiscalYear, Long onwerId, long objectiveId);
}
