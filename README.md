# 취미는 하고싶은데 혼자는 싫을 때 TOGETHER 🏌️‍♂️🏊‍♂️🏋️‍♀️🚴‍♀️

프론트엔드, 백엔드를 혼자 맡아 제작한 개인 프로젝트입니다.
기획부터 배포까지 총 8주 소요되었고 아래 링크로 접속하실 수 있습니다.
### https://toogether.me

<br><br>

## ❔ 프로젝트 주제 선정 이유와 개발 목표

직장생활을 하면서 지친 몸과 마음을 건강하게 만들 수 있는 취미를 갖고싶은 사용자를 위한 웹페이지를 주제로 선정했습니다.  
팀 프로젝트에서 구현한 기능 외에 좋아요, 조회수, 그룹가입, 메시지 기능을 추가하고 처음부터 끝까지 직접 계획하고 개발하는 것을 <br>
목표로 했습니다.

<br><br>

## ❔ 프로젝트 진행 후 느낀점

개발부터 배포까지 많은 오류들을 접하며 하나의 오류를 해결하기 위해 긴 시간이 소요된 적도 있습니다. 하지만 문제를 해결하는 과정에서 <br> 
프로젝트의 완성도와 그에 따른 성취감도 높아짐을 느끼며 시행착오를 겪었을 때 더 좋은 결과물을 얻을 수 있다는 점을 <br>
깨달았습니다. 또한 오류 해결 방식에 있어서 문제가 발생했을 때 머릿속으로 생각만 하기보단 검색과 책을 활용해 정보를 찾아보고 <br>
다양한 코드를 실행해보며 부딪히는 것이 문제 해결 속도를 빠르게 할 뿐만 아니라 개발에 대한 흥미도 더욱 높아지도록 하는 것을 <br>
직접 경험한 프로젝트입니다.

<br><br>


## ❔ Tech Skills

- IDE : Eclipse, DBeaver
- DBMS : MySQL 5.5<br>
- WAS : Apache Tomcat 8.5
- Frontend : JavaScript, HTML5, CSS3, JQuery, Bootstrap <br>
- Backend : Java, Spring
- Infra : AWS (EC2, RDS, Route53, ELB, ALB, ACM)
<br>

### Database ERD

![ERD](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/3e07c268-d2a3-4ae9-b55e-bfbcc01d3fcf)

<br><br>

### 배포 과정

1. AWS EC2 인스턴스 생성 후 퍼블릭ip를 발급받아 인스턴스와 연결
2. FileZilla로 AWS EC2 인스턴스에 업로드
3. AWS RDS로 DB인스턴스 생성 후 Dbeaver로 MySQL과 연결
4. 주소 뒤 8080을 항상 입력하기 번거롭기 때문에 80 to 8080 포트포워딩
5. 가비아에서 구매한 도메인을 AWS Route53에서 호스팅영역을 생성한 뒤 연결
6. AWS ACM에서 발급받은 SSL인증서를 사용하여 ELB(ALB)를 통해 HTTPS를 적용
<hr>

<br><br><br>

# 💻 Detailed Description

<br>

## 🖱 www.toogether.me
<br><br>

