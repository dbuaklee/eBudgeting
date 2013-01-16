package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetLevel;
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
	
	@Query("SELECT budgetType " +
			"FROM BudgetType budgetType " +
			"WHERE parentLevel = ?1 AND parentPath like ?2 AND " +
			"	(TO_CHAR(code) like ?3 OR name like ?3) ")
	Page<BudgetType> findAllByParentLevelAndParentPathLike(Integer level,
			String mainTypePath, String query, Pageable pageable);
	
	@Query("SELECT budgetType " +
			"FROM BudgetType budgetType " +
			"WHERE parentLevel = ?1 " +
			"ORDER BY budgetType.code asc ")
	List<BudgetType> findAllByParentLevel(Integer level);
	
	@Query("SELECT level " +
			"FROM BudgetLevel level " +
			"WHERE level.levelNumber = ?1 ")
	BudgetLevel findBudgetLevelNumber(Integer levelNumber);
	
	
	@Query("SELECT max(index) " +
			"FROM BudgetType type " +
			"WHERE type.parent = ?1 ")
	Integer findMaxIndexOf(BudgetType parent);
	
	
	@Query("SELECT max(code) " +
			"FROM BudgetType type " +
			"WHERE type.level = ?1 ")
	Integer findMaxCodeAtLevel(BudgetLevel level);

	
	@Modifying
	@Query("update BudgetType type " +
			"set lineNumber = lineNumber + 1  " +
			"where lineNumber > ?1 ")
	void incrementLineNumber(Integer prevLineNumber);
	

}
