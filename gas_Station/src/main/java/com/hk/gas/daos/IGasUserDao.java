package com.hk.gas.daos;

import java.util.List;
import java.util.Map;

import com.hk.gas.dtos.GasUserDto;

public interface IGasUserDao {
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
	//resultType이 없으면 boolean
	public boolean del_id(GasUserDto dto);
	public boolean del_blacklist(String id, String black_id, String why, String content);
}
