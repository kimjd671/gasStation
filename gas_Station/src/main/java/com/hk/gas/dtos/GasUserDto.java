package com.hk.gas.dtos;

import java.util.Date;

public class GasUserDto {

	private int seq;
	private String id;
	private String password;
	private String name;
	private String email;
	private String phone;
	private String role;
	private Date regdate;
	public GasUserDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public GasUserDto(int seq, String id, String password, String name, String email, String phone, String role,
			Date regdate) {
		super();
		this.seq = seq;
		this.id = id;
		this.password = password;
		this.name = name;
		this.email = email;
		this.phone = phone;
		this.role = role;
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "GasUserDto [seq=" + seq + ", id=" + id + ", password=" + password + ", name=" + name + ", email="
				+ email + ", phone=" + phone + ", role=" + role + ", regdate=" + regdate + "]";
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	
	
	
	
}
