package com.hk.gas.utils;

import java.awt.geom.Point2D;

import org.springframework.stereotype.Repository;

import com.jhlabs.map.proj.*;
import com.jhlabs.map.proj.ProjectionFactory;



@Repository
public class Util {	
	//&nbsp;&nbsp;<img src=""/>
	private String arrowNbsp;

	public String getArrowNbsp() {
		return arrowNbsp;
	}
	//글목록에서 ${dto.depth}값을 setArrowNbsp()에 아규먼트로 전달 ->
	public void setArrowNbsp(String depth) {
		
		String nbsp="";
		int depthInt=Integer.parseInt(depth);
		for(int i=0; i<depthInt; i++) {//depth의 크기만큼 nbsp작업을 함
			nbsp+="&nbsp;&nbsp;&nbsp;&nbsp;";
		}
		this.arrowNbsp=(depthInt>0?nbsp+"<img src='image/arrow.png' alt='답글'/>":"");
	}
	
	//static: 클래스명.메서드, 클래스명.멤버필드
	//non-static: 객체생성 후 객체명.메서드, 객체명.멤버필드
	//메서드의 종류: static과 non-static, return/void, 아규먼트o/아규먼트x
	public static String jsForward(String msg, String url){
		String s=  "<script type='text/javascript'>"
	   			+"alert('"+msg+"');"
	   			+"location.href='"+url+"';"
	   	        +"</script>";
	   	        
		return s;
	}
	
	public String projection(double x,double y) {
		String[] params = {
	            "+proj=tmerc",
	            "+lat_0=38N",
	            "+lon_0=128E",
	            "+ellps=bessel",
	            "+x_0=400000",
	            "+y_0=600000",
	            "+k=0.9999",
	            "+unit=m"
	        };
		Point2D.Double srcProjec = null;
		Projection katec = ProjectionFactory.fromPROJ4Specification(params);
		Point2D.Double pKatec = new Point2D.Double();
        srcProjec = new Point2D.Double(y,x); 
        katec.transform(srcProjec, pKatec);
        System.out.println("result(" + pKatec.getX() +"," + pKatec.getY() +")");
        return (String)(pKatec.getX()+"/"+pKatec.getY());
	}
	

}
