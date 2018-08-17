package com.hk.gas.daos;

import java.util.List;

import com.hk.gas.dtos.BookMarkDto;
import com.hk.gas.dtos.GasUserDto;

public interface IGasClientDao {
	public List<BookMarkDto> bookmark_List(String id);
}
