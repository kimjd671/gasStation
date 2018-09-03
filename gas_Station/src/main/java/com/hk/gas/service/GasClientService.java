package com.hk.gas.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.gas.daos.GasClientDao;
import com.hk.gas.dtos.BookMarkDto;
import com.hk.gas.dtos.FreeBoardDto;

@Service
public class GasClientService implements IGasClientService {

	@Autowired
	GasClientDao clientDao;
	
	@Override
	public List<BookMarkDto> bookmark_List(String id) {
		return clientDao.bookmark_List(id);
	}
	
	@Override
	public boolean reload_price(BookMarkDto dto) {
		return clientDao.reload_price(dto);
	}
	
	
	@Override
	public List<FreeBoardDto> freeboard_List() {
		
		return clientDao.freeboard_List();
	}
	
	@Override
	public List<FreeBoardDto> freepage_List(int page) {
		return clientDao.freepage_List(page);
	}
	
	@Override
	public List<FreeBoardDto> freeall_List() {
		return clientDao.freeall_List();
	}
	
	@Override
	public List<FreeBoardDto> search_List(String category, String value) {
		
		return clientDao.search_List(category, value);
	}
	@Override
	public List<FreeBoardDto> search_page(int page, String category, String value) {
	
		return clientDao.search_page(page, category, value);
	}
	
	@Override
	public List<FreeBoardDto> searchall_List(String category, String value) {
		return clientDao.searchall_List(category, value);
	}
	
	@Override
	public boolean freeborad_insert(FreeBoardDto dto) {
		
		return clientDao.freeborad_insert(dto);
	}
	
	@Override
	public boolean delete_bookmark(BookMarkDto dto) {
		return clientDao.delete_bookmark(dto);
	}
	
	@Override
	public FreeBoardDto free_getboard(int seq) {
		return clientDao.free_getboard(seq);
	}
	
	@Override
	public List<FreeBoardDto> free_getreply(int seq) {
		return clientDao.free_getreply(seq);
	}
	
	@Override
	public boolean free_readcount(int seq) {
		return clientDao.free_readcount(seq);
	}
	
	@Override
	public boolean like_up(FreeBoardDto dto) {
		return clientDao.like_up(dto);
	}
	
	@Override
	public boolean reply_insert(FreeBoardDto dto) {
		return clientDao.reply_insert(dto);
	}
	
	@Override
	public boolean delete_freeboard(int seq) {
		return clientDao.delete_freeboard(seq);
	}
	
	@Override
	public boolean update_freeboard(FreeBoardDto dto) {
		return clientDao.update_freeboard(dto);
	}
	
	@Override
	public boolean reply_update(FreeBoardDto dto) {
		return clientDao.reply_update(dto);
	}
	
	@Override
	public boolean reply_delete(int seq) {
		return clientDao.reply_delete(seq);
	}
	
	@Override
	public boolean insert_bookmark(BookMarkDto dto) {
		return clientDao.insert_bookmark(dto);
	}
}
