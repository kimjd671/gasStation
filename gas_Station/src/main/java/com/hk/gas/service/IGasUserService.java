package com.hk.gas.service;

import java.util.List;
import java.util.Map;

import com.hk.gas.dtos.GasUserDto;

public interface IGasUserService {
	public boolean insert_User(GasUserDto dto);
	public boolean chk_id(GasUserDto dto);
	public List<GasUserDto> find_id(GasUserDto dto);
	public boolean find_pwd(GasUserDto dto);
	public boolean pwd_reset(GasUserDto dto);
	public GasUserDto login(GasUserDto dto);
	public boolean update_info(GasUserDto dto);
	public List<GasUserDto> userlist();
	public List<Map<String, Object>> blacklist();
	public boolean black_insert(String id, String black_id, String why, String content);
	public boolean del_id(GasUserDto dto);
}
