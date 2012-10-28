package biz.thaicom.eBudgeting.repositories;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.eBudgeting.models.bgt.RequestColumn;

public interface RequestColumnRepositories extends
		PagingAndSortingRepository<RequestColumn, Long>, JpaSpecificationExecutor<RequestColumn> {

}
