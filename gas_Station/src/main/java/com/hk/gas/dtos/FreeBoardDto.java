package com.hk.gas.dtos;

import java.util.Date;

public class FreeBoardDto {
	private int seq;
	private String id;
	private String title;
	private String content;
	private Date regdate;
	private int refer;
	private int step;
	private int depth;
	private int readcount;
	private String likecount;
	public FreeBoardDto() {
		super();
		// TODO Auto-generated constructor stub
	}
	public FreeBoardDto(int seq, String id, String title, String content, Date regdate, int refer, int step, int depth,
			int readcount,String likecount) {
		super();
		this.seq = seq;
		this.id = id;
		this.title = title;
		this.content = content;
		this.regdate = regdate;
		this.refer = refer;
		this.step = step;
		this.depth = depth;
		this.readcount = readcount;
		this.likecount = likecount;
	}
	@Override
	public String toString() {
		return "FreeBoardDto [seq=" + seq + ", id=" + id + ", title=" + title + ", content=" + content + ", regdate="
				+ regdate + ", refer=" + refer + ", step=" + step + ", depth=" + depth + ", readcount=" + readcount
				+ ", likecount=" + likecount + "]";
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getRefer() {
		return refer;
	}
	public void setRefer(int refer) {
		this.refer = refer;
	}
	public int getStep() {
		return step;
	}
	public void setStep(int step) {
		this.step = step;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public String getLikecount() {
		return likecount;
	}
	public void setLikecount(String likecount) {
		this.likecount = likecount;
	}
	
	
}
