package biz.thaicom.eBudgeting.repositories;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.model.bgt.ObjectiveType;

public interface ObjectiveTypeRepository extends
		PagingAndSortingRepository<ObjectiveType, Long>, JpaSpecificationExecutor<ObjectiveType> {

}
