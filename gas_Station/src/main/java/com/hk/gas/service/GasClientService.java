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
}
