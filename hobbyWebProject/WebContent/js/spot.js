	var row = 0;
	var addr, latt, lonn = null;
	var info = 0;
		
//	console.log('실행됨');
//	console.log('=================JSON DATA=====================');
//	console.log(locationData); //데이터를 잘 받았는지 확인한다.
//	console.log('===============================================');
	
	
	function question(){
		$('#answer').show();
	}
	function questionOut(){
		$('#answer').hide();
	}
    //현재위치 버튼을 클릭하면 view 메서드 실행
	$('#myLoc').on('click', view);
	
    //사용자의 현재위치 데이터를 success와 error에 넘겨주기
	function view(){
		//navigator.geolocation.getCurrentPosition(success, error, options);
		navigator.geolocation.getCurrentPosition(success, error);
		//$('#search').hide();
	}

	//사용자의 현재위치를 받아 마커로 표시한다.
	function success(pos) {
	  	var crd = pos.coords;
	    //var latlng = new naver.maps.LatLng(crd.latitude, crd.longitude);
	    //현재위치의 위도,경도 정보를 reverse 메서드로 념긴다.
	    reverse(crd.latitude, crd.longitude);
	}
	
	//위도와 경도값으로 reverseGeoCode를 사용해 주소값 가져온 후 makeAddress 메서드로 주소를 만든다.
	function reverse(lat, lng){
	    var latlng = new naver.maps.LatLng(lat, lng);
	  	naver.maps.Service.reverseGeocode({
	        coords: latlng ,
	        orders: [
	            naver.maps.Service.OrderType.ADDR,
	            naver.maps.Service.OrderType.ROAD_ADDR
	        ].join(',')
	    }, function (status, response) {
	    	if (status === naver.maps.Service.Status.ERROR) {
	            return alert('Something Wrong!');
	        }
	    	 var items = response.v2.results,
	            address = '',
	            htmlAddresses = [];
				//console.log(items);
	        for (var i=0, ii=items.length, item, addrType; i<ii; i++) {
	            item = items[i];
	            //reverseGeocode 데이터들은 온전한 주소의 형태가 아니기 때문에 조합해 주소를 만들어야 하기 때문에 makeAddress메서드로 값을 넘겨준다
	            address = makeAddress(item) || '';
	            //도로명 주소가 존재하면 도로명주소, 존재하지 않으면 지번주소를 주소타입으로 지정
	            addrType = item.name === 'roadaddr' ? '[도로명 주소]' : '[지번 주소]';
				//console.log(item);
	        }
	        	//console.log(address, addrType);
	        	//주소를 구했으면 serachAddressRoCoordinate 메서드에 넘겨주고 실행
	            searchAddressToCoordinate(address);

	    });
	}
	//현재위치를 구할 때 에러 발생시 에러메시지 출력
	function error(err) {
	    alert('Error getting location: ' + err.message);
	}
	
	//NAVER MAP API로 구한 주소들을 조합해 현재위치의 주소 구하기
	function makeAddress(item) {
	    if (!item) {
	        return;
	    }
	    var name = item.name,
	        region = item.region,
	        land = item.land,
	        isRoadAddress = name === 'roadaddr';

	    var sido = '', sigugun = '', dongmyun = '', ri = '', rest = '';

	    if (hasArea(region.area1)) {
	        sido = region.area1.name;
	    }

	    if (hasArea(region.area2)) {
	        sigugun = region.area2.name;
	    }

	    if (hasArea(region.area3)) {
	        dongmyun = region.area3.name;
	    }

	    if (hasArea(region.area4)) {
	        ri = region.area4.name;
	    }

	    if (land) {
	        if (hasData(land.number1)) {
	            if (hasData(land.type) && land.type === '2') {
	                rest += '산';
	            }

	            rest += land.number1;

	            if (hasData(land.number2)) {
	                rest += ('-' + land.number2);
	            }
	        }

	        if (isRoadAddress === true) {
	            if (checkLastString(dongmyun, '면')) {
	                ri = land.name;
	            } else {
	                dongmyun = land.name;
	                ri = '';
	            }

	            if (hasAddition(land.addition0)) {
	                rest += ' ' + land.addition0.value;
	            }
	        }
	    }

	    return [sido, sigugun, dongmyun, ri, rest].join(' ');
	}
	function hasArea(area) {
	    return !!(area && area.name && area.name !== '');
	}

	function hasData(data) {
	    return !!(data && data !== '');
	}

	function checkLastString (word, lastString) {
	    return new RegExp(lastString + '$').test(word);
	}

	function hasAddition (addition) {
	    return !!(addition && addition.value);
	}

	//주소를 입력하고 엔터키를 클릭하거나 주소검색 버튼을 클릭하면 searchAddressToCoordinate 메서드 실행
	$('#address').on('keydown', function(e) {
        var keyCode = e.which;
        if (keyCode === 13) { // Enter Key
            searchAddressToCoordinate($('#address').val());
        }
    });
    $('#submit').on('click', function(e) {
        e.preventDefault();
        searchAddressToCoordinate($('#address').val());
    });
	
   //검색한 주소의 도로명,지번,영문명 주소를 각각 출력해 지도위에 표시하는 메서드
    function searchAddressToCoordinate(address) {
        naver.maps.Service.geocode({
        query: address
        }, function(status, response) {
            if (status === naver.maps.Service.Status.ERROR) {
    			$('#no-map').show();
    			$('#map').hide();
    			//address의 값을 지운다.
    			$('#address').val('');
                alert('Something Wrong!');
            }
            else if (response.v2.meta.totalCount === 0) {
            	alert('올바른 주소를 입력해주세요.');
            	//console.log(response.v2.meta.totalCount);
    			$('#no-map').show();
    			$('#map').hide();
    			//address의 값을 지운다.
    			$('#address').val('');
    			//올바른 주소가 아니면 table list를 지우고 row-- 해준다. row--를 하지 않으면 row == 1이기 때문에
    			//주소를 다시 올바르게 입력했을 때 newMapList에서 row == 1에 해당되면서 list가 존재하지 않는데 또 삭제를 하기때문에
    			//오류가 발생한다. 따라서 row--를 해줘서 이전 행이 삭제되지않고 바로 insertAddress 메서드로 넘어가도록 한다.
    			const adList = document.getElementById('mapList');
    			adList.deleteRow(0);
    			row--;
    			//console.log(row);
            }else{
            	//console.log(response.v2.meta.totalCount);
    			$('#map').show();
    			$('#no-map').hide();

	            var htmlAddresses = [],
	                item = response.v2.addresses[0],
	                point = new naver.maps.Point(item.x, item.y);
	            /*
	            if (item.roadAddress) {
	                htmlAddresses.push('[도로명 주소] ' + item.roadAddress);
	            }
	            if (item.jibunAddress) {
	                htmlAddresses.push('[지번 주소] ' + item.jibunAddress);
	            }
	            if (item.englishAddress) {
	                htmlAddresses.push('[영문명 주소] ' + item.englishAddress);
	            }
	            infoWindow.setContent([
	                '<div style="padding:10px;min-width:200px;line-height:150%;">',
	                '<h4 style="margin-top:5px;">검색 주소 : '+ address +'</h4><br />',
	                htmlAddresses.join('<br />'),
	                '</div>'
	            ].join('\n'));*/
	            
	            //item.x == longitude , item.y == latitude
	            newMapList(item.roadAddress, item.x, item.y, item.jibunAddress, item.englishAddress);
	            //infoWindow.open(map, point);
	            $('#address').val('');
            }
        });
    }
	//위 메서드가 처음 실행되면 row = 0으로 바로 insertAddress 메서드가 실행되지만
	//두번째 검색부터는 row = 1이기 때문에 이전 행을 삭제하고 insertAddress 메서드를 실행한다.
	function newMapList(address, longitude , latitude, jibun, engAd) {
		//console.log(address);
		//console.log(row);
   		if(row === 1){ // 검색이 두번 실행되면
   			const table = document.getElementById('mapList');
   			table.deleteRow(0); //이전 행 삭제
   			row--; //row값을 -1 해줘야 row값이 0 또는 1로만 반복된다.
			//console.log(latitude + ", " + longitude); 위도 경도 출력
   		}
   		insertAddress(address, longitude , latitude , jibun, engAd);
  	}
	
	//newMapList에서 가져온 정보들을 화면에 출력하고 지도의 위치를 변경한다.
   	function insertAddress(address, longitude , latitude , jibun, engAd){
   		var mapList = "";
    	mapList += "<tr>" 
    	mapList += "	<td>" + "[도로명주소] " + address +"<br>"+ "[지번주소] " + jibun +"<br>"+ "[영문주소] " + engAd +"</td>"
    	mapList += "</tr>"
    	$('#mapList').append(mapList);
    	row++; //모두 실행되면 row + 1 해준다.
    	
    	//address 값이 없으면 지번주소를 address에 넣어준다.
    	if(address === null || address === ''){
    		addr = jibun;
    	}else{
    		addr = address;
    	}
    	latt = latitude;
    	lonn = longitude;
    	rePlaceMap(latitude, longitude);
   	}
	
   	var clickedInfoAddress;
	var clickleader = null;
	var clickname = null;
	var clickaddress = null;
	
   	//검색한 주소 또는 클릭한 주소로 지도와 마커의 위치를 변경한다.
    function rePlaceMap(latitude, longitude){
    	var map = new naver.maps.Map('map', {
    	    center: new naver.maps.LatLng(latitude, longitude),
    	    zoom: 16
    	});
        var marker = new naver.maps.Marker({
            map: map,
            position: new naver.maps.LatLng(latitude, longitude),
            icon: {
      	    	 url: './image/location-dot.png', //아이콘 경로
      	    }
        });
        //지도를 클릭했을 때의 위도,경도를 reverse 메서드로 넘겨주고 marker의 위치를 변경한다.
        naver.maps.Event.addListener(map, 'click', function(e) {
    	    marker.setPosition(e.latlng);
    	    reverse(e.latlng.y, e.latlng.x); //e.latlng.x == longitude & e.latlng.y == latitude
    	    //console.log(e.latlng.y);
    	});
    	
        for(const location of Object.values(locationData)){ // locationData의 value값들만 사용한다.
      //for(const [name, location] of Object.entries(locationData)){ {locationName : {locationKey : locationValue}} 형태의 데이터를
      //그대로 변환하기 위해서는 이 코드를 사용한다.
   	   	 //데이터베이스의 locationData 길이만큼 반복해 각 위치에 marker2를 생성하고 marker2를 클릭하면 해당하는 정보를 infoWindow에 표시한다.
         //  for (var i = 0; i < locationData.length; i++) { 데이터들이 JSON형태가 아니면 이렇게 사용할 수 있다.
           //var location = locationData[i];
//          location 값들을 확인한다.
//  		console.log('==========================');
//  		console.log(location.name);
//  		console.log(location.address);
//  	    console.log(location.latitude);
//  	    console.log(location.longitude);
//  	    console.log(location.crew);
//  	    console.log('==========================');
          var latlng = new naver.maps.LatLng(location.latitude, location.longitude); 
          var infoContent = [
          	'<div id="info-window">',//이름을 클릭하면 스팟가입 메서드가 실행된다.
          	'<div id="info-name" onclick="joinSpot()"><i id="name-icon" class="fa-solid fa-globe"></i>',
          	'<div id="info-spotName">' + location.name + '</div><div id="info-join">참여</div></div>', 
          	'<div id="info-address">'+ location.address + '</div>',
          	'<div id="info-member"> Crew : '+ location.crew + '명</div>',
          	'</div>'
          ].join('');
          var infoWindow = new naver.maps.InfoWindow({
          	//content: infoContent
              content: infoContent,
              borderWidth: 0,
              anchorSize: new naver.maps.Size(5, 5),
          });
          
          //locationData의 marker 옵션
          var markerOptions = {
         	    position: latlng, //마커찍을 좌표
         	    map: map,
         	    icon: {
         	    	 url: './image/map-pin-navy.png', //아이콘 경로
         	    }
         	};
        /*
          var markerOptions2 = {
          	position: latlng, //마커찍을 좌표
          	map: map,
       	};*/
          //삭제되지 않은 스팟만 지도에 표시하고 클릭하면 infoWindow 표시하기
          if(location.available == '1'){
           var marker2 = new naver.maps.Marker(markerOptions);
           function handleMarkerClick(clickedMarker, clickedInfoWindow, leader, name, address) {
               return function () {
            	   //console.log('리더는'+leader);
                   clickedInfoWindow.open(map, clickedMarker);
                   clickleader = leader; //marker를 클릭하면 해당스팟 리더와 스팟이름, 주소를 따로 저장
                   clickname = name;
                   clickaddress = address;
               };
           }
           naver.maps.Event.addListener(marker2, 'click', handleMarkerClick(marker2, infoWindow, location.leader, location.name, location.address));
          }
       }
    }
    
    
   	//스팟 저장하기
    function registSpot() {
	   	var name;
        if(addr == null || latt == null || lonn == null){
        	alert('스팟 주소를 검색하세요');
        	return;
        }else{
	        while (true) {
	            name = prompt('스팟 이름을 입력해주세요');
	
	            if (name === null) {
	                return;
	            } else if (name.trim() === '') {
	                alert('이름을 다시 입력해주세요');
	            } else {
	                break;
	            }
	        }
	      	//저장된 데이터들을 가져온다.
	        var data = {
	            name: name, //name은 while문에서 가져오기 때문에 while문 뒤에 위치해야한다.
	            address: addr,
	            latitude: latt,
	            longitude: lonn
	        };
	        $.ajax({
	            type: 'POST',
	            //url: 'https://toogether.me/spotRegistAction',
	            url: 'spotRegistAction',
	            data: data,
	            success: function (response) {
	            	//spotRegistAction.jsp 페이지를 실행한 후 문자가 포함되어 있는지에 따라 알림창에 결과를 알려준다.
	            	if (response.includes("Spot saved successfully")) {
		                //console.log('Spot registration successful:', response);
		                alert('스팟 등록 완료');
		               	location.reload(true);
		                //console.log(data);
	            	}else if(response.includes("Information Error")){
	            		alert('원하는 스팟 주소를 검색하세요');
	            	}else if(response.includes("null userID")){
	            		alert("로그인 후 다시 시도해주세요.");
	         			window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%');
	            	}else if(response.includes("Spot name already exists")){
	            		//console.error('Spot registration error:', response);
	                    alert('이미 존재하는 이름입니다');
	            	}else{
	            		alert('이미 존재하는 주소입니다');
	            	}
	            },
	            error: function (xhr, status, error) {
	                //console.error('Spot registration error:', error);
	                alert('스팟 등록 오류');
	            }
	        });
        }
    }
    
    function joinSpot(){
    	//console.log("Clicked on location: " + clickname);
        //console.log("Address: " + clickaddress);
        var data2 = {
        	leader: clickleader,//marker를 클릭했을 때 저장된 clickleader, clickname,clickaddress 가져오기
            name: clickname,
            address: clickaddress
        };
        $.ajax({
            type: 'POST',
            //url: 'https://toogether.me/spotJoinAction',
            url: 'spotJoinAction',
            data: data2,
            success: function (response) {
            	if (response.includes("successfully")) { //초기 참여 유저가 가입 완료시
            		if(confirm('가입한 스팟에 접속 하시겠습니까?')){ //접속 여부 묻기
            			spotAccess(data2.name); //확인을 클릭하면 접속
            		}else{
            			location.reload(true); //취소를 클릭하면 화면 새로고침
            		}
            		//alert('스팟 참여 완료');
	               	//location.reload(true);
            	}else if(response.includes("leaders")){
            		spotAccess(data2.name); //스팟 생성자는 바로 접속
            	}else if(response.includes("exist")){
            		spotAccess(data2.name); //이미 참여한 유저는 바로 접속
            	}else if(response.includes("join error")){
            		alert('참여 오류1');
            	}else if(response.includes("database error")){
            		alert('데이터베이스 오류');
            	}else{
            		alert('정보 오류');	            		
            	}
            },
	        error: function (xhr, status, error) {
	            //console.error('Spot registration error:', error);
	            alert('스팟 참여 오류');
	        }
        });
    }
    
    //스팟 가입이 됐는지 검사하고 해당페이지로 이동
    function spotAccess(spotname){
		if(spotname == null){
    		alert('스팟 가입 오류');
    	}else{
    		var data3 = {
   	            spotname: spotname,
   	        };
   	        $.ajax({
   	            type: 'GET',
   	            //url: 'https://toogether.me/spotAccess',
   	            url: 'spotAccess',
   	            data: data3,
   	            success: function (response) {
   	            	if(response.includes("null")){
   	            		alert("로그인 후 다시 시도해주세요.");
   	      				window.open('loginPopUp', 'Login', 'width=450, height=500, top=50%, left=50%');  	            		
   	            	}else if(response.includes("regist error")){
   	            		alert('참여 오류2');
   	            	}else if(response.includes("access successfully")){
   	            		location.href='spotAccess?spot='+spotname;
   	            	}
   	            },
   		        error: function (xhr, status, error) {
   		            //console.error('Spot registration error:', error);
   		            alert('스팟 접속 오류');
   		        }
   	        });
    	}
    }
   	
/* 기본 지도 생성하기
var map = new naver.maps.Map('map', {
    center: new naver.maps.LatLng(37.5112, 127.0981), // 잠실 롯데월드를 중심으로 하는 지도
    zoom: 15
});

function createMap(location){
	var mapOptions = {
	    center: new naver.maps.LatLng(location), // 잠실 롯데월드를 중심으로 하는 지도
	    zoom: 15
	}
	var marker = new naver.maps.Marker({
	    position: new naver.maps.LatLng(location),
	    map: map
	}); 
}
//내 현재위치 지도 생성하기
function getCurrentPosition(){
	return navigator.geolocation.getCurrentPosition(resolve, reject);
}
const point = getCurrentPosition();
createMap(point);
*/