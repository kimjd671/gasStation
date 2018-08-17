package com.hk.gas;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hk.gas.dtos.GasUserDto;
import com.hk.gas.service.GasUserService;
import com.hk.gas.utils.Util;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	
	@Autowired
	private Util utils;
	@Autowired
	private GasUserService gasuser;
	
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@RequestMapping(value = "/main.do", method = RequestMethod.GET)
	public String test(Locale locale, Model model,String x,String y) {
		
		double nx=Double.parseDouble(x);
		double ny=Double.parseDouble(y);
		System.out.println(nx+"/"+ny);
		//Point2D xy=utils.test01(nx,ny);
		String xy=utils.projection(nx, ny);
		//System.out.println(xy.getX()+"/"+xy.getY());
		model.addAttribute("x",x);
		model.addAttribute("y",y);
		model.addAttribute("xy",xy);
		return "main";
	}
	
	@ResponseBody
	@RequestMapping(value = "/insertuser.do", method = RequestMethod.GET)
	public Map<String,Boolean> inseruser(GasUserDto dto,Locale locale, Model model) {
		System.out.println(dto);
		boolean isS=gasuser.insert_User(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	
	}
	
	@ResponseBody
	@RequestMapping(value = "/idchk.do", method = RequestMethod.GET)
	public Map<String,Boolean> idchk(GasUserDto dto,Locale locale, Model model) {
		boolean isS=gasuser.chk_id(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/findid.do", method = RequestMethod.GET)
	public Map<String, List> findid(GasUserDto dto,Locale locale, Model model) {
		System.out.println(dto);
		List<GasUserDto> ddto=gasuser.find_id(dto);
		Map<String,List> map=new HashMap<>();
		map.put("dto",ddto);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/findpwd.do", method = RequestMethod.GET)
	public Map<String,Boolean> findpwd(GasUserDto dto,Locale locale, Model model) {
		System.out.println(dto);
		boolean isS=gasuser.find_pwd(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/pwdreset.do", method = RequestMethod.GET)
	public Map<String,Boolean> pwdreset(GasUserDto dto,Locale locale, Model model) {
		System.out.println(dto);
		boolean isS=gasuser.pwd_reset(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/login.do", method = RequestMethod.GET)
	public Map<String,GasUserDto> login(GasUserDto dto,Locale locale, Model model,HttpServletRequest request) {
		GasUserDto ldto=gasuser.login(dto);
		System.out.println(ldto);
		Map<String,GasUserDto> map=new HashMap<>();
		HttpSession session = request.getSession();
		session.setAttribute("ldto", ldto);
		map.put("dto",ldto);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public void logout(Locale locale, Model model,HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
	}
	
	@ResponseBody
	@RequestMapping(value = "/chk_pwd.do", method = RequestMethod.GET)
	public Map<String,GasUserDto> chk_pwd(GasUserDto dto,Locale locale, Model model) {
		GasUserDto ldto=gasuser.login(dto);
		Map<String,GasUserDto> map=new HashMap<>();
		map.put("chkdto",ldto);
		return map;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/update_info.do", method = RequestMethod.GET)
	public Map<String,Boolean> update_info(GasUserDto dto,Locale locale, Model model) {
		System.out.println(dto);
		boolean isS=gasuser.update_info(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
}
