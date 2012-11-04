package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.FormulaColumn;
import biz.thaicom.eBudgeting.models.bgt.FormulaStrategy;

public interface FormulaColumnRepository extends
		PagingAndSortingRepository<FormulaColumn, Long>, JpaSpecificationExecutor<FormulaColumn> {

	@Modifying
	@Query("update FormulaColumn column " +
			"set index = index-1 " +
			"where index > ?1 and strategy = ?2 ")
	public int reIndex(Integer deleteIndex, FormulaStrategy formulaStrategy);

	@Query("" +
			"SELECT fc " +
			"FROM FormulaColumn fc " +
			"WHERE fc.strategy.fiscalYear = ?1")
	public List<FormulaColumn> findAllByFiscalYear(Integer fiscalYear);
	
}
