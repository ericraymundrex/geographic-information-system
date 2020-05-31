package Models;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Datasource{
	private static String URL="jdbc:mysql://localhost:3306/locations?useSSL=false";
	private static String USER="root";
	private static String PASSWORD="root";
	
	private static final String SELECT="SELECT ST_X(locations.locations) as x_coordinate, ST_Y(locations.locations) as y_coordinate, locations.* FROM locations ORDER BY ((ST_X(locations)-?)*(ST_X(locations)-?))+((ST_Y(locations)-?)*(ST_Y(locations)-?));";
	private static final String SELECT_BY_B_TYPE="SELECT ST_X(locations.locations) as x_coordinate, ST_Y(locations.locations) as y_coordinate, locations.* FROM locations WHERE business_type=? ORDER BY ((ST_X(locations)-?)*(ST_X(locations)-?))+((ST_Y(locations)-?)*(ST_Y(locations)-?));";
	public Datasource() {
		
	}
	//______________________________________________________________________________________________________________________
	//GET THE CONNECTION
	//______________________________________________________________________________________________________________________
	protected Connection GetConnection() {
		Connection connection=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e1) {
			e1.printStackTrace();
		}
		try {
			connection=DriverManager.getConnection(URL,USER,PASSWORD);
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return connection;
	}
	//______________________________________________________________________________________________________________________
	//GET ALL THE LOCATIONS
	
	//TO FIND THE DISTANCE 
	
	
	//STEP 1: Convert the (x,y) and (X,Y) to radians
	//STEP 2: dlon=lon2-lon1 and glat=lat2-lat1
	//STEP 3: a=(sin(dlat/2)^2)+cos(lat1)*cos(lat2)*(sin(dlon/2)^2)
	//STEP 4: c=2*sinInverse(sqrt(a))
	//STEP 5: distance=c*6371
	
	//______________________________________________________________________________________________________________________
	public List<Locations> selectAllLocations(double x,double y){
		List<Locations> locations=new ArrayList<>();
		try(Connection connection=GetConnection();
				PreparedStatement preparedStatement=connection.prepareStatement(SELECT)){
			preparedStatement.setDouble(1,x);
			preparedStatement.setDouble(2,x);
			preparedStatement.setDouble(3,y);
			preparedStatement.setDouble(4,y);
			ResultSet rs=preparedStatement.executeQuery();
			System.out.println(preparedStatement);
			while(rs.next()) {
				int id=rs.getInt("id");
				String business_name=rs.getString("business_name");
				String business_type=rs.getString("business_type");
				String opening_time=rs.getString("opening_time");
				String closing_time=rs.getString("closing_time");
				Double X=rs.getDouble("x_coordinate");
				Double Y=rs.getDouble("y_coordinate");
				double lon1 = Math.toRadians(Y); 
		        double lon2 = Math.toRadians(y); 
		        double lat1 = Math.toRadians(X); 
		        double lat2 = Math.toRadians(x); 
		        double dlon = lon2 - lon1;  
		        double dlat = lat2 - lat1; 
		        double a = Math.pow(Math.sin(dlat / 2), 2) 
		                 + Math.cos(lat1) * Math.cos(lat2) 
		                 * Math.pow(Math.sin(dlon / 2),2);
		        double c = 2 * Math.asin(Math.sqrt(a)); 
		        double r = 6371;
		        
				Double distance=c*r;
				System.out.println(distance);
				locations.add(new Locations(id,business_name,business_type,opening_time,closing_time,X,Y,distance));
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}
		return locations;
	}
	//______________________________________________________________________________________________________________________
	//GET THE SELECTED LOCATIONS
	//______________________________________________________________________________________________________________________
	public List<Locations> selectLocations(String businessType,double x,double y){
		System.out.println(businessType);
		List<Locations> locations=new ArrayList<>();
		if(businessType.length()==0) {
			try(Connection connection=GetConnection();
					PreparedStatement preparedStatement=connection.prepareStatement(SELECT);){
				preparedStatement.setDouble(1,x);
				preparedStatement.setDouble(2,x);
				preparedStatement.setDouble(3,y);
				preparedStatement.setDouble(4,y);
				ResultSet rs=preparedStatement.executeQuery();
				System.out.println(preparedStatement);
				while(rs.next()) {
					int id=rs.getInt("id");
					String business_name=rs.getString("business_name");
					String business_type=rs.getString("business_type");
					String opening_time=rs.getString("opening_time");
					String closing_time=rs.getString("closing_time");
					Double X=rs.getDouble("x_coordinate");
					Double Y=rs.getDouble("y_coordinate");
					double lon1 = Math.toRadians(Y); 
			        double lon2 = Math.toRadians(y); 
			        double lat1 = Math.toRadians(X); 
			        double lat2 = Math.toRadians(x); 
			        double dlon = lon2 - lon1;  
			        double dlat = lat2 - lat1; 
			        double a = Math.pow(Math.sin(dlat / 2), 2) 
			                 + Math.cos(lat1) * Math.cos(lat2) 
			                 * Math.pow(Math.sin(dlon / 2),2);
			        double c = 2 * Math.asin(Math.sqrt(a)); 
			        double r = 6371;
			        
					Double distance=c*r;
					System.out.println(distance);
					locations.add(new Locations(id,business_name,business_type,opening_time,closing_time,X,Y,distance));
				}
			}catch(SQLException e) {
				e.printStackTrace();
			}
			return locations;
		}else {
			try(Connection connection=GetConnection();
					PreparedStatement preparedStatement=connection.prepareStatement(SELECT_BY_B_TYPE);){
				preparedStatement.setString(1,businessType);
				preparedStatement.setDouble(2,x);
				preparedStatement.setDouble(3,x);
				preparedStatement.setDouble(4,y);
				preparedStatement.setDouble(5,y);
				ResultSet rs=preparedStatement.executeQuery();
				System.out.println(preparedStatement);
				while(rs.next()) {
					int id=rs.getInt("id");
					String business_name=rs.getString("business_name");
					String business_type=rs.getString("business_type");
					String opening_time=rs.getString("opening_time");
					String closing_time=rs.getString("closing_time");
					Double X=rs.getDouble("x_coordinate");
					Double Y=rs.getDouble("y_coordinate");
					double lon1 = Math.toRadians(Y); 
			        double lon2 = Math.toRadians(y); 
			        double lat1 = Math.toRadians(X); 
			        double lat2 = Math.toRadians(x); 
			        double dlon = lon2 - lon1;  
			        double dlat = lat2 - lat1; 
			        double a = Math.pow(Math.sin(dlat / 2), 2) 
			                 + Math.cos(lat1) * Math.cos(lat2) 
			                 * Math.pow(Math.sin(dlon / 2),2);
			        double c = 2 * Math.asin(Math.sqrt(a)); 
			        double r = 6371;
			        
					Double distance=c*r;
					System.out.println(distance);
					locations.add(new Locations(id,business_name,business_type,opening_time,closing_time,X,Y,distance));
				}
			}catch(SQLException e) {
				e.printStackTrace();
			}
			return locations;
		}
		}
	//______________________________________________________________________________________________________________________
	
	//______________________________________________________________________________________________________________________
}