package biz.thaicom.security.models;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import biz.thaicom.eBudgeting.models.hrx.Organization;
import biz.thaicom.eBudgeting.models.hrx.Person;

public class ThaicomUserDetail implements UserDetails {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6455793562688687936L;

	private Collection<? extends GrantedAuthority> AUTHORITIES;
	
	private String password;

	private String username;
	
	private Organization workAt;
	
	private Person person;
	
	
	public ThaicomUserDetail(String username, String password, Collection<? extends GrantedAuthority> AUTHORITIES) {
		this.username= username;
		this.password = password;
		this.AUTHORITIES = AUTHORITIES;
	}
	
	
	
	public Organization getWorkAt() {
		return workAt;
	}

	public void setWorkAt(Organization workAt) {
		this.workAt = workAt;
	}
	
	public String getWorkAtAbbr() {
		return this.workAt.getAbbr();
	}

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return AUTHORITIES;
	}

	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public String getUsername() {
		return username;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}




}
