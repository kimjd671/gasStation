package com.hk.gas.daos;


import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.gas.dtos.BookMarkDto;
import com.hk.gas.dtos.FreeBoardDto;


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
	public boolean reload_price(BookMarkDto dto) {
		int count = sqlSession.update(namespace+"reloadprice",dto);
		return count>0?true:false;
	}
	
	@Override
	public List<FreeBoardDto> freeboard_List() {
		
		return sqlSession.selectList(namespace+"freeboardlist");
	}
}
