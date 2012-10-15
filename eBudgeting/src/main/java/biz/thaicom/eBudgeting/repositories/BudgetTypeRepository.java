package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetType;

public interface BudgetTypeRepository extends
		PagingAndSortingRepository<BudgetType, Long>, JpaSpecificationExecutor<BudgetType> {

	@Query("FROM BudgetType " +
			"WHERE parent is null ")
	List<BudgetType> findRootBudgetType();

	@Query("SELECT DISTINCT budgetType.fiscalYear " +
			"FROM BudgetType budgetType " +
			"ORDER BY budgetType.fiscalYear asc")
	List<Integer> findFiscalYears();

}
