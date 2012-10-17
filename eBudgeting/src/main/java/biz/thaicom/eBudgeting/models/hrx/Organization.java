package biz.thaicom.eBudgeting.models.hrx;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="HRX_ORGANIZATION")
@SequenceGenerator(name="HRX_ORGANIZATION_SEQ", sequenceName="HRX_ORGANIZATION_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
public class Organization implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7959577438132453361L;
	
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="HRX_ORGANIZATION_SEQ")
	private Long id;
	
	@Basic
	private String name;
	
	@Basic
	private String abbr;
	
	@Basic
	@Column(name="IDX")
	private Integer index;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="PARENT_HRX_ORGANIZATION_ID")
	private Organization parent;
	
	@OneToMany(mappedBy="parent", fetch=FetchType.LAZY)
	private List<Organization> children;

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

	public String getAbbr() {
		return abbr;
	}

	public void setAbbr(String abbr) {
		this.abbr = abbr;
	}

	public Integer getIndex() {
		return index;
	}

	public void setIndex(Integer index) {
		this.index = index;
	}

	public Organization getParent() {
		return parent;
	}

	public void setParent(Organization parent) {
		this.parent = parent;
	}

	public List<Organization> getChildren() {
		return children;
	}

	public void setChildren(List<Organization> children) {
		this.children = children;
	}

	
	
}
