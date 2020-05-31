

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Models.Datasource;
import Models.Locations;


@WebServlet("/")
public class locationServer extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Datasource datasource;
    public locationServer() {
        this.datasource=new Datasource();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action=request.getServletPath();
		switch(action) {
			
			case "/search":
				if(request.getParameter("x")!=null) {
					search(request,response);
					break;
				}
			case "/":
				showAll(request,response);
				break;
		}
	}
	//______________________________________________________________________________________________________________________
	//ROUTES FUNCTIONS
	//______________________________________________________________________________________________________________________
	//TO SELECT ALL THE LOCATIONS NEAR ME
	private void showAll(HttpServletRequest request,HttpServletResponse response)
			throws ServletException,IOException{
		List <Locations> locationNearMe=datasource.selectAllLocations(0,0);
		request.setAttribute("locationNearMe",locationNearMe);
		RequestDispatcher dispatcher=request.getRequestDispatcher("location.jsp");
		dispatcher.forward(request, response);
	}
	//______________________________________________________________________________________________________________________
	//TO SELECT ALL THE LOCATIONS IN THE SPECIFIC BUSINESS TYPE
	//______________________________________________________________________________________________________________________
	private void search(HttpServletRequest request,HttpServletResponse response)
			throws ServletException,IOException{
		List <Locations> locationNearMe;
		String search=request.getParameter("business_type");
		double x=Double.parseDouble(request.getParameter("x"));
		double y=Double.parseDouble(request.getParameter("y"));
		System.out.println(x);System.out.println(y);
		System.out.println(search);
		System.out.println(search.length());
		if(search.length()==0) {
			locationNearMe=datasource.selectAllLocations(x,y);
		}else {
			locationNearMe=datasource.selectLocations(search,x,y);	
		}
		request.setAttribute("locationNearMe",locationNearMe);
		RequestDispatcher dispatcher=request.getRequestDispatcher("location.jsp");
		dispatcher.forward(request, response);
	}
	//______________________________________________________________________________________________________________________
	
	//______________________________________________________________________________________________________________________
	
}
