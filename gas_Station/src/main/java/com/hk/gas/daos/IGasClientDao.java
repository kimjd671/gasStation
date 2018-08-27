package com.hk.gas.daos;

import java.util.List;

import com.hk.gas.dtos.BookMarkDto;
import com.hk.gas.dtos.FreeBoardDto;
import com.hk.gas.dtos.GasUserDto;

public interface IGasClientDao {
	public List<BookMarkDto> bookmark_List(String id);
	public boolean reload_price(BookMarkDto dto);
	public boolean delete_bookmark(BookMarkDto dto);
	public List<FreeBoardDto> freeboard_List();
	public List<FreeBoardDto> freepage_List(int page);
	public List<FreeBoardDto> search_page(int page,String category,String value);
	public List<FreeBoardDto> search_List(String category,String value);
	public boolean like_up(FreeBoardDto dto);
	public boolean freeborad_insert(FreeBoardDto dto);
	public FreeBoardDto free_getboard(int seq);
	public List<FreeBoardDto> free_getreply(int seq);
	public boolean free_readcount(int seq);
	public boolean reply_insert(FreeBoardDto dto);
	
}
