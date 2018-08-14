package com.hk.gas.daos;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.hk.gas.dtos.GasUserDto;

@Repository
public class GasUserDaoImp implements IGasUserDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private String namespace="com.hk.gas.";
	
	@Override
	public boolean insert_User(GasUserDto dto) {
		
		int count=0;
		count=sqlSession.insert(namespace+"insertuser",dto);
		
		return count>0?true:false;
	}
	
	
	@Override
	public boolean chk_id(GasUserDto dto) {
		
		int count=0;
		count=sqlSession.selectOne(namespace+"chkid",dto);
		System.out.println(count);
		return count>0?true:false;
	}
	
	@Override
	public List<GasUserDto> find_id(GasUserDto dto) {
		return sqlSession.selectList(namespace+"findid",dto);
	}
	
	@Override
	public boolean find_pwd(GasUserDto dto) {
		int count=sqlSession.selectOne(namespace+"findpwd",dto);
		return count>0?true:false;
	}
	
	@Override
	public boolean pwd_reset(GasUserDto dto) {
		int count=sqlSession.update(namespace+"pwdreset",dto);
		return count>0?true:false;
	}
	
	@Override
	public GasUserDto login(GasUserDto dto) {
		GasUserDto ldto=sqlSession.selectOne(namespace+"login",dto);
		return ldto;
	}
	
	@Override
	public boolean update_info(GasUserDto dto) {
		int count=sqlSession.update(namespace+"updateinfo",dto);
		return count>0?true:false;
	}
}
