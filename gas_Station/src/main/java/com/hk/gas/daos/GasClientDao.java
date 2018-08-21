package com.hk.gas.daos;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.gas.dtos.BookMarkDto;
import com.hk.gas.dtos.FreeBoardDto;
import com.hk.gas.dtos.GasUserDto;

@Repository
public class GasClientDao implements IGasClientDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String namespace="com.hk.gas.";
	
	@Override
	public List<BookMarkDto> bookmark_List(String id) {
//		Map<String, String> map=new HashMap<>();
//		map.put("id",id);
		return sqlSession.selectList(namespace+"bookmarklist",id);
	}
	
	@Override
	public List<FreeBoardDto> freeboard_List() {
		
		return sqlSession.selectList(namespace+"freeboardlist");
	}
}
