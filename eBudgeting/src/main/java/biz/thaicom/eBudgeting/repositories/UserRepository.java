package biz.thaicom.eBudgeting.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import biz.thaicom.security.models.Group;
import biz.thaicom.security.models.User;

public interface UserRepository extends PagingAndSortingRepository<User, Long>,
		JpaSpecificationExecutor<User> {

	public User findByUsernameAndPassword(String userName, String password);
	public User findByUsername(String username);
	
	@Query("SELECT g "
			+ "FROM System s inner join s.availableGroups g "
			+ "	inner join g.members u "
			+ "WHERE " 
			+ "	u = ?1  "
			+ " AND s.name = 'EBUDGETING_SYSTEM'")
	public List<Group> findGroupsByUser(User user);	
}
