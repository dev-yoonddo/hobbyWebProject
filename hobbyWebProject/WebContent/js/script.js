var btn = document.querySelectorAll('.arrowBtn')
var slides = document.querySelectorAll('.slide').length - 1
var slot = 0

btn[0].addEventListener('click', function(e){
  if(play) {
    clearInterval(play)
  }
  var e = document.querySelector('.showing')
  
  if(slot == 0) {
    slot = 3   
    document.querySelectorAll('.slide')[slides].classList.add('showing')
    e.classList.remove('showing')     
  } else {
    slot-- 
    e.previousElementSibling.classList.add('showing')
    e.classList.remove('showing')     
  }   
})

btn[1].addEventListener('click', function(e){
  if(play) {
    clearInterval(play)
  }
  var e = document.querySelector('.showing')   
  
  if(slot == slides) {
    slot = 0
    document.querySelectorAll('.slide')[0].classList.add('showing')
    e.classList.remove('showing')      
  } else {
     slot++ 
    e.nextElementSibling.classList.add('showing')
    e.classList.remove('showing')  
  }  
})

function autoPlay() {
  e = document.querySelector('.showing')
  if(slot == slides) {
    slot = 0
    document.querySelectorAll('.slide')[0].classList.add('showing')
    e.classList.remove('showing')      
  } else {
    slot++ 
    e.nextElementSibling.classList.add('showing')
    e.classList.remove('showing')  
  }  
}
var play = setInterval(autoPlay, 5000)
