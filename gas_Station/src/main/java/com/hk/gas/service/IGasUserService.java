package com.hk.gas.service;

import java.util.List;

import com.hk.gas.dtos.GasUserDto;

public interface IGasUserService {
	public boolean insert_User(GasUserDto dto);
	public boolean chk_id(GasUserDto dto);
	public List<GasUserDto> find_id(GasUserDto dto);
	public boolean find_pwd(GasUserDto dto);
	public boolean pwd_reset(GasUserDto dto);
	public GasUserDto login(GasUserDto dto);
	public boolean update_info(GasUserDto dto);
}
