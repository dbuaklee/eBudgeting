package biz.thaicom.security.models;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import biz.thaicom.eBudgeting.models.hrx.Person;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;


@Entity
@Table(name="S_SYSTEM")
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class System implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1870592388688723086L;

	@Id
	private Long id;
	
	@Basic
	@Column(name="SYSTEM_NAME")
	private String name;
	
	@Basic
	@Column(name="DESCRIPTION")
	private String description;
	
	@OneToMany
	@JoinTable( name="S_SYSTEM_LIST",
        joinColumns=
            @JoinColumn(name="S_SYSTEM_ID"),
        inverseJoinColumns=
            @JoinColumn(name="S_GROUP_ID"))
	private Set<Group> availableGroups;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	
	
}
