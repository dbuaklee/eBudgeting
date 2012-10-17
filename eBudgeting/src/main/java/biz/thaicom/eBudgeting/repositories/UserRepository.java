package biz.thaicom.eBudgeting.repositories;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.security.models.User;

public interface UserRepository extends PagingAndSortingRepository<User, Long>,
		JpaSpecificationExecutor<User> {

	public User findByUsernameAndPassword(String userName, String password);
	public User findByUsername(String username);
	
}
