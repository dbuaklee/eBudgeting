package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.model.bgt.Objective;

public interface ObjectiveRepository extends PagingAndSortingRepository<Objective, Long>, JpaSpecificationExecutor<Objective>{
	public List<Objective> findByTypeId(Long id);

	public List<Objective> findByParentIdAndFiscalYear(Long id, Integer fiscalYear);
}
