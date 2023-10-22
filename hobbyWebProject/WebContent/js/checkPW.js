//onsubmit에 작동하는 함수이기 때문에 비밀번호가 아닌 모든 데이터도 다룰 수 있다.
//password check
function userDataCheck(obj) {
	const ckKor = /[ㄱ-ㅎㅏ-ㅣ가-힣]/g; //한글 체크
	const ckEng = /[a-zA-Z]/g; // 영어 체크
	const ckSpc = /[!?@#$%^&*():;+-=~{}<>\_\[\]\|\\\"\'\,\.\/\`\₩]/g;// 특수문자 체크
	const ckNum = /[^0-9]/g; // 숫자가 아닌 문자 체크
	const ckEngNum = /[a-zA-Z0-9]/g; // 영어+숫자 체크
	const ckSpace = /[\s]/g;// 공백 체크

	// id check
	var id = obj.userID;
	if (id.value.search(ckSpace) !== -1) {
		alert("공백이 포함되어 있습니다.");
		error(id);
		return false;
	}
	if (ckKor.test(id.value) || ckSpc.test(id.value)) {
		alert("아이디는 영어로만 입력해주세요.");
		error(id);
		return false;
	}
	if (id.value.length > 10) {
		alert("아이디는 10자 이내로 입력해주세요.");
		error(id);
		return false;
	}

	// name check
	var name = obj.userName;
	if (name.value.search(ckSpace) !== -1) {
		alert("공백이 포함되어 있습니다.");
		error(name);
		return false;
	}
	if (ckEngNum.test(name.value) || ckSpc.test(name.value)) {
		alert("이름은 한글만 입력해주세요.");
		error(name);
		return false;
	}

	// email check
	var mailSplit = (obj.userEmail.value).split('@', 2);
	var mail = obj.userEmail;
	if (mail.value.search(ckSpace) !== -1) {
		alert("공백이 포함되어 있습니다.");
		error(mail);
		return false;
	}
	if (mailSplit.length == 1) {
		alert("이메일 주소가 바르지 않습니다.");
		error(mail);
		return false;
	}

	// birth check
	var birth = obj.userBirth;
	if (birth.value.search(ckSpace) !== -1) {
		alert("공백이 포함되어 있습니다.");
		error(birth);
		return false;
	}
	if (birth.value.length !== 6) {
		alert("6자로 입력해주세요.");
		error(birth);
		return false;
	}
	if (ckNum.test(birth.value)) {
		alert("숫자만 입력해주세요.");
		error(birth);
		// console.log(ckNum.test(birth.value));
		return false;
	}

	// phone check
	var phone = obj.userPhone;
	var startP = phone.value.slice(0, 3);
	console.log(startP);
	if (phone.value.search(ckSpace) !== -1) {
		alert("공백이 포함되어 있습니다.");
		error(phone);
		return false;
	}
	if (phone.value.length !== 11 || startP !== '010') {
		alert("핸드폰 번호를 다시 입력해주세요.");
		error(phone);
		return false;
	}
	// alert('passwordCheck()');
	if (obj.userPassword.value != obj.userPassword1.value) {
		alert("비밀번호가 일치하지 않습니다");
		obj.userPassword.value = '';
		obj.userPassword1.value = '';
		obj.userPassword.focus();
		return false;
	}
	// 입력한 비밀번호가 8자 이상 12자 이하인가 검사한다.
	var len = obj.userPassword.value.trim().length;
	if (len < 8 || len > 12) {
		alert('비밀번호는 8자 이상 12자 이하로 입력해야 합니다.');
		obj.userPassword.value = '';
		obj.userPassword1.value = '';
		obj.userPassword.focus();
		return false;
	}

	// 영문자, 숫자, 특수문자가 각각 1개 이상 입력되었나 검사한다.
	var alphaCount = 0;
	var numberCount = 0;
	var etcCount = 0;
	// 입력된 비밀번호의 문자 개수만큼 반복하며 영문자, 숫자, 특수문자의 개수를 센다.
	var pw = obj.userPassword.value.trim();
	for (var i = 0; i < len; i++) {
		if (pw.charAt(i) >= 'a' && pw.charAt(i) <= 'z' || pw.charAt(i) >= 'A'
				&& pw.charAt(i) <= 'Z') {
			alphaCount++;
		} else if (pw.charAt(i) >= '0' && pw.charAt(i) <= '9') {
			numberCount++;
		} else {
			etcCount++;
		}
	}
	// alert('영문자: ' + alphaCount + "개\n숫자: " + numberCount + "개\n특수문자: " +
	// etcCount);
	if (alphaCount == 0 || numberCount == 0 || etcCount == 0) {
		alert('영문자, 숫자, 특수문자는 각각 1개 이상 입력해야 합니다.');
		obj.userPassword.value = '';
		obj.userPassword1.value = '';
		obj.userPassword.focus();
		return false;
	}

	return true;

}

// 기준에 맞지 않으면 입력했던 데이터를 지우고 커서옯기기
function error(result) {
	result.value = '';
	result.focus();
}

// 이메일 체크하기
function emailCheck(list) {
	// console.log(list); //받아온 리스트 출력
	const ckSpace = /[\s]/g; // 공백체크
	const maillast = [ 'com', 'kr', 'net' ]; //이메일 끝자리로 구분
	var emailList = list.split(','); //데이터베이스의 이메일 리스트를 ,로 나눠 구분 

	// 받아온 리스트의 첫번째,마지막 결과에 []기호가 포함되어있기 때문에 삭제하고 다시 배열에 넣어준다.
	var first = emailList[0].replace('[', '');
	var last = emailList[emailList.length - 1].replace(']', '');
	emailList[0] = first;
	emailList[emailList.length - 1] = last;

	// 사용자가 입력한 이메일 가져오기
	var useremail = $('#userEmail').val().trim().toLowerCase();
	var emailExists = false;

	for (var i = 0; i < emailList.length; i++) {
		var listItem = emailList[i].trim().toLowerCase();
		// console.log(emailList[0]);
		// 사용자가 입력한 이메일이 리스트에 존재하면 emailExists = true
		if (useremail == listItem) {
			emailExists = true;
			break;
		}
	}
	// true이면 이미 사용중인 이메일 텍스트 출력
	if (emailExists) {
		$('#checkMessage').html('이미 사용중인 이메일입니다.');
	} else { //일치하는 메일이 없으면 이메일 형식 검사
		
		// 입력받은 이메일을 @로 나눈다.
		const input = $('#userEmail').val().split('@', 2);
		// @로 나눈 문자열을 .을 기준으로 나눈다.
		const inputlast = input[1].split('.');
		// 입력한 이메일을 @로 나눴을 때 2개이고 공백을 체크했을 때 공백이 없으면
		if (input.length == 2 && $('#userEmail').val().search(ckSpace) == -1) {
			// 이메일 뒷자리 last를 반복한다
			for (var i = 0; i < maillast.length; i++) {
				var lastItem = maillast[i];
				// .뒤의 문자가 last중 하나와 일치하면 사용가능한 이메일이라는 텍스트 띄우기
				if (inputlast[inputlast.length - 1] === lastItem) {
					$('#checkMessage').html('사용가능한 이메일입니다.');
					break;
				} else {
					// 조건에 일치하지 않으면 텍스트 지우기
					$('#checkMessage').html('');
				}
			}
		} else {
			// 조건에 일치하지 않으면 텍스트 지우기
			$('#checkMessage').html('');
		}
	}
}
//비밀번호가 일치하지 않으면 텍스트 출력
function passwordCheck2() {
	var userPassword = $('#userPassword').val();
	var userPassword1 = $('#userPassword1').val();
	if (userPassword != userPassword1) {
		$('#checkMessage').html('비밀번호가 서로 일치하지 않습니다.');
	} else {
		$('#checkMessage').html('');
	}
}

/*
 * 비밀번호 암호화 function loginRSA(pw){ // rsa 암호화 var rsa = new RSAKey();
 * rsa.setPublic($('#RSAModulus').val(),$('#RSAExponent').val());
 * 
 * $("#userPassword").val(rsa.encrypt(pw));
 * 
 * return true; }
 */
