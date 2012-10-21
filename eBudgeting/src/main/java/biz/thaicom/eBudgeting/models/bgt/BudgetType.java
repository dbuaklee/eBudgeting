package biz.thaicom.eBudgeting.models.bgt;

import java.io.Serializable;
import java.util.List;
import java.util.Set;

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
import javax.persistence.OrderColumn;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;

@Entity
@Table(name="BGT_BUDGETTYPE")
@SequenceGenerator(name="BGT_BUDGETTYPE_SEQ", sequenceName="BGT_BUDGETTYPE_SEQ", allocationSize=1)
@JsonIdentityInfo(generator=ObjectIdGenerators.PropertyGenerator.class, property="id")
@JsonIgnoreProperties(ignoreUnknown = true)
public class BudgetType implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5984004367106256395L;
	
	// Field
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="BGT_BUDGETTYPE_SEQ")
	private Long id;
	
	@Basic
	private String name;
	
	@Basic
	private String code;
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="PARENT_BGT_BUDGETTYPE_ID")
	private BudgetType parent;
	
	@OneToMany(mappedBy="parent", fetch=FetchType.LAZY)
	@OrderColumn(name="IDX")
	private List<BudgetType> children;
	
	@Basic
	private Integer fiscalYear;
	
	@Basic
	@Column(name="IDX")
	private Integer index;

	public BudgetType() {
		
	}
	
	@JsonCreator
	public BudgetType(@JsonProperty("id") Long id) {
		this.id=id;
	}
	
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

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public BudgetType getParent() {
		return parent;
	}

	public void setParent(BudgetType parent) {
		this.parent = parent;
	}

	public List<BudgetType> getChildren() {
		return children;
	}

	public void setChildren(List<BudgetType> children) {
		this.children = children;
	}

	public Integer getFiscalYear() {
		return fiscalYear;
	}

	public void setFiscalYear(Integer fiscalYear) {
		this.fiscalYear = fiscalYear;
	}

	public Integer getIndex() {
		return index;
	}

	public void setIndex(Integer index) {
		this.index = index;
	}
	
	public void doBasicLazyLoad() {
		//now we get one parent and its type
		if(this.getParent() != null) {
			this.getParent().getId();
		} 
		
		if(this.getChildren() != null) {
			// we have to go deeper one level
			for(BudgetType child : this.getChildren()){
				if(child.getChildren() != null) {
					child.getChildren().size();
				}
			}
			
		}
	}
	

	public void doEagerLoad() {
		if(this.getParent() != null)
			this.getParent().getId();
		
		if(this.children != null && this.children.size() > 0) {
			for(BudgetType b : this.children) {
				b.doEagerLoad();
			}
		}
		
	}

	public void doLoadParent() {
		if(this.getParent() != null) {
			this.getParent().doLoadParent();
		}
	}	

	
	
	
}