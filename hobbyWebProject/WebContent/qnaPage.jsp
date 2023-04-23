<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width-device-width", initial-scale="1">
<meta charset="UTF-8">
<title>TOGETHER</title>
<link rel="stylesheet" href="css/main.css?after">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/leaflet@1.6.0/dist/leaflet.css"/>
<link href="https://fonts.googleapis.com/css?family=Teko:300,400,500,600,700&display=swap" rel="stylesheet">
<link href="https://hangeul.pstatic.net/hangeul_static/css/nanum-square.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script defer src="option/jquery/jquery.min.js"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://kit.fontawesome.com/f95555e5d8.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
<script type="text/javascript" src="js/script.js"></script>


</head>
<style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      width: 100vw;
      height: 100vh;

    }

    .wrapper {
      width: 100%;
      height: 100%;
      display: flex;

    }

    .main {
      width: 80%;
      height: 100vh;
      display: flex;
      justify-content: space-around;
      transition: all 1s linear;
      align-items: center;

      /* background-color: #f1c40f; */
    }

    .main div {
      width: 100px;
      height: 100px;
      border: 1px solid aliceblue;
      background-color: aliceblue;

      border-radius: 15px;
      box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.5);
    }

    .aside {
      width: 20%;
      height: 100vh;
      display: flex;
      flex-direction: column;
      justify-content: space-around;
      align-items: center;
      background-color: #95a5a6;
    }

    .aside div {
      width: 50px;
      height: 50px;
      border: 1px solid aliceblue;
      background-color: aliceblue;
      border-radius: 10px;
      box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.5);
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .aside div .mini {
      width: 40px;
      height: 40px;
      border: 1px solid rgb(71, 255, 227);
      background-color: rgb(71, 255, 227);
      border-radius: 8px;
      box-shadow: 5px 5px 5px rgba(0, 0, 0, 0.5);
      left: 0;
      top: 0;
    }
  </style>
</head>

<body>
  <div class="wrapper">
    <section class="main">
      <div class="first-container item">1</div>
      <div class="second-container item">2</div>
      <div class="third-container item">3</div>
    </section>
    <section class="aside">
      <div class="first-sidebar side droppable"></div>
      <div class="second-sidebar side droppable"></div>
      <div class="third-sidebar side droppable"></div>
      <div class="xxx-sidebar side droppable"></div>

    </section>
  </div>

</body>
<script src="js/qna.js"></script>

</html>