<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  

 <html>
<head>


<title>Business Near Me</title>


<style>

/* STYLE : GOOGLE MAPS_______________________________________________________________________________________*/
#map {
	  		width:100%;
      		height: 100%;
      		}
/* STYLE : GOOGLE MAPS_______________________________________________________________________________________*/

/* STYLE : AUTOCOMPLETE______________________________________________________________________________________*/
.autocomplete{
            position: relative;
            display: inline-block;
        	}
.autocomplete-items {
            position: absolute;
            border: 1px solid #d4d4d4;
            border-bottom: none;
            border-top: none;
            z-index: 99;
            /*position the autocomplete items to be the same width as the container:*/
            top: 100%;
            left: 0;
            right: 0;
        	}
.autocomplete-items div {
            padding: 10px;
            cursor: pointer;
            background-color: #fff;
            border-bottom: 1px solid #d4d4d4;
        	}
.autocomplete-items div:hover {
            background-color: #e9e9e9;
        	}
.autocomplete-active {
            background-color: DodgerBlue !important;
            color: #ffffff;
        }
        
/* STYLE : AUTOCOMPLETE______________________________________________________________________________________*/

</style>

<!-- BOOTSTRAP CDN___________________________________________________________________________________________ -->

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<!-- BOOTSTRAP CDN___________________________________________________________________________________________ -->


</head>
<!-- ON LOADING THE PAGE : USER GEETING USE LOCATION : getLocation() ______________________________________________-->

<body onload="getLocation()">

<!-- BOOTSTRAP ROW : START__________________________________________________________________________________________ -->
<div class="container mt-3 mb-3">
<div class="row" style="height:100%;">
<div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">

<!-- DISPLAYING THE MAP : END______________________________________________________________________________________ -->

<div id="map" ></div>

<!-- DISPLAYING THE MAP : END______________________________________________________________________________________ -->

</div>
<div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">

<!-- INPUT GROUP        : START____________________________________________________________________________________ -->

<div class="input-group mb-3">

<!-- ACTUAL FORM           :START_____________________________________________________________________________________ -->

<form action="search" method="post" autocomplete="off">
<nav>

<!-- TABS                :START_____________________________________________________________________________________ -->

  <div class="nav nav-tabs mt-3" id="nav-tab" role="tablist">
    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">Search</a>
    <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Change my location</a>
  </div>

 <!-- TABS                :END_______________________________________________________________________________________ -->

</nav>
<div class="tab-content" id="nav-tabContent">

<div class="tab-pane fade show active mt-1 autocomplete" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab"><input name="business_type" class="form-control" id="myInput" placeholder="Search near by "/></div>
<div class="tab-pane fade mt-2" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab"><div>Latitude :&nbsp;<input id="x" name="x" class="form-control"/></div>
<div>Longitude :&nbsp;<input id="y"name="y" class="form-control mt-2"/></div></div>

</div>
<button type="submit" class="btn btn-secondary btn-sm mt-2">Search</button>
</form>

<!-- ACTUAL FORM           :END_______________________________________________________________________________________ -->

</div>

<!-- INPUT GROUP         	:END_______________________________________________________________________________________ -->
<div class="list-group">


<!-- LISTING                :START______________________________________________________________________________________-->

<c:forEach var="locationNearMe" items="${locationNearMe}">
<a href="#" class="list-group-item list-group-item-action">
<div class="d-flex w-100 justify-content-between">

<!-- BUSINESS NAME  -->

<h5 class="mb-1"><c:out value="${locationNearMe.business_name}" /></h5>

<!-- DISTANCE -->

      <small class="text-muted">
      <c:if test="${locationNearMe.distance<8000}" >
      Distance:&nbsp;
      <c:out value="${locationNearMe.distance}"/>&nbsp;KM
      </c:if>
      </small>

<!-- BUSINESS TYPE -->

    </div>
    <p class="mb-1"><c:out value="${locationNearMe.business_type}" />
    
<!-- OPENAING AND CLOSING TIME -->

<br/>Opening time:&nbsp;
<c:out value="${locationNearMe.opening_time}" />
Closing time:&nbsp;
<c:out value="${locationNearMe.closing_time}" /></p>

<!-- COORDINATE POINT -->

<small class="text-muted">Coordinate point : (<c:out value="${locationNearMe.x}" />,
<c:out value="${locationNearMe.y}" />)</small>
  </a>

<!-- LISTING                 :END___________________________________________________________________________________________ -->

</c:forEach>

</div>
</div>
</div>
</div>

<!-- BOOTSTRAP ROW : END___________________________________________________________________________________________ -->





<!-- SCRIPT================================================================================================================= -->




<script type="text/javascript">

// X AND Y are the locations which display in the input 


var x = document.getElementById("x");
var y =	document.getElementById("y");

// image is the icon which should mark the user location

var image = 'https://developers.google.com/maps/documentation/javascript/examples/full/images/beachflag.png';


//GETTING THE LOCATION runs when loading the page

function getLocation() {
	  if (navigator.geolocation) {
	    navigator.geolocation.getCurrentPosition(showPosition);
	  } else { 
	    x.innerHTML = "Geolocation is not supported by this browser.";
	  }
	}
function showPosition(position) {
	  x.value =  position.coords.latitude ; 
	  y.value =  position.coords.longitude;
	  }


