$(document).ready(function(){
    

	
$('#userInfo').show();
$('#userSet').hide();

$('#menu1').on('click', function(){
    $('#userInfo').show();
	    $('#userSet').hide();
  });
$('#menu2').on('click', function(){
  $('#userInfo').hide();
   $('#userSet').show();
});

});