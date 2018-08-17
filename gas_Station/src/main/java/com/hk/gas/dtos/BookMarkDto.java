package com.hk.gas.dtos;

import java.util.Date;

public class BookMarkDto {

	private String id;
	private String b_name;
	private String location;
	private int gasoline;
	private int diesel;
	private int lpg;
	private Date regdate;
	public BookMarkDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BookMarkDto(String id, String b_name, String location, int gasoline, int diesel, int lpg, Date regdate) {
		super();
		this.id = id;
		this.b_name = b_name;
		this.location = location;
		this.gasoline = gasoline;
		this.diesel = diesel;
		this.lpg = lpg;
		this.regdate = regdate;
	}
	@Override
	public String toString() {
		return "BookMarkDto [id=" + id + ", b_name=" + b_name + ", location=" + location + ", gasoline=" + gasoline
				+ ", diesel=" + diesel + ", lpg=" + lpg + ", regdate=" + regdate + "]";
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getB_name() {
		return b_name;
	}
	public void setB_name(String b_name) {
		this.b_name = b_name;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public int getGasoline() {
		return gasoline;
	}
	public void setGasoline(int gasoline) {
		this.gasoline = gasoline;
	}
	public int getDiesel() {
		return diesel;
	}
	public void setDiesel(int diesel) {
		this.diesel = diesel;
	}
	public int getLpg() {
		return lpg;
	}
	public void setLpg(int lpg) {
		this.lpg = lpg;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	
}
