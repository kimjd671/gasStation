package com.hk.gas.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.gas.daos.GasClientDao;
import com.hk.gas.dtos.BookMarkDto;

@Service
public class GasClientService implements IGasClientService {

	@Autowired
	GasClientDao clientDao;
	
	@Override
	public List<BookMarkDto> bookmark_List(String id) {
		return clientDao.bookmark_List(id);
	}
}
