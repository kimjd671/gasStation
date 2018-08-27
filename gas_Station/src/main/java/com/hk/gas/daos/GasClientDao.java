package com.hk.gas.daos;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	@Override
	public List<FreeBoardDto> freepage_List(int page) {
		int pageMin=((page-1)*15)+1;
		int pageMax=page*15;
		Map<String,String> map=new HashMap<>();
		map.put("min", pageMin+"");
		map.put("max", pageMax+"");
		return sqlSession.selectList(namespace+"freeboardpage",map);
	}
	
	@Override
	public List<FreeBoardDto> search_List(String category, String value) {
		Map<String, String> map=new HashMap<>();
		map.put("search", category);
		map.put("index", value);
		return sqlSession.selectList(namespace+"searchlist",map);
	}
	
	@Override
	public List<FreeBoardDto> search_page(int page, String category, String value) {
		int pageMin=((page-1)*15)+1;
		int pageMax=page*15;
		Map<String,String> map=new HashMap<>();
		map.put("min", pageMin+"");
		map.put("max", pageMax+"");
		map.put("search", category);
		map.put("index", value);
		return sqlSession.selectList(namespace+"searchpage",map);
	}
	
	@Override
	public boolean freeborad_insert(FreeBoardDto dto) {
		int count =sqlSession.insert(namespace+"insertfreeboard",dto);
		return count>0?true:false;
	}
	
	@Override
	public boolean delete_bookmark(BookMarkDto dto) {
		int count =sqlSession.delete(namespace+"delbookmark",dto);
		return count>0?true:false;
	}
	
	@Override
	public FreeBoardDto free_getboard(int seq) {
		return sqlSession.selectOne(namespace+"freegetboard",seq);
	}
	
	@Override
	public List<FreeBoardDto> free_getreply(int seq) {
		return sqlSession.selectList(namespace+"freegetreply",seq);
	}
	
	@Override
	public boolean free_readcount(int seq) {
		int count =sqlSession.update(namespace+"readcount",seq);
		return count>0?true:false;
	}
	
	@Override
	public boolean like_up(FreeBoardDto dto) {
		int count =sqlSession.update(namespace+"likeup",dto);
		return count>0?true:false;
	}
	
	@Override
	public boolean reply_insert(FreeBoardDto dto) {
		int count=sqlSession.insert(namespace+"freeinsertreply",dto);
		return count>0?true:false;
	}
}