//===================================================GOOGLE MAP SCRIPT=====================================================
//===================================================GOOGLE MAP SCRIPT=====================================================
//===================================================GOOGLE MAP SCRIPT=====================================================

function initMap() {

	//Starting the maps
    var map = new google.maps.Map(document.getElementById('map'), {
        zoom: 16,
        center: { lat: 12.6892944, lng: 79.97901399999999 }
    });
	
	//MARKERS :--: getting the locations from the database
	//Getting the information about the location
  	var infowindow1 = new google.maps.InfoWindow({});
   	var marker=new Array();
   	
    <c:forEach var="locationNearMe" items="${locationNearMe}">
    
    marker[<c:out value='${locationNearMe.id}' />] = new google.maps.Marker({
        position:{ lat: <c:out value='${locationNearMe.x}' />, lng: <c:out value='${locationNearMe.y}' /> } ,
        map: map,
        animation: google.maps.Animation.DROP,
        title: "<c:out value='${locationNearMe.business_name}'/>"
      });
    
    marker[<c:out value='${locationNearMe.id}' />].addListener('click', function() {
    	infowindow1.setContent("<c:out value='${locationNearMe.business_name}' />");
        infowindow1.open(map, marker[<c:out value='${locationNearMe.id}' />]);
      });

    </c:forEach>
    
    //For user location in using HTML geolocation API
    infoWindow = new google.maps.InfoWindow;
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(function (position) {
            var pos = {
                lat: position.coords.latitude,
                lng: position.coords.longitude
            };
            var marker = new google.maps.Marker({
                position: pos,
                map: map, 
                title: "Your Location",
                animation: google.maps.Animation.DROP,
                icon: image
            });
            infoWindow.setPosition(pos);
            infoWindow.setContent('You are here');
            infoWindow.open(map);
            map.setCenter(pos);
        }, function () {
            handleLocationError(true, infoWindow, map.getCenter());
        });
    } else {
        handleLocationError(false, infoWindow, map.getCenter());
    }

}

function handleLocationError(browserHasGeolocation, infoWindow, pos) {
    infoWindow.setPosition(pos);
    infoWindow.setContent(browserHasGeolocation ?
        'Error: The Geolocation service failed.' :
        'Error: Your browser doesn\'t support geolocation.');
    infoWindow.open(map);
}


//===================================================GOOGLE MAP SCRIPT=====================================================
//===================================================GOOGLE MAP SCRIPT=====================================================
//===================================================GOOGLE MAP SCRIPT=====================================================
	
//===================================================AUTOCOMPLETE FORM=====================================================
//===================================================AUTOCOMPLETE FORM=====================================================
//===================================================AUTOCOMPLETE FORM=====================================================
function autocomplete(inp, arr) {
    var currentFocus;
    inp.addEventListener("input", function (e) {
        var a, b, i, val = this.value;
        closeAllLists();
        if (!val) { return false; }
        currentFocus = -1;
        a = document.createElement("DIV");
        a.setAttribute("id", this.id + "autocomplete-list");
        a.setAttribute("class", "autocomplete-items");
        this.parentNode.appendChild(a);
        for (i = 0; i < arr.length; i++) {
            if (arr[i].substr(0, val.length).toUpperCase() == val.toUpperCase()) {

                b = document.createElement("DIV");

                b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
                b.innerHTML += arr[i].substr(val.length);
                
                b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
                
                b.addEventListener("click", function (e) {
                    inp.value = this.getElementsByTagName("input")[0].value;

                    closeAllLists();
                });
                a.appendChild(b);
            }
        }
    });
    inp.addEventListener("keydown", function (e) {
        var x = document.getElementById(this.id + "autocomplete-list");
        if (x) x = x.getElementsByTagName("div");
        if (e.keyCode == 40) {
            currentFocus++;
            addActive(x);
        } else if (e.keyCode == 38) {
            currentFocus--;
            addActive(x);
        } else if (e.keyCode == 13) {
            e.preventDefault();
            if (currentFocus > -1) {
                if (x) x[currentFocus].click();
            }
        }
    });
    function addActive(x) {
        if (!x) return false;
        removeActive(x);
        if (currentFocus >= x.length) currentFocus = 0;
        if (currentFocus < 0) currentFocus = (x.length - 1);
        x[currentFocus].classList.add("autocomplete-active");
    }
    function removeActive(x) {
        
        for (var i = 0; i < x.length; i++) {
            x[i].classList.remove("autocomplete-active");
        }
    }
    function closeAllLists(elmnt) {

        var x = document.getElementsByClassName("autocomplete-items");
        for (var i = 0; i < x.length; i++) {
            if (elmnt != x[i] && elmnt != inp) {
                x[i].parentNode.removeChild(x[i]);
            }
        }
    }
    document.addEventListener("click", function (e) {
        closeAllLists(e.target);
    });
}

var bname = ["Super Market","Hospital","School"];

autocomplete(document.getElementById("myInput"), bname);


</script>


<!-- API KEY = AIzaSyD58DmiOW_-MDIgLrM7RTO9LYAn7NyMAVw-->
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyD58DmiOW_-MDIgLrM7RTO9LYAn7NyMAVw&callback=initMap"
        async defer></script>   
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous"></script>    

</body>

</html>