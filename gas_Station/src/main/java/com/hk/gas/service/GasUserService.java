package com.hk.gas.service;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hk.gas.daos.GasUserDaoImp;
import com.hk.gas.dtos.GasUserDto;
@Service
public class GasUserService implements IGasUserService{

	
	@Autowired
	GasUserDaoImp userdao;
	
	@Override
	public boolean insert_User(GasUserDto dto) {
		return userdao.insert_User(dto);
	}
	
	@Override
	public boolean chk_id(GasUserDto dto) {
		return userdao.chk_id(dto);
	}
	
	@Override
	public List<GasUserDto> find_id(GasUserDto dto) {
		return userdao.find_id(dto);
	}
	
	@Override
	public boolean find_pwd(GasUserDto dto) {
		
		return userdao.find_pwd(dto);
	}
	
	@Override
	public boolean pwd_reset(GasUserDto dto) {
		return userdao.pwd_reset(dto);
	}
	
	@Override
	public GasUserDto login(GasUserDto dto) {
		// TODO Auto-generated method stub
		return userdao.login(dto);
	}
	 
	@Override
	public boolean update_info(GasUserDto dto) {
		// TODO Auto-generated method stub
		return userdao.update_info(dto);
	}
}
