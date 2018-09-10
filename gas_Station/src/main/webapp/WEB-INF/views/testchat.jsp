<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%request.setCharacterEncoding("utf-8"); %>
<%response.setContentType("text/html; charset=utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
</head>
<body>
 <div>
        <input type="text" id="sender" value="${ldto.id}" style="display: none;">
        <input type="text" id="messageinput">
    </div>
    <div>
        <button type="button" onclick="openSocket();">Open</button>
        <button type="button" onclick="send();">Send</button>
        <button type="button" onclick="closeSocket();">Close</button>
    </div>
    <!-- Server responses get written here -->
    <div id="messages"></div>
    <!-- websocket javascript -->
    <script type="text/javascript">
        var ws;
        var messages=document.getElementById("messages");
        
        function openSocket(){
            if(ws!==undefined && ws.readyState!==WebSocket.CLOSED){
                writeResponse("WebSocket is already opened.");
                return;
            }
            //웹소켓 객체 만드는 코드
            ws=new WebSocket("ws://localhost:8090/gas/echo.do");
            
            ws.onopen=function(event){
                if(event.data===undefined) return;
                
                writeResponse(event.data);
            };
            ws.onmessage=function(event){
                writeResponse(event.data);
            };
            ws.onclose=function(event){
                writeResponse("Connection closed");
            }
        }
        
        function send(){
            var text=document.getElementById("messageinput").value+","+document.getElementById("sender").value;
            ws.send(text);
            text="";
        }
        
        function closeSocket(){
            ws.close();
        }
        function writeResponse(text){
            messages.innerHTML+="<br/>"+text;
        }
  </script>
</body>
</html>