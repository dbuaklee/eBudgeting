package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.BudgetType;
import biz.thaicom.eBudgeting.models.bgt.FormulaStrategy;

public interface FormulaStrategyRepository extends
		PagingAndSortingRepository<FormulaStrategy, Long>, JpaSpecificationExecutor<FormulaStrategy> {

	@Query("" +
			"SELECT fs  " +
			"FROM FormulaStrategy fs " +
			"	LEFT OUTER JOIN FETCH fs.formulaColumns columns " +
			"	INNER JOIN FETCH fs.type type " +
			"	LEFT OUTER JOIN FETCH type.parent parent " +
			"WHERE fs.fiscalYear = ?1 AND fs.type.id = ?2  " +
			"ORDER BY fs.index ")
	public List<FormulaStrategy> findByfiscalYearAndType_id(Integer fiscalYear, Long budgetTypeId);
	
	@Query("" +
			"SELECT fs  " +
			"FROM FormulaStrategy fs " +
			"	LEFT OUTER JOIN FETCH fs.formulaColumns columns " +
			"	INNER JOIN FETCH fs.type type " +
			"	LEFT OUTER JOIN FETCH type.parent parent " +
			"WHERE fs.fiscalYear = ?1 AND fs.type.id = ?2 AND fs.isStandardItem = true " +
			"ORDER BY fs.id ")
	public FormulaStrategy findOnlyStandardByfiscalYearAndType_id(
			Integer fiscalYear, Long id);
	
	@Modifying
	@Query("update FormulaStrategy strategy " +
			"set index = index-1 " +
			"where index > ?1 and fiscalYear = ?2 and type = ?3 ")
	public int reIndex(Integer deleteIndex, Integer fiscalYear, BudgetType budgetType);

	public List<FormulaStrategy> findAllByfiscalYearAndType_ParentPathLike(
			Integer fiscalYear, String parentPath);

	
	@Query("" +
			"SELECT strategy " +
			"FROM FormulaStrategy strategy " +
			"WHERE strategy.fiscalYear = ?1 AND strategy.isStandardItem = ?2" +
			"	AND (strategy.type.id = ?3 or strategy.type.parentPath like ?4) " )
	public List<FormulaStrategy> findAllByfiscalYearAndIsStandardItemAndType_ParentPathLike(
			Integer fiscalYear, Boolean isStandardItem, Long budgetTypeId, String parentPath);

	
	@Query("" +
			"SELECT fs  " +
			"FROM FormulaStrategy fs " +
			"	LEFT OUTER JOIN FETCH fs.formulaColumns columns " +
			"	INNER JOIN FETCH fs.type type " +
			"	LEFT OUTER JOIN FETCH type.parent parent " +
			"WHERE fs.fiscalYear = ?1 AND fs.type.id = ?2 AND fs.isStandardItem = false " +
			"ORDER BY fs.id ")
	public List<FormulaStrategy> findOnlyNonStandardByfiscalYearAndType_id(
			Integer fiscalYear, Long budgetTypeId);


	
}
