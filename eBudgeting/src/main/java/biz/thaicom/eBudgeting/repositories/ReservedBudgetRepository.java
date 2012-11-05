package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.bgt.ReservedBudget;
import biz.thaicom.eBudgeting.models.pln.Objective;

public interface ReservedBudgetRepository extends JpaSpecificationExecutor<ReservedBudget>,
		PagingAndSortingRepository<ReservedBudget, Long> {

	
	@Query("" +
			"SELECT reservedBudget " +
			"FROM ReservedBudget reservedBudget " +
			"WHERE reservedBudget.budgetType = ?1 and reservedBudget.forObjective = ?2 ")
	ReservedBudget findOneByBudgetTypeAndObjective(BudgetType budgetType,
			Objective forObjective);

	@Query("" +
			"SELECT reservedBudget " +
			"FROM ReservedBudget reservedBudget " +
			"WHERE reservedBudget.forObjective.fiscalYear = ?1 AND reservedBudget.forObjective.parentPath like ?2 ")
	List<ReservedBudget> findAllByFiscalYearAndParentPathLike(Integer fiscalYear,
			String parentPathLikeString);

	@Query("" +
			"SELECT reservedBudget " +
			"FROM ReservedBudget reservedBudget " +
			"WHERE reservedBudget.forObjective = ?1 and reservedBudget.budgetType = ?2 ")
	List<ReservedBudget> findAllByForObjectiveAndBudgetType(Objective objective, BudgetType budgetType);
	
	@Query("" +
			"SELECT reservedBudget " +
			"FROM ReservedBudget reservedBudget " +
			"WHERE reservedBudget.forObjective.id in (?1) and reservedBudget.budgetType = ?2 ")
	List<ReservedBudget> findAllByObjetiveIds(List<Long> objectiveIds, BudgetType budgetType);
		
}
