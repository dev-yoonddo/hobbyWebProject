//onsubmit에 작동하는 함수이기 때문에 비밀번호가 아닌 모든 데이터도 다룰 수 있다.
//password check
function userDataCheck(obj) {
	const ckKor = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g; 
	const ckEng = /[a-zA-Z]/g; // 영어체크
	const ckSpc = /[!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\"\'\,\.\/\`\₩]/g;//특수문자체크
	function error(result){
		obj.result.value = '';
		obj.result.focus();
		return false;
	}
	//id check
	var id = obj.userID.value;
	if(ckSpc.test(id)){
		alert("아이디에 특수문자를 입력할 수 없습니다.");
		error(id);
	}
	if(id.length > 10){
		alert("아이디는 10자 이내로 입력해주세요.");
		obj.userID.focus();
		return false;
	}
	//name check
	var name = obj.userName.value;
    if(regExp.test(name) || regExp2.test(name)){
    	alert("이름은 한글만 입력해주세요.");
    	obj.userName.focus();
        return false;
    }else{
        return true;
    }
	//email check
	var mail = (obj.userEmail.value).split('@',2);
	if(mail.length == 1){
		alert("이메일 주소가 바르지 않습니다");
		obj.userEmail.focus();
		return false;
	}
	//birth check
	var birth = obj.userBirth.value;
	if(birth.length > 6){
		alert("6자로 입력해주세요.")
	}
//	alert('passwordCheck()');
	if(obj.userPassword.value != obj.userPassword1.value){
		alert("비밀번호가 일치하지 않습니다");
		obj.userPassword.value = '';
		obj.userPassword1.value = '';
		obj.userPassword.focus();
		return false;
	}
//	입력한 비밀번호가 8자 이상 12자 이하인가 검사한다.
	var len = obj.userPassword.value.trim().length;
	if (len < 8 || len > 12) {
		alert('비밀번호는 8자 이상 12자 이하로 입력해야 합니다.');
		obj.userPassword.value = '';
		obj.userPassword1.value = '';
		obj.userPassword.focus();
		return false;
	}
	
//	영문자, 숫자, 특수문자가 각각 1개 이상 입력되었나 검사한다.
	var alphaCount = 0;
	var numberCount = 0;
	var etcCount = 0;
//	입력된 비밀번호의 문자 개수만큼 반복하며 영문자, 숫자, 특수문자의 개수를 센다.
	var pw = obj.userPassword.value.trim();
	for (var i = 0; i < len; i++) {
		if (pw.charAt(i) >= 'a' && pw.charAt(i) <= 'z' || pw.charAt(i) >= 'A' && pw.charAt(i) <= 'Z') {
			alphaCount++;
		} else if (pw.charAt(i) >= '0' && pw.charAt(i) <= '9') {
			numberCount++;
		} else {
			etcCount++;
		}
	}
//	alert('영문자: ' + alphaCount + "개\n숫자: " + numberCount + "개\n특수문자: " + etcCount);
	if (alphaCount == 0 || numberCount == 0 || etcCount == 0) {
		alert('영문자, 숫자, 특수문자는 각각 1개 이상 입력해야 합니다.');
		obj.userPassword.value = '';
		obj.userPassword1.value = '';
		obj.userPassword.focus();
		return false;
	}

	return true;

}
function passwordCheck2() {
	var userPassword = $('#userPassword').val();
	var userPassword1 = $('#userPassword1').val();
	if (userPassword != userPassword1) {
		$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
	} else {
		$('#passwordCheckMessage').html('');
	}
}

/*비밀번호 암호화
function loginRSA(pw){
	// rsa 암호화	
	var rsa = new RSAKey();
	rsa.setPublic($('#RSAModulus').val(),$('#RSAExponent').val());
	    
	$("#userPassword").val(rsa.encrypt(pw));
	    
    return true;
}*/
