package biz.thaicom.security.models;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="SEC_ROLE")
@SequenceGenerator(name="SEC_ROLE_SEQ", sequenceName="SEC_ROLE_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class Role implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -1051030830029169693L;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SEC_ROLE_SEQ")
	private Long id;
	
	@Basic
	private String roleName;
	
	@OneToMany
	private List<Program> programAllowList;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	
		
}
