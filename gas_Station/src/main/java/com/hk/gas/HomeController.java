package com.hk.gas;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hk.gas.dtos.BookMarkDto;
import com.hk.gas.dtos.FreeBoardDto;
import com.hk.gas.dtos.GasUserDto;
import com.hk.gas.service.GasClientService;
import com.hk.gas.service.GasUserService;
import com.hk.gas.utils.Util;

import net.sf.json.JSONArray;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	//객체생성 선언
	@Autowired
	private Util utils;
	@Autowired
	private GasUserService gasuser;
	@Autowired
	private GasClientService client;
	
	
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
	public String main(Locale locale, Model model,String x,String y) {
		
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

	@RequestMapping(value = "/aroundSearch.do", method = RequestMethod.GET)
	public String aroundSearch(Locale locale, Model model,String x,String y,HttpServletRequest request) {
		HttpSession session=request.getSession();
		double nx=Double.parseDouble(x);
		double ny=Double.parseDouble(y);
		String xy=utils.projection(nx, ny);
		GasUserDto ldto= (GasUserDto)session.getAttribute("ldto");
		if(ldto!=null) {
			String id=ldto.getId();
			List<BookMarkDto> booklist= client.bookmark_List(id);
			model.addAttribute("booklist",booklist);
		}
		
		model.addAttribute("x",x);
		model.addAttribute("y",y);
		model.addAttribute("xy",xy);
		return "aroundSearch";
	}
	
	@RequestMapping(value = "/nameSearch.do", method = RequestMethod.GET)
	public String nameSearch(Locale locale, Model model,String sido,String gugun,String x,String y,HttpServletRequest request) {
		HttpSession session=request.getSession();
		GasUserDto ldto= (GasUserDto)session.getAttribute("ldto");
		if(ldto!=null) {
			String id=ldto.getId();
			List<BookMarkDto> booklist= client.bookmark_List(id);
			model.addAttribute("booklist",booklist);
		}
		String name= request.getParameter("name");
		if(name!=null) {
			model.addAttribute("s_name",name); 
		}
		model.addAttribute("x",x);
		model.addAttribute("y",y);
		model.addAttribute("sido",sido);
		model.addAttribute("gugun",gugun);
		return "nameSearch";
	}
	
	@RequestMapping(value = "/admin_page.do", method = RequestMethod.GET)
	public String admin_page(Locale locale, Model model,HttpServletRequest request) {
		
		return "admin_page";
	}
	
	
	@RequestMapping(value = "/bookmark.do", method = RequestMethod.GET)
	public String bookmark(Locale locale, Model model,HttpServletRequest request) {
		HttpSession session=request.getSession();
		GasUserDto ldto= (GasUserDto)session.getAttribute("ldto");
		String id=ldto.getId();
		List<BookMarkDto> booklist= client.bookmark_List(id);
		System.out.println("booklist="+booklist);
		model.addAttribute("lists",booklist); 
		return "bookmark";
	}

	@RequestMapping(value = "/boardlist.do", method = RequestMethod.GET)
	public String boardlist(Locale locale, Model model,HttpServletRequest request) {
		int page=Integer.parseInt(request.getParameter("page"));
		String category=(String)request.getParameter("category");
		String value=(String)request.getParameter("value");
		if(category!=null) {
			System.out.println("search:"+category +"/"+value);
			List<FreeBoardDto> list=client.search_List(category, value);
			List<FreeBoardDto> pagelist=client.search_page(page, category, value);
			List<FreeBoardDto> alllist=client.searchall_List(category, value);
			System.out.println("게시물 검색");
			model.addAttribute("freelist",list);
			model.addAttribute("pagelist",pagelist);
			model.addAttribute("alllist",alllist);
			model.addAttribute("search_value",value);
			model.addAttribute("category",category);
			return "boardlist";
		}else {
			List<FreeBoardDto> list=client.freeboard_List();
			List<FreeBoardDto> pagelist=client.freepage_List(page);
			List<FreeBoardDto> alllist=client.freeall_List();
			model.addAttribute("freelist",list);
			model.addAttribute("pagelist",pagelist);
			model.addAttribute("alllist",alllist);
			return "boardlist";
		}
		
	}
	
	@RequestMapping(value = "/boardDetatil.do", method = RequestMethod.GET)
	public String free_boardDetail(Locale locale, Model model,HttpServletRequest request,HttpServletResponse response) {
		int seq=Integer.parseInt(request.getParameter("seq"));
		Cookie cookies[] = request.getCookies();
		Map mapcookie=new HashMap();
		if(request.getCookies() !=null) {
			for(int i=0;i<cookies.length; i++) {
				Cookie obj=cookies[i];
				mapcookie.put(obj.getName(), obj.getValue());
			}
		}
		String read_cookie =(String)mapcookie.get("readcount");
		String n_cookie="|"+seq;
		if(StringUtils.indexOfIgnoreCase(read_cookie, n_cookie)==-1) {
			Cookie cookie=new Cookie("readcount", read_cookie+n_cookie);
			cookie.setMaxAge(300);
			response.addCookie(cookie);
			client.free_readcount(seq);
		}
		List<FreeBoardDto> reply=client.free_getreply(seq);
		FreeBoardDto detail=client.free_getboard(seq);
		model.addAttribute("dto",detail);
		model.addAttribute("reply",reply);
		return "freeboard_Detail";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/projection.do", method = RequestMethod.POST)
	public List<Map<String,Object>> projection(Locale locale, Model model,HttpServletRequest request){
		
		String data=request.getParameter("data");
		List<Map<String,Object>> resultMap = new ArrayList<Map<String,Object>>();
		resultMap=JSONArray.fromObject(data);
		for (int i=0;i<resultMap.size();i++) {
			Map<String,Object> map=new HashMap<>();
			map=resultMap.get(i);
//	        System.out.println(map.get("name") + " : " + map.get("price"));
//	        System.out.println(map.get("x"));
//	        if(map.get("x").toString().indexOf(".")<0) {
//	        	map.put("x", map.get("x").toString()+".1");
//	        }
//	        System.out.println(map.get("y").toString().indexOf("."));
//	        if(map.get("y").toString().indexOf(".")<0) {
//	        	map.put("y", map.get("y").toString()+".10");
//	        }
	        String x=  map.get("x")+"";
	        String y=  map.get("y")+"";
//	        System.out.println(utils.bessel(Double.parseDouble(x),Double.parseDouble(y)));
	        
	        
			String xy=utils.bessel(Double.parseDouble(x),Double.parseDouble(y));
			String[] myxy=xy.split("/");
			map.put("x",myxy[0]);
			map.put("y",myxy[1]);
	    }

		return resultMap;
	}
	
	//ajax
	@ResponseBody
	@RequestMapping(value = "/projection_one.do")
	public Map<String,String> projection_one(Locale locale, Model model,String x,String y,HttpServletRequest request){
		Map<String,String> map=new HashMap<>();
	    String xy=utils.bessel(Double.parseDouble(x),Double.parseDouble(y));
		String[] myxy=xy.split("/");
		map.put("x",myxy[0]);
		map.put("y",myxy[1]);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/black_insert.do")
	public Map<String,Boolean> black_insert(Locale locale, Model model,String id, String black_id, String why, String content,HttpServletRequest request){
		Map<String,Boolean> map=new HashMap<>();
		boolean isS=gasuser.black_insert(id, black_id, why, content);
		map.put("isS", isS);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/del_blacklist.do")
	public Map<String,Boolean> del_blacklist(Locale locale, Model model,String id, String black_id, String why, String content,HttpServletRequest request){
		Map<String,Boolean> map=new HashMap<>();
		boolean isS=gasuser.del_blacklist(id, black_id, why, content);
		map.put("isS", isS);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/load_boardlist.do")
	public Map<String,List<FreeBoardDto>> load_boardlist(Locale locale, Model model){
		Map<String,List<FreeBoardDto>> map=new HashMap<>();
		List<FreeBoardDto> dto=client.freeall_List();
		map.put("dto",dto);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/userlist.do")
	public Map<String,List<GasUserDto>> userlist(Locale locale, Model model){
		Map<String,List<GasUserDto>> map=new HashMap<>();
		List<GasUserDto> dto=gasuser.userlist();
		map.put("list",dto);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/blacklist.do")                
	public Map<String,List<Map<String, Object>>> blacklist(Locale locale, Model model){
		Map<String,List<Map<String, Object>>> map=new HashMap<>();
		List<Map<String, Object>> dto=gasuser.blacklist();
		
//		System.out.println(dto.get(0));
		map.put("list",dto);
		return map;
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
	
	@ResponseBody
	@RequestMapping(value = "/del_id.do", method = RequestMethod.GET)
	public Map<String,Boolean> del_id(GasUserDto dto,Locale locale, Model model) {
		System.out.println(dto);
		boolean isS=gasuser.del_id(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/reload_price.do", method = RequestMethod.GET)
	public Map<String,Boolean> reload_price(BookMarkDto dto,Locale locale, Model model) {
		System.out.println(dto);
		boolean isS=client.reload_price(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete_bookmark.do", method = RequestMethod.GET)
	public Map<String,Boolean> delete_bookmark(BookMarkDto dto,Locale locale, Model model) {
		System.out.println(dto);
		boolean isS=client.delete_bookmark(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete_freeboard.do", method = RequestMethod.GET)
	public Map<String,Boolean> delete_freeboard(Locale locale, Model model,HttpServletRequest request) {
		int seq=Integer.parseInt(request.getParameter("seq"));
		boolean isS=client.delete_freeboard(seq);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete_reply.do", method = RequestMethod.GET)
	public Map<String,Boolean> delete_reply(Locale locale, Model model,HttpServletRequest request) {
		int seq=Integer.parseInt(request.getParameter("seq"));
		boolean isS=client.reply_delete(seq);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/freeboard_insert.do", method = RequestMethod.GET)
	public Map<String,Boolean> freeboard_insert(FreeBoardDto dto,Locale locale, Model model) {
		System.out.println(dto);
		boolean isS=client.freeborad_insert(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/freeboard_update.do", method = RequestMethod.GET)
	public Map<String,Boolean> freeboard_update(FreeBoardDto dto,Locale locale, Model model) {
		System.out.println(dto);
		boolean isS=client.update_freeboard(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/reply_update.do", method = RequestMethod.GET)
	public Map<String,Boolean> reply_update(FreeBoardDto dto,Locale locale, Model model) {
		System.out.println(dto);
		boolean isS=client.reply_update(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/likeup.do", method = RequestMethod.GET)
	public Map<String,Boolean> likeup(FreeBoardDto dto,Locale locale, Model model) {
		boolean isS=client.like_up(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/reply_insert.do", method = RequestMethod.GET)
	public Map<String,Boolean> reply_insert(FreeBoardDto dto,Locale locale, Model model) {
		System.out.println(dto);
		boolean isS=client.reply_insert(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value = "/bookmark_insert.do")
	public Map<String,Boolean> bookmark_insert(BookMarkDto dto,Locale locale, Model model) {
		System.out.println(dto);
		boolean isS=client.insert_bookmark(dto);
		Map<String, Boolean> map=new HashMap<>();
		map.put("isS",isS);
		return map;
	}
	
}
