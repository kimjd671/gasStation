package com.hk.gas.daos;

import java.util.List;

import com.hk.gas.dtos.BookMarkDto;
import com.hk.gas.dtos.FreeBoardDto;
import com.hk.gas.dtos.GasUserDto;

public interface IGasClientDao {
//	즐겨찾기
	public List<BookMarkDto> bookmark_List(String id);
	public boolean reload_price(BookMarkDto dto);
	public boolean delete_bookmark(BookMarkDto dto);
	public boolean insert_bookmark(BookMarkDto dto);
//	게시판
//	글목록
	public List<FreeBoardDto> freeboard_List();
	public List<FreeBoardDto> freepage_List(int page);
	public List<FreeBoardDto> freeall_List();
	public List<FreeBoardDto> search_page(int page,String category,String value);
	public List<FreeBoardDto> search_List(String category,String value);
	public List<FreeBoardDto> searchall_List(String category,String value);
//	추천
	public boolean like_up(FreeBoardDto dto);
//	글작성,삭제,수정
	public boolean freeborad_insert(FreeBoardDto dto);
	public boolean delete_freeboard(int seq);
	public boolean update_freeboard(FreeBoardDto dto);
//	글상세정보,댓글리스트
	public FreeBoardDto free_getboard(int seq);
	public List<FreeBoardDto> free_getreply(int seq);
//	조회수
	public boolean free_readcount(int seq);
//	댓글작성,삭제,수정
	public boolean reply_insert(FreeBoardDto dto);
	public boolean reply_update(FreeBoardDto dto);
	public boolean reply_delete(int seq);
	
	
}
