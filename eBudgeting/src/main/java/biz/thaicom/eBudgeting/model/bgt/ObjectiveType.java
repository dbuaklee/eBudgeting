package biz.thaicom.eBudgeting.model.bgt;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Basic;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;


@Entity
@Table(name="OBJECTIVETYPE")
@SequenceGenerator(name="OBJECTIVETYPE_SEQ", sequenceName="OBJECTIVETYPE_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class ObjectiveType implements Serializable {
	
	
	/**
	 * SerializedUID 
	 */
	private static final long serialVersionUID = -1906396844701411875L;
	
	
	// Field
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="OBJECTIVETYPE_SEQ")
	private Long id;
	
	@Basic
	private String name;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="OBJECTIVETYPE_PARENT_ID")
	private ObjectiveType parent;
	
	@OneToMany(mappedBy="parent", fetch=FetchType.LAZY)
	private Set<ObjectiveType> children;
	
	@Basic
	private Integer fiscalYear;
	
	
	// Normat get-set
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
	public ObjectiveType getParent() {
		return parent;
	}
	public void setParent(ObjectiveType parent) {
		this.parent = parent;
	}
	public Set<ObjectiveType> getChildren() {
		return children;
	}
	public void setChildren(Set<ObjectiveType> children) {
		this.children = children;
	}
	public Integer getFiscalYear() {
		return fiscalYear;
	}
	public void setFiscalYear(Integer fiscalYear) {
		this.fiscalYear = fiscalYear;
	}

	
	
}
