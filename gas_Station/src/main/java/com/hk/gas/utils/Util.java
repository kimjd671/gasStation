package com.hk.gas.utils;

import java.awt.geom.Point2D;

import org.springframework.stereotype.Repository;

import com.jhlabs.map.proj.*;
import com.jhlabs.map.proj.ProjectionFactory;



@Repository
public class Util {	
	Ellipsoid bessel1841 = new Ellipsoid(6377397.155, 1.0 / 299.152813);
	Ellipsoid wgs1984 = new Ellipsoid(6378137, 1.0 / 298.257223563);
	Parameters7 params = new Parameters7(
	    -115.8, 474.99, 674.11, 
	    -1.16, 2.31, 1.63, 
	    6.43
	);
	Ellip2Ellipsoid transform = new Ellip2Ellipsoid(bessel1841, wgs1984, params);

	
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
		Values3 src = new Values3(x, y, 0);
		Values3 dst = new Values3();
		transform.reverseTransform(src, dst);
        srcProjec = new Point2D.Double(dst.V2,dst.V1); 
        katec.transform(srcProjec, pKatec);
        System.out.println("result(" + pKatec.getX() +"," + pKatec.getY() +")");
        return (String)(pKatec.getX()+"/"+pKatec.getY());
	}
	
	
	public String bessel(double x,double y) {
		GeoTransPoint oKA = new GeoTransPoint(x, y);

		GeoTransPoint oGeo = GeoTrans.convert(GeoTrans.KATEC, GeoTrans.GEO, oKA);


		Double lat = oGeo.getY() ;

		Double lng = oGeo.getX() ;
		
		GeoTransPoint oLatLng = new GeoTransPoint(lat.intValue(), lng.intValue());
		String xy=""+lat.doubleValue()+"/"+lng.doubleValue();
		return xy;
	}

}
