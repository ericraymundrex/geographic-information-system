package Models;
public class Locations{
	private int id;
	private String business_name;
	private String business_type;
	private String opening_time;
	private String closing_time;
	private double x;
	private double y;
	private double distance;
	//CONSTRUCTOR
	public Locations(int id, String business_name, String business_type, String opening_time, String closing_time,double x,double y,double distance) {
		super();
		this.id = id;
		this.business_name = business_name;
		this.business_type = business_type;
		this.opening_time = opening_time;
		this.closing_time = closing_time;
		this.x=x;
		this.y=y;
		this.distance=distance;
	}
	
	//GETTER AND SETTER
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBusiness_name() {
		return business_name;
	}
	public void setBusiness_name(String business_name) {
		this.business_name = business_name;
	}
	public String getBusiness_type() {
		return business_type;
	}
	public void setBusiness_type(String business_type) {
		this.business_type = business_type;
	}
	public String getOpening_time() {
		return opening_time;
	}
	public void setOpening_time(String opening_time) {
		this.opening_time = opening_time;
	}
	public String getClosing_time() {
		return closing_time;
	}
	public void setClosing_time(String closing_time) {
		this.closing_time = closing_time;
	}

	public double getX() {
		return x;
	}

	public void setX(double x) {
		this.x = x;
	}

	public double getY() {
		return y;
	}

	public void setY(double y) {
		this.y = y;
	}

	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}
	
	
}