⚫ [메인](#--메인-)

⚫ [회원가입](#--회원가입-)

⚫ [로그인/로그아웃](#--로그인-및-로그아웃-)

⚫ [회원정보](#--회원-정보-관리-)

⚫ [커뮤니티](#--커뮤니티-)

⚫ [그룹](#--그룹-)

<br><br>

# - 메인 📍

<br><br>

### ⚙ 메인페이지로 이동 전 시작페이지
### ① 아이콘 무한 롤링 배너, ② 텍스트 타이핑, ③ 로딩 아이콘 생성 및 5초 뒤 mainPage로 이동

<br>

![startPage](https://user-images.githubusercontent.com/84071666/236174666-eef5a6e4-0ad2-4547-ad0e-cec6905c45fd.PNG)

<br><br>

### ⚙ 1 ) 스크롤시 색상이 변하는 header, 움직이는 텍스트, 페이지 상/하단으로 이동가능한 버튼

<br>

![main1](https://user-images.githubusercontent.com/84071666/235856720-931bbcfe-f645-4da8-94f6-073cac83c57d.PNG)

<br><br>

### ⚙ 2 ) 자동으로 움직이는 슬라이드, 해당 카테고리로 이동하는 TOGETHER 버튼

<br>

![main2](https://user-images.githubusercontent.com/84071666/235856706-4bf89328-0714-458b-acaf-949b3e27fd71.PNG)
![main-slide1](https://user-images.githubusercontent.com/84071666/235861314-90be116c-a03e-468c-b468-af6f17107124.PNG)
![main-slide2](https://user-images.githubusercontent.com/84071666/235861327-7ebd513d-0e4a-4446-8790-2b86da1c1db1.PNG)
![main-slide3](https://user-images.githubusercontent.com/84071666/235861330-83a73d36-305a-4889-b4f0-63bb82244baf.PNG)
![main-slide4](https://user-images.githubusercontent.com/84071666/235861333-b5f8b6c5-7269-4d6b-9639-86a3c2192db0.PNG)

<br><br>

### ⚙ 3 ) 이미지 무한 롤링 애니메이션

<br>

![main3](https://user-images.githubusercontent.com/84071666/235856717-9570fcc1-ce42-4365-b25f-73d00786c687.PNG)

<br><br>

### ⚙ 4 ) 화면 축소 디자인

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235858895-45401786-3627-4c3f-952c-0470a7179159.PNG" width="32%" height="450px">
<img src="https://user-images.githubusercontent.com/84071666/235858897-2353fc7f-2503-49b2-b950-fa9782cd91c6.PNG" width="32%" height="450px">
<img src="https://user-images.githubusercontent.com/84071666/235858889-3c1e81be-81fd-4606-8d12-6be50a1ea776.PNG" width="32%" height="450px">
</div>
<br><br>

---

<br><br>

# - 회원가입 📍

<br><br>

### ⚙ 1 ) 회원가입 기능, 비밀번호 불일치시 텍스트를 출력하고 일치하면 숨기기

<br>

![join1](https://user-images.githubusercontent.com/84071666/235858722-147e69b6-5b4a-4987-988b-d8cda6c7f251.PNG)
![join2](https://user-images.githubusercontent.com/84071666/235858725-d24d695c-589b-4cf4-8b2c-eac6f21afdd1.PNG)

<br><br>

### ⚙ 2 ) 비밀번호 검사, 아이디 유무 확인 후 모든 조건을 충족하면 회원가입 완료

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235858732-6da01566-2379-4fe6-a104-a3483c506b0b.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235858716-d086b410-df2b-43dc-bf38-756438c4616e.PNG" width="49%">
</div>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235858719-90f32f29-9f4b-406a-a47a-f46fb127c388.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235858731-632754f5-3a23-4e32-a8d2-46941849ad1c.PNG" width="49%">
</div>

<br><br>

### ⚙ 3 ) 비밀번호 SHA-256 암호화

<br>

![pwEncrypt](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/136579d2-ae9e-41de-8edd-e983c155b6e3)
---

<br><br>

# - 로그인 및 로그아웃 📍

<br><br>

### ⚙ 1 ) 비밀번호 일치, 공백, 아이디 유무 검사 후 모든 조건을 충족하면 로그인 완료

<br>

![login1](https://user-images.githubusercontent.com/84071666/235856990-35ef5e84-1699-49eb-a050-c2ebc76d6b6b.PNG)

<div style="display: flex-start;">
<img src="https://user-images.githubusercontent.com/84071666/235856997-7642fd3b-6c5b-4672-b806-08d205f5a4de.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235856998-920a1440-5738-4bf8-b40d-90c24d145dcd.PNG" width="49%" align="right">
</div>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235857000-64eaa871-c3b7-4a13-83c3-473ffe19c13b.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235857004-48a40e5d-c729-410b-b159-a4c36204f838.PNG" width="49%" align="right">
</div>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235857005-6a1448d8-aad3-441e-acaf-42dca90413cd.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235857007-87c978de-f9de-431a-815d-571870d542be.PNG" width="49%" align="right">
</div> <br><br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235857008-547bcad1-d68b-40c9-85dc-afe04d879634.PNG" width="60%">
<img src="https://user-images.githubusercontent.com/84071666/235857012-af99212f-752d-4d7e-bfe0-f40986e8ce44.PNG" width="39%" height="180px">
</div> 

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235856984-26cf668a-4f84-41b1-86d4-7d3d12ad8610.PNG" width="60%">
<img src="https://user-images.githubusercontent.com/84071666/235856986-3ec5b33b-8783-48c9-a9da-911c6488c789.PNG" width="39%" height="180px">
</div>

<br><br>

---

<br><br>


# - 회원 정보 관리 📍

<br><br>

## 🔘 1 ) 회원 정보 수정하기

<br>

<div style="display: flex-start;">
<img src="https://user-images.githubusercontent.com/84071666/235875451-a4c6e412-bfc7-4a1d-be78-2e919a4da178.PNG" width="30%" height="100px" align="left">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ae5608a8-cd14-4950-9fdf-0a889a38d75b.PNG" width="35%">
</div> <br><br>

![update1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/ba4b16aa-5566-4872-8e97-3dd12945362a)
![userupdate2](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/4d711143-8127-4b7a-b8c5-5b32ca8e2f7c)

<br><br>

### ⚙ 회원가입과 동일하게 비밀번호 일치 확인 후 수정완료

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235870960-ed4d85d3-6fd0-4e4c-8ac5-b235d6f0cb63.PNG" width="49%">
<img src="https://user-images.githubusercontent.com/84071666/235870965-67e21f23-1dde-4073-83cc-eed8f08f08e2.PNG" width="49%" align="right">
</div>

<img src="https://user-images.githubusercontent.com/84071666/235870969-7c856888-bc11-4b1a-be33-0b7f2876275f.PNG">

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
<img src="https://user-images.githubusercontent.com/84071666/235871017-46c8dca4-b563-417f-ae61-cb47dda79e5a.PNG" width="33%">
<img src="https://user-images.githubusercontent.com/84071666/235871019-5ab77eea-e706-4371-b5a1-5ea6f1bb2571.PNG" width="33%">
<img src="https://user-images.githubusercontent.com/84071666/235871024-b09a12bb-5957-4cdf-aea2-154595b4581b.PNG" width="33%">
</div>

<br><br>

### ⚙ 데이터를 5개씩 보이도록 하고 더이상 보여줄 데이터가 없으면 알림창을 띄우는 MORE 버튼

<br>

![userdeleteinfo8](https://user-images.githubusercontent.com/84071666/235896891-71adf65e-b96a-4b4f-9c22-761cef1656a0.PNG)
![userdeleteinfo9](https://user-images.githubusercontent.com/84071666/235896898-a60e1e9c-f2f0-4376-9435-f99dcc701946.PNG)
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

<br>

## 🔘 4 ) 메시지 관리

<br><br>

### ⚙ 데이터 관리와 마찬가지로 메시지 전체를 관리 가능

<br>

![btn-side3](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/d005d98f-eb9d-4bd4-9135-4f853bdb20e0)
![update4](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/b76196dc-a5ab-461d-af67-077f56ccbce0)
![update5](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/38d99019-81c6-45aa-bcac-ae7e7b07a601)

<br>

### ⚙ 메시지 보기

<br>

<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/123e49c4-4b95-4432-b67f-5d32aef220cc.PNG">

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/d74efadb-09e4-4fa8-9072-a8aa27f56c7d.PNG" width="45%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/de340b9d-2f56-4be9-81f1-3eeb2954f112.PNG" width="47%">
</div>


<br>

### ⚙ 메시지 삭제

<br>

![update9](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/d9f7aa12-d95f-4d4c-a24a-58fe9b10993c)

<br><br>

# - 커뮤니티 📍

<br><br>

## 🔘 1 ) 커뮤니티 접속

<br>

![community1](https://user-images.githubusercontent.com/84071666/235914393-655f3530-5b45-4532-b10c-a36d2730d8bd.PNG)

### ⚙ 참여하고싶은 카테고리 선택

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/6e495049-bf79-4bd0-a918-9b75af3ad028.PNG" width="45%">
<img src="https://user-images.githubusercontent.com/84071666/235914401-a34a3fa2-b2e7-4880-808e-1789ea48de19.PNG" width="50%">
</div>

<br>

### ⚙ SPORTS 카테고리 게시판으로 이동

<br>

![search1](https://user-images.githubusercontent.com/84071666/235914402-88640d54-ff8f-4ac7-9e32-3dd3e7c71235.PNG)
![search1-1](https://user-images.githubusercontent.com/84071666/235914406-adf293cf-4c69-4f10-add8-645977cb98e8.PNG)
![search1-2](https://user-images.githubusercontent.com/84071666/235914409-2766c22d-aa72-48c7-b232-bcb5db844319.PNG)

<br>

### ⚙ MORE버튼을 클릭하면 게시글을 10개씩 보여주고 더이상 보여줄 글이 없으면 알림창 띄우기

<br>

![search1-3](https://user-images.githubusercontent.com/84071666/235914412-55f08796-8f4d-48fc-9376-8de75e7b9f37.PNG)

<br>

### ⚙ LEISURE 카테고리 게시판으로 이동

<br>

![search2](https://user-images.githubusercontent.com/84071666/235914415-b46de4fd-964b-4460-8226-bd483dd8f59d.PNG)

<br>

### ⚙ 선택한 카테고리에 글이 없으면 알림창 

<br>

![search3](https://user-images.githubusercontent.com/84071666/235973504-c5d55d96-381e-4b35-93ce-b4dad970dcd5.PNG)

---

<br><br>

## 🔘 2 ) 커뮤니티 글 작성

<br>

### ⚙ 접속한 카테고리가 이미 선택되어 있고 변경 가능

<br>

![write1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/018f0c0b-e1ee-414e-8104-c846f4be9f07)

<br>

### ⚙ 카테고리 선택, 제목과 내용 작성

<br>

![write2](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/d051d399-80aa-4b96-8860-9393bca0717c)

<br>

### ⚙ 카테고리 미선택, 내용 미작성, 작성완료시 알림창 띄우기

<br>

![write3-1](https://user-images.githubusercontent.com/84071666/235973490-34370293-899d-4bd0-b3ac-894694b8c0cc.PNG)
![write3-2](https://user-images.githubusercontent.com/84071666/235973495-a54f6d3a-73c3-4ad4-9a5b-aeb6ec4dc5b9.PNG)
![write3](https://user-images.githubusercontent.com/84071666/235973488-e14e53ba-8bbd-4048-9db7-4749485cb123.PNG)

<br>

### ⚙ 작성 완료

<br>

![write4](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/886d5339-c08e-4472-8553-82fde14aebd8)

<br>

### ⚙ 작성한 글 보기

<br>

![view1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/657929af-e409-4a6d-87e3-88a6f5ceed13)
![view2](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/a30bd825-76f2-487f-80b4-18ef28e0c1fc)

<br>

#### 1. 로그인 하지 않은 유저에게 보이는 버튼

<br>

![btn1](https://user-images.githubusercontent.com/84071666/235973859-08b5a8c4-3291-4a0d-a82a-e1239c14a151.PNG)

<br>

#### 2. 로그인은 했지만 글 작성자가 아닌 회원에게 보이는 버튼

<br>

![btn3](https://user-images.githubusercontent.com/84071666/235973866-7a1011cc-cd13-42df-9583-a55261e7e2f0.PNG)

<br>

#### 2. 로그인 한 글 작성자에게 보이는 버튼

<br>

![btn-2](https://user-images.githubusercontent.com/84071666/235973863-84254a30-acd4-4789-b0f6-5f00fa2b9644.PNG)

<br>

#### 3. 관리자(admin)에게 보이는 버튼 : 모든 사용자 글 삭제 가능

<br>

![btn-4](https://user-images.githubusercontent.com/84071666/235973872-29e11747-ed85-41cb-8a35-6c61535b23c8.PNG)

---

<br><br>

## 🔘 3 ) 댓글 작성

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

<br>

### ⚙ 글 상단에 작성자, 좋아요, 조회수 표시

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235973461-9aed1560-ee07-4cc2-961c-52a149bad14b.PNG" width="60%">
<img src="https://user-images.githubusercontent.com/84071666/235973466-7768b8b7-c728-4931-b12c-15969f6dadf4.PNG" width="35%">
</div>

<br><br>

### ⚙ 하트🤍클릭시 하트🖤색상 변경 및 갯수 증가, 새로고침시 조회수 증가  

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/235973470-59d80b33-c3cb-4882-9ca2-c1277f91ee5e.PNG" width="60%">
<img src="https://user-images.githubusercontent.com/84071666/235973474-936dc53d-c9f9-496b-bc00-c5ff493eb4ec.PNG" width="35%">
</div>

---

<br><br>

## 🔘 4 ) 커뮤니티 글 수정

<br><br>

![boardupdate1](https://user-images.githubusercontent.com/84071666/235974307-9a9dcfc5-33c1-4b58-934c-6cd4946a63fe.PNG)
![boardupdate2](https://user-images.githubusercontent.com/84071666/235974312-2bb5193c-b889-401d-82e0-318aa33785bf.PNG)

<br>

### ⚙ 다른 카테고리로 변경 가능 
![boardupdate3](https://user-images.githubusercontent.com/84071666/235974314-df888c99-3984-4909-a505-efda4273481f.PNG)
![boardupdate4](https://user-images.githubusercontent.com/84071666/235974318-fc3bfe3b-1f77-4a7a-ab09-f1887c8e249d.PNG)
![boardupdate5](https://user-images.githubusercontent.com/84071666/235974300-cfeb5959-c208-4cec-998c-161bd275cc5f.PNG)

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

### ⚙ 그룹 가입 완료시 해당 그룹의 비밀번호를 알려준다.
  
<br>

![join6](https://user-images.githubusercontent.com/84071666/236120951-5e535d3d-bc85-4a5b-aad8-8de279b916a4.PNG)

<br><br>

### ⚙ 그룹 가입 완료시 가입한 사용자의 정보를 그룹 게시판에 출력

<br>

![view1](https://user-images.githubusercontent.com/84071666/236120957-d0ab98b0-ebd1-4cab-8193-420172182699.PNG)
  
<br><br>

## 🔘 3 ) 그룹 접속

<br><br>

![access1](https://user-images.githubusercontent.com/84071666/236120122-b697ac25-6e63-4fd1-a26b-cdc4beae9103.PNG)

<br>

### ⚙ 그룹에 가입하지 않은 사람은 접속 불가
![그룹수정1](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/91febf94-f767-4ac5-9152-1a63cbada4bb)

<br>

### ⚙ 가입한 유저에게 입력창을 띄우고 비밀번호가 일치할 때 까지 반복

<br>

<div style="display: flex;">
<img src="https://user-images.githubusercontent.com/84071666/236120124-b565985e-d3ca-44fa-9aa0-69ba34558d30.PNG">
</div>

<br>

### ⚙ 접속한 유저가 그룹생성자면 메시지확인&그룹삭제 버튼, 그룹가입자면 메시지전송&그룹탈퇴 버튼 생성

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/b61f532e-24ec-4f98-b80f-fbfa767ff838.PNG" width="30%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/8adb6285-13a4-412d-99b7-be155f1cd674.PNG" width="32%">
</div>

<br>

---

## 🔘 4 ) 메시지 확인 및 전송

<br><br>

### ⚙ 메시지 확인 버튼 클릭시 해당 그룹의 멤버가 보낸 메시지 목록 팝업창 생성
:메시지 목록 팝업창에서는 해당 그룹의 멤버에게 받은 메시지만 확인할 수 있다.

<br>

<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/f7344195-a4cb-41d4-9fa4-e41bfd91f921.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/bbdede0b-3dd5-4dd0-bf52-83c21c24e17e.PNG" width="47%">
</div>

<br>

### ⚙ 답장하기, 메시지 전송 버튼 클릭시 toUserID에 그룹생성자의 userID 또는 메시지를 보낸 사용자의 userID로 메시지를 전송한다.

<br>
<div style="display: flex;">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/7446116d-59e0-4029-be24-57fe3e384cdf.PNG" width="47%">
<img src="https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/d3c7f0cc-cce8-49ce-9b7a-b309248b50af.PNG" width="47%">
</div>

<br>

![btn-member3](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/b8ebaddd-51e7-41b0-9590-8204cc25344a)

<br>

### ⚙ 메시지 DB

<br>

![msg-db](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/7b10ce08-a9ab-450c-a44b-9d387d248343)


---

<br><br>

## 🔘 5 ) 그룹 탈퇴

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

<br><br>

## 예외처리

![errorPage](https://github.com/dev-yoonddo/hobbyWebProject/assets/84071666/14bf63d6-60b8-4abf-85d2-ae0c47126bdb)

<br><br><br><br><br><br>

# 진행한 프로젝트는 여기까지이며 <br> 추후에도 새로운 기능을 추가할 예정입니다. <br> 읽어주셔서 감사합니다 🥰
