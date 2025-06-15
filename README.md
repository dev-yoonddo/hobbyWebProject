# 취미는 갖고 싶은데 혼자는 싫을 때 TOGETHER 🏊‍♂️🏋️‍♀️👩‍❤️‍👨

## 현재는 배포 되어있지 않습니다.
## http://toogether.me <br><br> 테스트 아이디 : test / 비밀번호 : 1234

<br>

## ❔ Tech Skills

- Backend : Java (jdk 1.8)
- Frontend : JavaScript, HTML5, CSS3, JQuery <br>
- IDE : Eclipse, DBeaver
- RDBMS : MySQL 5.5
- WAS : Apache Tomcat 8.5
- Infra : AWS (EC2, RDS, Route53, ELB, ALB, ACM)

<br>

### ERD Architecture

![ERD](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/b6be40dc-cdc8-4d13-8c8f-d9aa8cf20b79)

<br>

<!--
### 배포
1. AWS EC2 인스턴스 생성 후 퍼블릭ip를 발급받아 인스턴스와 연결
2. FileZilla를 사용해 AWS EC2 인스턴스에 업로드
3. AWS RDS로 DB인스턴스 생성 후 Dbeaver로 MySQL과 연결
4. 주소 뒤 8080을 생략하기 위해 80 to 8080 포트포워딩
5. 가비아에서 구매한 도메인을 AWS Route53에서 호스팅영역을 생성한 뒤 연결
6. AWS ACM에서 발급받은 SSL인증서를 사용하여 ELB(ALB)를 통해 HTTPS를 적용
-->

<hr>

<br><br>

# 💻 View Project

<br>


