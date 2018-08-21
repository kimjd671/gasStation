package com.hk.gas.service;

import java.util.List;

import com.hk.gas.dtos.BookMarkDto;
import com.hk.gas.dtos.FreeBoardDto;

public interface IGasClientService {
	public List<BookMarkDto> bookmark_List(String id);
	public List<FreeBoardDto> freeboard_List();
}
