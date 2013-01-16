package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.bgt.FiscalBudgetType;

public interface FiscalBudgetTypeRepository extends
		JpaSpecificationExecutor<FiscalBudgetType>, PagingAndSortingRepository<FiscalBudgetType, Long> {

	
	@Query("" +
			"SELECT fbt.budgetType " +
			"FROM FiscalBudgetType fbt " +
			"WHERE fbt.fiscalYear = ?1 AND fbt.isMainType = true " +
			"ORDER BY fbt.budgetType.lineNumber")
	public List<BudgetType> findAllMainBudgetTypeByFiscalYear(Integer fiscalYear);

	
	public FiscalBudgetType findOneByBudgetTypeAndFiscalYear(BudgetType type,
			Integer fiscalYear);


	@Query("" +
			"SELECT fbt " +
			"FROM FiscalBudgetType fbt " +
			"	INNER JOIN FETCH fbt.budgetType type " +
			"WHERE fbt.fiscalYear = ?1 AND type.parent is not null " +
			"ORDER BY type.lineNumber")
	public List<FiscalBudgetType> findAllByFiscalYear(Integer fiscalYear);


	@Modifying
	@Query("UPDATE FiscalBudgetType fbt " +
			"SET fbt.isMainType = false " +
			"WHERE fbt.fiscalYear = ?1 ")
	public void setALLIsMainBudgetToFALSE(Integer fiscalYear);

	@Modifying
	@Query("UPDATE FiscalBudgetType fbt " +
			"SET fbt.isMainType = true " +
			"WHERE fbt.fiscalYear = ?1 and fbt.id in (?2) ")
	public void setIsMainBudget(Integer fiscalYear, List<Long> ids);

	@Query("" +
			"SELECT fbt " +
			"FROM FiscalBudgetType fbt " +
			"WHERE fbt.fiscalYear = ?1 AND fbt.budgetType.parentLevel <= ?2 AND fbt.budgetType.parentLevel > 0 " +
			"ORDER BY fbt.budgetType.lineNumber")
	public List<FiscalBudgetType> findAllByFiscalYearUpToLevel(
			Integer fiscalYear, Integer level); 
}
