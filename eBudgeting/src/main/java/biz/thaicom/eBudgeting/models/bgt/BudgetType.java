package biz.thaicom.eBudgeting.models.bgt;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

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
	
	@Basic
	private String parentPath;
	
	@Basic 
	private Integer parentLevel;
	
	@Basic
	private Integer lineNumber;
	
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
	
	@OneToMany(mappedBy="type", fetch=FetchType.LAZY)
	private List<FormulaStrategy> strategies;
	
	
	@ManyToOne(fetch=FetchType.LAZY)
	@JoinColumn(name="BGT_BUDGETLEVEL_ID")
	private BudgetLevel level;

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
	public String getParentPath() {
		return parentPath;
	}

	public void setParentPath(String parentPath) {
		this.parentPath = parentPath;
	}

	public List<FormulaStrategy> getStrategies() {
		return strategies;
	}

	public void setStrategies(List<FormulaStrategy> strategies) {
		this.strategies = strategies;
	}

	public Integer getParentLevel() {
		return parentLevel;
	}

	public void setParentLevel(Integer parentLevel) {
		this.parentLevel = parentLevel;
	}
	
	public Integer getLineNumber() {
		return lineNumber;
	}

	public void setLineNumber(Integer lineNumber) {
		this.lineNumber = lineNumber;
	}
	
	public BudgetLevel getLevel() {
		return level;
	}

	public void setLevel(BudgetLevel level) {
		this.level = level;
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

	public List<Long> getParentIds() {
		// OK will have to travesre back up .. we can get the parent path
		String parentPath = this.parentPath;
		if(this.parentPath == null) {
			return null;
		}
		
		//we will tokenize and put it in List<Long>
		List<Long> parentIds = new ArrayList<Long>();
		
		StringTokenizer tokens = new StringTokenizer(parentPath, ".");
		
		while(tokens.hasMoreTokens()) {
			String token = tokens.nextToken();
			//convert to Long
			Long parentId = Long.parseLong(token);
			
			parentIds.add(parentId);
		}
		return parentIds;
	}
	
	
	public String getTopParentName() {
		if(this.parentPath == null) {
			return "";
		}
		Pattern p = Pattern.compile(".*([0-9]+)\\.0\\.");
		Matcher m = p.matcher(this.parentPath);
		if (m.find()) {
			String topParentId = m.group(1);
			switch (Integer.parseInt(topParentId)) {
			case 1:
				return "งบบุคลากร";
			case 2:
				return "งบดำเนินงาน";
			case 3:
				return "งบลงทุน";
			case 4:
				return "งบอุดหนุน";
			case 5:
				return "งบรายจ่ายอื่น";
			default:
				return "unknown";
			}
		}
		return "";
	}
	
}