⚫ [회원가입](#--회원가입-)

⚫ [로그인/로그아웃](#--로그인-및-로그아웃-)

⚫ [이메일인증](#--이메일-인증-)

⚫ [회원정보](#--회원-정보-관리-)

⚫ [문의하기](#--문의하기-)

⚫ [커뮤니티](#--커뮤니티-)

⚫ [그룹](#--그룹-)

⚫ [채팅](#--채팅-)

⚫ [메시지](#--메시지-)

⚫ [이벤트](#--이벤트-)

⚫ [스팟등록/가입](#--스팟등록-및-가입-)


# - 회원가입 📍

<br><br>

### ⚙ 1 ) 이메일이 이미 사용되었거나 비밀번호 불일치시 텍스트를 출력하고 조건에 충족하면 삭제

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/43fe21fd-662d-4499-92f6-d72331072ddd.PNG" width="32%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ced74ac9-630d-4e92-b202-1fb4bce7d844.PNG" width="32%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/66f5e48c-6aa1-40ba-9317-a028cd7c62b6.PNG" width="32%">
</div>

<br><br>

### ⚙ 2 ) 비밀번호 검사, 아이디 유무 확인 후 모든 조건을 충족하면 회원가입 완료

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/442ac320-94b2-4389-8aa5-cdcf880e5715.PNG" width="49%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/321c1d6b-9af2-4596-8002-d88a05fa84cd.PNG" width="49%">
</div>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/4474e2e0-0514-4310-bc1d-05fb386d6df3.PNG" width="49%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ebc96329-f036-488d-8f23-1cb110322282.PNG" width="49%">
</div>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/e9537376-6a77-4ff3-a486-e5d65a2c17e8.PNG" width="49%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/c402b096-33fb-4019-bf85-a81fa3a9dc7b.PNG" width="49%">
</div>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/5bc3bae9-64a0-444d-a001-07e3c5ae1a43.PNG" width="49%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ce0a2c9c-124b-42c4-83e9-6fd952d2249e.PNG" width="49%">
</div>
  
<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235858732-6da01566-2379-4fe6-a104-a3483c506b0b.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235858716-d086b410-df2b-43dc-bf38-756438c4616e.PNG" width="49%">
</div>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235858719-90f32f29-9f4b-406a-a47a-f46fb127c388.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235858731-632754f5-3a23-4e32-a8d2-46941849ad1c.PNG" width="49%">
</div>

<br><br>

### ⚙ 3 ) 이메일 주소, 비밀 번호 SHA-256 암호화

<br>

![pwemailHash](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/7545f065-2a75-4443-b560-6ebe112902c6)

---

<br><br>

# - 로그인 및 로그아웃 📍

<br><br>

### ⚙ 1 ) 비밀번호 일치, 공백, 아이디 유무 검사 후 모든 조건을 충족하면 로그인 완료

<br>

![login1](https://user-images.githubusercontent.com/84071666/235856990-35ef5e84-1699-49eb-a050-c2ebc76d6b6b.PNG)

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235856997-7642fd3b-6c5b-4672-b806-08d205f5a4de.PNG" width="48%">
<img src="https://user-images.githubusercontent.com/84071666/235856998-920a1440-5738-4bf8-b40d-90c24d145dcd.PNG" width="48%">
</div>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235857000-64eaa871-c3b7-4a13-83c3-473ffe19c13b.PNG" width="48%">
<img src="https://user-images.githubusercontent.com/84071666/235857004-48a40e5d-c729-410b-b159-a4c36204f838.PNG" width="48%">
</div>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235857005-6a1448d8-aad3-441e-acaf-42dca90413cd.PNG" width="48%">
<img src="https://user-images.githubusercontent.com/84071666/235857007-87c978de-f9de-431a-815d-571870d542be.PNG" width="48%">
</div> <br><br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235857008-547bcad1-d68b-40c9-85dc-afe04d879634.PNG" width="60%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/9c01114c-6ec4-4796-9c66-83c5e4bd0de2.PNG" width="35%">
</div> 

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235856984-26cf668a-4f84-41b1-86d4-7d3d12ad8610.PNG" width="60%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/b18b43d0-d7ec-4910-90c4-b64e9bc565b9.PNG" width="35%">
</div>

<br><br>

---

<br><br>


# - 이메일 인증 📍

<br><br>

## 🔘 1 ) 회원가입 후 정보관리 페이지 접속을 위해 이메일 인증

<br>

![mail1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/1c9e1490-d0bf-4d9f-8232-3123a80866a3)

<br><br>

### ⚙ 이메일 정보가 없는 회원 접속시 이메일 입력 팝업 생성 후 기존에 사용된 이메일인지 확인

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/7a53f8b9-6169-4f03-9497-c68f2e52720e.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/bdecd3ca-687e-4533-b124-2fb7830d1fb4.PNG" width="47%">
</div>

<br><br>

### ⚙ 사용 가능한 이메일 주소이면 DB에 저장하고 인증 메일 발송

<br>

![mail2](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/099549ab-d30e-4a1f-8a98-076c36d594dc)

<br><br>

### ⚙ 이메일 계정 접속 후 수신 메일의 인증하기 클릭

<br>

![mail3](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/cada3bf5-1bf1-4409-8d4d-d2215b4a9d0d)
![mail4](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/f549791e-1f39-4560-8ddb-c44592bfb819)

<br><br>

### ⚙ 정상적으로 인증 완료시 알림창 띄운 후 창 닫기

<br>

![mail5](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/81c60e62-145b-4eef-b05a-1d51bcfdc2d0)

<br><br>

### ⚙ 기존 이메일 인증 페이지로 돌아가 인증완료 버튼을 클릭하면 정보 관리 페이지 접속 가능
#### : userID가 존재하고(로그인) DB에 이메일 정보가 존재하지 않으면 10초에 한번 새로고침

<br>

![mail6](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/f8b8bb31-77b2-4791-a5b7-d26dc484b7e8)
![update1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/7316a0c1-4712-491b-b22e-11899d651574)

<br><br>

---

<br><br>

# - 회원 정보 관리 📍

<br><br>

## 🔘 1 ) 회원 정보 수정하기

<br>

<div style="display: flex-start;">
<img src="https://user-images.githubusercontent.com/84071666/235875451-a4c6e412-bfc7-4a1d-be78-2e919a4da178.PNG" width="30%" height="130px" align="left">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ae5608a8-cd14-4950-9fdf-0a889a38d75b.PNG" width="40%">
</div>

<br><br>

### ⚙ 아이디는 수정 불가하도록 disabled

<br>

![update1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/7316a0c1-4712-491b-b22e-11899d651574)
![update2](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/17ffea4e-238f-408c-8ee2-215f6370d96d)

<br><br>

### ⚙ 입력받은 비밀번호를 암호화해 기존의 비밀번호와 비교하고 동일하면 정보수정 불가

<br>

![encryptPW](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/511a7bca-1a26-49ee-a94a-5e3877119348)

<br>

### ⚙ 회원가입과 동일하게 입력 조건, 비밀번호 일치 확인 후 수정 완료
#### *기존 이메일을 변경하지 않을때는 이메일 주소와 인증 정보가 그대로 저장되고 이메일 변경시 다른 아이디에서 사용중인 이메일이면 사용불가

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235870960-ed4d85d3-6fd0-4e4c-8ac5-b235d6f0cb63.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235870965-67e21f23-1dde-4073-83cc-eed8f08f08e2.PNG" width="49%" align="right">
</div>

<br><br>

![update3](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/5e351af1-f737-4dfc-8b68-fd4d376f0539)

<br><br>

<hr>

<br>

## 🔘 2 ) 회원 탈퇴하기

<br>

![userdelete1](https://user-images.githubusercontent.com/84071666/235876913-afdbf6eb-5e85-487c-be36-20087bfde708.PNG)

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235870978-d63ed342-3d8f-4699-af10-3c8f2adf1f11.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235870982-d783a468-c3a1-41c4-aa8d-75752db7493c.PNG" width="49%">
</div>

<br><br>

### ⚙ 회원 탈퇴 전 DB

<br>

: Available값이 모두 1

<br>

<img src="https://user-images.githubusercontent.com/84071666/235882416-ac9a481a-2f84-462b-95eb-cc382f7f5610.PNG" width="100%">
<img src="https://user-images.githubusercontent.com/84071666/235882419-b263c94a-c0c5-4928-bf54-949f1d144170.PNG" width="100%">
<img src="https://user-images.githubusercontent.com/84071666/235882422-35fe6073-9473-4069-aab1-f06a8629e833.PNG" width="100%">
<img src="https://user-images.githubusercontent.com/84071666/235882428-926cd41b-b42f-4ea3-ba26-5538559fb3a9.PNG" width="100%">
<img src="https://user-images.githubusercontent.com/84071666/235882433-c78e14da-f607-47b6-b21d-fc35b8c65908.PNG" width="100%">

<br><br>

### ⚙ 회원 탈퇴 후 DB
<br>

: Available값이 모두 0으로 변경

<br>

<img src="https://user-images.githubusercontent.com/84071666/235882418-d67ac260-07de-4e0b-8105-22bc7b3a761d.PNG" width="100%">
<img src="https://user-images.githubusercontent.com/84071666/235882420-7cc3b6fe-4cd2-4728-b50c-1dfd94d4f031.PNG" width="100%">
<img src="https://user-images.githubusercontent.com/84071666/235882424-b0e959c5-149a-45bb-b9c6-18bc3a1ba305.PNG" width="100%">
<img src="https://user-images.githubusercontent.com/84071666/235882432-ee46666a-f299-404f-8bb5-59b4de8ca12c.PNG" width="100%">
<img src="https://user-images.githubusercontent.com/84071666/235882434-f87282bd-123b-4c6a-9d0f-6739600b2738.PNG" width="100%">

<br><br>

### ⚙ 회원 탈퇴 전/후 페이지

<br>

: 회원 탈퇴시 userID의 데이터 모두 삭제

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235882439-3a8003cd-20f0-462b-b583-615acbe3ccc0.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235882440-abaaccd4-c389-4638-b7de-6b82c74d856a.PNG" width="49%">
</div>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235882443-cc058ac8-749f-4af7-a039-636977ef3fb1.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235882447-fe4e2020-b50f-4f40-b5da-802b5a9f4ceb.PNG" width="49%">
</div>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235882449-e104f131-dd9e-4b78-b3ea-905c2842d25c.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235882455-6a2bdca8-5cc9-4f72-8aad-8f101418fc05.PNG" width="49%">
</div>

<br><br>
<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235882458-fe352ec2-9634-49db-abbe-9ef8a1dfeafb.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235882410-ee8cbcf4-4eac-4670-9bb9-39e4d30c1456.PNG" width="49%">
</div>

<br><br>

---

<br>

## 🔘 3 ) 회원 데이터 관리

<br>

![btn-side2](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ca8ca440-9e95-4b21-afa9-3e8499cfa67e)
![userupdate3](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/788c8728-2494-4041-9912-e9b124d7ecc1)
![userupdate4](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/7829e25c-7dc8-4568-82c5-1ae8a35a9ba2)

<br><br>

### ⚙ 보기 버튼 클릭시 해당 데이터를 보이고 나머지 데이터는 숨기기

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235871017-46c8dca4-b563-417f-ae61-cb47dda79e5a.PNG" width="32%">
<img src="https://user-images.githubusercontent.com/84071666/235871019-5ab77eea-e706-4371-b5a1-5ea6f1bb2571.PNG" width="32%">
<img src="https://user-images.githubusercontent.com/84071666/235871024-b09a12bb-5957-4cdf-aea2-154595b4581b.PNG" width="32%">
</div>

<br><br>

### ⚙ 데이터를 5개씩 보이도록 하고 더이상 보여줄 데이터가 없으면 알림창을 띄우는 MORE 버튼

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235896891-71adf65e-b96a-4b4f-9c22-761cef1656a0.PNG" width="48%">
<img src="https://user-images.githubusercontent.com/84071666/235896898-a60e1e9c-f2f0-4376-9435-f99dcc701946.PNG" width="48%">
</div>

![userdeleteinfo10](https://user-images.githubusercontent.com/84071666/235910389-414c9eeb-b2d6-4277-95ff-e2f05a261ee2.PNG)

<br><br>

### ⚙ 각 데이터의 이름을 클릭하면 해당 페이지로 넘어가기

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235906491-8c5cd2a2-1763-4cc1-9020-131043eb0e23.PNG" width="44%">
<img src="https://user-images.githubusercontent.com/84071666/235908248-a55e630d-9fba-4841-9c06-9b9bc6243e3e.PNG" width="50%">
</div>

<br><br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235871059-ed598866-91d0-4e6d-88f7-a248fcfb290c.PNG" width="44%">
<img src="https://user-images.githubusercontent.com/84071666/235909302-3667a19a-b4d3-44f9-bea8-c139e40abb48.PNG" width="50%">
</div>

<br><br>

### ⚙ 원하는 데이터 전체 삭제

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235871066-4d332b60-2647-42d6-a776-66b3790d2eba.PNG" width="45%" align="left">
<img src="https://user-images.githubusercontent.com/84071666/235871071-9e489c07-0ac8-46ad-879f-edcb3f900a31.PNG" width="50%" align="right">
</div>


<img src="https://user-images.githubusercontent.com/84071666/235871076-cfc20d71-bcdc-478a-a1c1-32b5a5ff0d8f.PNG" width="70%">

<br><br>

### ⚙ 데이터 삭제 전/후 DB

<br>

:Member의 Available값이 0으로 변경됨을 확인할 수 있다.

<img src="https://user-images.githubusercontent.com/84071666/235912186-659bf2d2-3187-4ce5-a9c4-3ed18a5838ef.PNG" width="100%">
<img src="https://user-images.githubusercontent.com/84071666/235912203-44e5c05e-1d26-4f67-9902-3c947d6df93e.PNG" width="100%">

<br><br>

### ⚙ 데이터 삭제 후 데이터가 없다는 문구 표시

<br>

<img src="https://user-images.githubusercontent.com/84071666/235912255-548f42e2-d2fc-40cb-99b6-47cd02bb1acb.PNG" width="49%">


<br><br>

---

<br><br>

## 🔘 4 ) 메시지 관리

<br><br>

### ⚙ 데이터 관리와 마찬가지로 메시지 전체를 관리 가능

<br>

![btn-side3](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/d005d98f-eb9d-4bd4-9135-4f853bdb20e0)
![update4](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/b76196dc-a5ab-461d-af67-077f56ccbce0)
![update5](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/38d99019-81c6-45aa-bcac-ae7e7b07a601)

<br><br>

### ⚙ 메시지 보기 (30일동안 보관)

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/123e49c4-4b95-4432-b67f-5d32aef220cc.PNG">

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/d74efadb-09e4-4fa8-9072-a8aa27f56c7d.PNG" width="45%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/de340b9d-2f56-4be9-81f1-3eeb2954f112.PNG" width="47%">
</div>


<br><br>

### ⚙ 메시지 삭제

<br>

![update9](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/d9f7aa12-d95f-4d4c-a24a-58fe9b10993c)

<br><br>

---

<br><br>

# - 문의하기 📍

<br><br>

## 🔘 1 ) 관리자에게 문의하기

<br>

![qna1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/567cb5ef-a2bf-415b-a132-375be5e0b478)

<br><br>

### ⚙ 이모티콘 클릭시 관리자에게 전송되는 메시지 팝업 생성

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/a7a1cb0d-7375-43b4-a1ad-36177dcaa4a9" width="45%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/b2b50320-b7ef-46b1-a579-a54572e4170b" width="45%">
</div>

<br><br>

### ⚙ 빈칸 유무 검사 후 메시지 전송

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/6789e36a-2cbb-45b0-98e6-0fd3e5c1ca95" width="45%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/f23ab7d2-5a3d-4fdc-af35-dd19da90b578" width="45%">
</div>

<br><br>

### ⚙ 관리자 계정에서 확인 및 답변 가능

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/3f6c93d2-4276-42c2-8745-06e3796a1ac6" width="50%">

<br><br>

### ⚙ 메시지 관리와 같이 제목 클릭시 상세보기, 답장하기 클릭시 답장 가능

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/f747a8e8-e184-4ff5-9f36-111f966df236" width="45%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/e8316591-d619-406f-9444-4a6a169939bf" width="45%">
</div>

<br><br>

### ⚙ 빈칸 유무 검사 후 메시지 전송

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/6789e36a-2cbb-45b0-98e6-0fd3e5c1ca95" width="45%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/6324c5a7-4e4f-4728-b2c9-7a2bba796532" width="45%">
</div>

<br><br>

### ⚙ 관리자에게 온 답변에는 답장 불가

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/7a3f6e40-5e3f-4856-877e-c624716b5ecc" width="50%">

<br><br>

### ⚙ 문의하기 , 답변 완료시 DB

![qna7](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/3d8f4ebd-0764-4897-bd36-f5bdbe7eea0f)

<br><br>

---

<br><br>

# - 커뮤니티 📍

<br><br>

## 🔘 1 ) 커뮤니티 접속

<br>

![community1](https://user-images.githubusercontent.com/84071666/235914393-655f3530-5b45-4532-b10c-a36d2730d8bd.PNG)

<br><br>

### ⚙ 참여하고싶은 카테고리 선택

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/6e495049-bf79-4bd0-a918-9b75af3ad028.PNG" width="45%">
<img src="https://user-images.githubusercontent.com/84071666/235914401-a34a3fa2-b2e7-4880-808e-1789ea48de19.PNG" width="50%">
</div>

<br><br>

### ⚙ SPORTS 카테고리 게시판으로 이동

<br>

![search1](https://user-images.githubusercontent.com/84071666/235914402-88640d54-ff8f-4ac7-9e32-3dd3e7c71235.PNG)
![search1-1](https://user-images.githubusercontent.com/84071666/235914406-adf293cf-4c69-4f10-add8-645977cb98e8.PNG)
![search1-2](https://user-images.githubusercontent.com/84071666/235914409-2766c22d-aa72-48c7-b232-bcb5db844319.PNG)

<br><br>

### ⚙ MORE버튼을 클릭하면 게시글을 10개씩 보여주고 더이상 보여줄 글이 없으면 알림창 띄우기

<br>

![search1-3](https://user-images.githubusercontent.com/84071666/235914412-55f08796-8f4d-48fc-9376-8de75e7b9f37.PNG)

<br><br>

### ⚙ LEISURE 카테고리 게시판으로 이동

<br>

![search2](https://user-images.githubusercontent.com/84071666/235914415-b46de4fd-964b-4460-8226-bd483dd8f59d.PNG)

<br><br>

### ⚙ 선택한 카테고리에 글이 없으면 알림창 

<br>

![search3](https://user-images.githubusercontent.com/84071666/235973504-c5d55d96-381e-4b35-93ce-b4dad970dcd5.PNG)

<br><br>

---

<br><br>

## 🔘 2 ) 커뮤니티 글 작성

<br><br>

### ⚙ 접속한 카테고리가 이미 선택되어 있고 변경 가능

<br>

![write1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/83a4a89b-4984-4e8f-bd66-ec1c3e5dca44)

<br><br>

### ⚙ 카테고리 선택, 제목과 내용 작성, 첨부파일 선택

<br>

![write2](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/452f5cd8-0bf0-4504-b442-e8ce37cdd80f)

<br><br>

### ⚙ 카테고리 미선택, 내용 미작성, 첨부파일 확장자 확인, 작성완료시 알림창 띄우기

<br>

![write3-1](https://user-images.githubusercontent.com/84071666/235973490-34370293-899d-4bd0-b3ac-894694b8c0cc.PNG)
![write3-2](https://user-images.githubusercontent.com/84071666/235973495-a54f6d3a-73c3-4ad4-9a5b-aeb6ec4dc5b9.PNG)
![write3-3](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/183a1526-fb04-418d-8035-ac3dfc8ae531)
![write3](https://user-images.githubusercontent.com/84071666/235973488-e14e53ba-8bbd-4048-9db7-4749485cb123.PNG)

<br><br>

### ⚙ 작성 완료

<br>

![write4](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/a1873a26-f139-4676-aa29-3782ef15be62)

<br><br>

### ⚙ 작성한 글 보기

<br>

![view1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/50578393-6ca5-490c-9fac-f00c43453b85)
![view2](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/a30bd825-76f2-487f-80b4-18ef28e0c1fc)

<br><br>

### ⚙ 업로드 된 파일 클릭시 다운로드

<br>

![download](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/2bbbbabb-840e-49fb-8999-280b60382495)

<br><br>

### ⚙ 게시글 하단 버튼

<br><br>

#### 1. 로그인 하지 않은 유저에게 보이는 버튼

<br>

![btn1](https://user-images.githubusercontent.com/84071666/235973859-08b5a8c4-3291-4a0d-a82a-e1239c14a151.PNG)

<br><br>

#### 2. 로그인은 했지만 글 작성자가 아닌 회원에게 보이는 버튼

<br>

![btn3](https://user-images.githubusercontent.com/84071666/235973866-7a1011cc-cd13-42df-9583-a55261e7e2f0.PNG)

<br><br>

#### 2. 로그인 한 글 작성자에게 보이는 버튼

<br>

![btn-2](https://user-images.githubusercontent.com/84071666/235973863-84254a30-acd4-4789-b0f6-5f00fa2b9644.PNG)

<br><br>

#### 3. 관리자(admin)에게 보이는 버튼 : 모든 사용자 글 삭제 가능

<br>

![btn-4](https://user-images.githubusercontent.com/84071666/235973872-29e11747-ed85-41cb-8a35-6c61535b23c8.PNG)

---

<br><br>

## 🔘 3 ) 공지사항

<br><br>

### ⚙ 관리자 계정으로 공지사항 체크박스 체크 후 글 작성시 공지사항으로 등록

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/d5ea109d-dd7d-4c0c-8ef7-7db1589e757e" width="45%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/325d8229-a3db-4205-bbde-a52c2786369a" width="45%">
</div>

<br><br>

### ⚙ 공지사항은 모든 카테고리 검색 결과에 노출

<br>

![notice3](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/7cc07ddb-162d-4167-96c4-e486d3373148)

<br><br>

---

<br><br>

## 🔘 4 ) 댓글 작성

<br><br>

### ⚙ 댓글쓰기 버튼 클릭시 댓글 작성 박스 노출 및 댓글쓰기 버튼 숨기기

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235973881-f283cc80-8300-448f-967e-efa175b4f8ea.PNG" width="40%">
<img src="https://user-images.githubusercontent.com/84071666/235973889-c70156b7-5fc6-4021-833c-ec0196603a0c.PNG" width="50%">
</div>

<br><br>

### ⚙ 본인이 작성한 댓글에 보이는 삭제 버튼

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235973897-b3e3fc37-fa53-44b9-91de-5b85e91f9038.PNG" width="40%">
<img src="https://user-images.githubusercontent.com/84071666/235973904-1320e1a7-d7ee-4056-ab08-e1ae805b551a.PNG" width="50%">
</div>

<br><br>

### ⚙ 댓글 삭제 완료

<br>

<img src="https://user-images.githubusercontent.com/84071666/235973851-c951aa05-d887-4f3a-ad6f-e9a2075ffed6.PNG" width="60%">

<br><br>

### ⚙ 글 상단에 작성자, 좋아요, 조회수 표시

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235973461-9aed1560-ee07-4cc2-961c-52a149bad14b.PNG" width="60%">
<img src="https://user-images.githubusercontent.com/84071666/235973466-7768b8b7-c728-4931-b12c-15969f6dadf4.PNG" width="35%">
</div>

<br><br>

### ⚙ 하트 클릭시 하트 색상 변경 및 갯수가 1 증가, 다시 하트를 누르면 취소 및 갯수가 1 감소
: 새로고침시 조회수 증가

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235973470-59d80b33-c3cb-4882-9ca2-c1277f91ee5e.PNG" width="60%">
<img src="https://user-images.githubusercontent.com/84071666/235973474-936dc53d-c9f9-496b-bc00-c5ff493eb4ec.PNG" width="35%">
</div>

<br><br>

---

<br><br>

## 🔘 5 ) 커뮤니티 글 수정

<br><br>

![boardupdate1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/a24179db-19ee-4ed0-8a0d-67bc603b9954)
![boardupdate2](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ed7149ef-e25f-438b-9be5-2c88610b9518)

<br><br>

### ⚙ 카테고리,첨부파일 변경 가능 

<br>

![boardupdate3](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/686192f1-5898-436b-ad6c-fc86d0ff1293)
![boardupdate4](https://user-images.githubusercontent.com/84071666/235974318-fc3bfe3b-1f77-4a7a-ab09-f1887c8e249d.PNG)

<br><br>

### ⚙ 수정 결과

<br>

![boardupdate5](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/f6d2d6a9-cc35-4ae3-9801-2b266f68c71a)

<br><br>

---

<br><br>

# - 그룹 📍

<br><br>

## 🔘 1 ) 그룹 생성

<br><br>

### ⚙ 그룹 페이지는 로그인 하지 않으면 접속 불가 하므로 로그인 팝업창 띄우기

<br>

![login12](https://user-images.githubusercontent.com/84071666/236673216-bfea8799-cc9d-46a2-b19d-8082cc136ecd.PNG)

<br><br>

### ⚙ 그룹 메인 화면

<br>

![group1](https://user-images.githubusercontent.com/84071666/236118956-41e6b198-5b44-43f1-bd60-e4f78d209535.PNG)
![group2](https://user-images.githubusercontent.com/84071666/236118958-6cc65ad3-36c3-4904-b6dc-6af590acbd09.PNG)

<br><br>

### ⚙ 그룹 만들기 버튼을 클릭하면 가입 팝업 생성

<br>

![group3](https://user-images.githubusercontent.com/84071666/236118959-0228f450-3189-48f8-9cf5-8b3385007813.PNG)

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/236118960-6db6245c-54cc-4faa-9949-defcb7a1b02c.PNG" width="48%">
<img src="https://user-images.githubusercontent.com/84071666/236118962-d88a1ec0-d8ae-4c6e-a79f-9506e928c1eb.PNG" width="48%">
</div>

<br><br>

### ⚙ 생성 완료

<br>

![create3](https://user-images.githubusercontent.com/84071666/236118964-0d1ab74c-1557-41e9-ada6-cab98361db2f.PNG)

<br><br>

### ⚙ 그룹이름, 활동여부, 그룹 생성자, 가입 가능한 인원과 현재 가입한 인원 표시

<br>

![create4](https://user-images.githubusercontent.com/84071666/236118953-7b07b4e8-5a80-4924-adb3-5e1cece091d1.PNG)

<br><br>

### ⚙ 그룹 리더에게만 보이는 공지사항 작성 버튼클릭시 텍스트 박스 생성

<br>

![chat2](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/144aa3c2-5728-4541-9994-35df409de4c7)

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/9581fd6a-af43-4a60-a5ff-29e6f5037fab.PNG" width="38%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/1b5d6d25-767f-48a7-8d70-6bdb7986ad87.PNG" width="58%">
</div>

<br>

### ⚙ 작성완료 후 그룹페이지에 출력

<br>

![chat4](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/3ad7b552-bfe5-471a-ba09-0a132c4f7ad5)

---

<br><br>

## 🔘 2 ) 그룹 가입

<br><br>

![grouplist2](https://user-images.githubusercontent.com/84071666/236123166-a808e5ad-1588-449e-9c0f-7cb58631d34d.PNG)

<br>

### ⚙ 그룹생성자에겐 그룹접속 버튼만 노출
![그룹수정6](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/e9a0c71c-9ee1-4346-a55a-aef3b37cca66)

<br><br>

### ⚙ 그룹가입 버튼을 누르면 가입여부를 묻는 팝업창 띄우기
![그룹수정2](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ae2bb252-54ed-4663-9972-9ca56d5b2e2c)

<br>

### ⚙ 유저가 이미 가입한 그룹일 경우
![그룹수정4](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/db26b11e-3e26-4fdd-8492-220ac107d112)

<br>

### ⚙ 이미 정원이 다 찼을 경우
![그룹수정3](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/a7deb910-54de-4eb9-bc15-d9b001af951c)

<br>

### ⚙ 그룹을 탈퇴했을 경우
![그룹수정5](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/73baef42-755a-4dc0-8e91-99c5a76965cd)

<br><br>

### ⚙ 위 조건에 해당되지 않으면 가입 팝업창을 띄우고 데이터베이스 오류, 공백 유무, 아이디 중복, 이미 존재하는 데이터인지 확인 후 가입 완료

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/236120936-8edb14e3-fb53-4235-99bd-dd5ba2d2a398.PNG" width="48%">
<img src="https://user-images.githubusercontent.com/84071666/236120941-9db3b694-62de-4a13-81ce-295b96ce4685.PNG" width="48%">
</div>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/236120943-c0890163-4891-4430-8d65-55bd9839392c.PNG" width="48%">
<img src="https://user-images.githubusercontent.com/84071666/236120948-cc035f97-a2dd-4270-8deb-32ec2d17747f.PNG" width="48%">
</div>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/236120945-b2e16112-551f-4138-aac0-163b99a44f79.PNG" width="48%">
<img src="https://user-images.githubusercontent.com/84071666/236120954-5c31fe36-0bc1-4143-82d9-557a3e4b0161.PNG" width="48%">
</div>

<br><br>

### ⚙ 그룹 가입 완료시 해당 그룹의 비밀번호 알림
  
<br>

![join6](https://user-images.githubusercontent.com/84071666/236120951-5e535d3d-bc85-4a5b-aad8-8de279b916a4.PNG)

<br><br>

## 🔘 3 ) 그룹 접속

<br><br>

![chat1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/14f1883d-5812-4aeb-b751-c85880ff62c9)

<br><br>

### ⚙ 그룹에 가입하지 않은 사람은 접속 불가
![그룹수정1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/91febf94-f767-4ac5-9152-1a63cbada4bb)

<br><br>

### ⚙ 가입한 유저에게 입력창을 띄우고 비밀번호가 일치할 때 까지 반복

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/236120124-b565985e-d3ca-44fa-9aa0-69ba34558d30.PNG">
</div>

<br><br>

### ⚙ 비밀번호 5회 이상 입력 오류시 비밀번호 찾기

<br>

![findpw](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ed436548-592c-4965-9582-23383776e059)

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/8ef13db8-9c65-4c8b-9282-deeacb3c504c.PNG" width="48%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/819c875e-1206-47da-91d6-0a51b056a0b9.PNG" width="48%">
</div>

<br><br>

### ⚙ 빈칸 유무, 정보 일치 검사 후 비밀번호 알림

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/632853f3-67c3-455c-86c8-beccc920eb98.PNG" width="48%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/8e056288-93aa-4544-b3cf-92c2a84668ef.PNG" width="48%">
</div>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/344d7050-579d-47b0-aeb9-8bbf53f5b29f.PNG" width="48%">


<br><br>

### ⚙ 접속한 유저가 그룹생성자면 메시지확인&그룹삭제 버튼, 그룹가입자면 메시지전송&그룹탈퇴 버튼 생성

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/b61f532e-24ec-4f98-b80f-fbfa767ff838.PNG" width="30%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/8adb6285-13a4-412d-99b7-be155f1cd674.PNG" width="32%">
</div>

<br><br>

---

<br><br>

## 🔘 4 ) 그룹 탈퇴

<br><br>

### ⚙ 그룹 탈퇴시 그룹 메인 화면의 가입 인원에서 삭제
  
<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/236124025-1e5219fd-8ee5-4059-99de-cbe4f57d1928.PNG" width="43%">
<img src="https://user-images.githubusercontent.com/84071666/236124026-0a9d6d86-b7cb-4fca-9b2b-3c1fe206b5d2.PNG" width="50%">
</div>

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/236125789-a0c198aa-ce65-41d9-8d38-7ccb4892a7d9.PNG" width="19%">
<img src="https://user-images.githubusercontent.com/84071666/236125794-64d93f2a-41d3-43f0-9b3a-2a4fded3430e.PNG" width="20%">
</div>

<br><br>

### ⚙ 탈퇴한 회원은 그룹 접속 및 그룹 재가입 불가 

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/236124028-ce02b9ea-a5e7-4857-8e8b-394aeacb6fc9.PNG" width="48%">
<img src="https://user-images.githubusercontent.com/84071666/236124022-610fb714-736b-4e7a-941c-ccf1c60bd954.PNG" width="48%">
</div>

<br><br>

---

<br><br>

## 🔘 5 ) 그룹 삭제

<br><br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/236124080-7302a907-d983-4333-9df2-a6ef09a36279.PNG" width="48%">
<img src="https://user-images.githubusercontent.com/84071666/236124081-6b6aa21e-c088-4797-9e15-2b18dfacaef4.PNG" width="48%">
</div>

<br><br>

### ⚙ 그룹 삭제 완료시 활동중에서 비활동중으로 변경

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/236127560-132acca2-c4df-4dcf-88f3-1abdd2df0044.PNG" width="48%">
<img src="https://user-images.githubusercontent.com/84071666/236124083-74489947-46a7-4b34-8a1c-0efadb0484f7.PNG" width="48%">
</div>

<br><br>

### ⚙ 그룹 삭제 후 사용자가 그룹 가입 또는 접속 버튼 클릭시 비활동중인 그룹이라는 알림창 생성

<br>

![groupdelete4](https://user-images.githubusercontent.com/84071666/236124076-998c703f-a070-498c-afd8-7864477b50b3.PNG)

---

<br><br>

# - 채팅 📍

<br><br>

## 🔘 그룹 멤버들간의 실시간 채팅

<br><br>

### ⚙ 채팅 시작 전 초기화면

<br>

![chat2-1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ed29af3c-db7b-464f-9a32-a085cf31e2b3)

<br><br>

### ⚙ 채팅 전송 시 실시간으로 채팅화면 업데이트

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/e32f23f3-2a26-4e0e-9954-82bd721281ac.PNG" width="44%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/a3a86565-49a3-476e-8eb8-acd6bf56074d.PNG" width="52%">
</div>

<br><br>

### ⚙ 다른 브라우저를 이용한 채팅 테스트

<br>

![chat9](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/a9920f41-abc7-46f2-8d55-59c28108edaf)

<br><br>

### ⚙ 그룹 탈퇴 또는 회원 탈퇴시 아이디와 채팅내용 삭제

<br>

![out](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ea690589-f154-46f9-851e-1bfb3c2e061d)

<br><br>

---

<br><br>

# - 메시지 📍

<br><br>

## 🔘 1 ) 메시지 확인 및 전송

<br><br>

### ⚙ 메시지 확인 버튼 클릭시 해당 그룹의 리더가 보낸 메시지 목록 팝업창 생성
:메시지 목록 팝업창에서는 해당 그룹의 멤버에게 받은 메시지만 확인할 수 있다.

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/f7344195-a4cb-41d4-9fa4-e41bfd91f921.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/bbdede0b-3dd5-4dd0-bf52-83c21c24e17e.PNG" width="44%">
</div>

<br><br>

### ⚙ 답장하기, 메시지 전송 버튼 클릭시 그룹생성자 또는 메시지를 보낸 사용자의 userID로 메시지 전송 (리더와 멤버간의 대화 가능)

<br>
<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/7446116d-59e0-4029-be24-57fe3e384cdf.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/d3c7f0cc-cce8-49ce-9b7a-b309248b50af.PNG" width="47%">
</div>

<br>

![btn-member3](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/b8ebaddd-51e7-41b0-9590-8204cc25344a)

<br><br>

### ⚙ 해당 그룹이 비활동중이면 메시지 주고받기 불가

<br>

![groupDelSendMsg](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/a6496df4-2558-4f0f-b8c2-914f57b3204c)

<br><br>

### ⚙ 메시지 DB

<br>

![msg-db](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/7b10ce08-a9ab-450c-a44b-9d387d248343)


---

<br><br><br>

# - 이벤트 📍

<br><br>

### ⚙ 작성한 게시글이 5개 이상이고 본인이 생성한 그룹이 있으면 메인페이지에 팝업창 생성

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/99a6f871-e29f-40b4-ab5f-507ae4949792.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/4a8a967c-65b9-4ae2-ae1d-359a32698d40.PNG" width="47%">
</div>

<br><br>

### ⚙ 그룹 선택, 응모 내용, 회원 비밀번호를 입력하면 빈칸,비밀번호 일치 확인 후 응모 완료

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ea7e70f0-693a-49db-b27c-b9f0ad76e3ac.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/6a8dcbcb-df6a-4d50-a747-c973d0cddde3.PNG" width="47%">
</div>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/1f19664e-21b5-4231-8750-33e01a49eb06.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/e5fdb05f-02b8-40f7-b9ba-42595a4a4f5d.PNG" width="47%">
</div>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/8dfc22de-8d4a-4991-829f-ec35d5471bde.PNG" width="47%">
</div>

<br><br>

### ⚙ 관리자 계정으로 로그인 후 이벤트 추첨 사용 가능

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ad2b1ca3-66e6-4b55-8646-22116b91bbd7.PNG" width="20%">

<br><br>

### ⚙ 당첨 회원을 체크한 후 버튼 클릭시 당첨 처리되며 회원에게 보낼 메시지를 입력할 팝업창 생성

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/cd7a281f-784b-477c-a2f3-64d4fe50f26a.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/9648b18a-20db-4dfa-a4ab-05d18e422edb.PNG" width="47%">
</div>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/3b3fdd2d-8026-404d-b616-38f7e96f8832.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/34d8ef4c-c577-4a01-8e37-c7b28e0675fa.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/b81d5dc4-daf6-49d2-bb09-26597d2449a0.PNG" width="47%">

<br><br>

### ⚙ eventWin = 0 -> eventWin = 1 로 변경되며 DB에 당첨 메시지 데이터 추가

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/f948d278-9a94-4f27-b621-a247187db695.PNG" width="47%">

<br><br>

### ⚙ 당첨된 회원 로그인시 메인페이지에 당첨 메시지가 생성되며 더이상 보지않기를 클릭하면 다시 생성되지 않는다.

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/02f002d3-faea-4a4a-8b32-bfa93d21e71b.PNG" width="47%">

<br><br>

---

<br><br>

# - 스팟등록 및 가입 📍

<br><br>

## 🔘 1 ) 주소 검색 후 스팟 등록하기

<br><br>

### ⚙ SPOT 페이지 접속 화면

<br>

![map1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/5163ac5d-5464-4a16-8e5a-e6426df415f7)

<br><br>

### ⚙ 위치서비스 허용시 현재위치 검색 가능

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/8c07b115-1778-46c0-9039-88b540e87d35.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/81134ebd-ee4e-47a2-916b-a95aa3a09aff.PNG" width="47%">
</div>

<br><br>

### ⚙ 주소 검색시 화면에 주소 정보 출력, 스팟 등록하기 버튼 클릭시 스팟 이름 입력창 생성

<br>

![map10](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/14ebbff9-2680-4d74-b07c-a394c1fd36eb)

<br><br>

### ⚙ 주소와 이름이 이미 데이터베이스에 존재하는지 검사 후 등록 완료

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/06b88704-9709-4048-af9e-c6fab39214bf.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/f6df5e40-b398-4b62-989f-b51e7c008e78.PNG" width="47%">
</div>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ebe499bc-d2a5-4773-8a76-bdb0489a19ba.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/c081e027-2539-4bea-ac77-5a07d6fe5aa8.PNG" width="47%">
</div>

<br><br>

## 🔘 2 ) 스팟 크루 가입하기

<br><br>

### ⚙ 등록된 스팟들이 해당 위치에 표시되고 핀을 클릭하면 스팟이름, 주소, 크루인원이 표시된 윈도우 생성

<br>

![join1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ff319393-77d3-4b6e-a1b7-976cde1036de)

<br><br>

### ⚙ 스팟 이름을 클릭하면 스팟 가입

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/e3f9c411-cd4d-41ff-846c-b1793cb20664.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/b7eebd6f-b560-4b54-839c-c126445e67c6.PNG" width="47%">
</div>

<br><br>

---

<br><br>

# - 스팟등록 및 가입 📍

<br><br>

### ⚙ 가입완료시 접속 여부를 묻는 알림창이 생성되고 스팟 생성자와 기존 가입자는 바로 접속

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/665906f8-a729-412b-ad8f-f7f0d7e09cd3.PNG" width="47%">

<br><br>

### ⚙ 스케줄 등록을 원하는 날짜 클릭시 버튼 생성

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/61a3cdec-8057-44a6-87b9-eb835a7d5899.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/9e56f8cf-7b34-4b2c-a51f-512100a094e5.PNG" width="47%">
</div>

<br><br>

### ⚙ 스케줄 등록 버튼 클릭시 팝업 생성

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/14f32055-ba80-4014-b93c-700927c7e41a.PNG" width="47%">

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/97bd9449-ec0c-47b1-b3f8-872fb324f708.PNG" width="47%">

<br><br>

### ⚙ 스케줄 내용 입력 후 확인 클릭시 해당날짜에 아이콘 생성

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/e4039ef2-8ef8-421e-91aa-75319909eb07.PNG" width="47%">

<br><br>

### ⚙ 스케줄 확인 클릭시 등록된 스케줄 출력

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/c2829222-8ad7-4059-a3d0-f003377431a8.PNG" width="47%">

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/95762c69-8bbd-4926-b03d-87bb3a59fa47.PNG" width="47%">


<br><br>

---

<br><br>

## 예외처리

![errorPage](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/14bf63d6-60b8-4abf-85d2-ae0c47126bdb)
![error-500](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ec0c8ec8-1e50-4df5-a8b5-5e66353c3d32)

<br><br>

<br><br>

# 진행한 프로젝트는 여기까지이며 <br> 추후에도 새로운 기능을 추가할 예정입니다. <br> 읽어주셔서 감사합니다 🥰
