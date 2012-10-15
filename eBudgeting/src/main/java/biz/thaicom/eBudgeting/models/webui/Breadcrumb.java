package biz.thaicom.eBudgeting.models.webui;

import java.io.Serializable;

public class Breadcrumb  implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -5892416740569651820L;
	
	
	private String value;
	private String url;
	
	
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	
	
}
