package com.hk.gas.utils;

import java.util.ArrayList;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Controller
@ServerEndpoint(value="/echo.do")
public class EchoHandler extends TextWebSocketHandler {

	private static List<Session> sessionlist=new ArrayList<>();
	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	public EchoHandler() {
		System.out.println("웹소켓(서버) 객체생성");
	}
	 @RequestMapping(value="/chat.do")
	    public ModelAndView getChatViewPage(ModelAndView mav) {
	        mav.setViewName("chat");
	        return mav;
	    }
	 @OnOpen
	 public void onOpen(Session session) {
	     logger.info("Open session id:"+session.getId());
	     try {
	    	 final Basic basic=session.getBasicRemote();
	    	 basic.sendText("채팅방에 연결되었습니다.");
	    	 sessionlist.add(session);
		     basic.sendText(sessionlist.size()+"명 접속중");
	     }catch (Exception e) {
	            // TODO: handle exception
	        System.out.println(e.getMessage());
	     } 
	    }
	private void sendAllSessionToMessage(Session self,String message) {
        try {
            for(Session session : EchoHandler.sessionlist) {
                if(!self.getId().equals(session.getId())) {
                    session.getBasicRemote().sendText(message.split(",")[1]+" : "+message.split(",")[0]);
                }
            }
        }catch (Exception e) {
            // TODO: handle exception
            System.out.println(e.getMessage());
        }
    }
	 @OnMessage
	    public void onMessage(String message,Session session) {
	        logger.info("Message From "+message.split(",")[1] + ": "+message.split(",")[0]);
	        try {
	            final Basic basic=session.getBasicRemote();
	            basic.sendText(message.split(",")[1]+": "+message.split(",")[0]);
	        }catch (Exception e) {
	            // TODO: handle exception
	            System.out.println(e.getMessage());
	        }
	        sendAllSessionToMessage(session, message);
	    }
    @OnError
    public void onError(Throwable e,Session session) {
        System.out.println(e.getMessage());
    }
    @OnClose
    public void onClose(Session session) {
        logger.info("Session "+session.getId()+" has ended");
        sessionlist.remove(session);
    }
	
}
